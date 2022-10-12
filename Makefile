SUBDIRS = dev services

.EXPORT_ALL_VARIABLES:

build: $(SUBDIRS)

clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ ${MAKECMDGOALS}

.PHONY: build clean $(SUBDIRS)