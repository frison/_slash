SUBDIRS = postgres pgadmin4

build: $(SUBDIRS)

clean: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS} -f ${CURDIR}/../../Makefile.leaf \
		IMAGE_TO_BUILD=services-data-$@

.PHONY: build clean $(SUBDIRS)