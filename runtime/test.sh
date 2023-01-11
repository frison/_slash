#!/usr/bin/env sh

make build

docker run -it \
  -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" \
  -e WALKER_GIT_REPO="git@github.com:frison/_slash.git" \
  -e WALKER_GIT_REF="main" \
  -e WALKER_UPSTREAM_HOST="ofthemachine-curation.herokuapp.com" \
  -e FETCH_AFTER_COUNT=5 \
  -e WALKER_STEP_INTERVAL_IN_SEC=1 \
   runtime-walker:local \
   "printenv"