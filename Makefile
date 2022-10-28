SUBDIRS = dev services

build: $(SUBDIRS)

clean: $(SUBDIRS)

# We only support composite-dockerfiles to simplify multi-arch builds
# because buildx can't publish manifests to local registries which means
# no caching.
composite-dockerfile: dev

upstream: dev
	rm -rf .git

remote:
	git init
	git remote add origin git@github.com:frison/_slash.git
	git fetch origin main
	git reset --soft origin/main
	git add .


$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS}

.PHONY: build clean upstream $(SUBDIRS)
