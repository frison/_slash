---
layout: article
title:  "Personal Archiving and the IndieWeb"
summary: "The indieweb is about controlling your identity.  But it's also be a great way to claw back all that content I've been scattering across the web so I can get better at archiving!"
author: Brett Kosinski
date:   2019-12-22 13:58:09 -0700
category: [ indieweb, personalarchiving, ownyourdata ]
syndicate_to: [ twitter ]
no_fediverse: true
---

# Our data, scattered

A while back I started to [take](2018-01-01-fun-with-puppeteer.md) an [interest](2018-01-02-html-json-data-archiving.md) in the topic of personal data archiving, and in particular how the topic intersects with the various social media platforms that so many of us interact with.  The simple fact is that so much of who we are--the things we write, the photos and videos we take, the people we interact with, our very memories, as Facebook likes to remind us--are locked up in a bunch of different walled gardens that are difficult to escape, both technically and due to the powerful social pressures that keep us on these platforms.

I like to think of the traditional photo album as an interesting contrast.

It used to be that we collected memories in these books, and stored those books on a shelf.  There was some real downsides to this approach!  It's a pain to add stuff to them (I have to "print" photos??)  They're difficult to share and enjoy.  They're single points of failure (think: house fires).  They require intentional acts to ensure preservation.  The list goes on.

But, they were ours.  We owned them.  We could take those photos and easily copy them, share them, rearrange them, archive them, and so forth.

Now imagine that you collected all your photos in a photo album that you could only store and access from a vault being run by a private company.  The company would ensure the photos were protected and stored properly, and they provided a really nice, simple mechanism to easily add photos to your album right from your phone!  That's really nice!  But if you wanted to look at those photos, you'd have to go to the vault, enter your passcode, and then you could only look at them while you were in the vault.  And if you wanted to get a copy of all of those photos for yourself, well, you can, but it's ugly and complicated and designed to make it minimally possible and maximally difficult.

Next, imagine the corporation changed their policies in a way you didn't like.  Or imagine that corporation went bankrupt.  Or experienced a fire.  Or you lost the passcode for that vault.  Or a loved one passed away and didn't store the passcode in a safe place.

What then?

Today, we don't just lock those photos in one vault run by one private company.  We lock those photos in many vaults, spread out all over the place.  In doing so, we dramatically increase these risks, because instead of just one company failing or one account that we might lose access to or one set of terms of service we need to worry about, it's many.

All the while we fragment our identity, spreading ourselves thin across the internet, which makes it extremely difficult to preserve all of those memories.

So what can we do about it?

<!-- more -->

# Building a social hub

Imagine there was a way you could carve out a space on the internet that was exclusively your own.  In this space you could decide for yourself what you wanted to broadcast to the world.  It could be a place for you to post short notes, long articles, photos, videos, book reviews, or really anything else that you wanted to share with your friends and family.  All the content could appear in one location, rather than being fractured and spread out across a dozen little places out of your control.

In this place you could carefully curate your identity.  If you want to share something, you make the choice to share it.  If you want to delete something, you make the choice to delete it.  You never have to worry about your information being taken without your consent because it's your space.  You own it, and you control it.

And what about all those social media walled gardens where all of your friends and family currently reside?  Well, imagine you could take the content from your personal space and selectively choose to share things on those services.  Even better, imagine you could pull the social interactions in those walled gardens back to your own space so that, no matter where they happened, they could all be collected in one place.

Finally, imagine there was any easy way to interact with other personal spaces from your own, so that social interactions could happen directly rather than through those proprietary communities.

In this world, because the content is entirely under your control, there is no risk of a service going down or an account being lost.  Data collection and archiving happen automatically because the content you post is going to a single place that is a service you control.  In short:  you own your photo album again.  Except you get all those other benefits, including easy publishing, sharing, and so forth, as well.

This is the idea behind the [IndieWeb](https://indieweb.org), where folks are developing the tools and technologies that will allow the personal website or blog to evolve into a central social identity.

# Challenges with the personal website

When contrasting the personal website to the rise of social media, it's obvious the latter succeeded by providing a number of significant advantages[^1]:

1. Minimizes friction for content creation.
2. Enables simple, easy, complex social interaction, including liking, sharing, etc.
3. Standardizes the presentation of content and makes it available wherever we are.
4. Connects folks together on a single platform.
5. Makes it easy to find content, through both social filtering and algorithmic recommendation.
6. Requires no technical expertise to get involved.  Just sign up and go.

By contrast, when looking at blogs or personal websites, you find:

1. Content authoring and social interaction has gone mobile, with an emphasis on short-form content, photos, videos, etc, while blogs have typically been reserved for higher-effort, long-form publishing.
2. Personal websites aren't well-connected; sharing, liking, commenting, and so forth, is difficult across the distributed web.
3. Personal websites are varied and disparate, making interoperability a challenge.
4. Our contacts on social media won't follow us to our websites if we leave.
5. Curation and content discovery are a significant challenge in the distributed web.
6. Building and maintaining a personal website can be technically challenging and, for most, is not worth the trouble.

The folks behind the IndieWeb movement are trying to tackle these various issues through a mix of technology and recommended best practices.

Now, to be clear, there's still a ton of work to do, and the barrier to entry is still very high.  But there is progress being made that leads me to be slightly optimistic that the IndieWeb can, if not completely replace social media, at least provide a viable alternative for those searching for one.

# Simplifying content creation

Because personal websites are so varied and disparate, it's very difficult to build clean, simple, easy-to-use applications that can reduce the barriers to content creation.

The first step in solving this issue is to create a lingua franca that clients and websites can use to talk to each other.  The IndieWeb proposes the W3C draft standard [Micropub](https://micropub.net/) protocol as the solution.

Micropub is an extremely simple, lightweight, flexible protocol that allows clients to talk to websites.  The protocol is so simple that I actually wrote my own, [custom Micropub implementation](https://github.com/fancypantalons/lillipub) for use with my website, just for the intellectual exercise.

Now, obviously building your own Micropub endpoint is not for the feint of heart, but fortunately there are [plugins](https://indieweb.org/Micropub/Servers#CMS_Software) for a number of common CMSes and blogging engines (including Wordpress).

Combined with a [Micropub client](https://indieweb.org/Micropub/Clients)--I personally use [Indigenous](https://github.com/swentel/indigenous-android/)--it's becoming possible to post notes, articles, photos, or other content to a personal website right from your phone as easy as it is to write a tweet or post to Facebook.

# Diversifying content, standardizing semantics

It's time to break the stereotype of the blog as a place where we only post long-form content.  As my own website illustrates, it is not only possible, but exciting and freeing to post a diversity of types of content to personal websites, including short-form notes, photos, etc.

Even better, since its your website, you can present that content however you like!  Do you want a single merged timeline?  Timelines for different types of content?  Something completely different?  That's entirely up to you to decide!

However, this diversity of presentation does present issues when trying to encourage interaction between websites, content aggregators, and so forth.

And this is where [Microformats](http://microformats.org/) come in.

Where RSS and ATOM provide excellent mechanisms for broadcasting a feed of content, Microformats allow us to embed structural semantics right into the content itself.  This way, systems interacting with our websites can extract semantic meaning while still allowing for a great deal of freedom in how that content is presented.

Moreover, Microformats are designed to capture a wide range of different types of content and social interactions, so that we can post a like or a reshare right to our own websites in a way that other services can understand (I'll get back to this in a bit).

Unfortunately, while off-the-shelf support for Microformats is appearing in various places, it's still somewhat nascent.

For example, the out-of-the-box Minima theme that ships with Jekyll supports basic Microformats, but is missing quite a few things (e.g. a proper h-card including "rel=me" attributes on social media links, among many other things).  Wordpress, by contrast, has some support in the form of [plugins](https://wordpress.org/plugins/tags/microformats/) and other tools, but it's not a first-class feature, and can only be fully done by updating themes, which represents a non-trivial barrier to entry.

In my experience this is probably the most difficult part of self-hosting an IndieWeb site at this point.  Microformats can be tricky to implement, and there's still a lot of work being done to standardize things.  Unfortunately, Microformats are also a critical part of the IndieWeb infrastructure, and it's my view that simplifying their adoption will be critical to the IndieWeb thriving.

# Interacting with social media

Breaking the monopolies of the social media giants isn't going to happen overnight, assuming it ever happens at all.  The personal website or blog is a time-tested method of taking back control of our content and our identities, but what do we do about all those friends and family who stubbornly stick to established social media platforms?

The IndieWeb has a simple solution:  publish the content on your own personal website or blog, but then syndicate the content to those platforms.  In the IndieWeb this methodology is called ["Publish (on your) Own Site, Syndicate Elsewhere"](https://indieweb.org/POSSE), or POSSE for short.

Now, anyone who runs a blog is already very familiar with this pattern.  My wife, Lenore, has been manually syndicating content from her blog ([celebrityreaders.com](celebrityreaders.com/)) to her Facebook page for years.  She just didn't have a name for it.  The trouble is:

1. Established techniques are often manual, which is a huge pain.
2. There was no way to pull social interactions back from those platforms to your personal website.

[Brid.gy](https://brid.gy/) provides a solution for this for a number of platforms[^2], including Instagram and Twitter, by using IndieWeb technologies (including Microformats and Webmention, which I'll get to in a second) to support automated, two-way linking between personal websites and social media accounts;[^3] two-way in that Brid.gy can both automate the syndication of content from your personal website to various platforms, and can also pull back likes, replies, and other social interactions (what the IndieWeb refers to as a [backfeed](https://indieweb.org/backfeed)) from those platforms.

Now, I'll be the first to admit this is far from perfect.  Replying to a tweet on my blog is easy enough, but it's definitely more work than simply replying directly in Twitter, so do I really want to go through that effort every single time?

As a result, my own pattern is to publish content to my blog and POSSE it when it's content I'm confident I'll want to preserve or control:  original content of any kind, or replies or other interactions that I want folks to see on all the various platforms where I'm publishing.  Conversely, if I don't think the interaction is that important to preserve or broadcast, I'll often directly engage with the platform.

In this way, I gain all of the benefits of those social media platforms while having the choice to retain control over my content when it matters.

This isn't how you break the monopolies of the social media giants, but my integration with the IndieWeb isn't really a political statement, it's a practical one!

# Interacting without social media

Okay, so there's all these personal websites and blogs out there, but how do we go about interacting with one another **without** a social media platform of some kind?

This is where a W3C standard called [Webmention](https://webmention.net/) fits together with Microformats to give us a very elegant solution.

Webmention is an extremely simple mechanism for one website or page to ping another website or page to say "Hey!  I mentioned you!"  Anyone who is familiar with [Pingback](https://en.wikipedia.org/wiki/Pingback) should feel a sense of familiarity, here.

The differences are that Webmention is[^4]:

1. A W3C standard, and as a result is well-specified and understood.
2. Simple and lightweight while still supporting rich interactions online.
3. Designed to work with Microformats to support a wide variety of interaction types.

Digging into this last one a little bit, the IndieWeb has begun to use Microformats to standardize the structure around key content types including (but certainly not limited to) a variety of common online social interactions, such as:

* [replies](https://indieweb.org/reply)
* [likes](https://indieweb.org/like)
* [reshares](https://indieweb.org/reshare)

The way this works with Webmention, then, is that:

1. The social interaction (say, a reply) is posted to your personal website.
2. A Webmention is sent from that page to the target page the post is replying to.
3. The target page then reaches back into the source page and looks for common Microformats.
4. Recognizing the page represents a reply, the target page represents the reply in their own page (by linking, pulling the content to their own site, etc).

This allows direct social interaction between individuals strictly through posting to personal websites or blogs!  Very cool!

Now, this does require both the sending and receiving sites to support Webmentions.  Fortunately, there are, again, [loads of CMSes or CMS plugins](https://indieweb.org/Webmention#Publishing_Software) that add support for Webmentions to existing blogs.

But for truly rich interactions, Microformat support is absolutely required, and as I mentioned previously, that currently represents a non-trivial barrier to entry.

# Re-inventing social media

To me, the most exciting opportunities in the IndieWeb community aren't in getting more people building their own personal websites supporting microformats, webmentions, and so forth (though I'd be thrilled if that happened!)  For me, the really interesting challenges are creating solutions that:

1. Offer simple, out-of-the-box solutions that allow individuals with no technical expertise to participate in the IndieWeb with as little friction as possible.
2. Enable those solutions to integrate easily with major social media platforms in order to break down the [network effects](https://en.wikipedia.org/wiki/Network_effect) that prevent people from leaving.
3. Simplify the stitching together of these personal websites, using IndieWeb technologies, to enable low friction content discovery, curation, recommendation, and social interaction completely outside the existing social media ecosystem.

The first probably doesn't require a lot of exposition.  The simple fact is the IndieWeb is still technically intimidating.  Starting up a blog has always been a bit of a challenge (hence the Bloggers and Tumblrs of the world), and the IndieWeb layers on a bunch of new, still-developing technical solutions that are not for the faint of heart.

The obvious solution is a new service that simplifies the creation of personal websites, while using open standards and technologies so that individuals can take their content elsewhere if they want to.  Yes, this solution isn't perfect--any such platform has the potential for abuse, and places our content out of our direct control--but the reality is most folks do not want to run their own blogging platform, and that's okay!

The second issue is primarily technical.  The biggest challenge is in social media platforms that don't offer the APIs necessary to easily push/pull content to/from those platforms (I'm looking at you, Facebook).

The third issue is much more interesting to me.  Google Reader, in many ways, hinted at a direction:  enable people to publish on their personal websites, but supply a service that pulls that content into a discoverable feed while layering in social interaction features.

For example, you could imagine using a combination of RSS and Microformats to pull content from distributed personal websites into a combined feed, layering in content curation and recommendation, and using Webmentions to support comments or other interactions between that feed and the originating sites.

Alright, you can stop shouting [micro.blog](https://micro.blog/), now!

To me, [micro.blog](https://micro.blog/) is a really interesting experiment in a new generation of social media.  The service works roughly as follows:

1. First, you either create a hosted blog on the service **OR** integrate an existing personal website that's being hosted elsewhere.
   1. The former costs a bit of money (currently $5 a month), while the latter is free.  However, hosting means Micro.blog takes care of everything, and ensures your blog is fully IndieWeb-enabled.
2. People can follow each other on the service, just like Twitter or Facebook.
3. Content from the people you follow is pulled into a unified timeline view.
4. You can like or reply to content right in the service, from either the website or an app on your phone.
5. If you're hosting your own website, social interactions are sent back via Webmention; you're not trapped in the service.
6. Syndication and backfeed with social media platforms is built right into the service, and that includes publishing to Facebook, Twitter, and so forth.

So, how does this help us?

Well, the hosted version of Micro.blog allows people to quickly stand up a new blog and begin posting immediately while fully supporting Webmention, Microformats, and other IndieWeb technologies.  This basically eliminates the barrier of entry.

The timeline and curated discovery feeds make it possible for people to find each other and begin to interact.[^5]

Finally, first-class support for POSSE and backfeeds to/from platforms like Facebook and Twitter makes it easier to move to the platform without completely losing contact with all those folks on social media.[^6]

Now, that's not to say there aren't downsides!  The most obvious is that, again, posting to a service you don't control means the content is fundamentally not in your control.  However, the reliance on open technologies and formats means that:

1. Your content is portable; you can take it with you if you want.
2. Micro.blog plays well with the rest of the IndieWeb.  Just because you host on Micro.blog, doesn't mean I have to, and vice versa.
3. If you decide you want to leave Micro.blog and host elsewhere, you don't have to sever your connection with the Micro.blog community or the IndieWeb at large.

# What's next for the IndieWeb?

This post is long enough, so I think I'll reserve this topic for another day.  But here's some food for thought.

First, I think we need to continue to push the benefits of personal websites and how the IndieWeb is making it possible to run one while still enjoying all the benefits of traditional social media.  The [IndieWeb](https://indieweb.org/) landing page does a good job of laying out the fundamentals, but we need to connect those benefits to people's real-life pain points so they see the IndieWeb as a solution to their actual, real-life problems.

This is why this post began with what I think is an often overlooked benefit of personal websites:  simplifying data collection, archiving, and preservation.

Second, we need to continue to reduce barriers of entry so more people can be drawn into the still-nascent IndieWeb community.  I'm imagining something like a simple, canned blogging platform, built on something like [SOLID](https://solid.inrupt.com/), running on commodity cloud infrastructure, so people can own the data and the service without needing the technical expertise to actually operate the platform.

Third, we need to make syndication and interaction with social media platforms as simple and fool-proof as possible.  The IndieWeb vs social media cannot be an either-or choice if we expect people to give it a try.

I'm also personally very interested in the topic of content discovery and curation.  I feel like there's some exciting opportunities in the space of algorithmic curation that could enable content discovery while avoiding the evils of things like the Facebook news feed.

But with the shine now coming off the major tech giants, laws like GDPR and CCPA being passed, and people beginning to realize the issues with social media as its currently conceived, I feel like there's a real opportunity to create alternatives that connect people while allowing them to retain control over their identities online.

[^1]: By the way, I'll be the first to admit this list of challenges is certainly not exhaustive, and is somewhat cherry-picked based on the kinds of issues the IndieWeb movement is trying to solve.  But I do think it's a fairly honestly list of major benefits of traditional social media.
[^2]: You'll note Facebook isn't on the list.  As a perfect illustration of the dangers of closed platforms, Facebook's APIs make it extremely difficult to syndicate content to Facebook accounts or pull back social interaction information.  As a result, Brid.gy had to shut down their Facebook integration.
[^3]: It's entirely possible you found this blog post through an automatically syndicated link published to Twitter!
[^4]: From the IndieWeb [Webmention FAQ](https://indieweb.org/Webmention-faq)
[^5]: In my opinion this is the area where Micro.blog can probably do the most, as today discovery is a real challenge, and curation is currently done by hand, which won't scale in the long term.
[^6]: This isn't perfect.  If you have friends on Twitter, their Twitter posts aren't gonna show up in Micro.blog.  But at least your content will still show up in Twitter.
