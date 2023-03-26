---
layout: article
title: A Vim Tip - localvimrc
author: Brett Kosinski
date: 2011-12-14 02:00:00 -0700
no_fediverse: true
---

Inspired by [vim: revisited](http://mislav.uniqpath.com/2011/12/vim-revisited/), I thought I'd finally get around to writing up another blog post, this time focused on one of my favorite Vim plugins: [localvimrc](http://www.vim.org/scripts/script.php?script_id=441).

As even the most basic Vim user knows, Vim, upon startup, sources a file in the user's home directory called .vimrc (sometimes _vimrc or other variants, depending on the platform).  Traditionally, this file is used to store user customizations to Vim.  We're talking things like settings, user-defined functions, and a whole raft of other stuff.  But it has a rather annoying limitation:  it's global.  Of course, it's possible to condition a lot of settings based on filetype and so forth, but ultimately this isn't useful if you want to be able to specify settings at a project-level (for example, build settings, search paths, fold settings, etc).  And this is where the localvimrc plugin comes in.

With localvimrc loaded, Vim, upon opening a new file or switching buffers, will search **up** through the directory hierarchy, starting from the location of the file, to find a file named .lvimrc.  If such a file is found, the file is sourced just like any other vimrc file.  So now, you can place those project-specific configuration items in a .lvimrc in the top-level folder of your project, and voila!, you're good to go.

Of course, this alone is pretty damned useful, but there's another somewhat less obvious but handy feature of localvimrc files: they make it possible to find the root directory of your project.  And that is exceptionally useful for a few purposes:

1. You can set up [CommandT](http://www.vim.org/scripts/script.php?script_id=3025) to always search from the top of your project, regardless of where you invoked Vim.  I love this because I tend to navigate around in the shell and then edit files willy-nilly.
2. You can configure project-level build commands which understand how to jump to the top of your project to run them.
3. You can set up the Vim search path so that gf always works.
4. You can load up project-wide [cscope](http://cscope.sourceforge.net/) and [ctags](http://ctags.sourceforge.net/) files.
5. Probably lots of other stuff.

So, how does this work?  Well, below is a sample of one of my lvimrc files:

    if (!exists("g:loaded_lvimrc"))
      let g:loaded_lvimrc = 1
      let s:rcpath = expand("<sfile>:p:h")
   
      exec "map <leader>t :CommandTFlush<cr>\\|:CommandT " . s:rcpath . "<cr>"
      exec "set path=" . s:rcpath . "/**"
    endif

The first thing you'll notice is the guard.  The lvimrc file is loaded
whenever a buffer switch occurs, so this allows you to control which
things are evaluated every time the file is sourced and which are only
executed once.

Anyway, the real magic is in the subsequent lines.  First, we use the expand() command to get the canonical path to the file being sourced (remember, this is our .lvimrc file, so this will be the top-level directory of our project).  Then, we use that information to remap the CommandT command to run from the top-level project directory.  Nice!

And, as I mentioned, you can do a lot of other things here.  You can see the second line sets up our search path so we can gf to files in the project, as an example.  Personally, I actually created a function in my .vimrc file called LocalVimRCLoadedHook(rcpath) that contains a lot of standardized logic for handling projects.  You can find samples of all that on my [Vim-Config GitHub Project](https://github.com/fancypantalons/Vim-Config).
 

