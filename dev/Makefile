SUBDIRS = base python node rails utils

build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(SUBDIRS)

composite-dockerfile: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.leaf \
		IMAGE_TO_BUILD=dev-$@ \
		COMPOSITE_DOCKERFILE_DIR=${CURDIR}/../

.PHONY: build clean upstream $(SUBDIRS)
