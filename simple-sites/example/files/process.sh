#!/usr/bin/env bash

set -euo pipefail

cd /themes/default/blog
if test -e /content.tmp/about.md ; then
  mv /content.tmp/about.md /themes/default/blog/about.markdown
fi

mkdir _posts
mv /content.tmp/* /themes/default/blog/_posts

cat /config/config.yml >> /themes/default/blog/_config.yml
JEKYLL_ENV=production jekyll build

# Copy the static site to the output directory using the specified
# UID and GID run parameters, or the current user's UID and GID if not specified.
cp -r _site/* /static_site/
