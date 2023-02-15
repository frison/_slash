# TODO
- [ ] (1) Document each image with frontmatter + markdown
- [x] Change all `local` sourced files to be `.local` instead of `-local`
- [ ] (2) apt-lock for `apt-get install`'s in `Dockerfile` . For example, you pin every version in the installs and shit falls apart when there is a CVE (which is very good notifications). The fix would require a cache bust (no downstream apt-get updates), also forcing users to read about why it's happening.  `libpq5=14.5-0ubuntu0.22.04.1`
-- Alternative approach would involve sbom (software bill of materials) and a CVE scanner.
- [x] (3) Update github action to tag images instead of make new images for each thing (ie dev:python-latest, dev:rails, runtime:walker)

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