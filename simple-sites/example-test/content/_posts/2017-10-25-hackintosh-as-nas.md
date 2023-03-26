---
layout: article
title:  "Hackintosh as NAS"
author: Brett Kosinski
date:   2017-10-25 21:17:19 -0700
category: [ hackintosh, selfhosting ]
no_fediverse: true
---

So in my previous post I mentioned some challenges I encountered using macOS on my Hackintosh as a NAS, and my ultimate success in getting it working with Windows as a backup server... after moving the actual NAS'ing to a Linux VM.

What I didn't realize then, but I know now, is that at least on my NUC, for some reason, the IntelMausiEthernet is not actually stable!  I don't know if it's tied to high/sustained load, but for whatever reason, over time the NIC would lose connectivity with the network.  Re-plugging the network cable resolved the issue, but it would quickly recur.

This rapidly became a dealbreaker, as not only did it render the machine useless for backups, it also made it useless as a Transmission server.

Now, before you ask, no, I haven't spent any time debugging the issues and don't plan to.  So I haven't a clue what was actually wrong.

My solution was a lot simpler:  I just bought a USB Ethernet dongle and moved on with my life.  That, fortunately, has worked like an absolute charm and solved all of my network stability issues!

