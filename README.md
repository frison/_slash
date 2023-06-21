lodash-slash (`_slash`) is a simplified convention based pattern for container building, publishing, and using in your development environment.

# Making changes

Go to [DEVELOPERS.md](DEVELOPERS.md)

# Usage

- `make build` - will build all of the container images in the repository. This is a one-time operation, and you should only need to run it when you change the Dockerfile or any of their `files/` directory contents.
- `make clean` - will delete all the container images.
- `make upstream UPSTREAM_REGISTORY=frison` - will swap the image building to using upstream images provided as a parameter. This is useful if want to use your `_slash` images in your project, but want to save building them yourself.
- `make remote GIT_REMOTE=git@github.com:frison/_slash.git` - will setup git in this directory again enabling you to pull in new dockerfiles, services, as well as to provide you an opportunity to update the upstream with any of your local changes.

## Using these containers in your project

### In your repository run:
```
git submodule add git@github.com:frison/_slash.git _
cd _
cat .env >> ../.env
vim ../.env # Should have reasonable enough defaults
```

### If you want prebuilt images only (faster):
```
make upstream UPSTREAM_REGISTORY=frison
```

### Build the images
```
make build
```

## Verification (you will likely need to modify the .env location in the services file):
```
cd _
COMPOSE_FILE=services/docker-compose.yml docker-compose up
echo "http://localhost:3081" # Should be accessible and show pgadmin4
docker-compose run db-cli
```

## Starting the database

It's likely the `services/docker-compose.yml` file will need it's `.env` path updated.

After that is done, you can start the database with:
`COMPOSE_FILE=services/docker-compose.yml docker-compose up`

This will do many things:
- Will use a shared named network "database"
- Will host a web ui on http://localhost:3081
- Adheres to .env
- Will require make clean build on .env changes
