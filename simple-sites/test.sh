#!/bin/sh

if test -z "${NO_BUILD:-}" ; then
  make example
else
  echo "Skipping build. NO_BUILD parameter set."
fi

if test -n "$GENERATE" ; then
  rm -rf "$(pwd)/test/static_site/*"
  touch "$(pwd)/test/static_site/.gitkeep"
  docker run \
    -v "$(pwd)/test/content":/content \
    -v "$(pwd)/test/config":/config \
    -v "$(pwd)/test/static_site":/static_site \
    -e UID="$(id -u)" \
    -e GID="$(id -g)" \
    simple-sites/example:local
fi

if test -n "$SERVE" ; then
  echo "**************************************************"
  echo "*                                                *"
  echo "*  Serving static site on http://localhost:8080  *"
  echo "*                                                *"
  echo "**************************************************"
  docker run \
    -v "$(pwd)/test/static_site":/usr/share/nginx/html \
    -p 8080:80 \
    nginx:alpine
fi

if test -n "$ENTER" ; then
  docker run -it \
    -v "$(pwd)/test/content":/content \
    -v "$(pwd)/test/config":/config \
    -v "$(pwd)/test/static_site":/static_site \
    simple-sites-example:local \
    bash
fi

