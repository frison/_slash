---
layout: article
title:  "RSS: A Better News Feed"
summary: "Social media algorithms care only that you're engaged. They exist to advertise. Everything else is a side-effect. RSS lets you ditch the machine and build your own feed from trusted sources."
author: Brett Kosinski
date:   2020-03-05 21:18:53 -0700
category: [ indieweb, politics, technology ]
syndicate_to: [ twitter ]
no_fediverse: true
---

Quite a few years ago, for personal reasons, I decided to drop out of major social media platforms[^1].  This was just at the time when those platforms truly started to take over the world, so the whole thing more or less passed me by as I watched from the sidelines.  As a result, it wasn't until very recently that I came to appreciate just how much these platforms have become the primary way that people run across content online.

Of course, this really shouldn't be surprising.  Once upon a time, the internet was made up of an untold number of websites, big and small.  And this posed a real problem of content discovery.  Sure, we managed.  We managed with search engines, and bookmarks, and web portals, and other ad hoc technologies.  But it was a huge pain.

Today, this same kind of content discovery is done on social media platforms, with content pushed to the consumer by machine learning algorithms that optimize for "engagement", which is a technical term for "time spent on the service"[^2].

On its face this would seem like a good thing!  After all, if you're engaged, that must mean you're delighted by what you see!

But the reality is a lot more complicated.  Yes, certainly the things that delight us will keep us engaged.  But so do the things that make us outraged, or offended, or jealous.  And the algorithm can't tell the difference.  So whether you're clicking on a link because you want to see a picture of a [large cat in a small box](https://top13.net/wp-content/uploads/2017/01/cats-in-boxes-08.jpg), or you want to read an outrageous article about [how the world is really flat](https://www.pastemagazine.com/articles/2016/03/a-conversation-with-a-flat-earth-believer.html), it's all the same to the machine.

The result is an algorithmic filter bubble that often serves to misinform, usually while making us miserable.

On the other hand, those algorithms really do provide a useful function:  They push interesting content to us so we don't have to go and seek it out.  The problem is, we have no control over how they function.

Well, as you can probably guess, I'm here to tell you that there is an alternative, and it's a technology that's almost as old as the web itself: [RSS](https://en.wikipedia.org/wiki/RSS).

<!-- more -->

# What the heck is RSS?

Okay, forget the technical jargon.

Consider your favourite blog, or the front page of Twitter, or Reddit, or the Facebook newsfeed.  What do those all have in common?

Well, they're made up of a bunch of individual pieces of content pulled together into a convenient list, often organized in various ways, and often (or in the case of Reddit, entirely) sourced from other places on the internet.  When paging through one of those feeds, you'll find links to articles from various news outlets, other content aggregation sites, professional or amateur blogs, and so forth.

How does that content get there?

For a site like Reddit, the feed is supplied by the contributors to the site.  In the case of something like Facebook or Twitter, often the content creators publish the links.  Users then indicate their interest by subscribing to a subreddit or a Facebook Page, or by following a Twitter account.  Once that's done, the site then combines the content from those various sources into a feed that's curated by the service.

But what if there was a way for any news site, blog, or aggregator to publish a list of links to their content in a way that anyone could consume.  And then imagine there were apps or websites that would let you, the user, pick the sites you're interested in, and then pull those lists of links together into a master list that you could page through.  It'd be kinda like the Facebook Newsfeed or the Reddit frontpage, except you'd be in control over where the content came from, and there wouldn't be an algorithm deciding what to stick in front of you.

That's RSS!

# But I thought RSS was dead?

Every now and again I see a post somewhere claiming that RSS is dying or dead, and I've always found it a little puzzling.  Here's a quick list of some of the sites I use that publish an RSS feed:

* [CBC](https://www.cbc.ca/rss/)
* [BBC](http://www.bbc.com/news/10628494)
* [Christian Science Monitor](https://www.csmonitor.com/About/RSS)
* [New York Times](https://archive.nytimes.com/www.nytimes.com/services/xml/rss/index.html)
* [Hacker News](https://news.ycombinator.com/rss)
* [Reddit](https://old.reddit.com/wiki/rss)

And this is just a few of them.  Of course, I'd probably have a lot more, except the Hacker News and Reddit feeds provide enough filler that I don't feel I need more content...

Now, I won't claim RSS isn't on the decline.  Support has definitely fallen over the years.  But there's still many many sites that support it, and certainly far more than I'll ever need.

The biggest problem with RSS these days is one of discoverability.  Where websites used to prominently advertise their RSS feed links, and browsers used to provide one-click feed subscription right in the client, these days the feeds are often difficult to find.  This can make it seem like RSS isn't unsupported, when in fact it's just hidden away.

# Alright, I'm curious.  How do I begin?

In my opinion, the best place to start is with a web based RSS service.  There's a few worth trying:

* [Feedly](https://feedly.com) (this is the one I've used)
* [Inoreader](https://www.inoreader.com/)
* [NewsBlur](https://en.wikipedia.org/wiki/NewsBlur)
* [The Old Reader](https://theoldreader.com/) 

The nice thing about an online service is that it's easy to get started, they're available on any device, and critically, they provide discovery features so you don't have to hunt down the RSS feeds yourself.

And, yes, these services have mobile apps as well, so you can enjoy a first class experience on your smartphone or tablet.

Once you've signed up, the process is simple:  pick your interests, subscribe to some feeds, and start reading!

# Are there other options?

Absolutely!  In fact, there's so many it'd be a waste of my time to list them all, so I'll just point to Wikipedia's [Comparison of feed aggregators](https://en.wikipedia.org/wiki/Comparison_of_feed_aggregators).

If you go the route of either running a desktop RSS aggregator or a self-hosted service, you might run into the RSS feed discovery problem I mentioned earlier.  Fortunately, there are some browser add-ons that help:

* [Awesome RSS](https://addons.mozilla.org/en-US/firefox/addon/awesome-rss/) - A Firefox add-on that puts the RSS/Atom subscribe button back in the URL bar.
* [RSS Finder](https://chrome.google.com/webstore/detail/rss-finder/ijdgeedipkpmcliidjhbemmlgibfnaff?hl=en) - A Chrome Add-on that lists RSS feeds on the current page.

# Go forth and RSS!

I'm of the strong opinion that algorithmic curation is the root of all evil on social media platforms.

While I absolutely believe these technologies were created with good intentions, the combination of optimization for user engagement above all other metrics, combined with the need to drive ad revenues, has created technology platforms that are perfectly designed to misinform us and drive us apart, all while providing the perfect tools for manipulation and propaganda.

Technologies like RSS make it possible for people to break out of those platforms without having to sacrifice convenient content discovery and curation.

So give it a try!  You never know, you might like it!

[^1]: I hate that I feel like opting out of social media is the 21st century equivalent of saying "I don't own a TV"...
[^2]: Which really means "time spent being exposed to advertising".

