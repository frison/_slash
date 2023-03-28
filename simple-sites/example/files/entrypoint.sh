#!/usr/bin/env bash

set -euo pipefail

warn () {
  echo >&2 "warning : $@"
}

die () {
  cat /USAGE.md
  echo >&2 "$@"
  exit 1
}

if ! test -d /content ; then
  die "fatal : No content directory found."
fi

if ! test -d /static_site ; then
  die "fatal : No static site output directory found."
fi

if ! test -d /config ; then
  die "fatal : No config directory found."
fi

if ! test -f /config/config.yml ; then
  die "fatal : No config.yml file found."
fi

if test -z "${UID:-}" ; then
  warn "No UID specified. Using current user's UID."
  export UID=$(id -u)
fi

if test -z "${GID:-}" ; then
  warn "No GID specified. Using current user's GID."
  export GID=$(id -g)
fi

cd /themes/default/blog
mkdir /content.tmp
cp -R /content/* /content.tmp
./process.sh /content.tmp

if test -e /content.tmp/about.md ; then
  mv /content.tmp/about.md /themes/default/blog/about.markdown
fi

mv /content.tmp/* /themes/default/blog/_posts

cat /config/config.yml >> /themes/default/blog/_config.yml
JEKYLL_ENV=production jekyll build

# Copy the static site to the output directory using the specified
# UID and GID run parameters, or the current user's UID and GID if not specified.
cp -r _site/* /static_site/
chown -R ${UID}:${GID} /static_site/*

exec "$@"
