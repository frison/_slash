---
layout: article
title: Word Wrapping For The Win
author: Brett Kosinski
date: 2007-12-15 02:00:00 -0700
category: [ nethack, hacking, nintendods ]
no_fediverse: true
---

While development has slowed considerably on [NetHackDS](../projects/NetHackDS.md), partly due to me play... err... **testing**, partly due to me just needing a bit of a frickin' break (and partly due to the excessive drinking I did during our company Christmas party, which left me nonfunctional for much of today), I have been putting some effort into one of the more difficult enhancements I'm doing to the codebase:  adding proper word wrapping.

The impetus of all this started with a comment from one of my users who noted that, due to his/her poor vision, they've found my port rather difficult to use, as it makes use of a fairly small font.  As such, they were wondering if I could add support for larger font sizes, and I, of course, said I'd take a look at it.  It also happens that the only major remaining "known issue" in the code is one of text clipping: since the DS can only display, oh, maybe 65 columns of text, while much of the text in the game is designed for an 80-column display, there are a number of instances where the text is just chopped off on the right-hand side.  And this is related to the font size issue because both problems require the same solution:  word wrapping.

Now, the most basic word wrapping algorithm one might come up with, where you simply chop text where it's too long, and print the remaining portion on the next line, does the job well enough, but it's pretty unsightly.  You end up getting things like this:

Before:

     Hello, this is a really long piece of text I'm using for an example.
     And here is another line of text.

After:

     Hello, this is a really long piece of text I'm using
     for an example.
     And here is another line of text.

Ideally, in a situation like this, what you really want is for the word wrapping engine to understand that the text is really a paragraph, and the words shouldn't just be wrapped, but **reflowed** as well, so you get something like:

     Hello, this is a really long piece of text I'm using
     for an example.  And here is another line of text.

instead.  So, being the wildly talented programmer that I am, I reinvented yet another wheel, wrote a reflowing word-wrapping algorithm, and voila!  Fancy reflowed text.  And it looks mighty fine, too.  But there's a problem.  In order to write an algorithm like this, you have to identify paragraphs.  Now, it just so happens that blank lines are usually used to separate paragraphs (you need only look at this post to see that), and so it's pretty easy to identify where one paragraph starts and the other ends.  **But**, NetHack also likes to generate tabular data like this:

    No  Points     Name                                                   Hp [max]
      1      48117  brettk-Val-Hum-Fem-Neu died in The Gnomish Mines on
                   level 12.  Killed by an Elvenking.                      - [115]
      2      39115  brettk-Val-Hum-Fem-Neu died in The Gnomish Mines on
                   level 10 [max 11].  Killed by a vampire lord.           -  [79]
      3      29901  brettk-Bar-Hum-Mal-Neu died in The Gnomish Mines on
                   level 11.  Killed by a hallucinogen-distorted giant
                   ant, while helpless.                                    - [105]

and if you identify paragraphs by blank lines, and you reflow text, you end up with:

    No  Points     Name                                      
    Hp [max] 1      48117  brettk-Val-Hum-Fem-Neu died in The
    Gnomish Mines on level 12.  Killed by an Elvenking.     
    - [115] 2      39115  brettk-Val-Hum-Fem-Neu died in The
    Gnomish Mines on level 10 [max 11].  Killed by a vampire
    lord.           -  [79] 3      29901  brettk-Bar-Hum-Mal-Neu
    died in The Gnomish Mines on level 11.  Killed by a
    hallucinogen-distorted giant ant, while helpless.
    - [105]

Notice how the rows are all jammed together.  See, to the word wrapping engine, this looks like one big paragraph, thus it wrapped it accordingly, and the result is an unreadable mess.  So, in this case, you **don't** want to reflow the text.  In fact, there's really no nice way of handling this, so you're best off just using the ol' chop-and-print approach, as at least it somewhat preserves the tabular layout.  But what the heck do we do, now?

Well, the NetHack putstr() call that is used to write text to a window, and is the entry point I implement, takes an attribute, which normally specifies bold, underline, etc, for the text.  So, I created a new attribute bit, 0x1000, which basically says "don't reflow this text".  I then went into the NetHack core (yeah, more core mods... I don't like it, either) and altered the topten code so that, for the NDS version, it specifies this "dont reflow" attribute.  This same attribute is also used wherever files are paged out (such as the in-game help text).  But that does mean that, in effect, I've had to special case the NetHack core in a couple places in order to get the correct wrapping effect... basically, the solution sucks.  Unfortunately, I don't know of a better one.

But, on the bright side, the word wrapping works!  And I'm using the same code in the status updates, the text windows, the message output, and eventually the menu code.  Then, I just need to create a scrollable command window (the current one is entirely static), and the new, non-clipping, larger-font-capable NHDS will be ready!  Ish.

