---
layout: article
title: It's Aliiiiiive!
author: Brett Kosinski
date: 2006-11-07 02:00:00 -0700
category: [ technology, mythtv, diy ]
no_fediverse: true
---

Yes, it's true!  The [MythTV](../projects/MythTV.md) frontend works!  But what about the RAM, you ask?  Well, I decided to take the stick back to Best to get a refund/swap/something.  It was at this point that I discovered that, surprise!, I can't get a refund!  Apparently it was a final sale or something, which I evidentally didn't realize at the time.  This is especially shitty since I'm willing to bet that the stick is simply incompatible with the board, for whatever reason.  But, they're testing it anyway... and if it turns out to be good, I'm either going to try to get it swapped for a DDR2-533 stick or a store credit.  And worst case, I could probably sell it.

Meanwhile, I decided to head to Futureshop and buy a stick of DDR2-533 ($71 "open box", even though it had never been opened).  My thinking was that, if I get a working stick out of Best, I can always return the new stick to Futureshop.  After all, **they'll** give me a refund.  And, surprise surprise, with the new memory, the EPIA board POSTs just fine.  Shocker!

The bright side is I now have a working [Living Room Frontend](../projects/Living_Room_Frontend.md)!  It's not yet perfect, of course.  The video output isn't perfectly scaled to the screen size (apparently the TV-out chipset isn't fully supported under Linux, yet.. yay!).  DVD playback is very jerky (although the CPU isn't pegged, so something else is going on there).  And there are a bunch of things I haven't finished, such as getting the VFD working, or enabling suspend-to-RAM.  

OTOH, TV playback, itself, is perfect, with no tearing or stuttering, and the IR receiver I picked up works beautifully (although I need to adjust the receiver position a bit to improve reception).  So overall, I'm pretty happy with it.

**Update:**  Well, I got the VFD working!  It was pretty darn easy, too.  Lircd, the software I'm using to receive IR signals from the remote, has a driver for the display device, so I just needed to install lcdproc, and voila!, it works!

