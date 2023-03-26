---
layout: article
title: The Problems Begin
author: Brett Kosinski
date: 2006-10-18 02:00:00 -0700
category: [ aggravation, mythtv, technology, diy ]
no_fediverse: true
---

Things were going so well.  The [MythTV Backend](../projects/MythTV_Backend.md) is now built and humming away quietly in my basement, Fedora Core installed and working nicely.  The only minor glitch being some issues with the onboard NIC, though nothing that can't be solved.  Really, it was all going **too** well.

And then the other shoe dropped.

#### PVR Problems

A couple of days ago, the board for my [Living Room Frontend](../projects/Living_Room_Frontend.md) finally arrived after much waiting, whining, complaining, etc.  When it finally showed up, I eagerly went home and mounted the board in the lovely Antec case I bought (at which point I realized the EPIA board could also fit in micro-ITX case... it looked so tiny in the mini-ITX Antec).  I then wired up all the connectors, routed all the wiring nice and cleanly, and then went to install the RAM.  Which didn't fit.  Why?  Well, you see, I ordered DDR memory.  I then decided to opt for the EPIA EN12000EG instead of the M6000.  The M6000 takes DDR.  The EN... takes DDR2.  $80 blown.  Doh.

So, today, after running some errands, we stopped by [BEST](http://www.best-comp.com) and I picked up a stick of DDR2.  Then, after dinner, I installed the stick and powered up the board.  And nothing.

Actually, that's not true.  The PSU and case ventilation fans spun up, even though the power switch hadn't been pressed.  Not good.  Experienced computer builders will immediately recognize the potential problem this presents.

So, I decided to start trouble shooting.  The first thing was to make sure the PSU wasn't at fault, so I disconnected the ATX connector from the motherboard and flipped the power switch.  Nothing.  Nada.  This ruled out the PSU.

I then proceeded to reconnect the ATX connector and begin disconnecting other things gradually, testing the PSU in between.  And every time, the fans spun up.  Eventually, I was left with just the ATX connector attached to the board and nothing else.  No RAM.  No connectors.  Nothing.  And when I hit the power switch... the fans spun up.  Conclusion?  Bad motherboard.  Grrr...

So now I have to return the board and get a replacement.  Looks like no PVR for at least a few more weeks.  On the bright side, at least I can get the backend finished up.

Incidentally, in the process of looking up resources on how to debug this problem, I found this [forum post](http://hardware.mcse.ms/message324283.html) (second one down) describing the process of troubleshooting a motherboard.  I mirrored the content [here](../Motherboard_Troubleshooting.md) just in case the forum link disappears.

#### Wiring Hell

Meanwhile, I figured it would be a good idea to get the networking wired up to the living room.  Now, my plan was to reuse the existing coaxial outlet as the ethernet jack.  This is particularly convenient, in my case, because I'm dropping down between floors.  You see, in this case, when dropping cable from scratch, it's necessary to drive a hole between the lower wall framing plate and the subfloor.  This means augering a hole through four inches of wood... not fun, especially if you don't want to damage the wall.  However, because I was reusing the coax connection, this hole had already been cut, making my job much easier.

Thus, all I needed to do was drop a piece of cat5 around twelve inches straight down into the basement.  Easy, right?  Well, unfortunately, it wasn't that easy.  You see:

1. The coax utility box can't be moved out of the way, because it's fixed to the stud,
2. I'm dropping through an exterior wall, which means insulation, which gets in the way,
3. Because it's an external wall, the box is surrounded by a PVC boot, making it more difficult to access from below,
4. The hole in the basement is located near the exterior wall, over the existing framing, making it awkward to reach,
5. The existing coax is fixed inside the wall, meaning it can't be moved (or used to drag the cat5 through).

Now, the only workable method was to use a coat hanger to fish upward from the basement to the coax box.  Once I reached it, the plan was to fix the cat5 to the coat hanger and draw it down into the basement.  Things did not work out so well.  I eventually gave up at 12:30 last night, after around 4 hours poking and prodding inside my walls.

So, what now?  Well, Chris, a buddy from work, said he might come by on Saturday and give me a hand.  Hopefully, between the two of us, we can get the cable run.  Of course, until the EPIA replacement arrives, it won't actually get connected to anything...

