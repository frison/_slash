---
layout: article
title: Running in the Rain - Wetter or Drier?
author: Brett Kosinski
date: 2007-08-08 02:00:00 -0700
category: [ hacking, boredom, smalltalk ]
no_fediverse: true
---

Well, as anyone living in Edmonton knows, the weather in our area has been, well... rather crappy.  Cold, rainy, windy, it feels more like the fall than waning summer.  And through it all, I've persisted in cycle commuting, mostly because it allows me to justify (excuse) a rather gastronomically decadent lifestyle.  Consequently, I've found myself caught in more than a few showers over the last few weeks, resulting in much dampness, and, oddly enough, a bit of inspiration.

Now, a favorite show of many folks, myself included, is [Mythbusters](http://en.wikipedia.org/wiki/Mythbusters).  They attempt to perform "scientific" experiments to verify or debunk various myths, preconceived notions, and so forth.  Now, one of the topics they tackled was:  Does moving faster in the rain keep you dry, or get you wetter?  Well, in their "experiment", I seem to recall they found little difference between slow or fast walking, which I found a little surprising, and during a recent bike trip, I found myself pondering how it is they could have found the results they did.

Meanwhile, I've also been digging more deeply into the joyous language that is [Smalltalk](http://en.wikipedia.org/wiki/Smalltalk), specifically the [Squeak](http://www.squeak.org) implementation, and a related web application framework called [Seaside](http://www.seaside.st).  However, I've been at a loss for a small-scale project to hack up that would allow me to flex my rather atrophed Smalltalk muscles.  And so it was that, a couple days ago, while cycling home in the rain, I realized, why not simulate a person walking through a rain storm, and determine whether the Mythbusters results were accurate?

Now, before I get into the details, I should point out this really is pretty non-scientific.  I'm sure there are details that I've missed which make this simulation completely unrealistic.  But, it was fun. :)  Now, a bit of explanation about my methodology.  First, the simulation is two-dimensional, since I didn't think the added complexity of doing a full, 3D simulation would generate sufficiently different results.  Second, rather than moving my subject through a shower of rain drops at varying speeds, I decided to apply a uniform direction vector to the drops themselves (basically move the drops instead of the subject... the effect is the same, but the implementation is a lot easier).  With that said, the experiment is set up as follows (note, these parameters are all configurable, but this is what I chose... they're entirely arbitrary):

1. The rain drop spawn field is 20m by 20m.
2. The rain drops are created at a rate of 80 every second, distributed randomly across the top of the spawn field.
3. Rain drops fall at the terminal velocity for a typical drop indicated [http://www.grow.arizona.edu/water/raindropvelocity.shtml here] (6.25 m/s).
4. The subject is a rectangle approximately 6 feet tall by 6 inches wide.
5. The subject's walking speed varies from 1 to 8 m/s, stepping 0.25 m/s per experiment.
6. The subject "walks" a fixed 20m during each experiment.
7. Each experiment was repeated 10 times and the results averaged (since rain drops are spawned in random positions).

The final tallies can be seen in the graph below:

![Rain Drops Graph](/assets/images/Rain_Drops_Graph)

Granted, it looks a bit noisy, but the general trend appears to indicate that moving faster through a rain storm helps keep you drier!  Though, the advantage does seem to level off (it looks like a roughly exponential decay, to me, with the limit at some non-zero value).  Remember that, folks... the weather doesn't look like it's going to improve. :(

Incidentally, working on this in Squeak has been quite enjoyable.  The richness of the class library made many tasks **far** easier than they would be in other languages, and the ability to fix bugs as I go, and then **continue running the code** is, to say the least, incredibly cool.  And, frankly, I think Smalltalk is the most elegant programming language I've ever worked with. :)

**Update:**

Found an oversight in my simulation, but the above graph now reflects the latest version.  In short, I had to make sure the playfield was populated with raindrops before beginning each walk.  Otherwise, the subject could complete the walk before a drop ever fell low enough to hit him!

**Update 2:**

Woo!  I win a gold star!

