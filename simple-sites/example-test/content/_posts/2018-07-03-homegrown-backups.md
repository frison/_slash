---
layout: article
title: Homegrown Backups
author: Brett Kosinski
date: 2018-07-03 02:00:00 -0700
no_fediverse: true
---

I mentioned a while back that I'd moved to using my NUC as a backup storage device, and that continues to be a core use case after I repaved and moved the thing back over to Ubuntu.

Fortunately, as a file server, Linux is definitely more capable and compatible than macOS (which is why, back when it was a Hackintosh, I used a Linux VM as the SMB implementation on my LAN), and so I've already got backups re-enabled and working beautifully.

But the next step is enabling offsite copies.

Previously, I achieved this with Google Drive for macOS, backing up the backup directory to the cloud, a solution which worked pretty well overall!  Unfortunately, Google provides no client for Linux, which left me in a bit of a jam.

Until I discovered the magic that is [rclone](https://rclone.org/).

rclone is, plain and simply, a command-line interface to cloud storage platforms.  And it's an incredibly capable one!  It supports one-way folder synchronization (it doesn't support two-way, but fortunately I don't need that capability), which means that it's the perfect solution for syncing up a local backup folder to an offsite cloud stored backup.

But wait, there's more!

rclone also supports encryption.  And **that** means that (assuming I don't lose the keys... they're safely stored in my [keepass](https://keepassxc.org/) database (which, itself, is cloned in multiple locations using my other favourite tool, [Syncthing](https://syncthing.net/))) I can protect those offsite backups from prying eyes, something which Google's Drive sync tool does not offer.

I can also decide when I want the synchronization to occur!  I don't need offsites done daily.  Weekly would be sufficient, and that's a simple crontab entry away.

Now, to be clear, rclone would have worked just as well on the Hackintosh, so if you're a Mac user who'd like to take advantage of rclone's capabilities, you can absolutely do so!  But for this Linux user, it was a pleasant surprise!

