---
layout: article
title: Why I Hate Building Computers
author: Brett Kosinski
date: 2006-04-29 02:00:00 -0700
category: [ technology, aggravation, anecdotes ]
no_fediverse: true
---

So some of you may remember that a while back, I had a combination hard drive **and** power supply failure, simultaneously.  The hard drive failure was pretty easy to detect, thanks to that lovely, disturbing clicking noise that haunts the dreams of anyone who's experienced such a failure.  Fortunately, the danger here was mitigated by the fact that, for some time now, I've chosen to run a pair of drives in a mirrored configuration (aka, RAID-1).  Thus, while it appears to the user that I have a single drive, in reality, the data is always written to both drives.

The power supply, on the other hand, was an entirely different matter.  When I noticed the failed drive, I removed it from the mirror and attempted to reboot my computer.  But the other drive wouldn't spin up!  Or, it would spin up, but the computer wouldn't detect it!  Scared, I moved the drive to a spare machine I had, but sure enough, that machine wouldn't detect the drive either!  As a last resort, I took the drive to work the next day, and, to my great relief, the drive was perfectly readable, with all data intact.  It was at this point that Lenore reminded me that my spare machine wasn't in use because the hard drive controller was hosed.  I then made the assumption that the same was true for my main computer.

Thus, I resolved to purchase myself another motherboard.  So I took a trip over to BEST Computers and picked up a new board and a pair of new drives to replace my old mirror.  But, when I got home that evening, I had a little epiphany, and decided to use my spare computer's power supply in my main machine, just to test it out.  And voila!  It worked perfectly!  Let this be a lesson:  power supply failures can create weird, mysterious problems.

**Anyway**, what does this have to do with building computers?  Well, suddenly, I had myself a spare motherboard and nothing to do with it.  The natural thing, I thought, was to build a new machine (as opposed to just returning it...).  So, eventually, I picked up a new power supply ($80), and this combined with the surviving hard drive from my last mirror, and the video card and RAM from my spare machine equalled a new box.  Or so I thought.

So I began assembly.  All seemed to go well.  I got the motherboard mounted, and proceeded to grab the RAM... which, I discovered was 133-pin SDRAM, too old for my new board which required 184-pin DDR-RAM.  **sigh**  So I took a last minute trip to Best Buy (yeah yeah, piss off) and picked up a gig of new memory ($140 - $26 rebate).

Alright, so, RAM now installed.  Case back panel, mounted.  Front panel connectors, connected.  Hard drive and CD-ROM, installed.  So far so good.  Lastly, video card.  

Now, you probably already know this, but the job of the tech industry is to make simple things hard and hard things impossible.  In the case of video cards, they decided to invent the AGP slot, into which a video card is to be installed.  Which would be simple.  To make it hard, they decided to have different voltages for AGP.  3.3v, 1.5v, and if that wasn't enough, 0.8v too!  So, if you have a card in one voltage, and board which only takes another, you're hosed.

I bet you can guess what happened.  I, apparently, have a 3.3v AGP card.  Conveniently, my motherboard only takes a 1.5v AGP card.  **grumble**.  So now I'm stuck buying a new video card ($80).

So, total for this adventure:

|Motherboard|$150|
|Power supply|$80|
|RAM|$140|
|Video card|$80|
|Rebate|-$26|
|**Total:**|$424|

And the sick thing is, for about $80 more, I could get a whole new computer with a bigger hard drive and a nice sized LCD flat panel monitor to replace the 15" piece of CRT crap that I have now.  And that is why I hate building computers.

