SUBDIRS = base python rails node utils

.EXPORT_ALL_VARIABLES:

build: $(SUBDIRS)

clean: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: build clean $(SUBDIRS)