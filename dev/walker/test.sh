#!/usr/bin/env sh

docker build ../base -t dev-base:local
docker build ../python -t dev-python:local
docker build . -t dev-walker:local
docker run -it \
  -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" \
  -e WALKER_GIT_REPO="git@github.com:frison/_slash.git" \
  -e WALKER_GIT_SHA="main" \
  -e WALKER_ENTRYPOINT="echo hello" \
  -e OTM_HOST="ofthemachine-curation.herokuapp.com"
   dev-walker:local
