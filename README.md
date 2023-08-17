`_slash` (pronounced lodash-slash) is a convention-based pattern for using, building and publishing containers.

# The Conventions

- Every folder folder in the root of this repository represent a container's name
- Every subfolder in a container's folder represents a tag for that container
- Images and all of their tags are built using:
  - `make [folder]`
  - **OR** just an image tag is built using `cd [folder] && make [tag]`
- Images built locally will be tagged with `[folder]/[tag]:local`
- Upstream images are published [to my account on dockerhub](https://hub.docker.com/u/frison)
- There are `.github/workflows` for every `[folder]` that will build and publish the image to dockerhub.
- Environment variables are conformed across all images, and prefixed with `DEFAULT_`. So if one container expects `DATABASE_PORT` and another `DB_PORT`, those container entrypoints must map `DEFAULT_DB_PORT` to their corresponding local uses.

## Environment Variables

(note: they defaults are populated in [.env](./.env)])

|Variable|Description|
|---|---|
|DEFAULT_EMAIL|The email address to use wherever email addresses are needed|
|DEFAULT_DB_USER|The default database user|
|DEFAULT_DB_PASSWORD|The default database password|
|DEFAULT_DB_NAME|The default database name|
|DEFAULT_DB_PORT|The default database port|
|DEFAULT_DB_HOST|The default database host|


# Usage

- `make build` - will build all of the container images in the repository. This is a one-time operation, and you should only need to run it when you change the Dockerfile or any of their `files/` directory contents.
- `make clean` - will delete all the container images.
- `make upstream UPSTREAM_REGISTORY=frison` - will swap the image building to using upstream images provided as a parameter. This is useful if want to use your `_slash` images in your project, but want to save time by not building them yourself.
- `make remote GIT_REMOTE=git@github.com:frison/_slash.git` - will setup git in this directory again enabling you to pull in new dockerfiles, services, as well as to provide you an opportunity to update the upstream with any of your local changes.


Check out the [Developer Guide](./DEVELOPERS.md) for more details.
