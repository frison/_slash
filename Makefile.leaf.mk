PROJECT_RELATIVE_DIR :=$(shell realpath --relative-base=${COMPOSITE_DOCKERFILE_DIR} ${CURDIR})
DIR_NAME :=$(shell realpath --relative-base=${CURDIR}/.. ${CURDIR})
ABSOLUTE_PARENT_DIR := $(shell realpath ${CURDIR}/..)
PARENT_DIR := $(shell realpath --relative-base=${ABSOLUTE_PARENT_DIR}/.. ${ABSOLUTE_PARENT_DIR})
ESCAPED_PROJECT_RELATIVE_DIR := $(shell echo ${PROJECT_RELATIVE_DIR} | sed 's/\//\\\//g')

PUBLISHED_CONTAINERS = $(shell find ${ABSOLUTE_PARENT_DIR} -mindepth 1 -maxdepth 1 -type d | sort | grep -v '[0-9]\{3\}-.*')
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

build:
	@docker build . --tag $${IMAGE_TO_BUILD}:local

${DIR_NAME}: build
${PARENT_DIR}: build
	@echo "Building ${PARENT_DIR}"
$(PUBLISHED_SUBDIRS): build

base: build

# Transforms `FROM ([^/]*)` to `FROM (.*) AS $IMAGE_TO_BUILD`
#   These are images that do not have a "/" in them, because they're not the target
#   image we want to build or any local image.
# Transforms `FROM (.*):local (.*)` to `FROM (.*) AS (.*)`
# Transforms `COPY ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
# Transforms `COPY --chown=(..) ./(.*) (.*)` to `COPY ./${ESCAPED_PROJECT_RELATIVE_DIR}/(.*) (.*)`
composite-dockerfile:
	@echo \
	     "\n##########################################################" \
		 "\n# This file is generated by the Makefile. Do not edit it." \
		 "\n##########################################################\n" \
		>>  $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@echo \
	     "\n# Generated by Makefile for $${IMAGE_TO_BUILD}\n" \
	    >>  $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}
	@cat Dockerfile |\
		sed "s/FROM \([^/]*\)$$/FROM \1 AS $${IMAGE_TO_BUILD}/" |\
		sed "s/FROM \(.*\):local \(.*\)$$/FROM \1 \2/"\ |\
		sed "s/COPY\(.*\)\.\/\(.*\) \(.*\)$$/COPY \1\.\/${ESCAPED_PROJECT_RELATIVE_DIR}\/\2 \3/" \
		>> $${COMPOSITE_DOCKERFILE_DIR}/$${COMPOSITE_DOCKERFILE}

clean:
	@docker rmi --force $${IMAGE_TO_BUILD}:local || true

upstream:
	@echo "FROM frison/$${IMAGE_TO_BUILD}:latest" > Dockerfile
	rm -rf !Dockerfile

.PHONY: build clean upstream