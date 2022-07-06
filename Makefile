
build: dev-build stop

clean: clean-dev stop

stop:

run:

fuck: clean build run

dev-build: dev-build-base dev-build-python dev-build-rails

dev-build-base:
	docker build --file dev/base/Dockerfile --tag environment-dev-base:local-latest --tag scratchpad dev/base

dev-build-python: dev-build-base
	docker build --file dev/python/Dockerfile --tag environment-dev-python:local-latest dev/python

dev-build-rails: dev-build-base
	docker build --file dev/rails/Dockerfile --tag environment-dev-rails:local-latest dev/rails

.PHONY: list
list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'