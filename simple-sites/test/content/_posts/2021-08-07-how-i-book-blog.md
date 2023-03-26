---
layout: article
title:  "How I Book Blog"
summary: "I used to use Goodreads for tracking/reviewing books I've read. Then Amazon bought them and I decided to move all that stuff to my own blog. This is how I did it!"
author: Brett Kosinski
date:   2021-08-07 17:04:12 -0600
category: [ indieweb, ownyourdata ]
syndicate_to: [ twitter, indienews ]
no_fediverse: true
---

So while it turns out I forgot I'd posted about this topic [a while ago](2020-08-22-my-approach-to-activity-logging.md), it seemed worth revisiting and writing a focused post on how I'm book blogging.

Anyway, I don't know about you, but I tend to have a remarkably poor memory for the books I've read.  After I've finished a book or series, it doesn't take long for the details to get washed out and for my thoughts to blur into vague recollections  of what the book made me think and feel.  It was for this reason that I started using Goodreads.

For me, Goodreads served a few useful functions.  First, it gave me a place to track what I'm reading and, more importantly, what I've read.  Second, it gave me a spot to jot down my thoughts about books so that, later, I could go back and read those notes and refresh my memory.

But that meant trapping all of that information in someone else's silo, and I was never particularly comfortable with that.  And when Amazon went and bought Goodreads, I basically stopped using the service, and as a result, stopped tracking my reading.

When I decided to [reinvent my blog](2020-01-02-re-inventing-my-blog.md), I undertook the project with a central goal in mind:  to take back control over my own data and content.  To that end, book blogging was a perfect fit for this vision, and so I wanted to describe how I've leveraged approaches from the [IndieWeb](https://indieweb.org/) to solve this problem and [scratch my own itch](https://indieweb.org/scratch_your_own_itch).

By the way, I want to thank [Jamie Tanna](https://www.jvt.me/) and their post on [a Microformats API for Books](https://www.jvt.me/posts/2021/08/01/books-microformats/) which reminded me to finally write this post!

<!-- more -->

# The problem

For me, book blogging involves tracking a few key events[^1]:

1. Starting a book
2. Finishing a book
3. Recording a review for a book

By itself, this looks pretty straight forward!  For a static site like my own, which is based on [Jekyll](jekyllrb.com/), you could create page layouts for each of the event types containing appropriate [microformats](http://microformats.org) to mark up the content, and then write posts for each event.  Combined with a [micropub](https://indieweb.org/Micropub) endpoint that knows how to deal with [read posts](https://indieweb.org/read) and you have a pretty nice solution!

But as Jamie highlighted in their own post on this topic, one of the big challenges with book blogging in general is capturing and storing metadata about books.  In the case of my blog, for each of the aforementioned events I wanted to include a bunch of information about the book, including things like:

1. Title and author
2. Series and book number
3. Publication date
4. Cover image

The problem is that having to enter this information in every entry is an enormous pain, particularly for those read/finished posts, which you really want to be able to fire off quickly and easily to minimize the friction of posting.

Jamie's post outlines a solve for this by providing an API which can be used by IndieWeb sites to pull book metadata during the site build.

However, when I came up with my solution this API didn't exist!

At the time, in my mind, what I really wanted was something that would make it easy to scrape metadata for books I'm reading from an external source, including pulling cover images from search engines, and then store it locally so that it was really easy to edit that metadata to correct inaccuracies and so forth.  That way I could automate sourcing the raw metadata from elsewhere (obviating the need to hand-enter it), while still being able to manage and curate the information.

And if those external data sources later disappeared, my database wouldn't, which is a key benefit of owning your data.

With that idea in mind, I ended up taking a very different approach, and it starts with [Calibre](https://calibre-ebook.com/).

# Calibre as book database

Calibre is an extremely popular ebook management tool that supports tracking and storing digital books and their associated metadata.  Critically, it has a number of very nice attributes that made it an interesting option for me:

1. It has a very nice user interface for managing books, both individually and in bulk,
2. It has built in functions for scraping book metadata from popular sources, obviating the need to build that separately,
3. I was already using it!

My thinking went as follows:  what if I could use Calibre to maintain my own ebook database, complete with metadata and covers I've pulled from the web?  Then, I could write a Jekyll plugin that, upon build, would look up an ISBN specified in the page front matter, pull the relevant data from Calibre, and then populate the page.

But how do we get the data *out* of Calibre?

Well, this is the point where I discovered that, to my great surprise, it turns out Calibre has a very rich set of [command-line tools](https://manual.calibre-ebook.com/generated/en/cli-index.html)[^2].  And one of those tools is [calibredb](https://manual.calibre-ebook.com/generated/en/calibredb.html), which is a command-line tool for manipulating and querying data out of the Calibre database and presenting it in both human-readable and machine-readable formats.

# My solution

My solution starts with a new Jekyll plugin called [jekyll-library](https://github.com/fancypantalons/jekyll-library).  This plugin functions roughly as follows:

1. Find all pages that have an `isbn` attribute in the front matter
2. For each matching page, use `calibredb` to query book metadata from the Calibre database
3. Extract the book cover image from the Calibre database and store it in a configured target directory
4. Populate a new object called `book`, stored with the page data, containing the book metadata and the path to the cover image

Then, in Calibre, in addition to the ISBN, I added a few extra custom ids in the "Ids" block that store URIs for the author, book, and series, which allows me to automatically link to those external references in my posts.

This approach means any page that wants to reference metadata from my Calibre database can just include the `isbn` front matter and the plugin does the rest.

After that, it's up to the user to create page layouts that take advantage of this metadata.  In particular, I've created `read` and `review` post types with associated layouts.  For example, a review post might look like:

```
---
layout: review
title: "Review: Some book I read"
summary: "I'm reviewing this book that I read!"
author: Brett Kosinski
date:   2021-08-01 21:19:56 -0700
category: [ books ]
isbn: '1234567890123'
---
Here's a whole bunch of words about what I thought about this book.
```
The plugin and layout then does the rest!

A `read` post is even simpler:

```
---
layout: read
title: Currently reading Some Book
author: Brett Kosinski
date: 2020-03-08 15:14:03.929981684 -06:00
isbn: '1234567890123'
status: reading
category: [ books ]
---
```

Status, in this case, could be `reading` or `finished`.  Easy!

Finally, I updated my micropub endpoint to generate appropriate pages when a `read` post is sent in, which works really nicely with [indiebookclub](https://indiebookclub.biz/).

So what about publishing?

Since mine is a static site, my approach to publishing is pretty standard, in that my blog is managed as a git repository, and publishing means doing a `git push` to my server.  To that process I added a git pre-push hook that uses rsync to copy my calibre database to my server.  The server-side then has a post-commit hook to trigger the site build.[^3]

And, of course, because these are just another set of posts and I have full control over the infrastructure, they can be syndicated to other silos via [Brid.gy](https://brid.gy/), syndicated to [Micro.blog](https://micro.blog) via RSS, and so on.

What I really love about this setup is that, first, I'm not bound to any external source of book metadata.  Because I control my data source, there's no danger of metadata disappearing, covers being removed, and so forth.  That puts me fully in control of my site.

The other big benefit, for me, is that this lets me leverage something I was already doing with Calibre.  I've long used Calibre as a way to store and manage my ebook library, and this approach to book blogging builds on that approach and encourages me to keep my Calibre database clean and up-to-date.  Win win!

[^1]: Note, there's others you can imagine, here, including progress updates or "plan to read" posts, but I've not bothered with either of these at this time, as I don't find them personally useful.
[^2]: My initial crack at this actually involved directly running `fetch-ebook-metadata`, which provides a command-line interface to Calibre's underlying book metadata scraping infrastructure.  However, it didn't take me long to discover there was always going to be some human intervention required to clean up and correct the results.
[^3]: Astute readers will note that `read` events coming from indiebookclub require that the metadata be in the Calibre database, and the database be sync'd to the server, before the event can be pushed.  This is definitely a little bit cumbersome, but not so much that it's proven to be an issue.
