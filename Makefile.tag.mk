PROJECT_RELATIVE_DIR :=$(shell realpath --relative-base=${COMPOSITE_DOCKERFILE_DIR} ${CURDIR})
DIR_NAME :=$(shell realpath --relative-base=${CURDIR}/.. ${CURDIR})
ABSOLUTE_PARENT_DIR := $(shell realpath ${CURDIR}/..)
PARENT_DIR := $(shell realpath --relative-base=${ABSOLUTE_PARENT_DIR}/.. ${ABSOLUTE_PARENT_DIR})
ESCAPED_PROJECT_RELATIVE_DIR := $(shell echo ${PROJECT_RELATIVE_DIR} | sed 's/\//\\\//g')

PUBLISHED_CONTAINERS = $(shell find ${ABSOLUTE_PARENT_DIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep -v '[0-9]\{3\}-.*')
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean upstream ${DIR_NAME} ${PARENT_DIR} $(PUBLISHED_SUBDIRS) leaf-target base

build:
	@docker build . --tag $${IMAGE_DIRECTORY}/$${TAG_DIRECTORY}:local

${DIR_NAME}: build
${PARENT_DIR}: build
$(PUBLISHED_SUBDIRS): build
base: build

# Transforms `FROM ([^/]*)` to `FROM (.*) AS $IMAGE_TO_BUILD`
#   These are images that do not have a "/" in them, because they're not the target
#   image we want to build or any local image.
# Transforms `FROM [:image directory:]/[:tag directory:]:local (.*)` to `FROM [:image directory:]_[:tag directory:] (.*)`
# Transforms `COPY ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
# Transforms `COPY --chown=(..) ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
composite-dockerfile:
	@echo \
		"\n##########################################################" \
		"\n# This file is generated by the Makefile. Do not edit it." \
		"\n##########################################################\n" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@echo \
		"\n# Generated by Makefile for $${IMAGE_DIRECTORY}/$${TAG_DIRECTORY}\n" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@cat Dockerfile |\
		sed "s/FROM \([^ ]*\)$$/FROM \1 AS $${IMAGE_DIRECTORY}_$${TAG_DIRECTORY}/" |\
		sed "s/FROM \(.*\)\/\(.*\):local \(.*\)$$/FROM \1_\2 \3/"\ |\
		sed "s/COPY --from=\([^-]*\)-\(.*\) \(.*\)$$/COPY --from=\1_\2 \3/"\ |\
		sed "s/COPY\(.*\)\.\/\(.*\) \(.*\)$$/COPY \1\.\/${ESCAPED_PROJECT_RELATIVE_DIR}\/\2 \3/" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}

clean:
	@docker rmi --force $${IMAGE_DIRECTORY}/$${TAG_DIRECTORY}:local || true

upstream:
	@rm -rf *
	@echo "FROM $${UPSTREAM_REGISTRY}/$${IMAGE_DIRECTORY}:$${TAG_DIRECTORY}" > Dockerfile
