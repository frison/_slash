---
layout: article
title: Glorp - Early Impressions
author: Brett Kosinski
date: 2010-05-10 02:00:00 -0700
category: [ smalltalk, seaside, hacking ]
no_fediverse: true
---

Well, this was meant to be a shorter post, but alas, I've failed miserably.  Oh well, suck it up.  Well, assuming anyone's out there and actually reading this...  

Anyway, the topic today is... well, it should be evident from the post title: my initial impressions of [Glorp](http://www.glorp.org).  No, Glorp is not just the sound I make in the back of my throat while considering whether or not to ride the kiddie rollercoaster at [West Edmonton Mall](http://www.wem.ca).  It is, in fact, an <a class="inter Wikipedia outside" href="http://en.wikipedia.org/wiki/Object-relational_mapping">object-relational mapping</a> package for Smalltalk, which attempts to bridge the rather deep divide between the object-oriented and relational data modeling worlds.

Now, generally speaking, I tend to be a fan of ORM's.  Of course, that's probably because I've never really used one heavily in a production environment.  But, generally speaking, the idea of describing the relationship between objects and their tables in code, and then having the code do all the work to generate a schema seems like a really nice thing to me.  Of course, the real question then becomes, how hard is it to set up those mappings?  And it turns out, in Glorp, the answer is:  well, it's a pain in the ass.

Okay, to be fair, there's a reason it's a pain in the ass: Glorp is designed to be incredibly flexible, and so it's designed for the general case.  Unfortunately, that means added complexity.  What kind of complexity, you ask?  Well, allow me to demonstrate, using my little toy project as an example.  This little project of mine is an online Go game record repository.  As such, I need to store information about users, games, players, and so forth (well, there's not much more forth... other than tags, that's actually it).  So, suppose we want to define a Game object and a User object, such that a Game contains a reference to the User that submitted it.

Now, before I begin, you need to understand that a database is generally represented by a single Repository class of some kind.  That Repository class, which must be a subclass of DescriptorSystem, defines the tables in the database schema, their relationships, and how those tables map to the various objects in your system.  This information is encapsulated in methods with a standard naming convention (how very Rails-esque), so if some of this looks a tad funny, it's not me, it's the naming convention.

So, let's begin by defining a User.  First, we need to describe the table schema where the User objects will come from:

```smalltalk
tableForUSERS: aTable

    aTable 
        createFieldNamed: 'UserID' type: platform sequence;
        createFieldNamed: 'Name' type: platform text;
        createFieldNamed: 'Password' type: platform text.
        
    (aTable fieldNamed: 'UserID') bePrimaryKey.
```

This code **should** be pretty self-explanatory (a side-effect of Smalltalk's lovely syntax).  This method takes a blank DatabaseTable instance and populates it with the fields that define the User table.  Additionally, it sets the PK for the table to be UserID.  Easy peasy.  Now, assuming the Users table maps to a class called GRUser, we define the class model that this table will map to.

```smalltalk
classModelGRUser: model

    model 
        newAttributeNamed: #userid;
        newAttributeNamed: #name;
        newAttributeNamed: #password;
        newAttributeNamed: #games collectionOf: GRGame.
```

Also straightforward.  This specifies the various attributes that make up the GRUser class.  Incidentally, you still need to declare a real GRUser class... all this code does is tell Glorp what attributes it should be aware of, and what they are.

Lastly, we need to defined a "descriptor" for the Users -> GRUser mapping.  The descriptor basically defines how the various attributes in the model map to fields in the table.  Additionally, it defines the relations between the tables.  So, here we go:

```smalltalk
descriptorForGRUser: description

    | table |
    
    table := self tableNamed: 'Users'.
    
    description table: table.
    
    (description newMapping: DirectMapping)
        from: #userid to: (table fieldNamed: 'UserID').
        
    (description newMapping: DirectMapping)
        from: #name to: (table fieldNamed: 'Name').
        
    (description newMapping: DirectMapping)
        from: #password to: (table fieldNamed: 'Password').

    (description newMapping: ToManyMapping) 
        attributeName: #games;
        referenceClass: GRGame;
        collectionType: OrderedCollection;
        orderBy: #additionTime.
```

So, for each field, we define a mapping.  A DirectMapping instance maps an attribute to a field... err... directly.  The ToManyMapping, on the other hand, sets up a relation, and maps the #games attribute of the GRUser class to the GRGame class.  But how does it figure out how to do the join?  That's in the table and descriptor definitions for the Games table and GRGame object (note, I'm going to leave out the extra junk):

```smalltalk
descriptorForGRUser: description

    | table |
    
    table := self tableNamed: 'Users'.
    
    description table: table.
    
    (description newMapping: DirectMapping)
        from: #userid to: (table fieldNamed: 'UserID').
        
    (description newMapping: DirectMapping)
        from: #name to: (table fieldNamed: 'Name').
        
    (description newMapping: DirectMapping)
        from: #password to: (table fieldNamed: 'Password').

    (description newMapping: ToManyMapping) 
        attributeName: #games;
        referenceClass: GRGame;
        collectionType: OrderedCollection;
        orderBy: #additionTime.
```

So as you can see, in the table definition, we establish a foreign key from the Games table to the Users table, and then in the descriptor, we define a RelationshipMapping (which is a synonym for a OneToOneMapping) from GRGame -> GRUser.

I hope at this point you can see the one big problem with Glorp:  It's **really really complicated**.  Worse, it's not particularly well documented, which makes it a bit of a challenge to work with, and means that if you want to do something "interesting" it can be a bit of a challenge.  As a quick example, in my schema, the Games table has **two** references to the Players table, one for the white player, and one for the black player.  This greatly confuses Glorp, which means I had to do a bit of manual work to get the relationships set up.  Here's how the black player relation is established (there may be a better way, but I don't know what it would be):

```smalltalk
    blackField := table fieldNamed: 'Black'.
    playerIdField := (self tableNamed: 'Players') fieldNamed: 'PlayerID'.

    mapping := (description newMapping: RelationshipMapping)
        attributeName: #black;
        referenceClass: GRPlayer.
    
    mapping join: (
        self 
            joinFor: mapping
            toTables: { self tableNamed: 'Players' }
            fromConstraints: { }
            toConstraints: { ForeignKeyConstraint sourceField: blackField targetField: playerIdField }
    ).

```

And then it's basically the same thing for the white player.  Mmmm... ugly.

But, all that said, once the mappings are set up, suddenly Glorp can be a real joy to work with.  Here's the code necessary to add a user, and then query him back out:

```smalltalk
| user |

user := GRUser withName: 'shyguy' andPassword: 'secret'.

self session
    inUnitOfWorkDo: [ self session register: aGRUser ].

self session 
    readOneOf: GRUser where: [ :each | each name = 'shyguy' ].
```

The query is of particular interest.  That **looks** an awful lot like a straight select block, but it is, in fact, translated into an SQL query, which is then run against the database.  And that is pretty darn cool.  It almost looks like a pure object store, ala Magma, and that's mighty impressive.

