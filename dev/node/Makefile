SUBDIRS = 

.EXPORT_ALL_VARIABLES:
IMAGE_TO_BUILD=dev-node:local

build:
	@docker build . --tag $${IMAGE_TO_BUILD}

clean:
	@docker rmi $${IMAGE_TO_BUILD} || true

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: build clean $(SUBDIRS)
