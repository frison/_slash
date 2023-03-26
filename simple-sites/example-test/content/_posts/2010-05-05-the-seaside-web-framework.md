---
layout: article
title: The Seaside Web Framework
author: Brett Kosinski
date: 2010-05-05 02:00:00 -0700
category: [ smalltalk, seaside, hacking ]
no_fediverse: true
---

While I'm aware that I have, what, maybe two readers of this blog, I thought I might actually start regularly writing a few posts on some of my recent work in the realm of software development.  Why?  Well, I enjoy writing, and I enjoy... let's call it "self-gratification", so posting on my blog seems like a great way to satisfy both of those needs.

So, with all that said, I bring you the kickoff post, covering [Seaside](http://www.seaside.st).

#### A Little Introduction

Anyone who's done any amount of serious web development understands what an absolutely horrible place we, as a development community, find ourselves in.  We're still manually authoring HTML, hacking Javascript, writing AJAX callback hooks by hand, and generally doing all the nasty, gritty, ugly work to make rich web applications possible.  Of course, frameworks and abstraction layers have come along to make this a bit easier (Google's GWT is a great example), but in the end, many of us are still stuck in the dark ages when it comes to web development.

Enter Seaside.

Okay, no, wait, let's back up one step further.

#### A Little Pre-Introduction

You all know what [Smalltalk](http://en.wikipedia.org/wiki/Smalltalk) is, right?  For those not in the know, it's a nice, high-level, consistent, clean object-oriented programming language that is really the grandfather for many of the programming languages we see today.

Of course, if that were it, we'd probably all be using Smalltalk today.  But, alas, the history of Smalltalk is a messy one, sharing many similarities with the Unix battles of old, plagued by myriad, incompatible, expensive implementations that drove away developers to other solutions.

Furthermore, it's a little strange in at least one respect:  rather than code being stored in files, and compiled into binaries, the entire environment, including all your code, is composed into a single "image" from which you must do all you work, including editing, debugging, and so forth.  This has great advantages, for example:

1. The entire environment is available to you and can be inspected and modified as you desire.
2. Deploying an application involves just copying over an image and firing up a VM.

But there's also major disadvantages:

1. You *must* use the tools provided in the environment (ie, editor, debugger, etc).
2. Integration with version control systems isn't necessarily that great.
3. It can be tough to figure out where your code ends and the system begins.

So the picture is certainly mixed.  But the sheer power of Smalltalk, the language, and the encompassing environment makes it, at the very least, incredibly intriguing.

As for implementations, for hobbyists, the most commonly used environment is [Squeak](http://www.squeak.org), or it's more professional cousin [Pharo](http://www.pharo-project.org).  I've settled on the latter, as it seems to be taking a more professional tack, but it's really a matter of preference.

By the way, what I've said isn't actually true of [GNU Smalltalk](http://smalltalk.gnu.org/), but having never used it, I can't really speak to it's viability as a platform.  Of course, feel free to take a look at it and let me know what you think!

#### Where Were We

Oh yeah.  Enter Seaside.

So what's Seaside?  Well, it provides an advanced web development framework for Smalltalk that allows the developer to just, you know, get on with it already.

Yeah yeah, I know, you've heard that before.  So let me illustrate an example for you, and perhaps you'll see why Seaside excites me so much.

#### The Example

The program we want to develop is incredibly simple:

1. It presents a counter to the user.
2. It presents a "decrease" link which lowers the counter.
3. It presents an "increase" link which increases the counter.

That's it.  Now imagine, in a traditional web framework, how you would do this.  Well, obviously, you need some amount of state, here, in order to track the counter.  You could squirrel the value away in a hidden field in a page form (seriously ugly).  Or you could assign the user some kind of session ID, and then track the state on the server, using that session ID as a reference (somewhat complicated).  Either way, you, the developer, have to focus on how, exactly, that state will be managed.

Now let's look at how this program would be expressed in Seaside.  First, a class declaration:

```smalltalk
WAComponent subclass: #Counter
      instanceVariableNames: 'count'
      classVariableNames: ''
      poolDictionaries: ''
      category: 'Counter'
```

This is a simple class declaration describing a subclass of WAComponent named Counter, and containing an instance variable called 'count'.  Okay, so now we need an initializer:

 ```smalltalk
Counter>>initialize
   
  super initialize.

  count := 0.
```

Again, nothing too special here, we just want to initialize our superclass and our counter.  But now comes the meat of the program, and the magic:

```smalltalk
Counter>>renderContentOn: html

  html heading: counter.

  html anchor
    callback: [ counter := counter + 1 ];
    with: 'increase'.

  html space.

  html anchor
    callback: [ counter := counter - 1 ];
    with: 'decrease'.
```

Voila, that's the entire application, including links and state management.

No, really, that's it.  The whole thing.

So, how does it work?  Well, first...

#### A Bit On Blocks

Like other high-level languages such as Perl, C#, and others, Smalltalk supports the concept of a closure, which is called a block, encapsulating a chunk of code along with it's lexical scope.  That code can then later be invoked at your leisure.  For example:

```smalltalk
| var block |

var := 5.

block := [ Transcript show: 'Hello world, my value is '; show: var; cr ].
```

The variable 'block' now contains a reference to a closure which we can then invoke later with:

```smalltalk
block value.
```

This block remembers everything in it's lexical scope, so, for example, the variable 'var' will retain it's value, 5, and be emitted on the transcript.  This fact, that closures are stateful code objects, is key to the way Seaside works.

#### Back To The Example

So, in Seaside, you never hand-write HTML.  There aren't even any templating languages.  You generate all your HTML with code.

Yes, I know, this is weird, but bear with me.

You see, this has a **major** advantage.  Consider the following piece of code from the example:

```smalltalk
html anchor
  callback: [ counter := counter + 1 ];
  with: 'increase'.
```

Of course, this spits out an anchor.  Nothing fancy there.  But notice how we didn't specify a URL?  That's weird enough.  But notice something else?  There's an argument called 'callback', and we're providing it a block of code.  Can you guess what's happening here?

That's right.  Under the covers, Seaside generates a URL for us.  When the link is clicked, Seaside **invokes the callback automatically**.  And because the block remembers the lexical scope, it can fiddle with the counter variable, incrementing it.

So because we let Seaside generate the HTML, suddenly our program is incredibly simple.  Under the covers, Seaside manages all our state for us, associating an instance of the Counter object with our browser session.  When those links are clicked, the callbacks are invoked in the context of that Counter instance and can manipulate the state of the system.  Suddenly we're no longer hacking HTML, parsing CGI parameters, and all that hideous garbage.  We simply write what we want ('when the user clicks this link, increment the counter'), and Seaside does the rest.

#### Conclusion

So there you go.  A really quick intro to Smalltalk and Seaside.  As you can tell, this is incredibly exciting to me.  Why?  Well, developing web applications has always struck me as **incredibly** tedious.  Rather than just being able to write my damn application, I'm stuck parsing query parameters, managing state, manually handling state transitions, and a whole bunch of other garbage that's really only peripheral to the actual act of building an application.  Seaside, on the other hand, gets rid of all that tedium and lets me focus on the important thing:  building a powerful application.

And note, I've only just scratched the surface here.  Among Seaside's other powerful features, it has cleanly integrated:

1. JQuery
2. Prototype
3. Scriptaculous
4. A general AJAX framework for doing partial page updates
5. And probably a whole bunch of other stuff.

Mighty cool if you ask me.

So, all this said, again, the picture isn't completely rosy.  As with all things, there are many issues that Seaside developers must face:

1. Myriad persistence solutions that are of mixed quality.
2. Code management issues.
3. Deployment issues.
4. Scaling and performance challenges.

And probably other stuff, too.  Which will, of course, be fodder for further posts on this topic.

