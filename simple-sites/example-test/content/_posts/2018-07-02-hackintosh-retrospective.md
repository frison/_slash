---
layout: article
title: Hackintosh Retrospective
author: Brett Kosinski
date: 2018-07-02 02:00:00 -0700
no_fediverse: true
---

Well, it's finally happened.  After a year of running semi-successfully, I've finally decided the trouble wasn't worth the effort and it was time to retire the [Hackintosh](2017-07-20-hackintoshing.md).

As a project it was certainly a lot of fun, and macOS definitely has its attraction.  In the end, though, I found my NUC was serving a few core functions for which macOS wasn't uniquely or especially suited:

1. Torrent download server
2. Storage target for laptop backups
3. Media playback of local content as well as Netflix

Of course, the original plan was to also use the machine as a recording workstation, but so far it hasn't worked out that way.  Yet, anyway.

Prior to a recent security update, there was a couple of issues that I generally worked around:

1. Onboard bluetooth and the SD card reader don't work.
2. The onboard Ethernet adapter stopped working after heavily utilization.
3. Built in macOS SMB support is broken when used as a target for Windows file-based backups.

These issues were resolved, by:

1. Avoiding unsupported hardware.
2. Using an external ethernet dongle.
3. Performing all SMB file serving via a Linux VM running on VirtualBox.

Meanwhile, the threat of an OS update breaking the system always weighed on me.

Unfortunately, it didn't weigh on me enough: the 2018-001 macOS security update broke things pretty profoundly, as the Lilu kernel extension started crashing the system on boot.

A bit of research lead me to updating Lilu, plus a couple of related kexts while I was at it, which brought the system back to a basically functioning state, except now:

1. HDMI audio no longer worked.
2. The USB Ethernet dongle stopped working.

The first issue rendered the machine unusable as a video playback device, a use case which is surprisingly common (my office is a very cozy place to watch Star Trek or MST3K!).

The latter left me with a flaky file/torrent server.

In short, all the major use cases I had for the Hackintosh no longer worked reliably, or at all.

Meanwhile, nothing I was doing uniquely relies on macOS.  I'll probably never get into iOS development, and the only piece of software I'd love to have access to is Omnigraffle (I never got far enough into recording tools to get attached to them).

So, no major benefits, and a whole lot of pain meant, if I'm being pragmatic, the Hackintosh was no longer serving a useful function.

So what did I replace it with?

Ubuntu 18.04, of course!

So far it's been a very nice experience, with the exception of systemd-resolved, which makes me want to weep silently (it was refusing to resolve local LAN domain names for reasons I never figured out).  Fortunately, that was easily worked around, and I'm now typing this on a stable, capable, compatible Linux server/desktop.

When I do finally get back to recording, I'll install a low latency kernel, jack, and Ardour, and then move on with my life!

