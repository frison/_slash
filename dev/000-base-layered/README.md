# Base Container

This container serves as the base for all other development containers. You can see what is installed by looking at the Dockerfile.

## Extension Mounts

|Mount Point|Feature|Usage|
|-|-|-|
|`/home/human/.zshrc.local`| Shell customizations | Sourced on login |
|`/home/human/.zshrc.project.local`| Shell customizations specified for user local customizations to project | Sourced on login |
|`/home/human/.zshrc.project`| Shell customizations specified for project customizations | Sourced on login |
|`/home/human/.zshrc.secrets`| Mounted environment variables | Sourced on login |
|`/home/human/.zshrc.prompt`| Prompt customizations applied after oh-my-zsh loads | Sourced on login |
|`/home/human/.vimrc.local`| Vim Customizations | Sourced on login |
