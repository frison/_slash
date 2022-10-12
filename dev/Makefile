SUBDIRS = base python node rails utils

build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../Makefile.leaf \
		IMAGE_TO_BUILD=dev-$@

.PHONY: build clean upstream $(SUBDIRS)