---
layout: article
title: Ubuntu on the 2017 Lenovo X1 Carbon
author: Brett Kosinski
date: 2018-07-22 02:00:00 -0700
no_fediverse: true
---

I've long been an enormous fan of Lenovo equipment, and last year I decided to finally upgrade my aging T410 and get the truly fantastic 2017 revision of the X1 Carbon.  A year on it is unquestionably one of the finest pieces of equipment I've ever owned.

The laptop naturally shipped with Windows 10, and as an operating system I have few issues with it.  My work involves a lot of Microsoft-specific software, including Outlook and Skype for Business, so it's a good fit for when I want to work from home and not transport my work equipment from the office.  But as a development environment it's only decent.  [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) certainly makes the experience a fair bit more enjoyable, but it stills feels a little clunky.

Meanwhile, there's definitely a few things that irritate, the most notable being the unplanned reboots, for which Windows 10 has become legendary.

Of course, Windows on Intel hardware does have its advantages.  Chipsets and peripherals Just Work, and Windows has gotten much better with touchpad support and so forth.  So, in the end, I don't have a lot of complaints.  Ultimately, completely leaving Windows behind on this machine just isn't tenable given my use cases.

But, that doesn't mean I can't try Linux out, and so I did with Ubuntu 18.04!

This is just a quick write-up of the installation process and some of the issues I've encountered, in case this has any utility for anyone.

First off, honestly, the install process was dead simple.  I was a little worried about the UEFI bootloader and so forth, but ultimately I just had to:

1. Disable Fast Boot in Windows
2. Disable Secure Boot in the BIOS

After that, I carved out some space on the disk from the existing NTFS partition and then installed from a USB key I wrote using Rufus based on the Ubuntu 18.04 ISO.

So far, pretty bog standard stuff, and certainly a far cry from the old days of installing Slackware from a dozen floppies!

The OS, itself, works so well as to trick one into thinking all was going to be perfectly fine and everything was simply going to work out of the box!

Not so.

In particular, using the 4.15 kernel that ships with Ubuntu, I ran into a rather bizarre error where the Thunderbolt USB controller would be "assumed dead" by the kernel (Linux's words).  This resulted in attempts to enumerate the PCI devices failing, and **that** then lead to various and mysterious application failures if they happened to use libpci.  I can only assume the USB ports were also non-functional, but I never actually checked that.

This lead me down an extensive troubleshooting path that was only resolved when I decided to downgrade my kernel.

Yes, that's right.  Downgrade.

Moving to 4.14 resolved the issue, which means clearly a bug has been introduced in 4.15 (and before you ask, yes I tested 4.17, and no the issue isn't fixed... alas).

Oh, but there's more!

Sleep on lid closed worked wonderfully, except that upon waking, two finger scrolling broke.

Weird.

Fortunately, there's a workaround:  Add "psmouse.synaptics_intertouch=0" to your Linux kernel boot arguments.

With those two workarounds, this thing actually seems to be working pretty well (as evidenced by the fact that I'm writing this post on Ubuntu on my laptop).  Wifi clearly works, as does Bluetooth, sound, and accelerated video.  USB devices appear to work (though I've only just started testing).  Plugging in an external HDMI TV works flawlessly.  Suspend works perfectly (though I've still not gotten hibernate working).

In short, so far the essentials are functional.

Meanwhile, amazingly, battery life seems to be as good as Windows; something that I certainly couldn't claim in the past.  And that's without any kind of tweaking.

Update:  I installed TLP plus the associated Thinkpad kernel module and when just doing light browsing or typing, on a full charge, Ubuntu reports an astonishing fourteen hours of battery life.  Windows has never come close!

In short, while this setup is clearly still not for amateurs (having to downgrade kernels and fiddle with boot arguments to get basic functionality working is not for the feint of heart), it does seem to work well once those issues are overcome.

The real question is one of long-term stability (and utility).  Only time will tell!

Update:

Windows assumes the hardware clock is in local time.  Ubuntu defaults to assuming the hardware clock is in UTC (which is almost certainly the right thing to do).

This means that switching between the two results in the clock getting set incorrectly!

The simplest solution is to make Ubuntu match Windows' braindead setting as follows:

    timedatectl set-local-rtc 1 --adjust-system-clock

Confirm by just running timedatectl without any arguments, which should result in this warning:

    Warning: The system is configured to read the RTC time in the local time zone.
             This mode can not be fully supported. It will create various problems
             with time zone changes and daylight saving time adjustments. The RTC
             time is never updated, it relies on external facilities to maintain it.
             If at all possible, use RTC in UTC by calling
             'timedatectl set-local-rtc 0'.

