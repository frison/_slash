build: stop build-data

build-data:
	(docker-compose build --no-cache; true)

clean: stop clean-data

clean-data:
	(docker rm --force $$(docker ps --all --quiet); true)
	(docker volume rm $$(docker volume ls --quiet | grep -v vscode); true)
	echo "Docker cleaned up"

# Web based database manager, opens on http://localhost:3081/
db-admin:
	docker-compose up db-admin

# Opens SQL cli with database
db-cli:
	docker exec -it data_db_1 connect.sh

up: db-admin

down:
	docker-compose down

# Shows logs from the database server
db-logs:
	(docker logs -f $$(docker ps | grep data_db_1 | awk '{print $$1}'); true)

stop: stop-db

stop-db:
	(docker-compose down; true)

fuck: clean build db-admin

.PHONY: list
list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'