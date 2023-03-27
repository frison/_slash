make example

if test -n "$GENERATE" ; then
  sudo rm -rf test/static_site
  touch test/static_site/.gitkeep
  docker run \
    -v "$(pwd)/test/content":/content \
    -v "$(pwd)/test/config":/config \
    -v "$(pwd)/test/static_site":/static_site \
    simple-sites-example:local
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
  echo "**************************************************"
  echo "*                                                *"
  echo "*  Serving static site on http://localhost:8080  *"
  echo "*                                                *"
  echo "**************************************************"
  docker run -it \
    -v "$(pwd)/test/content":/content \
    -v "$(pwd)/test/config":/config \
    -v "$(pwd)/test/static_site":/static_site \
    simple-sites-example:local \
    bash
fi

