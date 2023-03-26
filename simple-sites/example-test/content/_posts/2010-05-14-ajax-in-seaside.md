---
layout: article
title: AJAX in Seaside
author: Brett Kosinski
date: 2010-05-14 02:00:00 -0700
category: [ smalltalk, seaside, hacking ]
no_fediverse: true
---

So, in yet another post on a series about [Pharo](http://www.pharo-project.org) and [Seaside](http://www.seaside.st), I thought I'd highlight a great strength in Seaside: it's incredibly powerful support for building rich, [AJAX](http://en.wikipedia.org/wiki/AJAX)-enabled web applications.

As any web developer today knows, if you're building rich web apps with complex user interactions, you'd be remiss not to look at AJAX for facilitating some of those interactions.  AJAX makes it possible for a rendered web page, in a browser, to interact with the server and perform partial updates of the web page, in situ.  This means that full page loads aren't necessary to, say, update a list of information on the screen, and results in a cleaner, more seamless user experience ([Gmail](http://www.gmail.com) was really an early champion of this technique).

Now, traditionally, an AJAX workflow involves attaching Javascript functions to page element event handlers, and then writing those functions so that they call back to the web server using an XmlHttpRequest object, after which the results are inserted into an element on the screen.  Of course, doing this in a cross-browser way is pretty complex, given various inconsistencies in the DOM and so forth, and so the web development world birthed libraries like [jQuery](http://www.jquery.org) and [Prototype](http://www.prototypejs.org/), and higher-level libraries like [Script.aculo.us](http://script.aculo.us/).  But in the end, you still have to write Javascript, create server endpoints by hand, and so forth.  Again, we're back to gritty web development.  And that makes me a sad panda.

Of course, this post wouldn't exist if Seaside didn't somehow make this situation a whole lot simpler, and boy does it ever.  To illustrate this, I'm going to demonstrate an AJAX-enabled version of the counter program mentioned in my [first post](Blog-2010-05-05.md) on Seaside.  So, instead of doing a full page refresh to display the updated counter value, we're simply going to update the heading each time the value changes.  Now, again, imagine what it would take to do this is a more traditional web framework.  Then compare it to this:

```smalltalk
renderContentOn: html

 | id counter |

 counter := 0.
 id := html nextId.

 html heading id: id; with: counter.

 html anchor
   onClick: (
     html scriptaculous updater
       id: id;
       callback: [ :ajaxHtml | 
         counter := counter + 1. 
         ajaxHtml text: counter.
       ]
   );
   url: '#';
   with: 'Increase'.
   
 html space.
 
 html anchor
   onClick: (
     html scriptaculous updater
       id: id;
       callback: [ :ajaxHtml | 
         counter := counter - 1. 
         ajaxHtml text: counter.
       ]
   );
   url: '#';
   with: 'Decrease'.
```

That's it.  The full script.

Now, a little explanation.  The script begins with a little preamble, initializing our counter, and allocating an ID, which we then associate with the header when we first render it.  Pretty standard fare so far.  The really interesting bit comes in the anchor definition, and in particular the definition of the onClick handler.  Of course, this bit bares a little explanation.

The various tag objects in Seaside respond to selectors that correspond to the standard DOM events.  When sending such a message, the parameter is an instance of a JSFunction object, which encapsulates the actual javascript that will be rendered into the document.  Now, in this particular example, we're actually using part of the Scriptaculous library wrapper to create an "updater" object, a type of JSFunction, which takes the ID of a page element, and a callback, and when invoked, causes the callback to be triggered.  Upon invocation, this callback is passed an HTML canvas, and when the callback terminates, the contents of that canvas are used to replace the contents of the indicated page element.  Neat!

So in this particular case, we have two anchor tags, each of which has an onClick event registered which, when invoked, updates the counter value and then updates the heading on the page.

By the way, there's also a little bit of extra magic going on here.  You'll notice the 'counter' variable is local, while in the original example it was an instance variable.  But this works, here, because those callbacks are actually lexical closures, and so the 'counter' variable sticks around, referenced by those closures, even though the function itself has returned, and the variable technically has gone out of scope.

To me, the really amazing thing, here, is that never once do I, as a developer, have to even touch HTML or Javascript.  The entire thing is written in clean, readable Smalltalk, and it's the underlying infrastructure that translates my high-level ideas into a functional, cross-browser implementation.  Once again, Seaside let's me forget about all those annoying, gritty little details.  I just write clean, expressive Smalltalk code, and it Just Works, exactly as I would expect it should.

**Update:**

If you want to see the above application running live, you can find it [here](http://seaside.b-ark.ca/ajaxcounter/).


