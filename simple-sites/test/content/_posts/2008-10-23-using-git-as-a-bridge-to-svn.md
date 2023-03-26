---
layout: article
title: Using Git as a Bridge to SVN
author: Brett Kosinski
date: 2008-10-23 02:00:00 -0700
category: [ hacking, git ]
no_fediverse: true
---

So, Lenore complained that I haven't been blogging much lately, so I thought I'd throw together a little something that would bore her to tears. :)  Now, as quick prelim, if you don't know what Git or Subversion is, I'd just skip this one.

Now, this whole thing is really more of a note-to-self, as I'm still getting used to git.  But I figured it might be useful to other developers.  Now I should say this isn't going to be a generic discussion about how to bridge Git to SVN.  That's be done to death all over the web.  What I'm particularly interested in is how to use git-svn when your Subversion repository has an... unusual topology.  See, the typical Subversion repository is laid out something like this:

    projectA
      trunk
      branches
        projectA-1.0
      tags
    projectB
      trunk
      branches
        projectB-1.0
      tags

In a case like this, importing the tree into git-svn is trivial.  However, at work, we have a Subversion repository that looks something like this:

    trunk
       projectA
       projectB
    branches
       projectA-1.0
       projectB-1.0

This layout requires some hacking to get git-svn working.  First off, you need to initialize a standard git repository:

    mkdir git
    cd git
    git init

Note, you'll probably also want to use "git config" to set a few parameters while you're at it (if you're on Windows, setting "filemode" and "autocrlf" to false is a very good idea).  Once the basic repo is set up, you can now add the SVN repositories you plan to fetch.  For example, to pull projectA and projectA-1.0, we'd run these commands

    git config --add svn-remote.projectA.url svn+ssh://path/to/svn/
    git config --add svn-remote.projectA.fetch trunk/projectA:refs/remotes/projectA
    git config --add svn-remote.projectA-1.0.url svn+ssh://path/to/svn/
    git config --add svn-remote.projectA-1.0.fetch branches/projectA-1.0:refs/remotes/projectA-1.0

Basically, we instruct git-svn what the mappings are between various tree names and their SVN equivalents.  This includes a URL to the repository, along with a definition of where to fetch the code from.  Once this is done, you need to populate your repository.  Note, I **think** the first fetch becomes the master branch (I'm not actually sure about this, but it seems that way), so it's best to yank trunk first (you can move the master moniker around, but why bother with such machinations if you can do it right the first time?):

    git svn fetch projectA
    git svn fetch projectA-1.0

Note, somehow, and I have no idea how, git even manages to figure out the 1.0 branch parent, so the essential structure is preserved, even though we perform separate fetches to populate the trees.

So now we have the trees downloaded, and as a bonus, the master tree is set up and tracking trunk.  Next, we need to create local branches tracking any remote branches we're interested in:

    git checkout projectA-1.0    # Switch into the remote branch
    git checkout --track -b 1.0  # Create a local branch named 1.0 tracking the projectA-1.0 remote branch

There, the tree is populated.  Finally, if you have svn:ignore properties set up, here's how you mirror them locally (note, you'll have to do this for each branch).  Now, in git, the ignore rules are stored in .gitignore files.  This is fine, except that, by default, git wants to include those files in the git repository, and thus they'd get pushed upstream in a dcommit.  Thus, we have to go through a bit of gymnastics to make sure that doesn't happen, and that the .gitignore files remain local.

First, open up .git/info/exclude and add these lines:

    .gitignore
    .gitmodules

This instructs git to ignore the .gitignore files (and .gitmodule files) on "git status" calls and so forth. Next, create the ignore files.

    git checkout master
    git svn create-ignore

Of course, when this happens, git-svn goes and does a "git add" for all the .gitignore files.  This is exactly what we **don't** want. :)  So, last but not least, we undo the adds:

    git reset HEAD

And your tree should now be ready for hacking.  Now for a few basic recipes.  First, to switch between branches:

    git checkout 1.0             # Switch to our projectA-1.0 tracking branch
    git checkout master          # Switch back to master

Second, here's how we update the current local branch to sync up with it's corresponding remote SVN branch:

    git svn rebase

Third, to commit a change to the local git branch:

    git commit -a

Next, to push the changes in the local git branch out to the Subversion repository:

    git svn dcommit

Note, a dcommit pushes each individual local commit to the Subversion tree as individual SVN commits.  However, there may be times when you want to roll together a series of local changes into a single SVN checkin (perhaps your code went through a lot of churn before the final version was reached).  Luckily, git makes it possible to do just that.  Imagine you've made some changes to trunk you want to check in as a single commit (I assume you've got the master branch checked out):

    git reset --soft refs/remotes/projectA  # Reset to the remote HEAD
    git commit -c ORIG_HEAD                 # Commit our original HEAD node into this tree.

Voila, the changes will now be combined into a single commit, and the old commits will be gone (well, technically they exist they're just orphaned).  Note, this **does** change "the past", and of course fiddling around with history is generally not a good idea.  But given we're talking about a local repository, here, I don't see a big problem with it.

Of course, a better alternative is to make all your changes in a local branch.  Then, when you're ready, you can merge the changes into the originating branch, and then commit them there.  That way, you can opt to delete the working branch if you don't care about the history, or keep it around if you think you might need it.

So there ya go.  Basic git-svn bridging on a non-standard tree layout.  And if you've read this sentence, congrats!  Your ability to stay awake against all odds is, without a doubt, stunning.

