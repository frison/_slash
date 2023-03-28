Usage
=====

Use the following mountpoints:

|  Mountpoint   | Description                                         |
| ------------- | --------------------------------------------------- |
| `/content`    | Location of markdown files representing the content |
| `/static_site`| Your markdown content turned into a static site     |
| `/config`     | Configuration files for the static site generator   |

Run the container, updating the volume paths to match your local
filesystem. For example, if you ran this command from a directory that
had the folders `test/content`, `test/config`, and `test/static_site`,
you would run:

``` shell
docker run \
  -v "$(pwd)/test/content":/content \
  -v "$(pwd)/test/config":/config \
  -v "$(pwd)/test/static_site":/static_site \
  -e UID="$(id -u)" \
  -e GID="$(id -g)" \
  frison/simple-sites:example
```

## `/content`

### `about.md`

``` yaml
---
layout: page
title: About
permalink: /about/
---

Content about your site. The beef of the about page.

```

### `yyyy-mm-dd-title-kekabs-are-tasty.md`

``` yaml
---
layout: post
title:  Welcome to Madness!
date:   2023-03-28 00:05:00 -0600
categories:
  - intro
  - progress
  - mostly-human
  - static-site-generation
---

Hey there!
I'm markdown!

I can be used for publishing to this thing.
```

## `/config/config.yml`

```
title:
email:
description: >-
  A multiline description of your site.
  Optional second line.
baseurl: "" # the subpath of your site, e.g. /blog
url: "" # the base hostname & protocol for your site, e.g. http://example.com
github_username: "" # your github username, specify it to enable github links
```

## `/static_site`

This is where the container stores the static content. Because we volume mounted above with `-v "$(pwd)/test/static_site":/static_site`, the static site will be available on your local filesystem at `$(pwd)/test/static_site`. These files will be owned by the current users `id`'s. You can serve them on `http://localhost:8080` with:

``` shell
  echo "**************************************************"
  echo "*                                                *"
  echo "*  Serving static site on http://localhost:8080  *"
  echo "*                                                *"
  echo "**************************************************"
  docker run \
    -v "$(pwd)/test/static_site":/usr/share/nginx/html \
    -p 8080:80 \
    nginx:alpine
```
