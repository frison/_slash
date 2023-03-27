---
layout: article
title:  "Revisiting IPv6"
author: Brett Kosinski
date:   2019-06-29 21:32:21 -0700
category: [ ipv6, selfhosting ]
no_fediverse: true
---

Many [years](2010-01-17-ipv6-experiment.md) [ago](2010-01-22-transition-complete) I experimented with running IPv6 in my home network (dual-stacked, not IPv6-only... I'm not that crazy!).  At the time this was mainly an intellectual exercise.  While a lot of major services already offered IPv6 (including Google, Facebook, and Netflix), the big draw of v6 is the ability to completely do away with NAT and simplify access to services and P2P applications running out of my home.  But without broad v6 support, even if my home network was available via v6, the rest of the world wouldn't be able to access it, which pretty severely curtailed the utility of the whole thing.

But, it was still an interesting exercise!

Until, that is, Netflix started cracking down on VPNs.

The way v6 was deployed in my network was via a tunnel supplied by [Hurricane Electric](http://he.net/).  That tunnel terminated in California, and, while not intentional, it allowed me to watch US Netflix in Canada.

That is until Netflix realized people were abusing those tunnels and started blocking inbound traffic via HE.

I considered potential workarounds, but I could never figure out a satisfying solution (in large part thanks to closed devices like Chromecasts).

And so I shut down v6 in my network.  While, previously, v6 didn't provide a lot of value, it also didn't cause me any problems.  Once this issue surfaced, it was no longer worth the effort.

Recently I decided to take another look at the situation to see if anything had changed.

Well, unfortunately Netflix still blocks traffic coming from Hurricane Electric traffic originating in the US.

**However**, it turns out, back in 2013, HE added new Points of Presence (POPs) in both Calgary and Manitoba.  That meant I could set up a tunnel with an exit point inside the country.

Would Netflix block that?

It turns out, the answer is:  No!

So I now have IPv6 back up in my home network.

But has the connectivity story changed?  Yes!

Much to my astonishment, I discovered that in the last couple of years, AT&T, Rogers, and Telus have all deployed native IPv6 inside their networks.  That means that, when I'm out and about in both Canada and the US, I have direct v6 connectivity back to my home network!  Even my mother-in-law's house has access thanks to her Telus internet package.

That's a huge expansion in coverage!

In fact, ironically enough, of the places I frequent, the only location that lacks v6 connectivity is my workplace.  Go figure.  But, in that case, I can always just tunnel through my linode VPS, which has had v6 connectivity for many many years.

IPv6 adoption may be taking a while, but it is happening!

