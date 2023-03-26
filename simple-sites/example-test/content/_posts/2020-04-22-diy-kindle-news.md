---
layout: article
title:  "DIY eReader News with RSS"
summary: "Did you know Calibre can turn an RSS feed into an eBook?  I didnt!  It turns out Calibre, tt-rss, and Wallabag make it possible to roll your own news that you can read right on your eReader!"
author: Brett Kosinski
date:   2020-04-22 19:33:32 -0600
category: [ selfhosting, indieweb, technology ]
syndicate_to: [ twitter ]
no_fediverse: true
---

I've mentioned this before, but I'll mention it again:  I'm a big fan of RSS.  For the uninitiated, RSS is a way to subscribe to a feed of content from a website and consume it in a reader or other tool of your choice.  And despite claims that it's dying out, I still manage to have more content in my feed reader than I possibly have time to consume.

For a long time I used [Feedly](http://www.feedly.com) as my RSS reader of choice.  But back in October I decided to [switch to tt-rss](2019-10-05-hello-tt-rss.md), a self-hosted RSS feed reading service that works on both browsers and through a mobile app.  Then, in a fit of boredom, I used some self-hosted home automation tools to [incorporate email newsletters](2019-10-10-experiments-in-automation.md) into my feed.  Meanwhile, I also decided to stand up an instance of [Wallabag](https://wallabag.org/en), a self-hosted website bookmarking service.

But I ran across a problem:  with all this content at my fingertips, I started to fall behind, particularly on all those long-form articles and newsletters I want to read.

And then I discovered Calibre's news scraping features and a solution presented itself!

<!-- more -->

You see, Calibre has this very cool feature where it can [scrape an RSS feed](https://manual.calibre-ebook.com/news.html) and use that to generate a valid ebook that is treated as a newspaper or magazine on an eReader like the Kindle.  So if the content you want to read is published to an RSS feed, you can use Calibre to convert it into an eBook.  Promising!

Now, today, this has... somewhat limited utility.  First, a lot of websites don't publish RSS feeds at all.  Those sites that do usually don't publish the full article contents in their RSS feeds, and instead only include an excerpt.  Finally, you'd probably need to fiddle around with Calibre recipes (which means writing code) to get nice looking output.

But with Wallabag, tt-rss, and a bit of elbow grease, you can get around this in a way that's simple and elegant!

# Level 1: Calibre and Wallabag

Wallabag is a self-hosted bookmarking service like Pocket, and like Pocket, one of its features is that, for things you bookmark, it'll scrape article content and store it offline.  Pretty slick!

But you might not realize that Wallabag can [publish that content in an RSS feed](https://doc.wallabag.org/en/user/configuration/rss.html) that can then be consumed by other tools.

You can hopefully guess where this is going!

The recipe is as follows:

1. Stand up an instance of Wallabag or use their hosted service.
2. In Wallabag, set up an API token and get the URL for your feed of choice (e.g. "unread").
3. Using Wallabag, bookmark a couple of blog posts or long-form articles you'd like to read on your eReader.
4. Set up a Calibre news scraping recipe for your Wallabag feed.  Don't worry, you can just use the out-of-the-box recipe without any changes.
5. Generate an eBook of the content, load it on your eReader, and enjoy!

The beauty of this is that, by leaning on Wallabag's content scraping features, you don't need to muck around with the Calibre recipe.  Just set up the feed in Calibre and fire it up.

Now any content you bookmark for reading later can be converted to a convenient eBook.  Nice!

# Level 2: Calibre and tt-rss

So, you're an avid user of RSS, and you've run across a few long-form articles that you just can't seem to get around to[^1].  Wouldn't it be nice if you could get that content onto your eReader?

To do this, we're going to rely on a few handy tt-rss features and plugins:

* [mercury_fulltext](https://github.com/HenryQW/mercury_fulltext) - Given an RSS feed, replaces the content of the RSS entry with the article content scraped from the originl website.[^2]
* [Published Articles](https://tt-rss.org/wiki/PublishArticles) - tt-rss allows you to mark articles for syndication back out to a new RSS feed.[^3]
* [Generated Feeds](https://tt-rss.org/wiki/GeneratedFeeds) - The API for getting the resulting feed back out so you can incorporate the content into another tool.  Like, say Calibre!

I'll leave the details to the reader, but the basic gist is:

1. Stand up a tt-rss instance.
2. Set up and configure the mercury_fulltext plugin.  Now your RSS feed will contain the full source articles for each entry.  This, by itself, is spectacular!
3. Subscribe to a bunch of RSS feeds.  Make sure to enable the mercury_fulltext plugin for each feed.
4. For any articles you want to read on your eReader, click the "Publish" icon to syndicate the content out to your Published Articles feed.
5. Set up a news feed in Calibre that uses the RSS feed for your Published Articles.
6. Generate your eBook!

Now, there's a couple of little tricks here.

First, I prefer to read my content from oldest article to newest, so I make sure to tack "&order=date_reverse" to the RSS feed URL.

Second, you probably want to filter the list to only unread or starred items so that not everything you've ever published is published out every time.  That means adding "&view-mode=unread" or "&view-mode=marked" depending on your preference.

Once again, the huge advantage to this approach is you don't need to muck around with your RSS recipes in Calibre since all the heavy lifting is done by the mercury_fulltext plugin.  Just put some items in your Published Articles feed, generate your eBook, and off you go!

# Level 3: Putting it together

The nice thing about the integration with Wallabag is that you can redirect any content you run across on the web to your eReader with minimal effort.

The nice thing about the integration with tt-rss is that anything you run across via RSS, you can similarly offline to your eReader for later consumption.

Together, you have a complete solution for generating your own electronic newspaper for convenient reading on your favourite device!

So how do we combine the two?  Well, there's a couple of options, and it's up to you how you approach it.

The first option is to set up your news feed in Calibre with both sources.  Calibre will happily scrape content from multiple RSS feeds and generate a single eBook, and that method works just fine here.

The second option, which I used, is to have tt-rss consume the RSS feed from Wallabag, and then have Calibre consume the feed from tt-rss.  The nice thing about this approach is that you have the option to read the stuff you bookmark in Wallabag either in tt-rss via the browser or mobile device, or on your eReader if that's your preference.

The important thing is, because this is all self-hosted tooling, you get to decide!

# Level 4: Automating the whole thing

I haven't yet gone this far, but if you own a Kindle[^4], the ultimate last step, here, is in automating the generation of the ebook and then emailing the content to your device.

The Calibre FAQ has all the [raw material to do this](https://manual.calibre-ebook.com/faq.html#how-do-i-run-parts-of-calibre-like-news-download-and-the-content-server-on-my-own-linux-server).  The basic idea is you write a shell script to:

1. Use ebook-convert to automatically pull down the news using your recipe.
2. Use calibre-smtp to email the eBook to your Amazon Kindle email address.
3. (Optional) Use calibredb to add the eBook to your Calibre library.

Then set up a cron job to run this script on some periodic basis.

Voila, you're now publishing your own custom newspaper to your Kindle!

[^1]: Which, for me, really means all those "Money Stuff" issues that I'm pulling into my RSS feed...
[^2]: There are other plugins for tt-rss that do the same thing, including the Readability plugin that ships with the product.  But mercury_fulltext has been flawless for me, even if it was a minor pain to set up, so it's definitely my recommended choice!
[^3]: I will confess that, prior to this project, I had no idea why this feature was of any use...
[^4]: Obviously I've only looked into this with the Kindle, so I have no idea if you can do something similar with other brands of eReader.
