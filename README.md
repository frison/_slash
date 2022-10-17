lodash-slash (`_slash`) is a development environment bootstrapper. It allows you to build (or utilize the upstreams) container images for your development environment, and then run them in a way that is easy to use and maintain.

# Usage

This project is designed to be used as a submodule of other projects. It does the following stuff not bad:
- The source of all containers for the project
  - How the containers are built
- Serves as the home for any services you need
  - Demonstrates useful patterns for hooking into containers initializers
  - Has a docker-compose.yml file that can be used as dependent services or initialized in a development container
- Forces consistent environment variables across your containers
- Demonstrates useful patterns for hooking into containers
- No downstream `apt-get update` . For example, if a container is based on `dev-base:local` it must not run `apt-get update` even if a package update would require it. The base images needs to have it's cache busted and everyone needs to read why.

In your repository run:
```
git submodule add git@github.com:frison/_slash.git _
cd _
cat .env >> ../.env
vim ../.env # Should have reasonable enough defaults
make build
```

Verification:
```
cd _
COMPOSE_FILE=services/docker-compose.yml docker-compose up
echo "http://localhost:3081" # Should be accessible and show pgadmin4
docker-compose run db-cli
```

# Good Enough Bash Patterns

|Category|What|Snippet|
|---|---|---|
|Environment Variables|Coalesce (use 'default') on null or empty|`${FOO:-${BAR:-default}}`|
|Environment Variables|Coalesce (use 'default') on null|`${FOO-${BAR-default}}`|

# The Makefile list of targets
https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile

# Starting the database
cd services/data && make db-admin
- Will use a shared named network "database"
- Will host a web ui on http://localhost:3081
- Adheres to .env
- Will require make clean build on .env changes

# Running a dev container
Make sure to start the database first
cd environments
make build
docker-compose run [python-cli|rails-cli|...]

# Making changes

environments/docker-compose.yml
    - You must make an .env file in the parent of the root directory
services/data/docker-compose.yml
    - env_file should not be parent of the project root while making changes, or you should make one in your project root parent