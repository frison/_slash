---
layout: article
title: Amusing Nerd Statistic For The Day
author: Brett Kosinski
date: 2008-11-07 02:00:00 -0700
category: [ hacking ]
no_fediverse: true
---

At work, I'm more or less the sole custodian of a major software component, and I've switched my day-to-day operations over to using git as a frontend to the corporate Subversion repository.  Now, part of this work involves managing three different product branches (a trunk version, a legacy version, and a current stable), plus now that I'm using git, I've started creating lots of topic branches for features I want to include, but am not ready to commit yet.

Well, I got curious about disk space usage, as git is supposed to be really efficient.  Here's what I found:

1. Trunk and current stable checked out from SVN.  Total disk space, 118M.
2. Git tree containing complete code and history for trunk, legacy, current stable, and five topic branches: 42M.

Now that's what I call efficient!

