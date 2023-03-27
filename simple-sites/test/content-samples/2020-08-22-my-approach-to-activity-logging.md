---
layout: article
title:  "Indieweb Activity Logging"
summary: "My hacky solution to book blogging and exercise tracking in the indieweb."
author: Brett Kosinski
date:   2020-08-22 11:54:27 -0600
category: [ indieweb, hacking, technology ]
syndicate_to: [ twitter ]
no_fediverse: true
---

My personal blog, a static site built with Jekyll, is a bit of a frankenstein.  I really need to write some posts that get into the dirtier details of how I've stitched various bits together (like webmentions, POSSE syndication, and so on).  But for this installment I wanted to start with something I'm doing which I think is a bit unique.

So, backing up, as we all know, social media isn't just about long-form articles on Medium, medium-length rants on Facebook, or short-form trollbait on Twitter.  We also track what we read, what we listen to, what we watch, the games we're playing, the exercise we engage in, the websites we're bookmarking, and on and on.  Basically, if there's some human activity that we want to collectively experience, there's probably a social platform somewhere.

I wanted to explore these same ideas, but in the context of my blog.  First I started with replacing Goodreads.  I've since followed that by blogging my cycling [PESOS](https://indieweb.org/PESOS)-style with Strava.  In both cases I've used a combination of purpose built, locally hosted tools for collecting metadata, and then integrating those tools with my blog to enabling publishing the data to the world.

I won't claim this is a friction-free approach.  But it's working pretty well for me, so I figured it was worth sharing!

<!-- more -->

# Replacing Goodreads

Effective book blogging requires solving a few problems:

1. Sourcing and storing book covers for use in posts
2. Storing metadata for books, including author, title, series, book number, and so forth
3. Storing and publishing status updates
4. Storing and publishing reviews

I've long been a user of [Calibre](https://calibre-ebook.com), although it's primary uses have been in managing and converting ebooks and, more recently, converting content from Wallabag and tt-rss into electronic newspapers for offline reading on my Kindle (which deserves its own post, as it's absolutely magical!)

However, Calibre is also an excellent tool for simply managing and storing book metadata, even if you don't have an electronic copy of a book!  You can use it to track authors, series, publishers, and so on, and even a star rating for each book.  It also, conveniently, acts as a store for book covers.

This gave me the core idea.  Suppose I could:

1. Enter book metadata into Calibre, including the book cover I want and, for books I've read, the star rating
2. Create a new post type in Jekyll, and include the ISBN or some other identifier in the page front matter
3. Write a Jekyll plugin to pull the metadata and book cover out of the Calibre database
4. Build layouts for the blog and my RSS feeds to render the posts.

So... yeah, that's basically what I did.

First, I wrote [jekyll-library](https://github.com/fancypantalons/jekyll-library).  This plugin uses the `calibredb` tool to pull book metadata and covers out of the Calibre database.  The metadata ends up getting populated as additional page metadata, and the cover is stored in a configured location on disk.

The posts themselves--status updates and reviews--are new Jekyll post types and include in the front matter the ISBN for the book.  The layouts then use the data pulled by the plugin to render reviews and so forth in the blog!

This means my book blogging workflow is now:

1. Add the book to Calibre.
2. Write a new post of the appropriate type, and reference the ISBN.

The blog does the rest!

Then, for bonus points, I updated my [Micropub](https://indieweb.org/Micropub) implementation, [lillipub](https://github.com/fancypantalons/lillipub), to support [read](https://indieweb.org/read) posts, and then integrated with [indiebookclub](https://indiebookclub.biz/) so I can easily post quick updates!

This is admittedly a little bit tedious.  Having to manage my own book metadata database makes for some irritating data entry.  It's a real shame the automated metadata retrieval in Calibre is unavoidably so hit-and-miss.

The upside is I can engage in some quality control and can also make decisions about the book summary and so forth.  And since the data is stored in Calibre at least I only have to enter the information once and the plugin does the heavy lifting.

The rest, however, is an absolute breeze.

And, with a bit of work on the RSS feed layouts, these posts automatically syndicate to places like micro.blog and Twitter (thanks to Brid.gy).

Of course, the ultimate solution would involve a POSSE feed into Goodreads, which is on my list of things to hack on some day (although I have no doubt Amazon has made this all but impossible).  But the social aspects of this kind of book tracking aren't actually that important to me (I review books so *I* can remember what the heck I thought of them!), so it's not very high on my priority list.

# Next up, Strava

Late last year I found myself starting to take road cycling a bit more seriously.  I'm fortunate to live on the edge of the city with easy access to good quality highways, and last year I found myself out in the country on multi-hour cycling trips purely for the pleasure of riding.

This year I've started pushing myself even harder, upping my distance and trying to push my pace, and that's given me a good reason to regularly track those rides so I can assess my progress and, frankly, brag about my successes!

In the past I used Runkeeper for this kind of tracking, and while this year I moved to Strava, in either case I've always been uncomfortable with the idea that these companies were the keepers of this data[^1].  So I wanted to find a way to pull this information back and keep it for myself, and while I was at it, surface it on my blog.

Now, the fact is, in the open source world, exercise tracking is not very well-trod territory.  The best option I came across is a project called [pytrainer](https://github.com/pytrainer/pytrainer), which is a very rough-around-the-edges exercise tracking tool.  But, while rough, it does the job pretty nicely and has some similar properties to Calibre.  In particular, it can:

1. Store exercise tracking data imported from GPX files
2. Calculate time, distance, elevation, average speed, calories burned, etc, based on that data
3. Provide a place for activity titles and comments

So, could I import the exercise data into pytrainer, enter some metadata by hand, then somehow pull the information out, render a map, and then populate a blog post automatically?

Well... mostly.

First, understand that pytrainer stores activity metadata in a sqlite database by default.  So, I wrote a simple Jekyll plugin (which I haven't published yet, but will get to eventually...) that can query this data back out of the database and store it in the page metadata.  This is keyed off the pytrainer activity ID which is stored in the post front matter.

So far so good.

The hard part was map rendering.  Pytrainer doesn't render and cache a map, instead just rendering on-the-fly.  That meant I had to find a Ruby plugin to do the same job in my plugin, and so that brought me to [gpx2png](https://github.com/fancypantalons/gpx2png).  While the plugin wasn't perfect and needed some tweaks to render things the way I wanted, it did the job, using [OpenStreetMap](https://www.openstreetmap.org/) to render the stored GPX path to a graphic suitable for display in a blog post.

Finally, I created/updated my Jekyll layouts to render the activity data into a suitable format.

With that nut cracked, my workflow is now as follows:

1. Track an activity using Strava
2. Download the GPX file for the activity from Strava
3. Import the GPX into Pytrainer and enter relevant metadata, including a title and comment (which is used as the text for the blog post)
4. Create a new `activity` post type referencing the pytrainer activity ID and including the Strava activity as a syndication link

And that's basically it!

Now, as with the book workflow, this is definitely tedious.  The manual steps to pull the data down from Strava and import into Pytrainer are begging to be automated, and I'm very tempted to look into that sooner rather than later.  Assuming Strava has a decent API, I could imagine a little script that takes a Strava ID and then:

1. Automatically pulls down the GPX from the website,
2. Scrapes the title and summary from Strava itself, 
3. Pops open an editor to enter the blog post content, and finally
4. Updates the pytrainer database and creates the blog post

Heck, maybe I could even automate this to the point that it could just check for new Strava activities automatically.  Hmm...

One final thing I should note:  Because I ride so very often, my front page was getting littered with activity posts, I now exclude most of them from the front page by default.  You can see the full list in my [activity category](/archives/category/activity/).

# In conclusion

I think I'm finding an interesting pattern, here, where you:

1. Use a purpose-built tool for tracking information on some subject,
2. Pull the data out using a Jekyll plugin, and then
3. Write lightweight blog entries which automatically incorporate that metadata.

This allows you to a) control and archive your own data, b) gain a lot of value from the tools themselves, and c) leverage that same data in blogging.

Pretty nice!

[^1]: Honestly, I'm uncomfortable with them having the data at all--this type of data is in many ways very similar to healthcare information--but it's a necessary evil given the benefits these platforms offer.
