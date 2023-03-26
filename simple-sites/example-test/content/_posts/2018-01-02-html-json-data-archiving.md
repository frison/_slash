---
layout: article
title: HTML JSON Data Archiving
author: Brett Kosinski
date: 2018-01-02 02:00:00 -0700
category: [ personalarchiving ]
no_fediverse: true
---

My Google Groups web scraping exercise left me with an archive of over 2400 messages, of which 336 were written by yours truly.  These messages were laid down in a set of files, each containing JSON payloads of messages and associated metadata.

But... what do I do with it now?

Obviously the goal is to be able to explore the messages easily, but that requires a user interface of some kind.

Well, the obvious user interface for a large blob of JSON-encoded data is, of course, HTML, and so started my next mini-project.

First, I took the individual message group files and concatenated them into a single large JSON structure containing all the messages.  Total file size: 4.88MB.

Next, I created an empty shell HTML file, loaded in jQuery and the JSON data as individual scripts, and then wrote some code to walk through the messages and build up a DOM representation that I could format with CSS.  The result is simple but effective!  Feel free to take a look [at my Usenet Archive here](http://b-ark.ca/usenet-posts/).  But be warned, a lot of this is stuff I posted when I was as young as 14 years old...

Usage is explained in the document, so hopefully it should be pretty self-explanatory.

Anyway, this got me thinking about the possibilities of JSON as an archival format for data, and HTML as the front-end rendering interface.  The fact that I can ship a data payload and an interactive UI in a single package is very interesting!

Update:  I also used this project as an opportunity to experiment with ES6 generators as a method for browser timeslicing.  If you look at the code, it makes use of a combination of setTimeout and a generator to populate the page while keeping the browser responsive.  This, in effect, provides re-entrant, cooperative multitasking by allowing you to pause the computation and hand control back to the browser periodically.  Handy!  Of course, it requires a semi-modern browser, but lucky for me, I don't much care about backward compatibility for this little experiment!

