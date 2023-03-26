---
layout: article
title: Using msysgit in Cygwin
author: Brett Kosinski
date: 2011-10-13 02:00:00 -0700
no_fediverse: true
---

Cygwin sucks.  Badly.  Particularly on Windows 7, where it's plagued by the infamous rebaseall bug.  As if that weren't enough cygwin's git port is terribly slow, and so rather frustrating to use.

Luckily, [msysgit](http://code.google.com/p/msysgit/) offers a fast, well-supported, drop-in replacement version of git for Windows, complete with a nice, clean installer, that fits much better into the Windows ecosystem.

But, alas, it's not without it's issues, and so here I'm trying to collect what little tidbits I'm learning as I make the transition.

### Using Pageant as your ssh-agent

Set the environment variable GIT_SSH to:

    "<path to putty>\plink.exe"

And **include the quotes**!  This is related to an issue in git-svn that I'll mention later.

### Merge Tools

You need to grab the entire folder [](https://github.com/msysgit/git/tree/master/mergetools) and drop it into <git folder>\libexec\git-core if you want any of the mergetools to work.  These weren't in my 1.7.7 installed folder, which I suspect is a bug.  Later or earlier versions may address this.

To use kdiff3 as a mergetool, run:

    git config --global mergetool.kdiff3.path <path to kdiff3.exe>
    git config --global merge.tool kdiff3

### Git-SVN Gotchas

There's a bug in git-svn with mergeinfo that can bite you in any version past 1.6.5.7.  To get around it, download the 1.6.5.7 tag from [here](https://github.com/msysgit/git/tags).

Grab git-svn.perl, and replace your copy of git-svn in:

    <program files>\Git\libexec\git-core

But note!  This version of git-svn has a bug in it where GIT_SSH has to have quotes around it, lest things go all pear-shaped.

### Lingering Issues

If you're using a cygwin shell (like rxvt), git won't honour the pager settings, as it can never figure out that it's running in an interactive terminal.  Naturally you can just pipe to your favourite pager by hand, but it's tricky to get back into that habit.

