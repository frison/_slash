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
