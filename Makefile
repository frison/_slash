IMAGE_ABSOLUTE_PATHS = $(shell find ${CURDIR} -mindepth 1 -maxdepth 1 -type d | grep -v '\.[a-zA-Z0-9]*$$' | sort)
SUBDIRS = $(notdir ${IMAGE_ABSOLUTE_PATHS})

.PHONY: build clean upstream clean-composite-dockerfile composite-dockerfile upstream-confirm $(SUBDIRS)

build: $(SUBDIRS)
clean: $(SUBDIRS)
clean-composite-dockerfile:
	rm -f Dockerfile.composite.*

# We only support composite-dockerfiles to simplify multi-arch builds
# because buildx can't publish manifests to local registries which means
# we can't use the `FROM dev-base:local` statements.
composite-dockerfile: clean-composite-dockerfile $(SUBDIRS)

upstream-confirm:
	@echo "Are you sure you want to delete _slash's .git (and more) directories?"
	@echo "If you have local changes you want to keep, you should commit and push them first."
	@echo -n "[y/N] : "
	@read ans; if [ "$$ans" != "y" ]; then exit 1; fi

upstream: upstream-confirm $(SUBDIRS)
	rm -rf .git
	rm -rf .github

remote:
	git init
	git remote add origin $${GIT_REMOTE}
	git fetch origin main
	git reset --soft origin/main
	git add .

remote-clean: remote
	git restore --staged .
	git checkout -- .
	git checkout main

$(SUBDIRS):
	@$(MAKE) -C $@ ${MAKECMDGOALS}

# We release on tags starting with v
release:
	git tag v$(VERSION)
	git push origin v$(VERSION)

# Nuke the remote tag
unrelease:
	git tag -d v$(VERSION)
	git push --delete origin v$(VERSION)

