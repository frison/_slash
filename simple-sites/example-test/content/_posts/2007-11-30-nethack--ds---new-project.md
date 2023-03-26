---
layout: article
title: NetHack + DS -> New Project!
author: Brett Kosinski
date: 2007-11-30 02:00:00 -0700
category: [ nethack, hacking, nintendods ]
no_fediverse: true
---

When I first got my DS backup device, it didn't take me long to track down, and quickly eliminate as impractical, the first, and to my knowledge, only attempt to make a [DS NetHack Port](http://stuartp.commixus.com/nhds/).  It's a "port", in the sense that it really just takes [NetHack](../NetHack.md), shrinks it down, displays the virtually unreadable game on the upper screen, and a graphical keyboard on the bottom screen.  Does it work?  Sure.  But only just barely.

So quite a while back, I decided I wanted to create a port of my own.  Much initial hackery was begun, followed by the usual subsequent boredom, followed by the devastating loss of my DS and backup device in an unfortunate incident involving my crappy memory and an airplane seat pocket.  The result was a project that languished in my subversion repository until, a few weeks back, my new R4 arrived in the mail which, when pared with the new DS my brother kindly bought me for my birthday, resulted in renewed homebrewing efforts!.

Since then, I've made enormous progress.  The game is essentially playable right now, and sports:

1. A top screen displaying a minimap, status and message display, and input prompt.
2. A bottom screen showing the game map in unscaled, scrolling, tile-y glory.
3. Support for movement using the joypad, as well as the stylus.
4. A popup command list, toggled with the L-button, from which the user may select commands with the stylus.
5. Full support for menus, again using the stylus for item selection.
6. String input using a virtual keyboard.
7. Save/Restore support.

Of course, if it were all roses, I'd release the thing right now.  But there are bugs, and a few things on the TODO list, as well:

1. Currently wide text is clipped... I'm not sure how to solve this, though.
2. The menus should be pageable with the joypad.
3. Quitting and saving should return the user to the flash cart menu, or possibly power off the DS.
4. It desperately needs a left-handed mode.
5. Keys need to be configurable.

And, of course, I need to test test test!  I'm primarily worried about memory usage... I think I have most of the issues worked out, and I spent a fair bit of time teleporting around the game in wizard mode, causing general mayhem, and didn't run across any issues.  But I'd like more time with it to make sure the obvious bugs are ironed out.

And even with those problems fixed, I will fully admit that:

1. It's kinda fugly.  But it's fugly the way text-mode nethack is fugly, so it's kinda charming that way, and
2. The text rendering code, particularly for menus, is *slow*.

But, in short order, I'll hopefully have a release out.  Meanwhile, stay tuned for screenshots... assuming I can get desmume up and running and working with my port. :)

Oh, and BTW, if anyone has thoughts for a name (NethackDS is taken, so I was thinking something like "Nethack Touched!", or possibly something even more lame, would work), please let me know!  Plus, then I'd know if anyone's bothering to read this thing, anymore. ;)

