---
layout: article
title: Git Lesson 2 - Pushing a local repo into SVN
author: Brett Kosinski
date: 2010-04-12 02:00:00 -0700
category: [ hacking, git ]
no_fediverse: true
---

For some time now I've been using [git](http://www.git-scm.org) as my front end to the [Subversion](http://subversion.tigris.org/) server at work, and I've never looked back.  And as a result, one of the things I occasionally find myself doing is creating a local git repository in order to manage little side projects I happen to be working on.  But, of course, eventually those projects need to be pushed into SVN, and in the process, it's nice if one can preserve the local commit logs (it'd be trivial to just push the blob of code into SVN and then create a new, local git-svn repo, but that's not nearly as nice).

Fortunately, git makes this remarkably easy.  First, in your git repo, rename trunk so you can get it out of the way:

    git branch -m master local

Next, you need to configure your git-svn bridge.  My last [blog entry](2008-10-23-using-git-as-a-bridge-to-svn.md) on git covers this topic, and it'll probably look something like this:

    git config --add svn-remote.trunk.url svn+ssh://svn/repo/
    git config --add svn-remote.trunk.fetch trunk/project:refs/remotes/trunk

Then, fetch the new git-svn bridged repo:

    git svn fetch trunk

When you do this, because you don't have a master, git will kindly create one for you corresponding to the new git-svn bridged branch.  Lucky!  So now we just need to get the local branch changes into master.

Ah, but there's some trickery, here.  If you were to just do a naive merge from local to master, the root commit on master would end up getting tacked onto the **end** of the local branch, which is exactly not what we want to happen.  The solution is to rebase local to master first:

    git checkout local
    git rebase master

Then you can merge and dcommit:

    git checkout master
    git merge local
    git svn dcommit

Git will then proceed to push each of your local commits into SVN, and voila, you're done!  Then you can just delete the local branch, as you obviously don't need it anymore.

