---
layout: article
title: ColdFusion Tip Of The Day - CFCs Are *Objects*
author: Brett Kosinski
date: 2010-09-03 02:00:00 -0700
category: [ rants, hacking, coldfusion ]
no_fediverse: true
---

So I have the "pleasure" of working on a couple ColdFusion projects on the side.  The thing about ColdFusion is it's a lot like Perl:  wonky syntax, often used by total amateurs, and can be horribly abused to do really bad things.  And guess who primarily uses ColdFusion?  Yeah... total amateurs.

As a beautiful example, let's consider the CFC, or ColdFusion Component.  This concept was added to ColdFusion in order to add modularity and object orientation to what was, frankly, a largely procedural programming mish-mash.  And it does a pretty good job:

1. It provides mechanisms for encapsulation.
2. It encourages code reuse.
3. It encourages documentation.

Well, assuming it wasn't being used by amateurs.  See, a CFC can, and should, be used like a real object.  But let's say you're a dumbass who doesn't understand object oriented programming.  Well, in that case, you might do something really stupid, like use a CFC as just a container for a bunch of utility functions that are only loosely related.  For example, you might do something stupid like:

```cf
<cfcomponent output = "false">
  <cffunction name = "init" access = "public" returntype = "myType">
    <cfreturn this>
  </cffunction>

  <cffunction name = "firstThing" access = "public">
    <cfargument name = "Datasource" type = "string" required = "1" />

    ...
  </cffunction>

  <cffunction name = "secondThing" access = "public">
    <cfargument name = "Datasource" type = "string" required = "1" />

    ...
  </cffunction>

  <cffunction name = "thirdThing" access = "public">
    <cfargument name = "Datasource" type = "string" required = "1" />

    ...
  </cffunction>
</cfcomponent>
```

See, because this person is a moron, they don't understand the concept of **instance variables**.  A smart person would stuff the datasource into an instance variable, and populate it when the object is initialized.  A complete moron would just pass the same parameters in over and over again because he or she is a god damned moron who shouldn't be allowed near a computer, let alone permitted to program one.

**deep breath**

**Bonus tip**:  Naming arguments to a function "table1", "table2", "table3", etc, should resulting in the "developer" being dragged into the town square, tarred, and feathered.

