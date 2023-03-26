---
layout: article
title: User Mode Linux As Cheap App Container
author: Brett Kosinski
date: 2011-01-11 02:00:00 -0700
no_fediverse: true
---

As anyone running Linux knows, one of the biggest challenges for a Linux user involves trying to run new software on an older distribution.  Many Linux applications (particularly Gnome and KDE apps) have enormous dependencies, and as applications move forward, they come to depend on newer versions of those dependencies.  The result is that, on, say, an older Ubuntu installation, running the latest version of your favorite application likely involves compiling and manually installing a dozen or more dependent libraries.  It is, to say the least, a huge pain in the ass.

In my particular case, my primary server is running an older flavour of Ubuntu, hosting my [MythTV](../projects/MythTV.md) backend software, [Apache](http://httpd.apache.org), [Deluge](http://www.deluge-torrent.org/), [Calibre](http://www.calibre-ebook.com/), and a few other applications.  And recently I decided I wanted to upgrade a few of these applications... enter dependency hell.  It quickly became obvious my plan simply wasn't feasible.

Now, I could've just given up, but I was bored, and I like fiddling around with things, and so the first thing that came to mind was a virtual machine of some description, running the latest version of Debian.  The most obvious solution was to install [VirtualBox](http://www.virtualbox.org/), and I briefly considered it, but vbox is a bit of a pain to manage remotely, and it certainly imposes a bit of a load on the host system.  Meanwhile, I knew I only wanted to run Debian on this thing, so a full-blown virtualization solution seemed like overkill.  And that's when I recalled a neat little project called [User Mode Linux](http://user-mode-linux.sourceforge.net/).

UML is an intriguing project.  It takes the Linux kernel, and by compiling it to its own architecture, turns the kernel into a standalone executable program.  Hand it a disk image containing a root filesystem, and the thing boots up as a nested Linux instance.  Voila!  Instant, lightweight virtual machine.  But how to get the root filesystem populated?  Enter [Debootstrap](http://wiki.debian.org/Debootstrap).

Debootstrap is beyond cool.  Give it an architecture and a distribution server, and it'll download and install the base components for a Debian-based operating system right into a directory of your choice.  So to build a UML disk image, you just need to:

    dd if=/dev/zero of=uml.img bs=1 count=1 seek=10G
    mkfs.ext3 uml.img
    mount uml.img /mnt -o loop
    debootstrap debootstrap --arch i386 sid *mnt http:*/http.us.debian.org/debian/

And voila!  The system is populated.  Now you just need a few tweaks:

1. Edit /etc/passwd and blank out the root password (make sure to reset it later!)
2. Modify /etc/udev/links.conf to add the UML block devices (see below).
3. Add /dev/ubd0 as the root filesystem in fstab.
4. Modify inittab, remove the existing VT definitions, and add one as follows: "c0:1235:respawn:/sbin/getty 38400 tty0 linux"

And then unmount the image and boot up as follows (assuming your linux kernel is in the current directory):

    ./linux mem=64M ubd0s=uml.img eth0=tuntap,,,ip.of.your.vm

And you should be in your VM!  Finally, set up the system locale properly (again, see below), and that's it, you're ready to install whatever applications you want to run!  At minimum, I'd recommend installing openssh-server.  Once set up, you can run the image headless with:

    ./linux mem=64M ubd0s=uml.img eth0=tuntap,,,ip.of.your.vm con=null &

(Note, there are other options for con... you can hook it up to a pty, making it accessible from screen or similar tools.  You can attach it to a Linux VT, or a serial port.  You can even make it available over telnet.)

Of course, eventually you might want some swap on the thing.  Fortunately, that's just a matter of creating a new disk image, adding:

    ubd1=swap.img

to the kernel command-line, and then doing a mkswap and swapon from the image itself (plus the necessary changes to fstab to add the swap on boot).

This configuration has enormous benefits.  First and foremost, it allows you to run select, bleeding edge software without having to modify the host system, which is really very nice.  Second, because you end up bootstrapping a minimum system by hand, the guest OS ends up very lightweight, so you can run the VM with a minimum of resources.  Third, this setup, being very similar to a BSD jail, allows you to sandbox away software that you'd like to isolate from the core system.

Of course, there are solutions which will provide better performance (KVM, XEN, etc).  But UML is very simple and straightforward, and for software that isn't performance sensitive, provides a very nice option.

### udev

Just append these links to /etc/udev/links.conf:

    M ubd0 b 98 0
    M ubd1 b 98 16
    M ubd2 b 98 32
    M ubd3 b 98 48
    M ubd4 b 98 64
    M ubd5 b 98 80
    M ubd6 b 98 96
    M ubd7 b 98 112

### locales

    apt-get install locales
    vi /etc/locale.gen - Uncomment "en_US.UTF-8 UTF-8"
    locale-gen
    update-locale LANG="en_US.UTF-8"

