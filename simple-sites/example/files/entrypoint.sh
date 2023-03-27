#!/usr/bin/env bash

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

cd /themes/default/blog
cp -R /content /themes/default/blog/_posts
jekyll build
mv _site/* /static_site

exec "$@"
