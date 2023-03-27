---
layout: article
title: Dangers of Abstraction
author: Brett Kosinski
date: 2010-05-26 02:00:00 -0700
category: [ hacking, musings, smalltalk ]
no_fediverse: true
---

One of the more impressive things about Pharo/Squeak is the level of depth in the core libraries, and how those libraries build upon each other to create larger, complex structures.  One need only look at the Collection hierarchy for an example of this, where myriad collection types are supported in a deep hierarchy that allows for powerful language constructs like:

```smalltalk
aCollection select: aPredicateBlock thenCollect: aMappingBlock
```

to work across essentially every type of collection available.  Unfortunately, building these large software constructs can have negative consequences when one attempts to analyze performance or complexity, and in this post I'll outline one particular case that bit me a few weeks back.

My problems all started while I was still [experimenting](Blog-2010-05-08.md) with [Magma](http://wiki.squeak.org/squeak/2665).  Magma, as you may or may not recall (depending on if you've read anything else I've posted... which you probably haven't) is a pure-Smalltalk <a class="inter Wikipedia outside" href="http://en.wikipedia.org/wiki/OODBMS">object-oriented database</a> whose end goal is to provide the Smalltalk world with a free, powerful, transparent object store.  

Now, among Magma's features is a powerful set of [collections](http://wiki.squeak.org/squeak/2639), which implement the aforementioned collection protocols, while also providing a much-needed feature: querying.  In order to make use of this facility, any column that you wish to generate queries over must have an <a class="inter Wikipedia outside" href="http://en.wikipedia.org/wiki/Index_(database)">index</a> defined over it, which is really a glorified hash table on the column[^1].  Whenever you create one of these indexes on a collection, the index itself is squirreled away in a file on disk alongside the database.  And that's where the problems come in.

In my application, a Go game repository, I had a fairly large number of collections sitting around holding references to Game objects (one per individual user, plus one per Go player), and I needed to be able to query each of these collections across a number of features (not the least of which, the tags applied to each game).  That meant potentially many **thousands** of indexes in the system, at least[^2].  And that meant thousands of files on disk for each of those indexes.

Well, when I first hit the site, I found something rather peculiar:  initially accessing an individual collection took a **very** long time.  On the order of a few seconds, at least.  Naturally this dismayed me, and so I started [profiling](http://onsmalltalk.com/profiling-smalltalk) the code, in order to pin down the performance issues.  And I was, frankly, a little shocked at the outcome.

It turns out that, deep in the bowels of the Magma index code, Magma makes use of the FileDirectory class to find the index file name for the index itself.  Makes sense so far, right?  As part of that, it uses some features of the FileDirectory class to identify files with a specific naming convention.  And **that** code reads the entire directory, in order to identify the desired files.

On the face of it, this should be fine.

However, internally, that code does a bunch of work to translate those file names from Unicode to internal Squeak character/strings.  And it turns out that little bit of code isn't exactly snappy.  Multiply that by thousands of files, and voila, you get horrible performance.

So believe it or not, the index performance issues had **nothing to do with Magma**.  It was all due to inefficiencies deep in the bowels of Squeak.  And hence the subject of this article.  Deep abstraction and code reuse is a **very** good thing, don't get me wrong.  But any time you build up what I think of as a "cathedral" of code, it's possible for rotting foundations to bite you later.

[^1]: That, by itself, is a rather onerous requirement, but that's really a separate issue

[^2]: Granted, in retrospect, there may have been a better way to design the DB, but for a very small scale application, this approach sufficed

