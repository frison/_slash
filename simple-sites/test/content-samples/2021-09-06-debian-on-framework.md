---
layout: article
title:  "Debian on Framework"
summary: "I finally put together a post on getting Debian Bullseye running on my Framework laptop! Here I focus on building a newer kernel plus custom Debian packages for libfprint and fprintd."
author: Brett Kosinski
date:   2021-09-06 19:05:18 -0600
category: [ frameworklaptop, linux, technology, righttorepair ]
syndicate_to: [ twitter ]
no_fediverse: true
---

I recently received the fantastic first laptop from a new company called [Framework](https://frame.work/), which is specializing in building extremely user-serviceable, repairable, upgradeable laptops (in fact, they recently received a rare [10 out of 10 from iFixit](https://www.ifixit.com/News/51614/framework-laptop-teardown-10-10-but-is-it-perfect)).  I opted for the DIY unit, which among other things allowed me to bring my own operating system, and for me the OS of choice is unquestionably Debian Linux.

Prior to receiving my Framework I'd been running Debian testing on a fifth generation Lenovo X1 Carbon.  As is typically the case with Lenovo, the X1 worked extremely well with Linux.  In fact, it worked far better than I'd ever expected of Linux on a laptop, which I'd come to assume was always an unreliable, janky affair.

Framework has similarly embraced the Linux community but, given the cutting edge hardware they've included, I was expecting some rough spots while drivers and so forth matured.  And while this has turned out to be somewhat true, the good news is it's been quite easy to get past those issues, and I'm happy to report that Debian testing is now working extremely well on my Framework.

In the rest of this write-up I cover the steps I took to get a fully functional Debian Bullseye installation running on my machine using the Gnome desktop environment (after which I did an in-place upgrade to Bookworm).

Of course, if you're looking for a slightly more turnkey solution, I strongly recommend trying out Ubuntu 21.04, which ships with a kernel that fully supports the Framework hardware.  You'll still need to take steps to get the fingerprint reader working, but at least you can avoid compiling a kernel.

<!-- more -->

# Installation

Honestly, there's not a lot to say about the base installation process.  Using my old laptop I downloaded an ISO from the [Debian download page](https://www.debian.org/distrib/netinst) and wrote it to a USB drive using the Gnome Disks tool (for Windows users, you'll want to use [rufus](https://rufus.ie/en/)).

After that it was a simple matter of starting up the Framework with the USB drive plugged in and I was off to the races.

In terms of disk layout, I did the following, though obviously this is a matter of personal taste:

1. Separate root and home directories.
2. Some reserved space between the root and home directories sufficient for a second root filesystem.[^1]
3. Swap space a little bigger than my physical memory (to support hibernation later).

The rest was a pretty vanilla install.

Upon logging into the Gnome desktop you may run into a problem where the touchpad doesn't register mouse clicks.  If you encounter this issue, you'll need to use the keyboard to enable "Tap to Click" (don't ask me why, I just work here):

1. Press the Windows key and type 'mouse', select 'Mouse & Touchpad'
2. Press the tab key until the "Tap to Click" toggle is highlighted, then press the Enter key to toggle

That should get your touchpad fully working.[^2]

# Enabling deep sleep and hibernate

If you make use of S2 suspend, you'll want to ensure you enable deep sleep in order to reduce battery usage.  To do so, open up `/etc/default/grub` (as root or with sudo) in your editor of choice and modify the `GRUB_CMDLINE_LINUX_DEFAULT` setting to add the following to the kernel argument:

```
mem_sleep_default=deep
```

If you're interested in experimenting with hibernation (which I'm using exclusively), you'll want to run `blkid | grep swap` with root privileges and collect the value of the `UUID` for the swap block device.  Once you have that value, add the following kernel argument:

```
resume=UUID=<UUID of the swap device>
```

Finally, I did note that when waking up from hibernate, I'd experience spurious but harmless NMI watchdog errors, so I just disabled it by adding the following:

```
nmi_watchdog=0
```

At this point you'd normally run `update-grub` but in the next section we'll be building and installing a new kernel, so that'll end up happening anyway.

# Wifi and Bluetooth

Assuming you bought a wifi card from Framework[^3], you'll probably find that neither wifi nor Bluetooth are working due to broken drivers in the kernel shipped with Debian Bullseye.  In order to fix this we're going to need to compile our own kernel.  I personally recommend grabbing the 5.12.19 kernel from [kernel.org](https://www.kernel.org), which as of this writing is working flawlessly on my machine.

Rather than outline every individual step here, I'm going to send you to the [Debian Handbook](https://debian-handbook.info/browse/stable/sect.kernel-compilation.html) which documents the process in detail.  However, to ensure a functioning touchpad, at the step where you copy the current kernel config file into your build directory, you'll need to take the extra step of enabling the I2C HID modules by adding the following extra lines to your .config file:

```
CONFIG_I2C_HID_CORE=m
CONFIG_I2C_HID_ACPI=m
```

Finally, you might as well take advantage of all those fancy cores on your new laptop by parallelizing the build as follows:

```
make -j 9 deb-pkg LOCALVERSION=-brettk KDEB_PKGVERSION=$(make kernelversion)-1
```

Just make sure you've got your Framework plugged in and set on a hard surface, because those fans are gonna be running full blast...

Once the build is done you should end up with a kernel package in the parent directory which you can install with `dpkg -i <kernel package name>` (as root or with sudo).

At this point if you try to boot your fancy new kernel you're gonna get an error about the kernel being unsigned. To deal with that, use Grub to boot into the system setup (or restart the machine while mashing the F2 key) and disable secure boot:

1. Tab to the Security page
2. Select the Secure Boot section at the bottom
3. Turn off "Enforce Secure Boot"
4. F10 to save and reboot into your new kernel

At this point all your hardware should be working with the exception of the fingerprint reader.  If you're using wifi, now is a good time to set it up!

# Fingerprint reader

To get the fingerprint reader working we'll need to install libfprint 1.92.1 and fprintd 1.92.0.

The more common way is to clone the respective git repositories, check out their tags, install the build pre-requisites, and then manually install to "/usr/local", but there's a couple downsides to that approach: first, it doesn't cleanly integrate fprintd into the system, and second, it'll be more difficult, later, when Debian upgrades those packages.

To avoid those issues, my approach was to build and install my own Debian packages for those two pieces of software, using the existing packages as a base.  I will warn you, though, the libfprint steps below are a little fiddly so make sure to *read closely*!

## libfprint

To begin, create a working directory and download the Debian package source, the libfprint source, and associated build dependencies:

```sh
apt source --download-only libfprint
sudo apt build-dep libfprint
sudo apt-get install libgudev-1.0-dev
git clone https://github.com/freedesktop/libfprint.git 
```

Now, we'll jump into the libfprint repository, check out the 1.9.2 tag, and unpack the debian control files:

```sh
cd libfprint
git checkout v1.92.1
tar -xJvf ../libfprint_1.90.7-2.debian.tar.xz
```

At this point if you attempt a build you'll get a whole mess of errors.  We're going to need to change the debian control files to adapt them to the new code.

To begin, we need to make some changes to the `debian/rules` file.  First, we'll update the rules to only build the driver we need:

```makefile
CONFIG_ARGS = -Dudev_rules_dir=/lib/udev/rules.d -Dgtk-examples=false \
              -Ddrivers=goodixmoc
```

We'll also need to comment out the lines for moving around the autosuspend files (as far as I can tell they're only needed for the ELAN driver):

```makefile
override_dh_install:
#	mv debian/tmp/lib/udev/rules.d/60-libfprint-2-autosuspend.rules \
#		debian/tmp/lib/udev/rules.d/60-libfprint-2.rules
```

Next up, we need to modify `debian/libfprint-2-2.install` to install `hwdb.d` and not `rules.d`:

```
lib/udev/hwdb.d/
usr/lib/${DEB_HOST_MULTIARCH}/libfprint-*.so.*
```

Then, download a copy of the [libfprint 1.92.1 symbols](/assets/files/libfprint-2-2.symbols) and place the file in the `debian/` directory.

Finally, we'll update `debian/changelog` to add an entry for our version at the top of the file:

```
libfprint (1:1.92.1-1) unstable; urgency=medium

  * custom build for use on my Framework laptop

 -- Brett Kosinski (brettk) <email>  Fri, 6 Sep 2021 20:05:00 -0700
```

Then, build the package!

```sh
sudo dpkg-buildpackage -b -uc -us
```

The result should be a set of Debian packages in the parent directory!  You'll want to use `dpkg` to install:

* libfprint-2-2_1.92.1-1_amd64.deb
* libfprint-2-dev_1.92.1-1_amd64.deb
* gir1.2-fprint-2.0_1.92.1-1_amd64.deb

## fprintd

While getting libfprint built was a bit of a pain, fprintd is much simpler.  The first essential steps are the same (starting in some build directory):

```
apt source --download-only fprintd
sudo apt build-dep fprintd
git clone https://github.com/freedesktop/libfprint-fprintd.git 
cd libfprint-fprintd
git checkout v1.92.0
tar -xJvf ../fprintd_1.90.9-1.debian.tar.xz
```

Edit `debian/changelog` to create a new entry for our version:

```
fprintd (1:1.92.0-1) unstable; urgency=medium

  * custom build for use on my Framework laptop

 -- Brett Kosinski (brettk) <email>  Fri, 6 Sep 2021 20:05:00 -0700
```

Then build the package!

```sh
sudo dpkg-buildpackage -b -uc -us
```

You should end up with a package named `fprintd_1.92.0-1_amd64.deb` in the parent directory that you can install with `dpkg`.

Finally, enable and start the service:

```
sudo systemctl enable fprintd.service
sudo systemctl start fprintd.service
```

# Setting up fingerprints

At this point, if all went well, assuming you're using Gnome you can enroll a new set of fingerprints:

1. Hit the Windows key, type "Users", and open the settings panel
2. Select "Fingerprint login"
3. Enroll fingerprints

Additionally, if you want to use the fingerprint reader with `sudo`, you can run the following command:

```
sudo pam-auth-update --enable fprintd
```

Voila!  At this point all of the hardware on your laptop should be functioning.

# Power management

Power management on Linux has traditionally been a bit... fiddly to get right.  On the Framework I've had great success running `tlp` with the following settings:

```
CPU_ENERGY_PERF_POLICY_ON_BAT=power
PCIE_ASPM_ON_BAT=powersupersave
```

Note, some folks report performance issues with this policy.  If that's the case, change the first setting from `power` to `balance_power`.

Additionally, note that as of this writing, both the HDMI and SD card modules have been reported to increase power draw.  I expect these issues will be partially or fully resolved in the future, but for now, if you're looking to extend battery life, I recommend removing those cards when they're not in use.

Finally, there have been some reports of Panel Self Refresh causing screen stuttering or flickering.  I've not experienced this on 5.12.19 but if you do run into this issue, add `i915.enable_psr=0` to your kernel boot arguments.  Keep in mind, though, that this can increase power consumption significantly (i.e. 2-3W idle versus 5-6W).

# Other stuff

So that's it!  At this point you should have a fully functioning Framework laptop with all the bells and whistles enabled.

Of course, there's a whole bunch of other things I did to improve the quality of life on my machine, including:

* Getting decent HiDPI going with Wayland (this could be a whole, very long post of its own)
* Switching to Pipewire for audio (much better Bluetooth support)
* Enabling hibernation in various circumstances

But, quite honestly, there's nothing special about the Framework in those respects and any generic Linux HOWTO or blog post on those topics will send you in the right direction.

Good luck!  And if you have any questions or issues, the [Framework community forums](https://community.frame.work/) are an absolutely outstanding resource.

[^1]: I like to leave room for a second operating system install, in case I decide I want to re-pave the OS or try other OSes or Linux distributions.
[^2]: It's worth noting this was not an issue in Ubuntu 21.04.
[^3]: Of course, one of the beautiful things about this laptop is you can always buy a wifi card separately or even scavenge one from an old laptop so long as it's compatible with an M.2 2230 socket.
