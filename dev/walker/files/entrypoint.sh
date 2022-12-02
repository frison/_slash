#!/usr/bin/env sh

. /shell_utils/core

validate_env_exists "SSH_PRIVATE_KEY" "to access the git repo"
validate_env_exists "WALKER_GIT_REPO" "to checkout the walker repo"
validate_env_exists "WALKER_GIT_SHA" "to checkout the desired version of the walker repo"
validate_env_exists "WALKER_ENTRYPOINT" "to run the walker"
export WALKER_STEP_INTERVAL=${WALKER_STEP_INTERVAL:-5}

. /shell_utils/workdir

# Prepare the ssh key
mkdir -p ~/.ssh
export SSH_PRIVATE_KEY_PATH=~/.ssh/walker_github_private_key
echo "$SSH_PRIVATE_KEY" > $SSH_PRIVATE_KEY_PATH
chmod 600 $SSH_PRIVATE_KEY_PATH

cd $WORK_DIR
git init
git remote add origin $WALKER_GIT_REPO

# Skipping host checking would require adding github to known hosts prior to checkout
# Which is doable, but not worth the effort atm
GIT_SSH_COMMAND="ssh -i $SSH_PRIVATE_KEY_PATH -o StrictHostKeyChecking=no" git fetch --depth 1 origin $WALKER_GIT_SHA

# Want to nuke this to prevent exfil of the private key from walkers
rm $SSH_PRIVATE_KEY_PATH

# Start the first process
while [ $STOP -eq 0 ]; do
    sh -c "$WALKER_ENTRYPOINT"
    sleep $WALKER_STEP_INTERVAL
done

echo "got stopped"