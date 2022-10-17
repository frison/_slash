SUBDIRS = dev services

build: $(SUBDIRS)

clean: $(SUBDIRS)

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
