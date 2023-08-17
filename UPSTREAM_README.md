# This is a placeholder for the upstream swapping capabilities that are a littlebit orthogonal to the rest of the project but awesome none the less

## Using these containers in your project

### In your repository run:
```
git submodule add git@github.com:frison/_slash.git _
cd _
cat .env >> ../.env
vim ../.env # Should have reasonable enough defaults
```

### If you want prebuilt images only (faster):
```
make upstream UPSTREAM_REGISTORY=frison
```

- `make upstream UPSTREAM_REGISTORY=frison` - will swap the image building to using upstream images provided as a parameter. This is useful if want to use your `_slash` images in your project, but want to save time by not building them yourself.
- `make remote GIT_REMOTE=git@github.com:frison/_slash.git` - will setup git in this directory again enabling you to pull in new dockerfiles, services, as well as to provide you an opportunity to update the upstream with any of your local changes.