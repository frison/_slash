---
layout: article
title:  "Hackintoshing"
author: Brett Kosinski
date:   2017-07-20 21:02:19 -0700
category: [ hackintosh ]
no_fediverse: true
---

Early in the year, on a bit of a whim, I decided to pick up an [Intel NUC](https://www.intel.com/content/www/us/en/products/boards-kits/nuc/kits/nuc6i5syh.html).  These things are actually pretty slick little kit computers.  The model I purchased sports:

* Intel i5-6260U Skylake CPU
* Four USB ports
* HDMI and DisplayPort
* Built in WiFi and Bluetooth
* Ethernet
* SDXC card reader
* Audio output jack

All in a box that's 11x11x5cm.

As it's a kit, you're responsible for adding storage and memory, so to this I added 8 GB of RAM and a 120 GB SSD I had lying around.

Now, the main purpose of this thing was to replace the old computer I was using for idle guitar recording and so forth.  To that end, I loaded it up with [Ubuntu Studio](https://ubuntustudio.org/), installed Ardour, Guitarix, and a few other bits and bobs, and called it a day.  But I haven't been playing much lately, and recording not at all, so there it sat.

And then, on a whim, for reasons I honestly don't recall, I figured, hey, I'm bored and that NUC is just sitting there... why not descend into the depths of hell and try turning this thing into a [Hackintosh](https://en.wikipedia.org/wiki/OSx86)?

"A what?", you say?

Well, Mac OS is only shipped and supported with Apple hardware.  But ever since Apple switched to Intel for their machines, there's been a busy little community of masochists hacking the operating system and getting it to work on non-Apple hardware.  It's not for the faint of heart, but if you like to tinker and self-torture, it's an interesting challenge.

You can imagine why this piqued my curiosity.  Tinkering?  Masochism?  I'M IN!

My first crack at this, last weekend, involved trying to install El Capitan (macOS 10.11) with a standard recipe on tonymacx86.com.  This... did not go well.  To this day I have no idea why it didn't work, but it consistently failed to boot into the OSX kernel when I tried to load the installer from a USB stick.  I'm pretty sure I briefly went insane.  And the muttering.  My god, the muttering.

But, because I'm not one to give up in the face of adversity, even when the project is nearly pointless, I soldiered on.

And then it came to this: My hail mary.  Screw El Cap, why not just jump straight to Sierra and see what happens?  So on a Tuesday night I downloaded Sierra (macOS 10.12) directly from the App Store and tried it one last time.

And I'll be damned, it worked very nearly flawlessly!  I had to drop in some additional tweaks to get the Intel graphics chipset to work properly, but otherwise... it... just works.  I'm not 100% sure this isn't all an hallucination as a result of sleep deprivation.

So, let's define "just works".  The things that do work:

* Accelerated Intel Iris 540 graphics (I'm running this on a 1920x1080 Samsung TV).
* USB ports
* Onboard Ethernet
* HDMI audio

Of the things that don't work (and I knew these ones going in):

* WiFi and Bluetooth
* SD card reader

Fortunately I wired ethernet into my office years ago, and have a far more capable USB SD card reader, so none of these things much matter.

And beyond that, this thing is working great!  It's snappy as hell, and seems pretty darn stable.  Overall, after going through struggles with El Cap that made me want to tear my hair out, once I switched to Sierra the process ended up being incredibly easy (thanks to a great community with lots of resources and recipes).  As a result, I now have a very capable little Mac with the most recent version of macOS running on it.  Want proof?  Here it is!

{% lightbox /assets/images/Hackintosh.jpg --data="socket_with_diode" --img-style="max-width:800px;" %}

Not bad!

To this I've added recording software, drawing/diagramming tools, development tools, etc, transforming my languishing NUC into a very capable little multimedia authoring workstation.

Thanks Hackintosh community!

Update:

Just updated to macOS 10.12.6 using Apple's stock updater.  Flawless victory!


