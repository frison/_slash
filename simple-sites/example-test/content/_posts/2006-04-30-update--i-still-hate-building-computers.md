---
layout: article
title: Update - I Still Hate Building Computers
author: Brett Kosinski
date: 2006-04-30 02:00:00 -0700
category: [ technology, aggravation, anecdotes ]
no_fediverse: true
---

So, in an amusing twist of fate, after going to Best Buy (yes, again... piss off!) and buying myself another video card for a whopping $129, I discovered (during a household search for other components, but I'll get into that later) that I did, in fact, have a spare video card that will suffice... an old PCI Mach64, which will certainly do the job for the short term (and will eventually find itself in my server, in a swap for the GeForce card it currently possesses).  Thus, now I find myself needing to go back to Best Buy (yes, for a **third** time) to return the card I just purchased.

Oh well, on the bright side, I'm saving myself $129, and I found that old card I was **sure** I had!

##### Updated Update:

Bah, so I plugged in the Mach64 card, and the board wouldn't power up.  Odd, I thought.  I pulled the card, and when I hit the power switch, at least the fan started spinning.  So I plugged in the GeForce and... spinny fan, but no POST (Power On Self Test, for those not in the know... the part of the boot sequence where the RAM is counted, etc).  Not even a beep from the speaker.  And the HD led stays on, which doesn't seem like a good thing.

So, I think I'm gonna abort this whole process.  I'll try taking the board back to BEST, and the card back to Best Buy (I'll keep the RAM and just load up Frodo for now).  Now, on to trying to compile a new kernel for Frodo, since the current kernel apparently doesn't recognize more than 896 megs of RAM (as oppose to the 1.5 gigs that's in there).  I hate computers.

##### Further Updated Update:

Got the new memory in and the new kernel compiled.  After futzing with my video drivers, I even have X working again!  Now comes the wait to see if anything broke... good thing I kept the old kernel around.

