---
layout: article
title: Bitter Defeat
author: Brett Kosinski
date: 2007-12-06 02:00:00 -0700
category: [ nethack, hacking, nintendods, frustration ]
no_fediverse: true
---

The current version of NHDS does a kind of funny thing when you die: instead of returning you to the fancy schmancy splash screen, it powers the DS off.  As it happens, it does the same thing when the user saves their game (which is a good thing, IMHO), and this is no coincidence.  It just so happens they share the same shutdown codepath.

Well, a couple people mentioned this, and I thought, yeah, I should try to fix that.  It is, after all, rather irritating to have to power the DS back on after YASD.  But, alas, I stand defeated.  The problem is this:  the NetHack core contains a lot of internal state.  And the initialization of this state happens in a variety of places, and it's not very neatly factored out.  As an example, the core function, moveloop(), which is what gets the game going, performs a bunch of state initialization for the player.

Now, on, say, the Unix port, when the game ends, the program terminates.  There's no concept of the game restarting.  And so all of this state isn't a problem.  But the case of NHDS is different.  If I attempt to start the game again (and trust me, I've tried), the core gets mightily confused, puzzled why various bits of state are initialized, and further puzzled when it's attempts to initialize others bits of state fail.  It's all quite the mess, really.

The consequence?  I can see no way of fixing this problem.  It's an inherent issue with the way the game is structured.  Oh well... on the bright side, at least I can just blame the DevTeam.

