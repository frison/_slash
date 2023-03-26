---
layout: article
title:  "Fun with themes"
summary: "For kicks I wanted to build a dark mode for my blog, which led me down the garden path of CSS custom properties and easter eggs..."
author: Brett Kosinski
date:   2020-02-18 09:42:26 -0700
category: [ hacking ]
syndicate_to: [ twitter ]
no_fediverse: true
---

One of the many things that attracted me to tech, back in the day, was the total DIY freedom of hacking computers to do whatever I wanted.  And when you're a kid, it's even more fun because you aren't looking at your pet projects through the lens of "value" or "product market fit" or "differentiators".  You just... do stuff, simply because it's fun!

Or, put more simply:  You play.  And as adults, we have play beaten out of us.  And that is just a darn shame.

Well, one of the fun things about running your own blog on your own server with software you control is that it's a *wonderful* place to play!  Heck, the re-design of this blog started off as just me screwing around for the fun of it.

So, while on vacation, I thought it would be fun to build a dark mode theme for my blog using the technique outlined in [this post](https://dev.to/ananyaneogi/create-a-dark-light-mode-switch-with-css-variables-34l8) (which it turns out is one of many).

If you want to see the results... well, first off, if your OS is set to use a dark mode theme, you might already be seeing it!  Otherwise, the little lightbulb icon in the navbar toggles the themes.

In addition, if you poke around in my site, you might find an easter egg that enables a couple of additional retro themes designed to honour the computers of the past that inspired me and lead me to where I am today!

<!-- more -->

Now, I'm not going to write yet-another-post on CSS custom properties for creating a dark theme.  There's plenty of other posts that get into those details.  Though I will say this whole exercise was a really great way to learn about custom properties and CSS calculations, if only to see how far things have come in this area.

However, I will note a couple of interesting nuances, having done this all using Jekyll with a site based on their default Minima theme.

*Note:*  I did *not* spend any time trying to make this scheme work with older browsers.  This is my blog, and I'm not that worried about IE users.  If you need to support older browsers, you're gonna have to do a bit more heavy lifting.

First off, Jekyll's themes make heavy use of Sass to make the themes configurable.  Unfortunately, these variable substitutions, calculations, and so forth, all occur at compile time, which means they're not useful when wanting to do on-the-fly client-side replacement of CSS.

As a result, one of the key things I needed to do was swap out Sass variables for CSS custom properties in various places.  For example, this:

```scss
$base-font-size:   16px !default;
$base-font-weight: 350 !default;
$base-line-height: 1.5 !default;
```

Turned into this:

```css
--base-font-size: 18px;
--base-font-weight: 350;
--base-line-height: 1.5;
``` 

Then, I had to go through the various theme files, and convert the various Sass calculations into the equivalent CSS calc() expressions.  So, things like this:

```scss
margin-left: $spacing-unit * 4;
margin-right: $spacing-unit * 4;
```

Turned into this:

```css
margin-left: calc(var(--spacing-unit) * 4);
margin-right: calc(var(--spacing-unit) * 4);
```

The one exception to this is the use of Saas "lighten" and "darken" functions, which have no easy CSS calc() equivalent, so in those cases I loaded the results into Sass variables and then stuck this in CSS custom properties like this:

```scss
--border: 1px solid #{lighten($text-color-light, 40%)}
```

You'll notice the use of an explicit Sass interpolation expression.  This is required when using CSS custom properties in Sass.

Finally, I took this opportunity to rework my themes a bit to contain more semantic variables.  For example, the minima theme uses a `grey-color` variable as a general-purpose accent color in a bunch of places, and I replaced that with more specific variables (e.g. `--border-color`) so that I had more explicit theme control.

Okay, so that took care of the base theme, but there's a glaring hole I had to close:  syntax highlighting.

The base Minima theme comes with a syntax highlighting color scheme that I was never that thrilled by, so I took this opportunity to:

1. Rebuild the syntax highlighting scheme to use CSS custom properties, with the existing theme colors used as default values.
2. Create a new syntax highlighting scheme for my light mode theme based on [Lucius Light](https://github.com/jonathanfilip/vim-lucius).
3. Create a new dark mode syntax highlighting scheme based on Lucius Dark (this is my preferred Vim colorscheme).

This was definitely the most tedious part of the process.  The base theme contained lines like this:

```css
.c     { color: #998; font-style: italic } // Comment
```

So I wrote up a little Perl hack job to produce this (building a new theme then involves redefining these variables as needed):

```css
.c {
  font-style: var(--comment-font-style, italic);
  color: var(--comment-color, #998);
  font-weight: var(--comment-font-weight, var(--base-font-weight));
  background-color: var(--comment-background-color, var(--block-background-color));
}
```

Here's that hack job, in case you're curious:

```perl
for my $line (@lines) {
  $line =~ m|^(.+?)\s*\{(.*?)\} // (.*?)$|;

  my $class = $1;
  my $attrs = $2;
  my $name = $3;

  $name =~ s/\./-/g;
  $name = lc($name);

  my %attrs = (
    "color" => "var(--text-color)",
    "background-color" => "var(--background-color)",
    "font-style" => "normal",
    "font-weight" => "var(--base-font-weight)"
  );

  for my $attr (split(/;/, $attrs)) {
    $attr =~ /^\s*(.+):\s*(.*?)\s*$/;

    $attrs{$1} = $2;
  }

  print ".$class {\n";

  for my $attrname (keys %attrs) {
    print "  $attrname: var(--$name-$attrname, $attrs{$attrname});\n";
  }

  print "}\n\n";
}
```

Yes, I still use Perl--whenever I need to do this kind of one-off text processing, there's just nothing like it, especially given how totally fluent I am with the language.

Finally, I threw together a bit of JS to trigger theme toggling in various circumstances, including detecting when the user has dark mode set as their preferred mode (which is why some of you may already be seeing the new theme!)

Those whole exercise was really valuable for a few reasons:

1. It was super fun!  I love tweaking my site design, and I'm really happy with the results.
2. It was a great way to experiment with some more modern browser features.
3. To make the themes easier to build, it forced me to clean up and normalize my site styles.  The result is the site is much simpler, more consistent, and just more "put together".

And did I mention it was fun??
