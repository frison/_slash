# How this works

This is a convention based container image builder and publisher with support for reusing scripts and base images.

## Environment

To build images locally with this tool, you'll need to have the following installed:

- `docker`
- `make`

**The above is mediocre, but it's been verified on various linux, mac, and windows systems to work without issue.**

## Project Configuration

You will need to configure your repositories action variables and action secrets.

### Action Variables

- `DOCKERHUB_USERNAME` - Your dockerhub username -- only dockerhub is supported

# Action Secrets

- `DOCKERHUB_TOKEN`

## Directory Structure

- `[:image directory:]` - The directories that represent an image and it's tags. Ie. `scratch/`
- `[:image directory:]/[0-9]-.*` - A `base image` used in all or some of the `[:tag directory:]`. Ie. `scratch/000-base` **This is not published.**
- `[:image directory:]/[:tag directory:]` - An image that will be built as `[:image directory:]/[:tag directory:]:local` (ie. `scratch/000-base:local` and `scratch/scripts:local`
- `.github/` - Contains the github actions responsible for building and publishing the images.  They will be published as `[:image directory:]:[:tag directory:]` and additional suffixes (like short-hash). (ie, `scratch:scripts`, `scratch:scripts-d3adb33`)

## The Porcelain

- `make [:image directory:]` - Will build all of the images in the `[:image directory:]` and their dependencies.
- `cd [:image directory:] && make [:tag directory:]` - Will build the image in the `[:tag directory:]` and tag it locally as `[:image directory:]/[:tag directory:]:local`.
- `cd [:image directory:] && make base` - Will build all of the base images in the `[:image directory:]`.
- `make composite-dockerfile` - Will generate a `Dockerfile.composite.[:image directory:]` file that will enable building targets in the `[:image directory:]` which will parallelize with buildx -- this is used for building the images with github actions. The targets of the `Dockerfile.composite.[:image directory]` are of the form `[:image directory:]-[:tag directory:]`. These targets have different names than the local image names because of limitations in multi-stage build names.

# Adding a new image

Add a new directory to the root of this project. Assuming it's named `[:image directory:]`, and copy an `[:other image directory:]/Makefile`. No modification are needed. All of the above `make` commands will work.

To publish these images, create `.github/workflows/[:image directory:].yml` using an existing file as an example.

# Adding a new tag for an image

Add a new directory in the `[:image directory:]`. Call it `[:tag directory:]`. No additional modifications are needed. All of the above `make` commands will work.

To publish these tags, update `.github/workflows/[:image directory:].yml` file by adding it to the matrix build.

# Caveats

Don't put `-` in your `[:image directory:]/[:tag directory:]` unless you want to fix that limitation.

|File|Tips|
|--|--|
|`services/docker-compose.yml`|env_file should not be parent of the project root while making changes, or you should make one in your project root parent|

## `git-layer`

This repository makes use of git-layers, which is an alternative to git submodules that fits this repository's needs better. To update and embed external changes into this repository using git-layer:

- Get https://github.com/frison/git-layer
- run `git-layer --apply`
