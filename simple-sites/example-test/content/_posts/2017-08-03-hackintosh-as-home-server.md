---
layout: article
title:  "Hackintosh as a home server"
author: Brett Kosinski
date:   2017-08-03 21:12:38 -0700
category: [ hackintosh ]
no_fediverse: true
---

The Intel NUC really is a remarkable little device.  The NUC I have (NUC6i5SYK) contains a Core i5-6260U containing 2 physical cores supporting hyperthreading clocked at 1.8Ghz base frequency up to 2.8Ghz turbo.  Into that little box I've recently packed 32GB of RAM and a 1TB NVMe SATA drive (I'd use PCIe, but macOS compatibility isn't great for PCIe NVMe drives), turning my NUC into an excellent, power-sipping little home server and workstation.

To that I've also added a Behringer UMC202HD U-Phoria USB audio interface and a DI box, which turns thing into a very nice little audio recording workstation.  Of course, it looks a little funny because the NUC is actually smaller than the audio interface!

{% lightbox /assets/images/USB_Audio_Interface.jpg --data="socket_with_diode" --img-style="max-width:800px;" %}

Some things I'm planning to do with this:

* Recording workstation.  Nuff said.
* Home backup server.  I'll expose the storage as a network drive that our Windows laptops can use as a backup storage location.
* Torrent server.  Transmission is an excellent, OSX native torrent client, and with 1TB of storage, my NUC is a perfect place to run it.

And more generally, this could be a useful place to host VMs as needed, and... well, really anything else I could imagine using a home server for (custom DVR for my IP camera system?  Hmm...).

Is this all overkill?  Maybe.  But hey, that's just how I roll...

