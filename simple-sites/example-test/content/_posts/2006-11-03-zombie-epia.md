---
layout: article
title: Zombie EPIA
author: Brett Kosinski
date: 2006-11-03 02:00:00 -0700
category: [ mythtv, technology, diy, aggravation ]
no_fediverse: true
---

So, you remember that dead EPIA board, right?  Yeah, the one I was going to use in my [Living Room Frontend](../projects/Living_Room_Frontend.md) as part of my [MythTV](../projects/MythTV.md) project?  Well, after shipping it Fedex some time last week, it finally arrived at [Logic Supply](http://www.logicsupply.com) yesterday morning, and underwent testing.  And can you guess what happened?  Oh yes, I bet you can!  The board booted just fine for them!  Oooh, surprise surprise.

But, how can that be, you ask?  Didn't it exhibit some odd behaviour, such as powering up without the power switch being hit?  Well, according to the support guy at LS, the board comes with AC loss auto-restart enabled by default!  What this means is that, if it notices the AC get connected, it will automatically boot itself (which is good for a system you want on all the time).  This mislead me into believing something was going wrong, when in fact it wasn't.  This, coupled with the fact that the board simply won't POST without RAM installed, lead me to believe the board was toast when it was, in all probability, the RAM the whole time.

Damnit I hate hardware hacking.

Anyway, the bright side of all this is that Andy, another co-worker/buddy of mine, was visiting Princeton, New Jersey (where our corporate head office is).  So, on the return path, I had LS overnight the board to Princeton for $25, and then I had Andy bring it back across the border.  Result?  Three day turn-around on the cheap!

Unfortunately, now I have a problem.  I need to test my RAM.  However, I'm not yet aware of a DDR2-compatible box that I can utilize for the purpose.  And until I can verify the memory, I can't really move forward on the FE.
  Did I mention how much I hate hardware hacking?

