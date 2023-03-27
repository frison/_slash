---
layout: article
title: So.  Awesome.
author: Brett Kosinski
date: 2006-10-19 02:00:00 -0700
category: [ mythtv, diy, technology ]
no_fediverse: true
---

Well, after all the problems with ethernet cabling and bad motherboards, things took a bit of an upswing today on the [MythTV](../projects/MythTV.md) project, and it all started when the TV tuner card arrived!  Yup, it showed up before lunch today, and when we got home this evening, I promptly installed it in the backend and had it configured in around 15 minutes.  It went beautifully!  And the MythTV setup process went equally smoothly!

But it gets better!  What I really wanted to do was test out the backend.  So I plugged it in to our basic cable and then configured the mythtv backend.  Then, I compiled the frontend on frodo (twice... I compiled 0.20 first, not realizing the backend was running the 0.20-fixes branch), and voila!  I was suddenly watching TV on my computer!  I could pause, rewind, skip forward, browse around in the EPG (which has a nice little preview of the current channel, just like our existing DSTB), and of course record.  And it all works perfectly!  Even the channel tune times, which I feared would be a little long, are decent... maybe 1.5-2 seconds to switch?  Not bad at all!

So I've already marked The Daily Show and The Colbert Report to record this evening (since they run on CTV).  We'll see what they look like tomorrow.  Then I can play around with the commercial skip and transcoding functions.  Good times!  Now if I can only get that EPIA replacement, I can be doing all this right on my TV!

Update:

I also managed to play around with [MythWeb](http://www.mythtv.org/wiki/index.php/MythWeb), the web interface to MythTV, and I gotta say, it's pretty sweet.  It provides a really nice interface for perusing your channel lineup, editting your recording schedule, viewing previously recorded material (assuming your browser and OS are set up correctly), and even accessing your music archive.  Very nice!  And, again, it worked more or less out-of-the-box (minus a probably unnecessary tweak to Apache's configuration), proving once again that going with Fedora Core and pre-built binary packages was, hands down, one of the best ways to go.

