make simple-sites

docker run \
 -v "$(pwd)/simple-sites/example-test/content":/content \
 -v "$(pwd)/simple-sites/example-test/config":/config \
 -v "$(pwd)/simple-sites/example-test/static_site":/static_site \
 simple-sites-example:local
