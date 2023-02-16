IMAGE_ABSOLUTE_PATHS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d | grep -v '\.[a-zA-Z0-9]*$$' | sort)
SUBDIRS = $(notdir ${IMAGE_ABSOLUTE_PATHS})

build: $(SUBDIRS)
clean: $(SUBDIRS)
clean-composite-dockerfile:
	rm -f Dockerfile.composite.*

# We only support composite-dockerfiles to simplify multi-arch builds
# because buildx can't publish manifests to local registries which means
# we can't use the `FROM dev-base:local` statements.
composite-dockerfile: clean-composite-dockerfile $(SUBDIRS)

upstream: $(SUBDIRS)
	rm -rf .git
	rm -rf .github

remote:
	git init
	git remote add origin git@github.com:frison/_slash.git
	git fetch origin main
	git reset --soft origin/main
	git add .

remote-clean: remote
	git restore --staged .
	git checkout .

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS}

.PHONY: build clean upstream $(SUBDIRS)

# We release on tags starting with v
release:
	git tag v$(VERSION)
	git push origin v$(VERSION)

# Nuke the remote tag
unrelease:
	git tag -d v$(VERSION)
	git push --delete origin v$(VERSION)

