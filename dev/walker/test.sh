#!/usr/bin/env sh

docker build . -t dev-walker:local
docker run -it \
  -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" \
  -e WALKER_GIT_REPO="git@github.com:frison/_slash.git" \
  -e WALKER_GIT_SHA="main" \
  -e WALKER_ENTRYPOINT="echo hello" \
   dev-walker:local