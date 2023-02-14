# Usage:
#   `make [folder]`  - will build the docker image for the folder, including it's dependent containers assuming
#                      they of the form `[0-9]{3}-[a-z]+`. They will be built in lexical order. This image will
#                      be tagged with `${current-dir}-[folder]:local`
#   `make clean`     - will remove all of the docker images for the folder and it's dependent containers.
#   `make base`      - will build only the base containers for the folder.
#
# Note: It is assumed there are no dependencies between the non-base containers.

DIR_NAME := $(notdir ${CURDIR})
BASE_CONTAINERS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d -regextype sed -regex '.*[0-9]\{3\}.*' | sort)
PUBLISHED_CONTAINERS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d | sort | grep -v '[0-9]\{3\}-.*')
IMAGE_PREFIX = ${DIR_NAME}
SUBDIRS = $(notdir ${BASE_CONTAINERS} ${PUBLISHED_CONTAINERS})
BASE_SUBDIRS = $(notdir ${BASE_CONTAINERS})
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean upstream composite-dockerfile base $(SUBDIRS)

$(DIR_NAME): build
build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(PUBLISHED_SUBDIRS)
	@rm -rf $(BASE_CONTAINERS)

composite-dockerfile: $(SUBDIRS)

base: $(BASE_SUBDIRS)

$(BASE_SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.leaf.mk \
		IMAGE_TO_BUILD=${IMAGE_PREFIX}-$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../ \
		COMPOSITE_DOCKERFILE=Dockerfile.${IMAGE_PREFIX}

$(PUBLISHED_SUBDIRS): base
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.leaf.mk \
		IMAGE_TO_BUILD=${IMAGE_PREFIX}-$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../ \
		COMPOSITE_DOCKERFILE=Dockerfile.${IMAGE_PREFIX}
