---
layout: article
title: Sometimes You Actually Have To Rewrite It
author: Brett Kosinski
date: 2012-03-30 02:00:00 -0700
category: [ hacking ]
no_fediverse: true
---

So, a couple years back I started doing some subcontracting work for a buddy of mine who runs a little ColdFusion consultancy.  As part of that work, I took ownership of one of the projects another sub had built for one of his client, and the experience has been... interesting.

See, like PHP and Perl, ColdFusion has the wonderful property of making it very easy for middling developers to write truly awful code that, ultimately, gets the job done.  And so it is with this project.  My predecessor was, to be complementary, one of those middling developers.  The codebase, itself, is a total mess.  Like, if there was a digital version of Hoarders, this code might be on it.  **But**, it does get the job done, and ultimately, when it comes to customers, that's what matters (well, until the bugs start rolling in).

Of course, as a self-respecting(-ish) developer, this is a nightmare.  In the beginning, I dreaded modifying the code.  Duplication is rampant, meaning a fix in one place may need to be done in many.  Side effects are ubiquitous, so it's difficult to predict the results of a change.  Even simple things like consistent indentation are nowhere to be found.  And don't even dream of anything like automated regression tests.

Worse, feeling no ownership of the code, my strategy was to minimally disturb the code as it existed while implementing new features or bug fixes, which meant the status quo remained.  Fortunately, around a year ago I finally got over this last hump and made the decision to gradually start modernizing the code.  And that's where things got fun.

One of the biggest problems with this code is that data access and business logic are littered throughout the code, with absolutely no separation between data and views.  And, remember, it's duplicated.  Often.  So the first order of business?  Build a real data access layer, and do it such that the new code could live beside the old.  Of course, this last requirement was fairly easy since there was no pre-existing data access layer to live beside...

So, in the last year, I've built at least a dozen CFCs that, slowly but surely, are beginning to encompass large portions of the (thankfully fairly simple) data model and attendant business logic.  Then, as I've implemented new features or fixed bugs, I've migrated old business logic into the new data access layer and then updated old code to use the new object layer.  Gradually, the old code is eroding away.  **Very** gradually.

Finally, after a year of this, after chipping away and chipping away, **finally**, while there's still loads of legacy code kicking around (including a surprising amount of simply dead code... apparently my predecessor didn't understand how version control systems work--if you want to remove code, remove it, don't comment it out!), the tide is slowly starting to turn.  More and more often, bugs that need to be fixed are getting fixed in one place.  New features are able to leverage the object layer, cutting down development time and bugs.  And some major new features coming down the pipe will be substantially easier to build with this new infrastructure in place.  It's really incredibly satisfying, in a god-damn-this-is-how-it-should-be sort of way.

The funny thing is, this kind of approach goes very much against my natural instincts.  Conservative by nature, I'm often the last person to start rewriting code.  However, if there's one thing this project has taught me (along with a couple wonderfully excited, eager co-workers), it's that sometimes you really do have to gut the basement to fix the cracks in the foundation.  And sometimes, you just gotta tear the whole house down.

