---
layout: article
title: NethackDS Screenshots
author: Brett Kosinski
date: 2007-12-01 02:00:00 -0700
category: [ nethack, hacking, nintendods ]
no_fediverse: true
---

Well, I promised some shots of my Nethack port in action, and I aim to please!  Now, I couldn't figure out how to get my code working with Desmume, so I just gave up and used a camera.  You'll have to forgive the consequent bluriness...

{% lightbox /assets/images/Image-a1b11d7c21af092c --thumb="/assets/thumbs/Image-a1b11d7c21af092c" --data="Image-a1b11d7c21af092c" --img-style="max-width:100;" %}

Here we see a newly minted game.  On the bottom screen you can see the visible play area.  On the top screen you can see the minimap, with a red box representing the displayed region on the lower screen, as well as the player's status and the welcome message.

{% lightbox /assets/images/Image-71d1497cb11a2897 --thumb="/assets/thumbs/Image-71d1497cb11a2897" --data="Image-71d1497cb11a2897" --img-style="max-width:100;" %}

This shows the popup command menu.  The user holds the L button (eventually this will be swappable, for you lefties) to make the menu popup, at which point the user can tap a command to have it execute.  Much nicer than an on-screen keyboard, I think...

{% lightbox /assets/images/Image-91646e33517f69cf --thumb="/assets/thumbs/Image-91646e33517f69cf" --data="Image-91646e33517f69cf" --img-style="max-width:100;" %}

And this last shot shows the inventory list after selecting the Inventory command.  As you can see, there's a bit of clipping, but it otherwise works as advertised.  If this were a Drop command or something similar, the user would be able to tap items to select them (multiple taps begin counting from 1).

So there you go!  See, it's not vapour after all!  Well, not **technically**, anyway...

**Update:**

And now key remapping is implemented!  This includes handedness swapping (swaps the shoulder buttons), and mapping commands to the joypad and the primary buttons.  And the changes are persisted across sessions.  Neat, eh?

