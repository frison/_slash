---
layout: article
title: On Algorithms
author: Brett Kosinski
date: 2012-10-29 02:00:00 -0700
category: [ hacking ]
no_fediverse: true
---

So, generally speaking, I've typically adhered to the rule that those who develop software should be **aware** of various classes of algorithms and data structures, but should avoid implementing them if at all possible.  The reasoning here is pretty simple, and I think pretty common: 

1. You're reinventing the wheel.  Stop that, we have enough wheels.
2. You're probably reinventing it badly.

So just go find yourself the appropriate wheel to solve your problem and move on.

Ah, but there's a gotcha, here:  Speaking for myself, I never truly understand an algorithm or data structure, both theoretically (ie, how it works in the abstract, complexity, etc) and practically (ie, how you'd actually implement the thing) until I try to implement it.  After all, these things in the abstract can be tricky to grok, and when actually implemented you discover there's all kinds of details and edge cases that you need to deal with.

Now, I've spent a lot of my free time learning about programming languages (the tools of our trade that we use to express our ideas), and about software architecture and design, the "blueprints", if you will.  But if languages are the tools and the architecture and design are the blueprints, algorithms and data structures are akin to the templates carpenters use for building doors, windows, etc.  That is, they provide a general framework for solving various classes of problems that we as developers encounter day-to-day.

And, like a framer, day-to-day we may very well make use of various prefabbed components to get our jobs done more quickly and efficiently.  But without understanding how and why those components are built the way they are, it can be very easy to misuse or abuse them.  Plus, it can't hurt if, when someone comes along and asks you to show off your mad skillz, you can demonstrate your ability to build one of those components from scratch.

Consequently, I plan to kick off a round of posts wherein I explore various interesting algorithms and data structures that happen to catch my attention.  So far I have a couple on the list that look interesting, either because I don't know them, or because it's been so long that I've forgotten them...

**Data Structures**

1. Skip list
2. Fibonacci heap
3. Red-Black tree
4. Tries
   1. Radix/PATRICIA Tries
   2. Suffix Tries
1. Bloom filter

**Algorithms**

1. Various streaming algorithms (computations over read-once streams of data):
   1. Heavy hitters (finding elements that appear more often than a proscribed freqency)
   2. Counting distinct elements
   3. Computing entropy
1. Topological sort

And I guarantee there's more that belong on this list, but this is just an initial roadmap... assuming I follow through, anyway.

