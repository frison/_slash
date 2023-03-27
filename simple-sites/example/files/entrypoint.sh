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
mkdir /content.tmp
cp -R /content/* /content.tmp

if test -e /content.tmp/about.md ; then
  mv /content.tmp/about.md /themes/default/blog/about.markdown
fi

mv /content.tmp/* /themes/default/blog/_posts

cat /config/config.yml >> /themes/default/blog/_config.yml
JEKYLL_ENV=production jekyll build
mv _site/* /static_site

exec "$@"
