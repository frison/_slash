---
layout: article
title: Journalling with Vim
author: Brett Kosinski
date: 2017-10-28 02:00:00 -0700
no_fediverse: true
---

I've toyed on and off with journalling for some time now.  Not blogging, which is a much more public activity focused on sharing, but true journalling: the writing of thoughts for personal reasons and not for public consumption.

But it's never really taken.

I've tried to be consistent about writing travel logs for major trips, as I do find that activity extremely powerful for both cementing memories at the time and allowing me to refresh my memories after the event.  But beyond that, it's not something I've been able to turn into a habit.

Now, my past attempts always focused on putting pen to paper, but recently I realized that, as fascinated as I am with notebooks and so forth... well, I bloody well hate physical writing!  Because I'm horribly out-of-practice, it's slow, tiring, and messy, while affording me no real benefits.  It simply gets in the way, and in doing so, makes the act of journalling more unpleasant.

And, the reality is I'm a technologist.  My tools are the screen and the keyboard.  Why fight that?

So I decided to turn to those tools to build an alternative stack built on Vim, plus a few plugins, based on [this blog post](http://blog.mague.com/?p=602).

For basic journalling functionality, vimwiki and calendar-vim are a perfect combination:

* [vimwiki](https://github.com/vimwiki/vimwiki)
* [calendar-vim](https://github.com/mattn/calendar-vim)
* [vim-pencil](https://github.com/reedes/vim-pencil)

Automatic timestamped files with basic markup and linking.  Simple.  Easy.  Portable.

After that, it's all about ergonomics.  My preferred writing environment is spartan and attractive, with a large, easy-to-read font.  That brings us to a few additions:

* [Goyo](https://github.com/junegunn/goyo.vim)
* [Limelight](https://github.com/junegunn/limelight.vim)
* [Office Code Pro Font](https://github.com/nathco/Office-Code-Pro) (light version)
* [Customized Lucius color scheme](https://github.com/fancypantalons/Vim-Config/blob/master/lucius.vim)

Finally, we have a bit of vimrc configuration that I've found handy:

```vimscript
" Automatically switch to writing mode when a wiki page is opened.
au FileType vimwiki set guifont=Office_Code_Pro_Light:h14|call pencil#init({'wrap': 'soft'})|set sbr=


" Turn on Limelight when Goyo is enabled
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Hotkey mapping to open the calendar pane
map <leader>C :Calendar<cr>
map <leader>G :Goyo<cr>
```

And voila!

Now, I'm still getting used to this setup, so I could see it requiring additional tweaks.  And it is Vim, so it's not the ideal word processing environment (though I finally figured out the right formatoption tweaks to get paragraph reflow to mostly work the way you'd expect).  But it's simple and it works!

The only remaining question is whether I'll actually start building up the habit...


