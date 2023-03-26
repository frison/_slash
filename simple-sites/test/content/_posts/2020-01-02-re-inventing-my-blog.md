---
layout: article
title:  "Reinventing my blog"
summary:  "Most of what you see from me starts on my blog. Tweets, photos, or articles, I post them on my blog and syndicate. Part 1 on why and how!"
author: Brett Kosinski
date:   2020-01-02 22:26:01 -0700
category: [ indieweb ]
syndicate_to: [ twitter ]
no_fediverse: true
---

# The idea

If you've been paying attention to [my](2019-11-11-moving-to-jekyll.md) [writing](2019-11-17-posting-to-twitter.md) [lately](2019-11-18-dangers-of-silos.md), [you'll](2019-11-18-indieweb-success.md) [notice](2019-11-25-my-micropub-endpoint-lillipub.md) a [theme](2019-12-01-markdown-all-the-things.md).  Toward the end of November I got it into my head to rebuild my blog for reasons that, in hindsight, I don't actually remember[^1][^2].

At the time my main goal was to change the technology over from an old blog engine to something a bit more modern.  But as I thought more about what I wanted for my blog, and read more about the IndieWeb movement, I realized my idea of what a blog could be was incredibly limited.

To their great credit, modern walled garden web services have given us with a lot of ways to express ourselves:

* Short notes (tweets, status updates)
* Long-form content (blog posts, articles)
* Photos
* Reactions (likes)
* Shares (bookmarks, retweets)

Not to mention more specialized status updates like what we're reading, what we're listening to, etc.

Each of these represents a piece of content we're creating and publishing.  We may not think of it that way because firing off a tweet or writing a quick status update is so easy.  But they're all just alternative formats for self-expression.

Unfortunately, as I've noted [previously](2019-12-22-indiewebbing.md), because these are each their own walled garden, this content is split up and spread out across many services.  At best this is annoying[^3]!  At worst, it's a great way to ensure that the things we write or post could get [lost someday](https://www.buzzfeednews.com/article/katienotopoulos/how-we-killed-the-old-internet) when those services inevitably die.

And then, as I read more about the IndieWeb, I realized I'd been thinking about my blog all wrong.

Yeah, sure, traditionally blogs were the home primarily for long-form content.  But it's my blog.  It can be whatever I want it to be.  So, why not turn my blog into the place where I post *all* of the things!  And then, after authoring on my own site, automatically *syndicate* to those social networks!

<!-- more -->

# First, a picture

I'm going to be upfront with you:  What I'm about to outline here, and then describe in subsequent posts, is not for the faint of heart.  I suspect I could've done this all a lot more easily with Wordpress.  And services like [micro.blog](http://micro.blog) are working to make things even more turnkey.

But I'm a nerd and I like doing things the hard way[^4].

So, here's my blog in a nutshell:

{% digraph Workflow %}
graph [ bgcolor = "transparent", penwidth = 0.1 ]
node [ margin = 0.2 ]
Server [ label = "Web Server" ]
Webmention [ label = "Webmention.io" ]
Bridgy [ label = "Brid.gy" ]
Microblog [ label = "Micro.blog" ]

Markdown -> Jekyll [ label = "      1  " ]
Jekyll -> Server [ label = "  2, 8  " ]
Jekyll -> Bridgy [ label = "  3a  " ]
Bridgy -> Twitter [ label = "  4  " ]
Twitter -> Bridgy [ label = "  5  " ]
Bridgy -> Webmention [ label = "  6a  " ]
Webmention -> Jekyll [ label = "  7  " ]
Jekyll -> Microblog [ label = "  3b  " ]
Microblog -> Webmention [ label = "  6b  " ]
{% enddigraph %}

Yeah, okay, so it looks a little complicated.  And it is!  It also took a long time to get right, and in subsequent posts I plan to zoom in and get into some of the details.

But for now we'll start at the ten thousand foot view.

# Posting

It all begins with a post.  The post is written as a Markdown file with a bit of what Jekyll calls "front matter" that describes the post, including things like a title, summary, date, and critically, a type.  On my blog, the type could be one of:

* note - Short-form post
* article - Long-form content
* bookmark - Sharing a link I find interesting
* repost - Re-posting something because I want to advocate for it
* like - Exactly what it sounds like
* read - Status update for a book

Each post type also includes additional front matter information relevant to it.  For example, an article includes a summary, while a note might include a reference to an image.

These posts appear both on the front page in a merged timeline, as well as individual pages with next and previous links for navigation.

Critically, all post types are properly marked up with microformats so services like Brid.gy can understand what they are and how to handle them.

# Syndication and backfeed - Twitter

Great, so I have a post, now what?

Well, at step 3a, Jekyll sends a message to [Brid.gy](http://brid.gy).  This message is actually a [Webmention](https://webmention.net/), and when Brid.gy receives it, it finds the page on my blog where the post originated, verifies that it's supposed to be syndicated, and then if so, examines the microformats on the page to figure out what kind of post the page represents and what content to syndicate.

Then, at step 4, Brid.gy posts an appropriate tweet by mapping:

1. Notes, bookmarks, and reads to tweets
2. Notes with photos to tweets with an image
3. Articles to tweets with a link back to the article
4. Reposts to retweets
5. Likes to... well, likes.

At step 5, Brid.gy periodically checks for any activity associated with posted tweets (e.g. likes, replies, etc). 

At step 6a, Brid.gy converts any tweet activity into webmentions that are sent back to the site's configured webmention endpoint.

In my case, because I run a static site generator, some other service needs to consume those webmentions, and for that purpose I use [webmention.io](https://webmention.io).  That service receives webmentions, stores them, and makes them available for retrieval by static site generators like Jekyll.

And that brings us to step 7, where Jekyll pulls down any webmentions and renders them into their target pages when the site gets rebuilt and published at step 8.

As a result, any replies, retweets, or other activity are pulled back to my blog!

# Syndication and backfeed - Micro.blog

In parallel, my blog publishes a custom [RSS feed](/microblog.xml) that formats each post such that the content is suitable for ingestion into the [micro.blog](https://micro.blog) platform.

On micro.blog, individuals can engage in the posts in various ways, including likes and comments/replies, in ways that somewhat resemble Twitter.

The difference is micro.blog natively supports IndieWeb technologies, including webmention.  As a result, likes and replies are automatically sent back to my blog and included in the site build at step 7.

When the site is published at step 8, the pages also include any replies or likes that occurred on that platform!

# Micropub

So, okay, this is great, but... isn't it a pain to have to write a Markdown page any time I want to write a quick note?

Well yeah.  It definitely would be.  Fortunately, the IndieWeb comes to the rescue once again, and this time it's with a technology called [Micropub](https://www.w3.org/TR/micropub/).

Micropub is a protocol that standardizes how a client, which wants to post content, can communicate with a server, which publishes that content.  There are quite a few Micropub clients out there, but I use two:

1. [Indigenous](https://github.com/swentel/indigenous-android) - A Micropub client for Android.
2. [Quill](https://quill.p3k.io/) - A web-based Micropub client.

I use Indigenous to quickly post notes, bookmarks, or other content directly from my phone, and I use Quill to do the same when I'm at a PC.

I pair one of these clients with my own Micropub server, [Lillipub](https://github.com/fancypantalons/lillipub)[^5].  Lillipub consumes the Micropub protocol and generates an appropriately formatted post that gets published to my blog.

As a result, posting a note on my phone, which is then syndicated as a tweet, is almost as easy as tweeting directly!

# The result

It took me quite a while, but now my front page timeline is a merged representation of anything and everything I want to post!  And when I post that content, it's posted to a system I run, using open, transparent, standard formats that are portable and easy to work with.

That content is then syndicated to two different social networks in a way that looks native to that platform.  And any interactions on those social networks are pulled back and published right alongside the original content.

Okay, so technically that's pretty cool, but otherwise, so what?

Well, in the past, because I constrained myself to only writing long posts, my blog would only show activity when I was feeling motivated to write something longer.  And that motivation definitely ebbs and flows.

But now, if I want to just throw up a note or post a quick picture, I can, as easily as I could post a status update to Facebook.

And instead of just posting to my blog and hoping someone sees it, I can make that content visible on social networks like Twitter, which leads to engagements that, again, come back to my blog.

The end result is that my blog, the space I've created for myself on the web, is much more dynamic and *alive*.  And that's pretty darn exciting!

*Update:*

And, of course, just as I post this article, I realize I introduced a bug in my Twitter syndication while I was mucking around with my layouts recently.  Thanks, Murphy!

[^1]: Little did I realize this is almost the [tenth anniversary](/2010/01/22/transition-complete.html) since the last re-launch of my blog, so maybe there was something subconscious going on there...
[^2]: Or I was just bored.
[^3]: And now media companies are asking me to subscribe to Netflix and Amazon Prime and Disney Plus and CBS All Access and... but that's a topic for another post.
[^4]: Did I mention I was bored?
[^5]: I didn't really have to write my own micropub server, but it was a fun little side project I did purely for my own amusement.  Remember:  I'm a nerd.
