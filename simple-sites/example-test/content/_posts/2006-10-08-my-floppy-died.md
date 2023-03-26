---
layout: article
title: My Floppy Died
author: Brett Kosinski
date: 2006-10-08 02:00:00 -0700
category: [ technology ]
no_fediverse: true
---

Well, it finally happened.  It was only a matter of time, really.  Yes, that's right... my floppy died.

First off, for those less geeky types, I should probably explain what I was using my floppy for.  You see, hooking a computer directly up to the Internet is not unlike having unprotected sex with every woman in a two block radius.  Why?  Because all the computers in a two block radius are likely directly connected to yours (assuming you're using cable internet), and so you're vulnerable to any viruses, spyware, zombie computers, etc, etc, that happen to be buzzing around your local node.  And I haven't even covered non-local attacks.

Thus, it's generally a good idea to use some kind of protection.  This protection usually comes in the form of a **firewall**, which is not unlike a digital condom, acting as a layer of protection between your soft, vulnerable computer, and the harsh outside world.  Now, there are two major kinds of firewalls.  The first is a software firewall, and resides on the computer to be protected.  Another is a separate firewall appliance which is physically located in the network path between the computer to be protected and the outside world.  This would be this style that I favour.

So what about that floppy?  Well, you see, as a geek, I thought it would be fun to build my own firewall.  So I coupled some old spare parts with the Linux-based [LEAF](http://leaf.sourceforge.net) firewall package, and voila!  Home-built firewall.  And to improve protection (while, as it turns out, reducing reliability), I placed the actual firewall software on a, yup, you guess it, (read-only) floppy disk.  Which has since died. :(

Fortunately, my wireless router can perform double duty as a simple firewall, so for now, this is my solution... though, at some point, I'd like to go back to a standalone firewall solution.  Though, this time, I think I'll put it on a CD-ROM.

