---
layout: article
title:  "Single Sourcing My Cookbook"
summary: "Part one of two on single sourcing content to produce multiple attractive outputs. In this case, a write-up about the creation of my personal cookbook!"
author: Brett Kosinski
date:   2022-03-08 09:21:48 -0700
category: [ indieweb, ownyourdata ]
syndicate_to: [ twitter ]
no_fediverse: true
---

Note:  This was originally going to be a single post about both my [Cookbook](/Recipes) and my [CV](/CV), but it turns out I can really ramble, so I'm splitting it into two posts.

One of the benefits of using a static site generator (in my case Jekyll) to build this website is that all the underlying content is stored in simple text files.  Most of the page content itself is just markdown files with a YAML header block.  The page layout is simple HTML templates using liquid macros.  Formatting is SASS that's transformed into vanilla CSS.

This has a few of benefits.  First, the site is future-proofed--plain text means I can move to a different engine any time I want, as the content is stored in a format that's easy to extract and transform.  Second, the ecosystem of tools to handle text files generally, and YAML and markdown specifically, is enormous, which means I can lean on all that existing infrastructure to do interesting things.

In this post I'll cover the first of two examples where I've taken advantage of these benefits to produce, not just this website, but beautiful PDFs, ebooks, and even Word documents, from the same source content.

<!-- more -->

# The "B" Ark Cookbook

Back in the year 2000, not too long after I met my wife, her family held a reunion.  As part of the event, one of the relatives pulled together recipes from various members of the family, collecting them into a cookbook that was printed and handed out to everyone.

I have to say, I absolutely love this little book!  Flip to any page and you'll find a picture of the family who contributed the recipe, a little biography about them, and then the recipe itself.  The book serves as family record, photo album, a preservation of traditions, and a practical reference.

Pre-internet, recipes were often shared this way, from person to person, family to family.  Sure, we'd buy cookbooks, but we'd also clip recipes out of magazines or newspapers, and scrawl recipes down on a haphazard collection of cards and scrap pieces of paper.  We'd chat about some new recipe we got from a friend, or inherited from a grandmother.  We'd pass those recipes between us like physical memes.  These collections formed a kind of tradition, a shared family culture.

And then came the internet.

There's still a few folks with whom I share recipes, but these days, if I want to try making something, I'm far more likely to just go trawling the internet.  This has its pros and cons.  On the one hand, I can find a recipe for darn near anything from anywhere, which is amazing!  On the other hand, that sense of shared culture and traditions has, at least for me, been diluted.

Worse, speaking for myself, when I'm trying to find a recipe for some dish I've never prepared before, I find the internet to be utterly bewildering.  Any search could produce two dozen different recipes, with no obvious way to choose between them.  One would hope social filtering via review schemes might help, but half the time reviews are along the lines of:

> 5 stars!  Note, I added five new ingredients, removed three, changed a bunch of ratios, and basically created a new recipe.  Fantastic!

To get through the noise I've settled on a few trusted online and offline sources--America's Test Kitchen, The Joy of Cooking, etc--that I use as my starting references.  Then, as I get more familiar with a recipe, I start to riff on it.

This works great, except:

1. For online sources, you run the risk that the recipe disappears, moves, or gets put behind a paywall.  I can't count the number of recipes that have vanished when I wasn't paying attention.[^1]
2. I want to be able to record my deviations from the core recipe, which is awkward even in printed books.
3. For the above reasons, it's even more difficult to share those recipes with family and friends.

And so I settled on the same solution that our parents used: I started building my own recipe collection!

My collection started as printed pages in a binder, but the downsides quickly became apparent:  it's difficult to keep organized, the pages get dirty or messy, it's useless if I find myself at a grocery store and needing to check the ingredient list for something, and it's difficult to share in an online world.

So why not put my collection online?

And thus my [recipe collection](/Recipes) was born![^2]

This has worked pretty well for me, but cooking with this reference requires some kind of internet-capable device, which means that I either 1) use a phone, 2) bust out my laptop, or 3) get a tablet.  For the longest time I just settled on option 2, but then I ran across the [reMarkable](https://remarkable.com), and after much drooling, I decided to pull the trigger.  I now had my perfect digital cookbook device (among many other things)!

But now I had a different problem:  How do I get the cookbook onto the reMarkable?  It doesn't have a built in web browser (which is actually one of the reasons I bought the thing), so I'd need to convert the content into some kind of offine readable form.  In a perfect world that'd mean a PDF.

But how could I turn my markdown-based recipe collection into both HTML and PDF and have it look great both ways?

Enter [Pandoc](https://pandoc.org).

Pandoc is an incredibly powerful tool for taking in various markup formats and converting them into a variety of different outputs.  The question was then how I could take all these independent markdown pages and stitch them together into a single output.

Now, Pandoc does theoretically support taking multiple input files and mashing them together into a single output.  But I pretty quickly abandoned the idea, as I couldn't quite get the formatting control I wanted.  Instead, I ended up throwing together a small Ruby script that would:

1. Output a suitable Pandoc YAML header block with various configuration options.
2. Read each markdown page in my recipe collection, parsing the individual YAML headers to pull out some important metadata.
3. Output those individual recipe pages into a single markdown file with appropriate section headers.

I could then take that single markdown output and format it using Pandoc.  Nice![^3]

Best of all, I could use Latex to generate the PDF output, which means absolutely gorgeous typesetting.

This has worked out incredibly well!  I now have the PDF loaded on my tablet, and I can even use the reMarkable to jot notes down (which I then incorporate back into the recipe), cross off steps in the recipe as I complete them, etc.  It really is the best of both the digital and print worlds!  And it's possible because the underlying content is built on open formats that are easily manipulated and transformed by a whole ecosystem of tools.

Fairly recently, for no other reason than because I could, I decided to take advantage of Pandoc again to also produce an EPUB formatted ebook of my collection which can be read on any eInk device.  Cool!

Now, in general, producing multiple formats from a single source has one major challenge: lots of fiddling with individual format quirks to get good looking results.

In the case of Latex, the work was in getting the right set of header definitions in place to get the formatting looking just right.  And if you've worked with Latex you'll know that can involve a lot of black magic and cargo cult coding.

The EPUB output posed similar challenges, except it involved a lot of fiddling with CSS definitions to get things looking right.  And that's ignoring device-specific quirks[^4].

And, of course, the HTML output, itself, required its fair share off CSS fiddling and template design to get the right look and feel that matched my overall site design.

Finally, in all three cases, if I want to change the structure of the underlying data or the formatting of the output, I'll have go through the same process all over again.  This issue cannot be understated, and underscores an important point: changes to the structure of the source content will be enormously disruptive!  So best to get it right with a single secondary format, and then go from there.

But overall, it's been a fun little experiment, and a great way to leverage my website for something other than blogging!

[^1]: This issue gets to the heart of one of the many reasons I now try to self-host and own my own data: the ephemerality of online data and services means that we can no longer take for granted the simple idea of information permanence.  A book on a shelf will always be there.  But data that you don't personally control could disappear at any moment.
[^2]: This started out largely as a factual collection--ingredients and procedures--but I've recently started putting in a bit more commentary with my recipes, as well, in the hopes of creating my own archive of family traditions.  It's been very fun!  I highly recommend it!
[^3]: I recently discovered the script is not quite complete.  I tend to use a lot of footnotes, and I realized that I'll need to renumber them in the combined output if I want that to work correctly.
[^4]: On the Kindle I ran into all kinds of rendering bugs when converting my EPUB file to MOBI using Calibre.  It took me a while to realize the solution was to simply switch to AZW3...
