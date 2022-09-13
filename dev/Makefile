SUBDIRS = base python node rails utils

.EXPORT_ALL_VARIABLES:

build: $(SUBDIRS)

clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: build clean $(SUBDIRS)