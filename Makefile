build: stop build-data

build-data:
	(cd services/data && docker-compose build --no-cache; true)

clean: stop clean-data

clean-data:
	(docker rm --force $$(docker ps --all --quiet); true)
	(docker volume rm $$(docker volume ls --quiet | grep -v vscode); true)
	echo "Docker cleaned up"

# Web based database manager, opens on http://localhost:3082/
db-admin:
	cd services/data && docker-compose up db-admin

# Opens SQL cli with database
db-cli:
	docker exec -it data_db_1 connect.sh

# Shows logs from the database server
db-logs:
	(docker logs -f $$(docker ps | grep data_db_1 | awk '{print $$1}'); true)

stop:
	(cd services/data && docker-compose down; true)

fuck: clean build db-admin