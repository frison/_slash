---
layout: article
title:  "Homegrown Backups Redux"
author: Brett Kosinski
date:   2019-06-23 21:11:16 -0700
category: [ selfhosting ]
no_fediverse: true
---

Over the last couple of years I've [written](2017-08-03-hackintosh-as-home-server.md) [extensively](2017-08-09-macos-as-nas.md) [about](2017-10-25-hackintosh-as-nas.md) [backup](2018-07-03-homegrown-backups.md) solutions.  The whole thing started as I tried to find a use for my NUC, which I initially turned into a [Hackintosh](2017-07-20-hackintoshing.md), a solution that was, frankly, in search of a problem.

macOS ran fairly nicely on the thing, but eventually I ran into [issues](2018-07-02-hackintosh-retrospective.md) which ultimately lead me to just converting the thing over to an Ubuntu 18.04 installation.  In the end, Linux is just, at least in my experience, a much better home server OS for mixed-OS environments (taking the SMB issues on the Mac as a perfect example).

Anyway, I still needed a backup solution, and I originally settled on a combination of a few things:

* For Windows machines
** A Samba file share on the server
** Windows 10 built in file copy backup capabilities
* For Linux machines
** Syncthing for real-time storage redundacy
** rclone for transferring backups to Google Drive for off-site replication.

The whole thing stalled out when I screwed up the rclone mechanism and inadvertently deleted a bunch of items in my broader Google Drive account.

Oops.

And so I became gun shy and paused the whole thing.

The other big change is I switched over to Ubuntu on my X1 Carbon, which meant that I now needed to sort out the backup solution for a Linux client as well.  Syncthing is great for redundancy, but it's not itself a backup solution.

So a couple of things changed, recently, that allowed me to close those gaps and resolve those issues.

First off, when it comes to rclone and Google Drive, I enabled two features:

* Set the authentication scope to "drive.file"
* Set the root_folder_id to the location on Drive where I want the backups stored

The first setting authenticates rclone to only be able to manipulate files it creates.  So Google Drive should prevent rclone from accidentally touching anything else but the backups it's transferring.

The second setting is belt-and-suspenders.  By setting the root_folder_id, even if Google Drive somehow screwed up, rclone would never look outside of the target folder I selected.

So, the accidental deletion problem should be well behind me.

The issue of backups with Linux was to expand my use of Syncthing to include additional folders on my laptop I want stored on my backup server.  This ensures that my laptop is always maintaining a real-time replica of critical data in another location.

Finally, I adopted [Restic](https://restic.net/) for producing snapshot backups of content that I replicate to my backup server.

Basically, I create a local replica of data on the server (either with Syncthing, rclone, lftp, or other mechanisms) and then use Restic to produce a backup repository from those local copies.  Restic then takes care of de-duplication, snapshotting, restoration, and other mechanisms.  The Restic repositories then get pushed out to Google Drive via rclone.

I've also extended this backup strategy to the contents of my linode instance (where this blog is hosted), and to Lenore's [blog](https://celebrityreaders.com).  Specifically, I use rclone (or lftp) to create/update a local copy of the data on those respective servers, and then use Restic to produce a backup repository from those copies.  And, again, those repositories are then pushed out to Drive.

Overall, I think this stack should work nicely!  And I like that it neatly separates the various stages of the process (data transfer, backup, off-siting) into a set of discrete stages that I can independently monitor and control.

Update:

Just a quick handy tidbit: When using rclone for backup purposes like this, it's a good idea to create a custom OAuth API key for use with Google Drive.  By default rclone uses a default API key shared by all other rclone users, which means you're sharing the API quota as well.  As a result, you get much better performance with your own key (though, unless you're willing to jump through a lot of hoops, you're stuck with "drive.file" scope... which, again, for this purpose isn't just fine, it's desirable).

