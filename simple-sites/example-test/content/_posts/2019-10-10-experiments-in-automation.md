---
layout: article
title:  "Experiments in Automation"
author: Brett Kosinski
date:   2019-10-10 21:40:08 -0700
category: [ selfhosting ]
no_fediverse: true
---

With the knock out success of my [ttrss service rollout](2019-10-05-hello-tt-rss.md), I thought it might be fun to look into other self-hosted services that I might find useful.  Now, let's be very clear, this was, on its face, entirely a make-work project to give me something fun to do with my spare time.  But the outcome has proven surprisingly useful!

It all began when I came across [Huginn](https://github.com/huginn/huginn).  Huginn is an open source implementation of the kind of service offered by [IFTTT](https://ifttt.com/), [Zapier](https://zapier.com/), and I'm sure others (Microsoft Flow popped up while I was finding the links to those services).  The general idea is that these services allow you to plumb or connect various other services together to effect an automated workflow.  For example, you might receive tweets on one end and shoot them off to, say, a Slack channel on the other.

Okay, so what would I do with this?

Well, as a bit of background, I'm an avid reader of [Matt Levine](https://www.bloomberg.com/opinion/authors/ARbTQlRLRjE/matthew-s-levine ).  Mr. Levine offers a newsletter that one can subscribe to that is delivered daily to ones email inbox.  Notably, if you want to read this content on the Bloomberg website, it's hidden behind a decided effective paywall that happens to defeat web scrapers.  That means getting this content into my RSS feed isn't directly possible.

But wouldn't it be nice if I could take those emails, scrape out the content, and republish them to a private RSS feed that I could incorporate into ttrss?

<!-- more -->

Well, with Huginn I can do just that!

First, I set up a rule in gmail to apply a label to, and then archive, the newsletter emails.

Then, I set up a Huginn pipeline that does the following:

1. Use the Imap Folder Agent to connect to my gmail account and retrieve any new emails with the label applied (making sure to use the text/html MIME enclosure so the full message body is available).
2. Use the Website Agent to parse the email body and pull out the link to the article on Bloomberg.
3. Use the Data Output agent to republish the content as an RSS feed.

Finally, in ttrss I subscribe to the feed and... voila!

![Matt Levine RSS Feed](/assets/images/Matt_Levine_RSS_Feed.jpg)

Now that is pretty darn useful!

Since then I've also set up [Gotify](https://gotify.net/) and integrated it with Huginn and other services in my home to notify me when, for example, my offsite backup process is completed (and yeah, I could do that with just Gotify, but piping the events through Huginn gives me more flexibility later to do other things with them... like... publish them to an RSS feed?  I dunno...).

This is some very nice infrastructure!  I'm now very curious how else I might leverage this stuff, or what other services I could deploy (some of which are listed [here](https://github.com/Kickball/awesome-selfhosted))...

