---
layout: article
title:  "The Great IPv6 Experiment"
author: Brett Kosinski
date:   2010-01-17 21:26:24 -0700
category: [ ipv6 ]
no_fediverse: true
---

So during the last week I decided it was about time I rebuilt my firewall, if for no other reason than to upgrade to the latest version of [m0n0wall](http://m0n0.ch/wall/), as the version I was running dated back to 2006.  Of course, naturally enough, during the course of my initial experimentation, my old firewall hardware kicked the bucket (it was an old 150Mhz P-II... I'm surprised it hadn't died sooner), so I suddenly found myself in need of a new firewall PC.  "Lucky for my, I ditched my old MythTV motherboard", I thought to myself... what a fool I was.

As a bit of background, I've been running an open wireless access point for years and years now, and to achieve reasonable security, the network topology was something like the following:

{% graph Topology %}
rankdir = LR;
node [shape = rectangle]; WiFirewall Firewall;
node [shape = circle];
Wireless -- WiFirewall;
WiFirewall -- LAN;
LAN -- Firewall;
Firewall -- WAN;
{% endgraph %}

Where both the WiFirewall and Firewall perform network address translation.  Unfortunately, this means:

1. The wireless network is double-NATed, which makes forwarding ports back from the firewall to the wireless network a heck of a lot more cumbersome.
2. I have to maintain two separate sets of firewall rules.

Plus, the WAP I have doesn't support IPv6, so if I wanted to deploy IPv6 internally, I couldn't do so for the wireless pool.

Well, this screamed for a solution, hence me building a new firewall.  My vision was the following:

{% graph Topology %}
node [shape = rectangle]; Firewall;
node [shape = circle];
WAN -- Firewall;
Firewall -- LAN;
Firewall -- Wireless;
{% endgraph %}

In this sort of arrangement, the firewall acts as a single NAT for both subnets, and also allows me to control access from the wireless pool to the LAN and vice versa all in one place.  Plus, because both subnets are directly connected to the firewall, which supports IPv6, I can deploy v6 across my network.

Of course, this scenario requires three NICs in the firewall, one for the WAN, one for the wireless subnet, and one for the LAN subnet.  So I took my spare machine, threw three NICs in it, fired up the newest version of m0n0wall, and got... "watchdog timeout: dc0", followed by hard locks.

*sigh*

*Many* hours later, after running up and down the stairs a couple dozen times, my conclusion was IRQ conflicts between one of the NICs and the USB controller on the board.  Yes, that's right, in 2010, I was fighting with IRQ conflicts.  Seriously, what the heck?

The next day, I relented and decided to try out another motherboard I had lying around (yes, that's right, I had two spare motherboards just lying around.  Go figure.)  Luckily, this one seems to work beautifully, and I now have a brand new firewall set up as described above.  I even configured m0n0wall's traffic shaping such that bittorrent traffic is de-prioritized versus other traffic, so I no longer need to perform upstream throttling in rtorrent, as the firewall takes care of everything (and it works beautifully... rtorrent can now saturate my upstream, while web browsing, etc, continue to work flawlessly).

Furthermore, I figured, hey, why not deploy IPv6 for kicks?  So I went and allocated a tunnel from [Hurricane Electric](http://www.tunnelbroker.com).  They provide *free* IPv6 tunnels plus a free routable /48 if you want it (yes, that's right, an 80-bit address space for nothing).  You just need a router/firewall that supports it.  Well, as you might imagine, m0n0wall does.  Additionally, Hurricane Electric has a deal with Google such that, if you use HE's nameservers, then all of Google's services will be accessible over IPv6.  So now anyone connected to my WAP will be able to browse the IPv6 internet, and access Google's services over v6.  Neat!

And, as if that weren't enough, I registered a new domain name:  "b-ark.ca".  I then plan to use [afraid.org](http://freedns.afraid.org), which is a free DNS hosting service which provides support for IPv4, both static and dynamic, and IPv6, both forward and reverse.  Of course, I'll need to find a way to cleanly migrate away from "frodo.dyn.gno.org", but once I do, that address will be disappearing, and this place will be reachable at "b-ark.ca".

