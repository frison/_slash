# Usage

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

# Coalesce on null+empty
${FOO:-${BAR:-default}}

# Coalesce on null (unset)
${FOO-${BAR-default}}

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
    - env_file should not be parent of the project root while making changes, or you should make one in your project root parent
services/data/docker-compose.yml
    - env_file should not be parent of the project root while making changes, or you should make one in your project root parent