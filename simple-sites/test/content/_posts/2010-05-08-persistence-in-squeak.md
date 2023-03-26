---
layout: article
title: Persistence in Squeak
author: Brett Kosinski
date: 2010-05-08 02:00:00 -0700
category: [ smalltalk, seaside, hacking ]
no_fediverse: true
---

Ah, deliciously punny post title.  You'll see, assuming you make it to the end of this thing... don't worry, I won't blame you if you don't.

Over the last week or so, I've been working on a little toy project, partly to fill a need I have, and partly to fiddle around with developing a web application in Seaside and Smalltalk, and specifically the Squeak implementation of Smalltalk.

Now, there are many parts needed to build a functional web-based application.  Obviously you need a web server to actually serve the application.  You need some sort of language to implement the application in.  You need a framework in which to actually build that application (okay, sure, back in the days of the wild west, people built their own, but you'd be a fool to do that today given the plethora of frameworks available which simplify the web development process).  And last but not least, in all probability, you need a data persistence solution.

Of course, the first thing that comes to mind when turning ones thoughts to persistence is a good old fashioned relational database, which has been the cornerstone of data persistence for many a decade now.  But when one is working in a deeply object-oriented language like Smalltalk, working with a relational database becomes rather cumbersome due to the rather substantial impedance mismatch between relational and object-oriented data modeling.  As a result, we as an industry have turned to tools such as automated object-relational mappers (eg, Hibernate, etc) to try and ease the pain of this mismatch, but in general, the results aren't what I would call pretty.

Which is why, during my first hack at leveraging a persistence solution for my little Seaside application, I decided to try something entirely different: an object-oriented database called [Magma](http://wiki.squeak.org/squeak/2665).  Unfortunately, it didn't go too well.

#### On Magma

Magma is a very interesting project.  As a persistence solution, it really aims for the same space occupied by [Gemstone/S](http://www.gemstone.com/products/gemstone): to act as a completely transparent persistence solution for object-oriented data models.  By that I mean the idea is that you hand Magma an object graph, and it persists it to it's own custom data format on disk.  When you pull it back out, Magma reifies parts of the object graph you're interested in, and when you modify the graph, Magma spots the changes and reflects them back into the persistent store.

Of course, on the face of it, this seems like absolute magic.  You simply work with your objects.  When you want to persist a change, you just do something like:

```smalltalk
session commit: [ model doStuff ].
```

And voila, everything just, well, works.  Of course, persistence is about more than just simple object storage, in that you also need to be able to query the data model, and be able to do so in an efficient manner.  To that end, Magma provides a few specialized collection objects, such as the MagmaCollection class, which provide interfaces for applying indexes, querying, sorting, and so forth.

So, on it's face, Magma looks like a fantastic solution!  The transparent persistence model makes it dead easy to manipulate your data model, and you no longer have to jump through all the object-relational modeling hoops that one would normally have to deal with.

But, alas, it's just not that easy.

Unfortunately, Magma has one serious fault that rules it out for all but the most basic data-driven applications:  It's **slow**.  Additionally, because Magma absolutely requires per-attribute indexes for any collection you want to query, the number of indexes in a data model can grow substantially, particularly in data mining/exploration tools.  Worse, Magma steps on a rather nasty performance problem in Squeak whereby large numbers of files in a single directory (as in, thousands) causes the FileDirectory class to bog down... and guess what happens when you create a large number of indexes?  That's right, a lot of files get created in a single directory, and so you get utterly dismal performance when any index is initially opened.

And as if that weren't enough, in order to really squeeze decent performance out of Magma, you must start tweaking what are called "read strategies".  See, when you start reifying an object graph, you have to make a decision on how deep to go before you stop.  After all, if you have a deep tree of objects, unless you plan to traverse that whole tree at some point, it's a waste of time to load the whole thing all at once.  So the "read strategy" dictates at what depth various parts of the object graph are read.  But ultimately, what this equates to is deep micromanagement of the database behaviour, and, quite frankly, I have absolutely no interest in that.

Thus, after many days of fighting, I've decided to throw out Magma.  Which is rather painful, as I already have an object model built up assuming it's use.  Fortunately, the very nature of Magma means you don't really tailor the object model too tightly to the database, but things do leak through here and there, and the model itself must, to some extent, be designed to facilitate querying, traversals, and so forth.  Thus, any movement away from an RDBMS will necessitate rethinking my data model.

#### A Way Forward?

So what now?  Well, I've decided to take the hit and switch to a solution based on [Glorp](http://www.glorp.org), an object-relational mapping system for Smalltalk, and [PostgreSQL](http://www.postgresql.org), that venerable RDBMS.  Of course, this will likely come with it's own issues, first and foremost one of installation...

Unfortunately, while Squeak package management has taken a step forward with [Monticello](http://wiki.squeak.org/squeak/1287), the management of dependencies between packages, and inconsistencies between platforms (eg, Pharo vs Squeak) means that things are a lot harder for the user than they need to be.  In this particular case, the original Glorp port is rather old.  So the folks developing [SqueakDBX](http://www.squeakdbx.org/) have worked to port over the latest version to Squeak, with some success.  Unfortunately, their installation script doesn't appear to work in Pharo.  So I had to resort to pulling in their loader classes and then manually executing the installation steps by hand.  Tedious, to say the least.

But, on the bright side, I have a Pharo image that seems to have a functional Postgres client and Glorp install, so I can start fiddling with those tools to see if they can meet my needs.

Which brings me back to the double entendre.  Because returning to the Squeak world has reminded me of one thing:  Occasionally the tools get in your way as much as they clear it out for you, and so sometimes you really do need to be incredibly... yes, I'm gonna say it, get ready... here it comes... **persistent**.

