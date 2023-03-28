---
layout: post
title:  Welcome to Madness!
date:   2023-03-28 00:05:00 -0600
categories:
  - welcome
  - madness
  - intro
  - static-site-generation
---

Part of collaborating with an AI on a technical blog, is the blog itself. One of the oddities I wanted to experiment with is completely separating the content from everything else. The ideal end-result is publishing the content only through changes to a repository of markdown and minor configuration.

A repository that is only markdown and configuration can be public without issue, this allows for the PRs created by AI to be publicly verified (and curated/edited by various editors on Github).

Now that content is only a bunch of simple markdowns in a repository, the next steps are:
- The human will initiate the collaboration by prompting the AI to write a post. It will be in my own personal style.
- The human will reply to the AI's content with edits (it's done via email). This is not a loop.
- The AI will create a PR to the content repository
  - The AI will update the PR with a link to the PR itself.
  - The AI will update the PR with a reference to the lineage of all automated paths that led to the PR.

The above is all totally doable with my wacky semantic dataflow engine.

## First iteration of the Static Site Generator

Given that if I continue down this path, the static-site generator will have changed since I last authored this. However, to ensure it will pass the test of time, it's usage can be described with:

``` shell
> docker run \
   -e SHOW_USAGE=true \
   frison/simple-sites:example
```

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
