#!/usr/bin/env bash

. /shell_utils/core

validate_env_exists "SSH_PRIVATE_KEY" "to access the git repo"
validate_env_exists "WALKER_GIT_REPO" "to checkout the walker repo"
validate_env_exists "WALKER_GIT_REF" "to checkout the desired version of the walker repo"

export WALKER_UPSTREAM_HOST=${WALKER_UPSTREAM_HOST:-"ofthemachine-curation.herokuapp.com"}
export WALKER_STEP_INTERVAL_IN_SEC=${WALKER_STEP_INTERVAL_IN_SEC:-5}
export FETCH_AFTER_COUNT=${FETCH_AFTER_COUNT:-10}
export GIT_REPO=${WALKER_GIT_REPO}

. /shell_utils/workdir

# Prepare the ssh key
mkdir -p ~/.ssh
export SSH_PRIVATE_KEY_PATH=~/.ssh/walker_github_private_key
echo "$SSH_PRIVATE_KEY" > $SSH_PRIVATE_KEY_PATH
chmod 600 $SSH_PRIVATE_KEY_PATH

# Unset all env vars that end in _PRIVATE_KEY, ie SSH_PRIVATE_KEY, but a little more aggressive
# because some k8s env vars have _PRIVATE_KEY in them
unset $(printenv | cut -f1 -d=  | grep '.*_PRIVATE_KEY$')

cd $WORK_DIR
git init
git remote add origin $WALKER_GIT_REPO

pull() {
  # Skipping host checking would require adding github to known hosts prior to checkout
  # Which is doable, but not worth the effort atm
  GIT_SSH_COMMAND="ssh -i $SSH_PRIVATE_KEY_PATH -o StrictHostKeyChecking=no" git fetch --depth 1 origin $WALKER_GIT_REF

  # If the refs are branches, we need to nuke them or things will look like they've diverged and the checkout
  # will fail.
  git for-each-ref --format '%(refname:short)' refs/heads | xargs git branch -D || true
  # We fetched it, now we check it out.
  git checkout $WALKER_GIT_REF
  git checkout -b walker-$(date +%s)
  git clean --force -dx
  export GIT_REF=$(git rev-parse --short HEAD)
}

pull

# Want to nuke this to prevent exfil of the private key from walkers
# SECURITY: The ssh key is only for pulling repos -- or at least should be. We keep it around
# so the walker can update itself
#
trap "STOP=1" SIGINT SIGTERM

COUNTER=1

while [[ $STOP -eq 0 ]]; do
    if [ $(( $COUNTER  % $FETCH_AFTER_COUNT)) -eq 0 ]; then
        pull
    fi
    sh -c "$@"
    sleep $WALKER_STEP_INTERVAL_IN_SEC
    let COUNTER=COUNTER+1
done
