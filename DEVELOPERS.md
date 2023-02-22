# How this works

## Environment

To build images locally with this tool, you'll need to have the following installed:

- `docker`
- `make`

**The above is mediocre, but it's been verified on various linux and mac systems to work without issue.**

## Directory Structure

- `[:image directory:]` - The directories that represent an image and it's tags. Ie. `scratch/`
- `[:image directory:]/[0-9]-.*` - A `base image` used in all or some of the `[:tag directory:]`. Ie. `scratch/000-base` **This is not published.**
- `[:image directory:]/[:tag directory:]` - An image that will be built as `[:image directory:]-[:tag directory:]:local` (ie. `scratch-000-base:local` and `scratch-scripts:local`
- `.github/` - Contains the github actions responsible for building and publishing the images.  They will be published as `[:image directory:]:[:tag directory:]` and additional suffixes (like short-hash). (ie, `scratch:scripts`, `scratch:scripts-d3adb33`)

### Caveats

Don't put `-` in your `[:image directory:]/[:tag directory:]` unless you want to fix that limitation.

## The Porcelain

- `make [:image directory:]` - Will build all of the images in the `[:image directory:]` and their dependencies.
- `cd [:image directory:] && make [:tag directory:]` - Will build the image in the `[:tag directory:]` and tag it locally as `[:image directory:]-[:tag directory:]:local`.
- `cd [:image directory:] && make base` - Will build all of the base images in the `[:image directory:]`.
- `make composite-dockerfile` - Will generate a `Dockerfile.composite.[:image directory]` file that will enable building targets in the `[:image directory:]` which will parallelize with buildx -- this is used for building the images with github actions. The targets of the `Dockerfile.composite.[:image directory]` are of the form `[:image directory:]-[:tag directory:]`

# Adding a new image

Add a new directory to the root of this project. Call it `[:image directory:]`, and copy an `[:other image directory:]/Makefile`. No modification should be needed. All of the above `make` commands will work without modification

If you wish to publish these images, you have to create `.github/workflows/[:image directory:].yml` file using an existing file as an example.

# Adding a new tag for an image

Add a new directory in the `[:image directory:]`, all of the above `make` commands will work without modification. To have it automatically published, you have to add it to the `.github/workflows/[:image directory:].yml` file by adding it to the matrix build.

|File|Tips|
|--|--|
|`services/docker-compose.yml`|env_file should not be parent of the project root while making changes, or you should make one in your project root parent|
