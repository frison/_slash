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

if test -n "${SHOW_USAGE:-}" ; then
  cat /USAGE.md
  exit 0
fi

if test -n "${SHOW_CHANGES:-}" ; then
  cat /CHANGELOG.md
  exit 0
fi

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

mkdir /content.tmp
cp -R /content/* /content.tmp
/process.sh /content.tmp
chown -R ${UID}:${GID} /static_site/*

exec "$@"
