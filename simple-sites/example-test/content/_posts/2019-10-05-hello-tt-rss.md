---
layout: article
title:  "Goodbye Feedly, Hello Tiny Tiny RSS!"
author: Brett Kosinski
date:   2019-10-05 21:36:25 -0700
category: [ selfhosting ]
no_fediverse: true
---

I've been a huge fan of [RSS](https://en.wikipedia.org/wiki/RSS) for a very long time now.  For those not aware, RSS is a protocol that allows websites (news organizations, blogs, aggregators, etc) to push out a feed of content as they publish it.  As an example, the CBC publishes a [list of RSS feeds](https://www.cbc.ca/rss/ ) that any reader can subscribe to.

The reader then uses an RSS feed reader to subscribe to the feed and consume it.

Now, that by itself sounds just okay, but the real magic happens when you subscribe to a large number of feeds.  What most folks don't realize--even those familiar with RSS--is that RSS feeds are extremely common and widely available across many web properties.  In my case, I subscribe to a number of news sources (CBC, BBC, NYT, etc), some technology aggregators (Hacker News, Reddit Programming), plus a number of random blogs and other outlets.

The RSS feed reader can then combine these streams of content in various ways.  Personally, my preference is to just see a single list of all the most recently published articles that I can then scroll through.  The best services allow me to consume that stream of content on multiple devices--in particular, on a desktop or on a phone--so that no matter where I am, my RSS feeds are at my fingertips, showing me a stream of all the content I've chosen to subscribe to.

Ultimately, what this amounts to is something like the Facebook news feed, except I'm personally selecting my sources rather than having content selected for me by some proprietary algorithm on a social network.

Now up until 2013 folks widely agreed that [Google Reader](https://en.wikipedia.org/wiki/Google_Reader) was one of the best feed readers out there.

Unfortunately, Google, in their infinite wisdom, decided to shut Google Reader down.

Fortunately, there are plenty of fine alternatives out there, and for a very long time [Feedly](http://www.feedly.com) was my tool of choice.  The web interface is clean and functional, the Android app is excellent, and it has a lot of interesting features if you're willing to pay for their subscription.  If you're interested in dipping a toe into the RSS waters, I highly recommend it!

However, there are a couple of things about RSS that can be a bit of a nuisance.

First, news sources frequently only publish their article titles, perhaps a brief excerpt, and a link, so that you have to leave the feed reader and visit their website to consume the content.  I can understand why that is (i.e. ad revenue), but it's a real pain.  First, the context switch to the website is always a bit jarring (and on a phone, a bit slow); each site has a different layout which means the reading experience isn't consistent; and if I want to read the content offline, I'm out of luck.

Second, some types of feeds, notably Reddit and Hacker News, publish links to *their* aggregation service rather than to the article content itself, often without any excerpt at all.  The result is a rather bland, difficult-to-use feed.

Third, call me paranoid, but I'm not thrilled about having a third party tracking what I'm reading.

And then I discovered [tt-rss](https://tt-rss.org/).

<!-- more -->

tt-rss is a self-hosted RSS feed service.  This means you stand up a server and run the application yourself (which, unfortunately, means the barrier to entry is pretty high, even for technical folks).    It ships with a decent out-of-the-box web UI (that can be spruced up with themes), and it can be paired with an Android app for the phone.  Once set up, the experience is vaguely analogous to Feedly:  You subscribe to feeds in tt-rss, then view them on the web browser or mobile device.

But the real magic with tt-rss is the fact that it's open source and extensible with plugins.  And *that* means you can customize.

And customize I did!

The first thing I did was set up the [mercury_fulltext](https://github.com/HenryQW/mercury_fulltext) plugin for tt-rss (and its associated service).  The mercury_fulltext plugin processes each entry in the RSS feed and replaces the included excerpt with a stripped down version of the content directly from the source.

This means that the full article content is inlined right into the feed, and so there's need to leave the RSS client to read the content.  And since the presentation is now controlled by the reader, you get a nice, consistent reading experience right in the app.

But it gets better!

The second thing I did was hack the mercury_fulltext plugin so it understands Reddit and Hacker News feeds.  So, for those sources, the original source article's content is inlined right into the RSS feed.  To make it clear where the content came from, the URL for the source is displayed at the top of the article.  And finally, the Reddit or Hacker News comment link is appended to the end of the article so that I can get to their site to see the user commentary.

This wouldn't be possible with a closed source application or web service.  The fact that the whole thing runs on a server I control means I can make the experience my own.

And I also retain control over my data.

Here's what it looks like:

![tt-rss](/assets/images/tt-rss_feed.jpg)

Nice, right?

----

As an aside, while working on this project, I realized that the RSS feed for this blog was horribly broken, so that's fixed now.  For folks who were previously subscribed (LOL, as if you exist...), apologies for the sudden flood of entries.  For those not subscribed, give it a shot!


