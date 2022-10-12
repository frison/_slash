SUBDIRS = postgres pgadmin4

.EXPORT_ALL_VARIABLES:

build: $(SUBDIRS)

clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ ${MAKECMDGOALS} -f Makefile -f ${CURDIR}/../../Makefile.leaf

.PHONY: build clean $(SUBDIRS)