---
layout: article
title:  "macOS as NAS"
author: Brett Kosinski
date:   2017-08-09 21:09:56 -0700
category: [ hackintosh, selfhosting ]
no_fediverse: true
---

So, as I mentioned previously, one of my ideas for my hackintosh server was to turn it into a backup server/NAS for my home.  As a server, the NUC is an excellent option, being low power, quiet, and incredibly compact.  And while I can do some amount of backing up to cloud storage (i.e. Drive), for regular day-to-day backups a proper local solution is preferable.

Now, Lenore and I both have Windows 10 equipped laptops, which means we can take advantage of the File History feature to actually perform backups to a designated network drive.  So, it would seem that simply setting up a drive share on the Mac, and pointing our laptops at it, would do the job nicely!

Au contraire.

A few releases back macOS moved away from Samba to their own implementation of SMB (the Windows file sharing protocol).  Well, apparently that implementation of SMB does *not* work with File History.  And I have no idea why.  The errors you get make no sense, and there's basically no solutions out there on the internets.

You'd be amazed how long I spent pulling my hair out over this one.

Ironically, the solution I arrived at was as silly as it was obvious:  I deployed an Ubuntu Server VM running headless on the Mac via VirtualBox.  The VM mounts the macOS filesystem and shares it using Samba.

But it works!  We now have backups!

And while I was at it, I also finally set up Transmission and Flexget so I could move my bittorrent activity to the Mac as well.  The downloaded content is shared using the built-in macOS drive sharing features... for basic reads it seems to work just fine.  For now, anyway.

