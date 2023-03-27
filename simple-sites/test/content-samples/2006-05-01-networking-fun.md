---
layout: article
title: Networking Fun!
author: Brett Kosinski
date: 2006-05-01 02:00:00 -0700
category: [ technology, diy, house ]
no_fediverse: true
---

So, aside from the computer building debacle as reported earlier, I **finally** got around to one other major TODO I've had on my list some time, that being to get some household networking going and move the damn cable modem and firewall downstairs.  Previously, the cable modem was in our bedroom, and we had a hacked up piece of cat5 running into the den, which was a substandard solution, to say the least, so I felt it was about damn time to do something about this.

The beauty of this situation is that in basically all new houses, they're wiring up the telephones using cat5, which means 8 pairs of wires, rather than just the old two.  This means that, at every telephone jack in a new house, there are two pairs in use, and six extra pairs just sitting there, begging to be wired up.  Well, regular ol' 10baseT, which is capable of doing 10 Mb/s (sufficient for my needs) only needs four pairs.  So, using the telephone line already wired into the den, I was able to hook up 10baseT from the den straight to the basement without having to drop a single line.  Sweet!

For those wondering how to do this, it's simple.  You need just a few pieces of equipment:

1. A modular faceplate and two connectors, an RJ11 and an RJ45 (or two RJ45s, if you like).
2. A blade screwdriver.
3. A pair of wire cutters/strippers.

With these items, the process of wiring is a simple matter:

1. Remove the old plate and disconnect the wires.  The blue and blue/white wires should be the ones in use.  *Warning*: the ring voltage on telephone lines is enough to give a nasty shock, so do your best to avoid touching both wires at the same time.
2. Connect the original wires to the middle pins of the to-be-telephone connector.  For an RJ45, that would be as follows:  
   1. blue -> pin 4
   2. white/blue -> pin 5.
1. Plug in the telephone and verify it works.
2. Wire up the ethernet connector as follows:
   1. white/orange -> pin 1
   2. orange -> pin 2
   3. white/green -> pin 3
   4. green -> pin 6

That's it!  Well, not quite.  Now you get to wire up the other end.  If you head to the electrical panel in your basement, you should see the various telephone lines from the house congregate.  It's up to you to figure out which one corresponds to the jack you're wiring.  I just disconnected them until I disabled the phone line I was working on. :)  Once you've found the line, take the unconnected wires (there should be six) and splice a piece of ethernet to the white/orange, orange, white/green, and green lines such that the wire colours match.  This will create a straight-through connection that you can wire into a hub.  If you want to create a cross-over (so that you can connect the panel end directly into a computer) wire the white/green to white/orange and green to orange.

There, **that's** it!  After this, I installed a cable splitter, moved my cable modem and firewall into the basement, and then ran a patch cable from the jack upstairs into my hub, and voila!  Done!  Good times...

For my next trick, I think I'll pick up another hub at some point, put it in the basement, and then put in another modular jack where my cable is currently wired in and run ethernet to the hub, in preparation for some sort of video PC or hacked Xbox-type solution.  Plus, hey, it's good ol' techy fun!

