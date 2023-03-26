---
layout: article
title: Again with the NetBSD
author: Brett Kosinski
date: 2010-03-05 02:00:00 -0700
category: [ hacking ]
no_fediverse: true
---

Well, it's been a couple days now, and I continue to fiddle around with NetBSD... it's definitely not going to be displacing Ubuntu any time soon, but it's definitely an amusing project to play around with.

Most recently, as I was testing out Evolution (my email client) compiled from pkgsrc, I discovered that it started up **incredibly** slowly.  Like, 5 minutes from invocation to a window popping up on my desktop.  So, a little Google-fu, and I found myself [here](http://blog.netbsd.org/tnf/entry/netbsd_runtime_linker_gains_negative).  It turns out that one of the things Evolution does a **lot** is attempt to open shared libraries that don't exist.  Unfortunately, those failures are very expensive, and as of 5.0.2, NBSD's linker doesn't cache the failures.

And this is where that blog post comes in.  The author of that post wrote up a negative lookup cache and incorporated it into the NBSD dynamic linker.  By itself, that'd be interesting, but what's deeply cool about this is that I was able to get a patch representing his change, tweak them, apply them to my local copy of the NBSD source, and then build out and install a new version of the dynamic linker.  Result:  startup times went from minutes to seconds.  I'd call that a huge win.

What this fundamentally speaks to is just how open and easy it is to fiddle around with the internals of NetBSD.  The entire system is designed to make it trivial to alter the base and rebuild it out from scratch, which makes it possible to do the kinds of things I just did.  Very cool!

Next up:  Attempt to hack nouveau DRI support into the kernel so I can get reasonable video performance.

