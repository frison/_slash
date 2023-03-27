---
layout: article
title: Mysterious Uptime
author: Brett Kosinski
date: 2010-03-11 02:00:00 -0700
category: [ hacking ]
no_fediverse: true
---

Or:  Why RAID isn't foolproof.

First, a little bit of background.  At home, I have a [MythTV](../projects/MythTV.md) installation.  And as part of that installation, I have a [MythTV Backend](../projects/MythTV_Backend.md), which is basically a glorified fileserver that sports a couple video capture cards, the MythTV scheduling and recording software, a [mysql](http://www.mysql.org) database, and a few other odds and ends (not the least of which is this web server).  Now, being a fileserver, one of the jobs that machine fulfills is to provide large amounts of storage, primary for MythTV recordings, and since I don't want to lose those records, I have my storage set up in a RAID-1 mirror, which basically takes two drives and makes it look like a single drive, while underneath, anything written to the logical drive is actually written out to both physical disks.  That way, if something bad happens, I have what amounts to a live backup that I can quickly switch to (in addition to my regular, nightly incremental and weekly checkpoint backups).

So I came home on Wednesday night to discover something rather annoying:  Some sort of write error had occurred on one of those physical disks, and so the mirror was degraded and deactivated.  Now, this has happened in the past (I think it's related to a buggy DMA implementation on my SATA controller), but usually recovery is pretty easy:  remove the bad disk from the mirror, then re-add it, which causes Linux to synchronize the two disks, using the good disk as the primary.  But for some reason, this time, it wasn't so easy.

See, when I ran a command to view the status of the mirror, I found both drives marked as "removed" (ie, taken out of the mirror), and one marked as a "spare".  That itself is kinda weird, as usually it's one active, and one failed.  "Whatever", I told myself, "I'll just take the spare out of the mirror, re-add it, and then add the other drive, and voila, that should be it".  But when I attempted to re-add the spare, I got the weirdest error message:

    cannot find valid superblock in this array - HELP

I can tell you right now, when your computer is imploring you for help, it's probably a bad thing.  Now, for those not in the know, a superblock is kinda like a special marker on the disk, and in this case, it tells Linux which mirror the disk belongs to, along with a bunch of other metadata.  This error indicates that this decidedly important piece of bookkeeping information was, supposedly, absent.  That's bad.  Unfortunately, googling around lead me nowhere.  Even more confusing, when I attempted to mount (ie, attach, connect, etc) one of the halves of the mirror, the OS detected the filesystem, and the contents of the mirror looked to be intact.  And running a tool to examine the RAID mirror components returned what looked like perfectly normal data.

In the end, I gave up for the day, figuring I would come up with some strategy for moving forward the next day.  Eventually, I settled on breaking the mirror up, mounting both drives separately, and then using a tool like [rsync](http://samba.anu.edu.au/rsync/) to manually back up the primary disk to the secondary... not an ideal solution, as a disk failure means you lose everything since the last snapshot, but it'd do the job, and I wouldn't have to deal with RAID headaches anymore.

So this evening, I fire up zaphod (that's the fileserver name) into single user mode, and as I watch the kernel messages scroll by, I see the RAID mirror... start up perfectly normally.  Examining the mirror showed one active disk, and one re-syncing, suggesting that the kernel was rebuilding the RAID successfully.  What.  The.  Heck.  And as of this writing, I still have absolutely **no idea** what on earth went wrong, or how it magically got fixed.

Lucky.

