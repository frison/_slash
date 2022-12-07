#!/usr/bin/env sh

make build

docker run -it \
  -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" \
  -e WALKER_GIT_REPO="git@github.com:frison/_slash.git" \
  -e WALKER_GIT_REF="main" \
  -e OTM_HOST="ofthemachine-curation.herokuapp.com" \
   runtime-walker:local \
   "./services/data/postgres/files/bin/connect.sh"