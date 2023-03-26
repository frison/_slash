---
layout: article
title:  "Chesterton's Fence"
summary: "The last few months have me thinking a lot about technology, disruption, and the metaphor Chesterton's Fence, or why you need to think about systems before reforming them."
author: Brett Kosinski
date:   2022-12-23 10:33:23 -0700
category: [ prodmgmt, politics, technology ]
---

Back in 1929, [G. K. Chesterton](https://en.wikipedia.org/wiki/G._K._Chesterton), an English writer and philosopher[^1], described what is now known as [Chesterton's Fence](https://en.wikipedia.org/wiki/G._K._Chesterton#Chesterton's_fence), a metaphor about reforming systems:

> In the matter of reforming things, as distinct from deforming them, there is one plain and simple principle; a principle which will probably be called a paradox. There exists in such a case a certain institution or law; let us say, for the sake of simplicity, a fence or gate erected across a road. The more modern type of reformer goes gaily up to it and says, 'I don't see the use of this; let us clear it away.' To which the more intelligent type of reformer will do well to answer: 'If you don't see the use of it, I certainly won't let you clear it away. Go away and think. Then, when you can come back and tell me that you do see the use of it, I may allow you to destroy it.'

In the context of his writings, G. K. Chesterton was using this as an argument in favour of certain socially conservative views (hence the title of the essay "The Drift from Domesticity").  But the core principle--that it's important to understand systems before you change them--is far more broadly applicable (and apolitical!), and is something that I think the technology industry would be wise to adopt.

<!-- more -->

----

I have to admit my [CV](https://b-ark.ca/CV) is... kinda weird.  Entirely unlike a typical tech worker, I've stayed at the same company for my entire professional career, starting out as a developer and, after over a decade, moving into product and staff management, a turn I first took way back in 2014.  In the subsequent eight years I've had to learn a *lot*, and probably the most important lesson of all has been cultivating a sense of humility[^2], something that I try to instill in my own staff.

The company I work at builds ad tech, and as part of our product we have a system for managing advertising campaigns, each of which is composed of a number of lines (in the business these are sometimes called IOs, or Insertion Orders) that specify the ad to play, the target audience, the target number of impressions, and so forth.

Early in my career in PM, a customer asked us for a new feature:  They'd really like to be able to easily create new lines that pick up where the previous line left off.  On its face this seemed understandable, but it wasn't immediately obvious why this was so urgent, so we asked a few more questions. Through those discussions we realized our customers were using the system in a way entirely unlike what we'd envisioned!

"What the heck!  They're using it wrong!" we said, and we pushed back on the request.  Instead, we thought, the customer should change their workflows to match our expectations.

Now, Chesterton would have said "If you don't see the use of it, I certainly won't let you clear it away. Go away and think."  It's a shame I didn't have Mr. Chesterton standing over my shoulder that day.

Some time later, when this request came up again, we had some additional discussions, and a number of additional use cases popped out of the woodwork; use cases that were completely rational once you had a better understanding of how advertising campaigns are bought, sold, and managed.[^3]

There was a basic lesson, here, that I had to learn the hard way: sometimes, yes, users may lack a complete understanding of your product and as a result end up using it the "wrong" way.  If that's true, *that's your fault* for not engaging with those users to help them understand how to best use your product[^4].

But it's every bit as likely that there's something you, Product Manager, do not understand, and it is your job to keep digging, to uncover what's really going on in the lives of your users.

At bottom, though, this gets to the issue of humility: Chesterton's Fence asks us to assume the best of the people who came before us and who surround us today.

A "disrupter" might say "this system is stupid" or "whoever came up with this way of working is dumb".  Chesterton's Fence asks us, instead, to assume the best of people; to assume that the decisions those people made were rational at the time and made with the best information they had available; and to first assume that *we* are missing something before we go ahead and change things.

Critically, this principle is *entirely apolitical*.  Rather, it's "conservative" in the sense that it implores us to change systems after we understand them and not before, whether those proposed changes come from the left or the right[^5].

Admittedly, I'm not the first one to bring up Chesterton's Fence recently, and I think we can thank Elon Musk and his actions with Twitter for its resurgence.  If you ever wanted a case study in changing systems before you understand them, you need only look at the mass exodus of advertisers as Elon has profoundly transformed the way Twitter operates.

And why has he done what he's done?

Well, there's no one single answer to that question[^6].  But I'd argue that, like so many Silicon Valley "disruptors", he lacks something:  Basic humility.

[^1]: And according to Wikipedia, "Christian apologist", though I don't plan to touch on his theological views.
[^2]: Though anyone who knows me will know this is an endless struggle.
[^3]: I apologize for being a bit vague, here.  I don't tend to write a lot about my professional experiences as I worry about what I can and can't divulge.
[^4]: Yeah, this is a pretty strong statement.  After all, we live in a world that has instructions on packages of toothpicks.  But taking this your default position is a good idea.
[^5]: Critically, this also doesn't mean systems shouldn't be changed!  Sometimes systems are rooted in discrimination, the preservation of power structures, out-dated values and beliefs, and so forth.  In those cases, reform is critical.  But understanding those roots helps us ensure we make the right changes.
[^6]: Treating Twitter as a political project, first, and a business and technology platform, second, is certainly a big part of it.
