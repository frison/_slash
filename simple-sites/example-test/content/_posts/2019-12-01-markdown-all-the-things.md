---
layout: article
title:  "Markdown all the things!"
summary: "A post on self-hosted note taking with Markdown and some supporting tools."
author: Brett Kosinski
date:   2019-12-01 11:57:23 -0700
category: [ indieweb, selfhosting ]
syndicate_to: [ twitter ]
no_fediverse: true
---

I'll be the first to admit that I'm a frequent user of tools like Google Keep, Google Docs, etc.  But I've never been terribly comfortable with my dependency on those services.  Yeah, obviously there's the privacy concerns, but more fundamentally, I just want control over my data!  It's a heck of a lot harder to run "grep" over a set of notes in Google Keep...

Thematically, if you've been paying attention to this blog, you'll notice this is [part](2019-10-05-hello-tt-rss.md) [of](2019-10-10-experiments-in-automation.md) [a](2019-06-23-homegrown-backups-redux.md) [theme](2019-11-18-dangers-of-silos.md).  Ultimately, I'm doing what I can to make sure I can manage and control my own information outside the walls of the common internet monopolies.

Now, [quite a while ago](2017-10-28-journalling-with-vim.md) I adopted [vimwiki](https://github.com/vimwiki/vimwiki) as my note taking method of choice.  Before you get scared off, Vim is just a tool to enable a more fundamental idea: that personal information management should be built on the simplest possible tools and file formats, with the data under my own control.

In my case, I chose to focus on taking notes using plain text files, with a basic markup language that would allow me to write richer text and link those notes together.

When I first started doing this a few years ago I chose to stick with Vimwiki's native markup, as it supported a few things out-of-the-box that Markdown, at the time, didn't neatly support without using poorly supported extensions (I'm looking at you, checkboxes!)  However, right around that same time, Github [released a spec](https://github.blog/2017-03-14-a-formal-spec-for-github-markdown/) for their extensions to Markdown that plugged a lot of the holes that had concerned me, and since then support for these extensions has expanded considerably.

This caused me to revisit the issue and I concluded that a migration to Markdown made a lot of sense.

<!-- more -->

It made even more sense when considering that my [move to Jekyll](2019-11-11-moving-to-jekyll.md) meant I was already switching to Markdown for my blog.  Switching over my notes meant that I could use a single markup and the same set of tools for all my private note taking and my blog writing.  Slick!

I got even more excited when I discovered [Markor](https://github.com/gsantner/markor)!  Markor is a Markdown editor for Android with fairly complete support for the CommonMark spec.  Combined with [Syncthing](https://syncthing.net/), I could have my notes *and* my blog available on all my devices, which means I can take notes or even write blog articles on my phone, on my laptop, or anything else that has a text editor.

Ultimately, I'd say it took me a good three to four hours to do all the bulk processing necessary to convert my old Vimwiki notes to Markdown (a conversion that, it's worth pointing out, would've been difficult or impossible if I had been tied down to closed file formats), and the result has absolutely been worth the effort!

So, to recap, using the following stack of tools:

* Jekyll
* Vim + vimwiki
* Markor
* Syncthing

I now have what amounts to my own, private, cross-device, holistic writing solution that allows me to maintain control of my data using open formats.

I'd call that a win!

Now, if you're not terribly comfortable writing in Markdown yourself, there are solutions!  Applications like [Joplin](https://joplinapp.org/) attempt to replace tools like Evernote.  There also plenty of simple WYSIWYG Markdown editors out there, as well, if that's all you need.  And that is, of course, the point: by using something like Markdown you give yourself the freedom to pick the tools you want, without having to sacrifice openness and interoperability.
