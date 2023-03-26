---
layout: article
title: More Myth Progress
author: Brett Kosinski
date: 2006-10-28 02:00:00 -0700
category: [ technology, diy, mythtv ]
no_fediverse: true
---

Well, today I decided it was time to get the IR blaster working in [MythTV](../projects/MythTV.md).  This is the device that controls our settop box, so that we can tune channels in the digital tier.

Now, I decided to purchase an IR blaster (and receiver) from the guy running [irblaster.info](http://www.irblaster.info), and I gotta say, I couldn't be happier!  The blaster works absolutely perfectly, and I haven't seen it miss a tune yet.  Setting it up was remarkably straightforward:

1. Plug into serial port.
2. Install lirc kernel module.
3. Copy DCT2524 configuration into /etc/lircd.conf
4. Install channel.pl from [http://www.iwamble.net/IRBlaster_Howto.txt this tutorial] (along with some tweaks to make it behave well with our DSTB).
5. Instruct Myth to use the channel change script.

And voila!  Works like a charm.  Tune times are a bit longer, now, as you've gotta wait for the box to get the key clicks and then switch, but overall, it ain't bad at all.

Of course, this is all just testing.  Until the replacement EPIA board arrives, we'll be stuck watching regular ol' TV for a while, yet.

