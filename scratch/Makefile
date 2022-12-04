# These represent containers used by other containers in the build process that will not
# be published. They are not intended to be used directly by users.
#
# Also, base containers need to be built before any of the other containers. This isn't a problem
# when using composite dockerfiles because docker's multi-stage build will build them in the correct
# order. However, when building locally we want the base containers to be built first to clobber our existing
# :local tags.
#
# It is assumed there are no dependencies between the non-base containers.
BASE_CONTAINERS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d -regextype sed -regex '[0-9]{3}-.*' | sort)
PUBLISH_CONTAINERS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d | sort | grep -v '[0-9]{3}-.*')
IMAGE_PREFIX = $(notdir ${CURDIR})
SUBDIRS = $(notdir ${BASE_CONTAINERS}+${PUBLISH_CONTAINERS})

# Phony targets are targets that don't reference files; they are just commands -- some just happened to be named after
# subdirectories.
.PHONY: build clean upstream composite-dockerfile $(SUBDIRS)

build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(SUBDIRS)

composite-dockerfile: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.leaf \
		IMAGE_TO_BUILD=${IMAGE_PREFIX}-$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../ \
		COMPOSITE_DOCKERFILE=Dockerfile.${IMAGE_PREFIX}
