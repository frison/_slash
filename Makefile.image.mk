##
# Version: 1.2 (2023-06-17)
# Usage:
#   `make [folder]`  - will build the docker image for the folder, including it's dependent containers assuming
#                      they of the form `[0-9]{3}-[a-z]+`. They will be built in lexical order. This image will
#                      be tagged with `${current-dir}/[folder]:local`
#   `make clean`     - will remove all of the docker images for the folder and it's dependent containers.
#   `make base`      - will build only the base containers for the folder.
#
# Note: It is assumed there are no dependencies between the non-base containers.

DIR_NAME := $(notdir ${CURDIR})
BASE_CONTAINERS = $(shell find ${CURDIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep '.*[0-9]\{3\}.*')
PUBLISHED_CONTAINERS = $(shell find ${CURDIR} -maxdepth 2 -type f -name "Dockerfile" -exec dirname "{}" \; | sort | grep -v '[0-9]\{3\}-.*')
IMAGE_PREFIX = ${DIR_NAME}
BASE_SUBDIRS = $(notdir ${BASE_CONTAINERS})
PUBLISHED_SUBDIRS = $(notdir ${PUBLISHED_CONTAINERS})

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean upstream composite-dockerfile base $(BASE_SUBDIRS) $(PUBLISHED_SUBDIRS)

$(DIR_NAME): build
build: $(BASE_SUBDIRS) $(PUBLISHED_SUBDIRS)

# Clean in reverse-order to minimize forced image deletions because of depentent images.
clean: $(PUBLISHED_SUBDIRS) $(BASE_SUBDIRS)

upstream: $(PUBLISHED_SUBDIRS)
	@rm -rf $(BASE_CONTAINERS)

composite-dockerfile: $(PUBLISHED_SUBDIRS) $(BASE_SUBDIRS)

base: $(BASE_SUBDIRS)

$(BASE_SUBDIRS):
	$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.tag.mk \
		IMAGE_DIRECTORY=${IMAGE_PREFIX} \
		TAG_DIRECTORY=$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../ \
		COMPOSITE_DOCKERFILE=Dockerfile.composite.${IMAGE_PREFIX}

$(PUBLISHED_SUBDIRS): $(BASE_SUBDIRS)
	$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.tag.mk \
		IMAGE_DIRECTORY=${IMAGE_PREFIX} \
		TAG_DIRECTORY=$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../ \
		COMPOSITE_DOCKERFILE=Dockerfile.composite.${IMAGE_PREFIX}
