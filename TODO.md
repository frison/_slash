# TODO
- [ ] (1) Document each image with frontmatter + markdown
- [x] Change all `local` sourced files to be `.local` instead of `-local`

# (1)
Because frontmatter in markdown is yaml, we can use it to outline (and later, build a navigatable image registry with feature capabilities).
```
---
image: dev-base
description: Base container for development containing common tools, shells, and configuration.
environment:
    ENVIRONMENT_VARIABLE_1: Used for XYZ
    ENVIRONMENT_VARIABLE_2: Used for ABC
mount-points:
    /home/human/.zshrc.local:
    /home/human/.zshrc.secrets:
    /home/human/.vimrc.secrets:
---
```