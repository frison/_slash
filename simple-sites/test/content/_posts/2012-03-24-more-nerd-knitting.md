---
layout: article
title: More Nerd Knitting
author: Brett Kosinski
date: 2012-03-24 02:00:00 -0700
no_fediverse: true
---

Well, yet another long blogging hiatus.  So what's so important that I would take the time to author yet another scintillating installment?  Why, a knitting project, of course!

Some good friends of ours are expecting, and as I often do, another baby blanket is thus in the queue.  This one, however, is a bit unique, in that the mother has a very specific, and I think fairly awesome, request:  she wants a [Tux](http://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Tux.png/220px-Tux.png) blanket.

Awesome.

Of course, with some video game knitting experience behind me, throwing together a pattern for this is pretty straight forward:

1. Knit a swatch to determine row and stitch gauge.  This is *really* important, as this determines our pixel aspect ratio.
2. Based on desired measurements, calculate the size of our canvas by multiplying the row and stitch gauges by the target width and height respectively (in this case, 36x48 inches for 162 x 288 pixels).
3. Find decent source image.
4. Scale image to fit into desired canvas and layout, making sure to take into account our aspect ratio!
5. Apply "posterize" filter to limit to the number of colours in our knitting palette.
6. Scale back up by 6-8 times, and use the Gimp's grid generator plugin to transform into a pattern.

Result:

{% lightbox /assets/images/Tux_Pattern.png --thumb="/assets/images/thumbs/Tux_Pattern.png" --data="Tux_Pattern.png" --img-style="max-width:100;" %}

Then, I just split the image into three pieces and printed out in portrait mode.  Voila!  Pattern complete!

Next step, actually knitting the thing (I've already got materials picked out).

