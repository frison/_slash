---
layout: article
title: Slow, Inexorable Progress
author: Brett Kosinski
date: 2007-12-16 02:00:00 -0700
category: [ nethack, hacking, nintendods ]
no_fediverse: true
---

Very very slow... or, at least it feels that way.  In reality, I can't really complain.  Word wrapping, even nice paragraph-reflowing word wrapping, is in and works quite nicely.  Meanwhile, the command window is now finished, and supports snazzy scrolling when it's necessary (of course, the default font still doesn't require it, but switching to, say, the map font, which is 8x16, results in four pages of commands).  It's lightening quick, too, unlike the rest of the rendering code (yay large backbuffers and DMA copies).  Meanwhile, the menu item wrapping code is... coming along.

Of course, the menu code has been a constant thorn in my side... I'm starting to realize I really need to go back and rethink how the code is designed, but at this point, I just want to get it working and move the heck on.  Of course, that may be easier said than done.  Currently, the big problem is that, previously, I could assume menu pages were the same size.  After all, every item had the same height, so once the page size was calculated, it was basically constant.  But now, with items being wrapped, they may take up two or even three lines in the menu, and I suddenly need a much smarter algorithm for determining how to page forward/back through the menu.  It's all quite tedious... which is why, I suspect, I left it for so long. **sigh**

**Update:**

Well, in a wave of inspiration, I managed to get the scrolling issues fixed before I left for work this morning (yay for extremely simple solutions).  There's still at least one crasher I've come across, but so far things are looking pretty darn good, if I do say so myself.

