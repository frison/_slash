SUBDIRS = dev services

build: $(SUBDIRS)

clean: $(SUBDIRS)

upstream: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS}

.PHONY: build clean upstream $(SUBDIRS)