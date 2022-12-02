#!/usr/bin/env sh

set -eu

. /shell_utils/core

validate_env_exists "$SSH_PRIVATE_KEY" "to access the git repo"
validate_env_exists "$WALKER_GIT_REPO" "to checkout the walker repo"
validate_env_exists "$WALKER_GIT_SHA" "to checkout the desired version of the walker repo"
validate_env_exists "$WALKER_ENTRYPOINT" "to run the walker"
export WALKER_STEP_INTERVAL=${WALKER_STEP_INTERVAL:-5}

. /shell_utils/workdir

# Prepare the ssh key
export SSH_PRIVATE_KEY_PATH="~/.ssh/walker_github_private_key"
echo "$SSH_PRIVATE_KEY" > $SSH_PRIVATE_KEY_PATH
chmod 600 $SSH_PRIVATE_KEY_PATH

cd $WORK_DIR
git init
git remote add origin $WALKER_GIT_REPO
GIT_SSH_COMMAND="ssh -i $PRIVATE_KEY_PATH -o IdentitiesOnly=yes" git fetch --depth 1 origin $WALKER_GIT_SHA

# Start the first process
while [ $STOP -eq 0 ]; do
    sh -c "$WALKER_ENTRYPOINT"
    sleep $WALKER_STEP_INTERVAL
done

echo "got stopped"