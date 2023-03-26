---
layout: article
title: Hosting Git on Windows
author: Brett Kosinski
date: 2012-10-21 02:00:00 -0700
category: [ git ]
no_fediverse: true
---

Using Git to push changes upstream to servers is incredibly handy. In essence, you set up a bare repository on the target server, configure git to use the production application path as the git working directory, and then set up hooks to automatically update the working directory when changes are pushed into the repository.  The result is dead easy code deployment, as you can simply push from your repository to the remote on the server.

But making this work when the Git repository is being hosted on Windows is a bit tricky.  Normally ssh is the default transport for git, but making that work on Windows is an enormous pain.  As such, this little writeup assumes the use of HTTP as the transport protocol.  

### Installation

So, first up we need to install a couple components:

1. msysgit
2. Apache

**Note:** When installing msysgit, make sure to select the option that installs git in your path!  After installation the system path should include the following[^1]:

    C:\Program Files\Git\cmd;C:\Program Files\Git\bin;C:\Program Files\Git\libexec\git-core

Now, in addition, we'll be using git-http-backend to serve up our repository, and it turns out the msysgit installation of this tool is broken such that one of its required DLLs is not in the directory where it's installed.  As such, you need to copy:

    C:\Program Files\Git\bin\libiconv-2.dll

to

    C:\Program Files\Git\libexec\git-core\

### Repository Initialization

Once you have the software installed, create your bare repository by firing up Git Bash and running something like:

    $ mkdir -p /c/git/project.git
    $ cd /c/git/project.git
    $ git init --bare
    $ git config core.worktree c:/path/to/webroot
    $ git config http.receivepack true
    $ touch git-daemon-export-ok

Those last three commands are vital and will ensure that we can push to the repository, and that the repository uses our web root as the working tree.

### Configuring Apache

Next up, add the following lines to your httpd.conf:

    SetEnv GIT_PROJECT_ROOT c:*git*
   
    ScriptAlias *git* "C:/Program Files/Git/libexec/git-core/git-http-backend.exe/"
   
    <Directory "C:/Program Files/Git/libexec/git-core/">
      Options +ExecCGI FollowSymLinks
      Allow From All
    </Directory>

Note, I've omitted any security, here.  You'll probably want to enable some form of HTTP authentication.

In addition, in order to make hooks work, you need to reconfigure the Apache daemon to run as a normal user.  Obviously this user should have permissions to read from/write to the git repository folder and web root.

Oh, and last but not least, don't forget to restart Apache at this point.

### Pushing the Base Repository

So, we now have our repository exposed, let's try to push to it.  Assuming you have an already established repository ready to go and it's our master branch we want to publish, we just need to do a:

    git remote add server http://myserver/git/project.git
    git push server master

In theory, anyway.

**Note:**  After the initial push, in at least one instance I've found that "logs/refs" wasn't present in the server bare repository.  This breaks, among other things, git stash.  To remedy this I simply created that folder manually.

Lastly, you can pop over to your server, fire up Git Bash, and:

    $ cd /c/git/project.git
    $ git checkout master

### Our Hooks

So, about those hooks. I use two, one that triggers before a new update comes to stash any local changes, and then another after a pack is applied to update the working tree and then unstash those local changes.  The first is a pre-receive hook:

    #!/bin/sh
   
    export GIT_DIR=`pwd`
   
    cd `git config --get core.worktree`
    git stash save --include-untracked

The second is a post-update hook:

    #!/bin/sh
   
    export GIT_DIR=`pwd`
   
    cd `git config --get core.worktree`
   
    git checkout -f
    git reset --hard HEAD
    git stash pop

Obviously you can do whatever you want, here.  This is just something I slapped together for a test server I was working with.

[^1]: Obviously any paths, here, would need to be tweaked on a 64-bit server with a 32-bit Git.

