---
layout: article
title: The Gallery Cometh
author: Brett Kosinski
date: 2006-07-19 02:00:00 -0700
category: [ hacking, wiki ]
no_fediverse: true
---

I decided to take a tour through my collection of digital camera photos and was, frankly, surprised at how much **stuff** I had.  Worse, none of it was terribly accessible nor shareable.  And so I finally cracked and decided it was time to get some kind of photo gallery going on.

Now, I could have one with [Gallery](http://gallery.sourceforge.net), which [Brad](http://blog.8r4d.com/) has used to power his [photo gallery](http://gallery.pixelazy.com), but I really wanted something that would integrate directly into my wiki, so that I could easily incorporate gallery photos into wiki pages, comment on them in the normal fashion, etc, etc.  Unfortunately, nothing of the sort really exists for Oddmuse, meaning it was time to roll my own.

The result is my [Gallery](Gallery.md).  It's pretty bare bones, at this point... really, it's just functional enough to be useful.  It can:

* Add galleries and images through a standard web interface.
* Support infinite nesting of galleries.
* Handle zips and tarballs, as well as standard image formats.
* Does the usual pagination stuff, so you don't get all gallery images at once.
* Does on-demand scaling of images, so people can choose different resolutions.

And all of this is done in the context of the standard wiki subsystems, so you can comment, search, etc (though search is b0rked for image captions and descriptions right now... that's on my todo list).

Anyway, there you have it.  Take a look.  Give me feedback if you like.  And if I can make the code, you know, not horrible, I'll release the source to it.

