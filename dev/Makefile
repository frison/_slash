SUBDIRS = base python node rails utils

.EXPORT_ALL_VARIABLES:

build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ ${MAKECMDGOALS} -f Makefile -f ${CURDIR}/../Makefile.leaf

.PHONY: build clean upstream $(SUBDIRS)