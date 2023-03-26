---
layout: article
title:  "Running Debian Buster on an OLPC"
summary: "Back in 2008 I got an OLPC XO-1 during the G1G1 program.  Question:  Can you successfully run Debian Buster on this modest hardware?  Answer:  Yes!"
author: Brett Kosinski
date:   2020-06-12 22:05:50 -0600
category: [ hacking, linux, masochism, olpc ]
syndicate_to: [ twitter ]
no_fediverse: true
---

Way back in the before time, in the long long ago of 2008, I decided to participate in the [One Laptop Per Child](https://en.wikipedia.org/wiki/One_Laptop_per_Child) Give One Get One program.  The vision of the program was compelling: play a small part in enabling childhood education by providing children in the poorest parts of the world access to cheap, simple, rugged computers.  Load them with electronic books and educational software.  Add support for wifi and mesh networking to enable connectivity[^1].  Unlock creativity in kids the way computers unlocked creativity in me.

Things didn't exactly pan out as everyone had hoped, but I still ended up with my very own [OLPC XO-1](2008-01-18-the-xo-arriveth.md), and it's sat quietly in a closet ever since, a toy that I take out and play with occasionally.

Well, we recently did a top-to-bottom purge of our house, and in doing so I once again ran across my XO-1.  So I decided to take it out and play with it again.  In particular, I was curious: what would it take to run the very latest version of Debian on this modest little device?

Turns out not much!  But where it got tricky, it got *really* tricky...

<!-- more -->

# Beginning

First, it's important to note that what follows is a very idealized write-up of the random walk it took me to get to a functioning system.  If you're reading this, just insert random dead-ends, attempts and re-attempts, late nights, and a lot of failure before I managed to make the dang thing work...

So it turns out a while back I'd already installed Debian Lenny on the XO, and it sat resident on an old SD card installed in the machine.  Apparently inspiration repeats itself.  But Lenny was obviously incredibly old and there was zero chance I was going to attempt an upgrade in place.  I'd need to figure out how to do this from scratch.

I started with the obvious: hunting around online for an existing guide or HOWTO for installing Debian on an XO-1, and that eventually led me to [the DebXO repository](https://github.com/atphalix/DebXO/)[^2].  Unfortunately, the project has been relatively dormant for a while now, so there was no chance I could use the supplied scripts out of the box.  I was going to have to do things by hand... which, let's face it, is way more fun!

# Basic setup

My personal laptop runs Ubuntu, which is a Debian variant, and so ships with a tool called `debootstrap`.  For those unfamiliar, `debootstrap` allows one to install a complete, basic Debian root filesystem on a target device.  Populate it with a kernel and you have the most barebones, basic core of a Debian system.  So, SD card (formatted as an ext3 filesystem) in hand, the first thing I needed to do was install the base system:

```
$ sudo debootstrap --arch x86 --components=main,non-free buster /mnt/sdcard http://ftp.ca.debian.org/debian/
```

What follows is a lengthy process of getting the basic filesystem in place and is so boring as to be unworthy of inclusion here.

Once the basic filesystem is in place, we'll need to perform a few key actions: install a kernel and ancillary bits to make the image bootable, and then update the fstab so the root filesystem is properly mounted on boot.

# Booting

My first crack at booting actually involved trying to use the stock Debian kernel.

This did not work.

To be honest, I don't recall how the failure manifested itself, but blow up it did!

So instead I decided to go grab an officially released kernel from the OLPC project and drop that into the image.  To do that I went and grabbed the [Linux 3.10](http://dev.laptop.org/~kernels/public_rpms/f20-xo1/kernel-3.10.0_xo1-20130716.1755.olpc.c06da27.i686.rpm) kernel RPM, pulled it open with the Gnome Archive Manager, and extracted the contents of the `/boot` and `/lib` directories into the root of my SD card.  In doing so this gave us a few bits:

1. The kernel itself
2. The kernel modules
3. `/boot/olpc.fth`, a Forth script that acts as the entrypoint for the OLPC boot process.

Next, I cracked open `/etc/fstab` and added the following line:

```
/dev/mmcblk0p1 / ext3 defaults,noatime 1 1 
```

Then I unmounted the card, popped it into the OLPC, and by god, it worked!

Sort of.  But we'll get to that later.

# Installing some packages

The base filesystem is obviously extremely barebones.  To make the XO-1 useful, we need to install some additional bits and pieces.

To do that, I popped the SD card in, mounted proc and devpts into the filesystem, and chrooted in[^3]:

```
sudo mount -t proc proc /mnt/sdcard/proc
sudo mount -t devpts devpts /mnt/sdcard/dev/pts
sudo chroot /mnt/sdcard
```

At this point I found myself in the root of the OLPC filesystem with the full power of `apt` at my disposal.  At this point I installed a whole raft of components.  First, there's the core bits you need to run the basic OS:

* olpc-powerd, olpc-kbdshim, olpc-xo1-hw
* firmware-libertas, wireless-tools, crda, wireless-regdb, wicd, wicd-curses
* alas-utils
* locales
* kbd, console-data, console-settings

Next we have a few standard utilities:

* psmisc
* openssh-client, openssh-server
* vim
* curl

Then there's all the bits we need to run X:

* xserver-xorg-core, xserver-xorg-legacy
* xserver-xorg-video-geode, xserver-xorg-video-openchrome
* xserver-xorg-input-kbd, xserver-xorg-input-synaptics, xserver-xorg-input-evdev
* xfonts-100dpi, xfonts-scalable, xfonts-base, fonts-liberation2
* x11-xserver-utils, x11-utils, xauth, xinit

Finally the bits you need for a functioning desktop (I went with LXDE):

* nodm, desktop-base, lxde, menu, xfce4-power-manager, wicd-gtk
* midori, ca-certificates

And this point, don't forget to run:

```
dpkg-reconfigure locales
```

At this point I expected everything to just work (albeit a bit slowly), but I ran across an issue I hadn't anticipated: today, glibc requires the kernel implement `getrandom`, and that syscall isn't available in Linux 3.10!  The result was randomly failing software.

I guess I was gonna have to build my own kernel after all.

# Building the kernel

It had been a *long* time since I'd last built a custom kernel, so the very basics eluded me.  Fortunately, with a lot more hunting around online, and the dusting off of some vague memories, I managed to make it work.  Eventually.

First off, which kernel?  Well, I figured, let's be ambitious!  So I went out and grabbed the 5.7 kernel release and got to work.

The hard part in building a kernel is configuring the damn thing, as the dizzying array of settings, combined with the deep technical jargon, makes it nearly impossible to make all the right choices.  Fortunately, the OLPC folks have a [5.0 kernel tree](http://dev.laptop.org/git/olpc-kernel/log/?h=olpc-5.0) with a configuration already available.  So I grabbed the `xo_1_defconfig` from `/arch/x86/configs`, dropped it into my tree, and then did the obvious:

```
make ARCH=x86 xo_1_defconfig
make bzImage
```

And off it went!  Before long I had a shiny new kernel ready and waiting for me.  So I dropped it into the `/boot` directory, updated the softlink at `/vmlinuz`, and fired it up![^4]

And I was greeted with a scrambled screen followed by a spontaneous reboot.

Huh.

It took me days to finally figure out the solve.

# Building the kernel, take two

I honestly spent hours and hours fiddling with kernel settings, compiler arguments, and alternative source trees in an attempt to figure out the source of the problem.

At one point I cut back to various other known good kernel versions from the OLPC project, including various versions of the 4.x line.  In those cases the results were different, but no less discouraging:

```
ok boot
Invalid Opcode
```

This clearly points to an issue in the compiler, as it appeared to be generating invalid code for the OLPC.  But how do I solve *that*?  Messing around with compiler settings while hoping to land on the solution?  Ugh...

The answer came when I decided to look at the `dmesg` output for the olpc-5.0 kernel build to see which version of gcc was used to build the kernel.  The answer was GCC 4.8, which is available in Debian Jessie (though not as the default compiler).

So, desperate, I set up a new 32-bit Jessie VM (shameless plug for QEMU+KVM, which is an amazing, open source, Linux-native virtualization stack) in the hopes that I could reconstruct the kernel build environment.  The trickiest bit, here, was in realizing Jessie doesn't use GCC 4.8 by default, so I had to explicitly install the `gcc-4.8` package and then run all my `make` commands with `CC=gcc-4.8` as one of the arguments.

Then, on my freshly minted VM, I took the olpc-5.0 kernel branch, built out the kernel, dropped the image on the SD card, and booted up the XO-1.

And by god.  It worked!

Apparently somewhere along the way GCC broke code generation for the AMD Geode LX.  If I was more ambitious I would bisect GCC versions to find the regression, but... ugh.

Anyway, with a working 5.0 kernel I decided to try my hand at 5.7.1, and once again, the kernel booted just fine![^5]

Mostly.

# A broken DCON driver

The XO-1 has a rather unusual video hardware configuration that allows the XO to go to sleep with the display still enabled.  This oddball hardware configuration requires a driver, and that driver is built into the stock kernel.

Unfortunately, inspecting the kernel logs, it was evident that driver was not working.

However, booting the old 5.0 kernel, it clearly *was* working.  So something changed.

It turns out that somewhere in between, the driver had been rewritten to update it to no longer use old, deprecated in-kernel APIs used to interact with GPIO devices.

But, too lazy to actually diagnose the issue, I used a large hammer:  I copied the old 5.0 driver into the 5.7 kernel tree!  This did require a bit of hacking, as I needed to tweak the Kconfig.  But otherwise it built fine, and [you can download the replacement driver](/assets/linux-5.7.1-old-dcon-driver.tar.gz) (just decompress the archive into the root of the 5.7.1 kernel tree).

Then, another build, and voila!  it worked!

After that I made more tweaks to the configuration, removing unnecessary modules, adding support for some USB ethernet devices, and other little tweaks.  You can [download my .config file](/assets/linux-5.7.1-xo_1_defconfig) if you want to build one out yourself!

Oh, and do yourself a favour and add this to your kernel parameters in `olpc.fth`:

```
net.ifnames=0
```

Turns out the OLPC wifi driver spins up the msh0 and wlan0 devices in a random order.  Combined with [udev device renaming](https://wiki.debian.org/NetworkInterfaceNames), it means it's a coin toss whether the correct device gets used.

And note, you may have to fix your wicd configuration so that it references `wlan0`.

# Oh Rust...

I should probably mention at this point that, yes, the `getrandom` issue was resolved!  Yay!

So I fired up X, and opened up the LXDE system menu, and... the panel crashed.

Huh.

Eventually it occurred to me to manually run `lxpanel` from a shell so I could observe it crashing, and I'll be damned if I didn't get a familiar failure:

```
Program terminated with signal SIGILL, Illegal instruction.
```

Huh.

Little did I realize I was about to dip into a tiny bit of drama in the open source community.

Firing up trusty `gdb` and running the application during this error pointed to librsvg as the origin of the issue.  So, I naturally searched for the error and this library and turned up [a Redhat Bugzilla issue](https://bugzilla.redhat.com/show_bug.cgi?id=1612540).

See, it turns out that the librsvg maintainer has decided to start porting bits of the library over to Rust.  And the Rust compiler unfortunately [includes SSE2 instructions in any 686 compile](https://github.com/rust-lang/rustup/issues/1196).  This is clearly a severe limitation in Rust CPU support, but the Rust maintainers have committed to not fixing it as they view pre-SSE2 CPUs as not worth supporting.  And the librsvg maintainer is... well... to put it politely, unapologetic regarding his choices.

Apparently neither one of these groups is interested in [thinking of the children](https://tvtropes.org/pmwiki/pmwiki.php/Main/ThinkOfTheChildren)!

Unfortunately, that means that the stock librsvg that ships with Debian Buster will never work on the XO-1.

Digging around, I found that version 2.40.21 of librsvg was the last version that did not include any Rust.  So, I set up a 32-bit Buster VM (it's just easier than trying to cross-compile to 32-bit on my laptop), downloaded the 2.40.21 source, and configured and built the thing:

```
$ ./configure \
  --build=i386-linux-gnu \
  --prefix=/usr --includedir=\${prefix}/include \
  --mandir=\${prefix}/share/man --infodir=\${prefix}/share/info \
  --sysconfdir=/etc --localstatedir=/var \
  --libdir=\${prefix}/lib/i386-linux-gnu --libexecdir=\${prefix}/lib/i386-linux-gnu \
  --libexecdir=\${exec_prefix}/libexec \
  --disable-silent-rules --disable-maintainer-mode \
  --disable-dependency-tracking --enable-pixbuf-loader \
  --enable-installed-tests --enable-introspection \
  --enable-vala --enable-gtk-doc \
  GDK_PIXBUF_QUERYLOADERS=/usr/lib/i386-linux-gnu/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders

$ make
```
The result was a shared library in the `.libs` directory that I manually dropped into place.

Then, I once again booted the XO-1, fired up LXDE, and... by god... it worked!

# Some tweaks

At this point the XO-1 basically works, though there was a few additional tweaks I added to the mix:

* I fired up `dpkg-reconfigure console-setup` and disabled changing the boot font, as the one it picked was far too small.
* I reconfigured X to fix a DPI issue:
  * sudo X -configure
  * Copy `xorg.conf.new` to `/etc/X11/xorg.conf`
  * Edit the monitor section and add the line `DisplaySize 200 150`

And... that's it!

# This was harder than it looked

This is definitely an idealized version of this story that elides a lot of deep frustration.  Here's a few examples of things I tried and failed with:

1. Using (or rather failing to use) NetworkManager before I learned about Wicd.  Big mistake.
3. Not knowing about the various OLPC support packages that make the special keys and switches work correctly.
4. The kernel.  So many false starts with the kernel.
5. Hours poking around at lxpanel trying to understand why it was crashing before it dawned on my to fire it up in gdb.
6. Attempting to fix librsvg itself before realizing it's a Rust compiler issue.
7. Digging around in the DCON driver code before just deciding to port the old driver.
8. Solving the wifi device renaming problem.

But, in the end, the XO is working nearly perfectly!

Now, I gotta say, on the one had, this was an awful lot of effort for a largely pointless outcome.  After all, the XO is so modest that it can't reasonably be used for much anymore besides a dumb terminal.  But, in a lot of ways, taking this on reminds me of many of the old projects I used to tackle.

In the past I'd rarely worry about whether or not the thing I decided to try was of value to anyone.  Instead, I attacked these projects for the same reason people climb mountains: because they're there.  The joy was in the cracking of hard problems; the fun was in the solving of those weird issues that make technology sometimes feel like a perverse Rubik's Cube.

And so in the end it was an enormously satisfying little detour!

[^1]: Maybe even include a hand-cracked charger for when a power supply wasn't available.  This part did not pan out.
[^2]: Which, it turns out, is the exact project I used back when I installed Lenny... I really was repeating myself!
[^3]: And don't forget you need to unmount proc and devpts before unmounting the SD card... I tried that once.  I was confused.
[^4]: I deliberately skipped two steps here: updating initrd and installing the kernel modules.  I wanted to test if the kernel could even boot first...
[^5]: It's worth noting that I built the kernel with all the necessary drivers compiled in.  That means my XO has no kernel modules installed, and does not boot with an initrd.  I had to update my `olpc.fth` accordingly.
