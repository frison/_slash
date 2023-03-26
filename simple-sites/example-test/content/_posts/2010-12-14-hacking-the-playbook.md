---
layout: article
title: Hacking the PlayBook
author: Brett Kosinski
date: 2010-12-14-2 02:00:00 -0700
category: [ hacking, playbook ]
no_fediverse: true
---

So, hopefully here begins a series of posts on coding for the [Blackberry PlayBook](http://us.blackberry.com/playbook-tablet/).  In this first post, I'll talk a bit about the PlayBook itself, and the [SDK](http://us.blackberry.com/developers/tablet/) currently available.

#### The Platform

Unlike previous Blackberry hardware, which has traditionally run their custom embedded Blackberry OS, the PlayBook is the first BB device to run their new OS based on QNX, a realtime Unix variant that's been around for nearly 30 years, now.  My guess, based on various reading, is that Blackberry feels this new platform will scale better on the new embedded hardware that's hitting the market, particularly the multicore devices everyone is anticipating.

As such, they plan to offer three different SDKs:

1. A Java SDK, which I presume will offer compatibility with their existing Java kit on BBOS.
2. A native QNX SDK, so you can write bare metal applications, such as games.
3. An [Adobe AIR](http://www.adobe.com/products/air/) SDK.

As of this writing, the AIR SDK is the only platform available, a move that, I suspect, reflects a desire, by Blackberry, to migrate developers to that environment (and more importantly, reflects Adobe's goal of becoming **the** application development platform for the mobile space).

#### The SDK

On Linux, the kit comes as a number of parts:

1. [Flex Mobile](http://labs.adobe.com/technologies/flex/mobile/), a cross-platform kit for developing Flex applications running on the AIR runtime.
2. Blackberry's Flex kit, which contains the various Flex libraries needed to build PlayBook applications.
3. A simulator, which comes in the form of an ISO which is meant to be coupled with [VMWare Player](http://www.vmware.com/products/player/).

Of course, if you live in a Windows or MacOS platform, you also get to take advantage of Flex Builder, but alas, it isn't available for Linux.  That said, since the GUI designer tools in Flex Builder don't work with the PlayBook GUI elements, it's utility is far more limited, mainly to providing integrated help, code completion, and so forth, none of which is strictly necessary to developing for the PlayBook.

As for Flex/AIR itself, the language is ECMAScript, which is compiled down to SWF's, which are then packaged up by the Blackberry toolchain, and can then be installed on the simulator.

#### Up Next

In my next post, I'll cover compiling the venerable HelloWorld sample on Linux, and getting it running on the PlayBook; while this is actually quite easy to do with the command-line tools, it took a little bit of hunting around to find the proper incantations to make it happen.

After that, I'll do a little work to dissect the HelloWorld app and write a bit about my first impressions on the kit.

Interesting Stuff!  Stay tuned for more Tales Of Interest!

