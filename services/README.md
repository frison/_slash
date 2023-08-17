# Services Images

## The Conventions

- Every tagged image in this directory will be added to the `docker-compose.yml` file for use elsewhere.
- Environment variables are conformed across services. That is, if one services uses `DB_PORT` then all services will use `DB_PORT`. This conformance is done through the container's entrypoints.

## Running the Services

In the root of this repository, run:
```
echo "*****************************************************************"
echo "Once the database-admin service is running, you can access it at:"
echo "http://localhost:3081"
echo "*****************************************************************"
COMPOSE_FILE=services/docker-compose.yml docker-compose up
```

## Port Mappings

|Service|Host|Container|Service Dependencies|
|---|---|---|---|
|database|5432|5432||
|database-ui|3081|80|database|
