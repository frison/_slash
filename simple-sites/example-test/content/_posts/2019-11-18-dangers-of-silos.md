---
layout: article
title:  "Locked in Internet Silos"
author: Brett Kosinski
date:   2019-11-18 21:48:39 -0700
syndicate_to: [ twitter ]
syndication: [ "https://twitter.com/brettkosinski/status/1196673369120264192" ]
category: [ indieweb, selfhosting ]
summary: [ "An intro post about my attempts to slowly pull myself out of internet silos so I can better control my data." ]
no_fediverse: true
---

# The Centralized Web

I don't think I'd be making news by pointing out that the internet, today, is dominated by large, centralized services.  While this centralization of the internet is a far cry from the original vision of peer-to-peer interactions and democratization, those services have, in many ways, enriched our lives by connecting friends and family, individuals and businesses, citizens and government.

But I also wouldn't be making news by pointing out that those same services have a darker side, particularly those that would bill themselves as "free".  While ostensibly costing us nothing, these free services make billions collecting and monetizing our personal data while optimizing our use of those systems to enhance engagement[^1].  Worse, the data they collect, with or without our consent, is locked away outside of our control.

I know this.  And yet I still find myself making use of many of these services, including:

* Google
  * Email (Gmail)
  * Storage (Photos, Drive)
  * Calendar (uh... Calendar)
  * Notes (Keep)
* Github
* Feedly
* Ravelry

And I'm sure many others besides.

Each of these services provides immense value! Instead of having to host email, or create my own offsite storage system, or manage my own git server, I can save time and effort by having someone else do the work for me.

However, in exchange, each of these services holds a piece of who I am.  And I don't control any of it.

<!-- more -->


# The Dark Side of Centralization

In some cases the piece of me these services hold is small.  In others it's so large as to be difficult to grasp.  Some services hold data that I also store elsewhere, while others retain the only copy of that information.  Some of this data is not terribly interesting, while other data is so sensitive that only few should see it.

This is frightening when you consider just how dangerous these services can be.

First off, each of these services may be collecting data about me in ways I may not even be aware of.  Google, for example, makes it [surprisingly difficult](https://www.techrepublic.com/article/how-to-stop-google-from-tracking-and-storing-your-locations/) to disable location tracking in Android.  Facebook is known to create [shadow profiles](https://www.theverge.com/2018/4/11/17225482/facebook-shadow-profiles-zuckerberg-congress-data-privacy) for people who've never used the service.  And don't get me started on Android [app data collection](https://www.nytimes.com/interactive/2018/12/10/business/location-data-privacy-apps.html).

This data collection makes these centralized services extremely high-valued targets for attackers.  After all, it wasn't so long ago that an [Equifax data breach](https://en.wikipedia.org/wiki/Equifax#May%E2%80%93July_2017_data_breach) left millions of people vulnerable to identity theft.  The natural counterargument is that a small number of centralized services leaves fewer locations that need to be secured.  However those same services provide a troubling lack of transparency regarding data collection, security, and handling practices, not to mention notification of security breaches (for example, the Equifax breach began in May, was noticed at the end of July, and announced to the public in September).

More fundamentally, there is a basic misalignment of incentives at work, particularly for these "free" services.  The old adage goes that if a product is free, you are the product, and that couldn't be more true in the current ad supported environment of the free internet.  As a result, these organizations are highly incentivized to learn as much as possible about all of us, while encouraging us to use their services, even to our own detriment.

Of course, all this is pretty philosophical.  What if I don't care about all my data being collected and monetized?

Well, consider all of the content you have locked away in these services; all those photos and videos in Facebook, all those emails in Gmail, all those posts on Medium.

What happens if one of those services goes down?  I know that sounds crazy, but I suspect Myspace thought the same once!

What happens if one of those services changes their terms of service in a way that makes you want to switch?

What happens if something happens to you, and your loved ones want access to all those photos or videos you once took?

What if you simply stop liking the service and want to go somewhere else?

These closed systems put our data out of our hands and out of our control, and that's simply dangerous.

So what's the alternative?

# Breaking Out of the Silos

I'll be the first to admit that getting away from this model of centralization is not something just anyone can do.  Not yet, anyway.  In that way, sadly, privacy and data autonomy is a [new form of inequality](https://newrepublic.com/article/154026/digital-privacy-class-issue), and it's something I'm increasingly interested in exploring.

But, in the meantime, I can certainly improve my own circumstances.

I've already begun writing a bit about this topic.  My posts on my [switch](2019-10-05-hello-tt-rss.md) to [tt-rss](2019-10-10-experiments-in-automation.md), and my decision to transition to [Jekyll](2019-11-11-moving-to-jekyll.md), are connected and part of a theme: to move further toward [self-hosting](https://old.reddit.com/r/selfhosted/) and support of [IndieWeb](https://indieweb.org/) technologies.

To continue the thread, I plan to write more about my switch away from Google Keep to [Markdown](https://daringfireball.net/projects/markdown/), [Markor](https://github.com/gsantner/markor), and [vimwiki](https://github.com/vimwiki/vimwiki).

I'll also cover my Jekyll switch-over in more detail, including my attempt to incorporate IndieWeb technologies like [webmention](https://indieweb.org/Webmention) while syndicating to silos using [brid.gy](https://brid.gy/).

And then there's my gradual shift away from Gmail (though I haven't made the leap quite yet).

Of course, I don't believe for a second that I can completely wean myself off of centralized internet services.  However, I can mitigate the risks and control the data that's most important to me.

[^1]: Where engagement is defined as a compulsive need to continue to interact with the service. Whether that compulsion is driven by anger, fear, or joy is of course immaterial.
