---
layout: article
title: Fun with Open Data
author: Brett Kosinski
date: 2011-10-25 02:00:00 -0700
category: [ python, hacking ]
no_fediverse: true
---

### A Simple Problem

So, recently I found myself struggling with a very simple problem:  I kept missing our darn garbage pickup date.  Yeah, sure, the city sends out a little printed schedule, and it usually makes it to my refrigerator, but given that requires I actually pay attention to the silly thing, it doesn't end up helping me much.

Now, in the past, I've solved this problem by manually punching the pickup dates into Google Calendar.  This works, but it's tedious, error prone, and whenever the new schedule comes out, I have to do it all over again.  And if it wasn't clear, I'm lazy.  Real lazy.  So last time around I simply didn't get around to doing it.

And so I miss the pickup dates.

Obviously what I really wanted was an iCalendar formatted file that I could just subscribe to in Google Calendar, at which point I could move on with my life.  But, alas, to my knowledge no such resource exists.

### An Idea Is Formed

Well, I found myself discussing this with my officemate, Steve, and he pointed out that the pickup schedule is, in fact, available online in raw form as part of the City of Edmonton's [Open Data Catalog](http://data.edmonton.ca/).  The Open Data Catalogue is a remarkable resource.  In it you can find a staggering amount of data about the city, provided in a simple, machine-readable form, and browseable online.  It's really very cool, and it feels like a resource just waiting to be tapped.

Anyway, back to the topic at hand, it turns out the pickup schedule is available right in the catalogue, albeit in a fairly raw form.  At this point, the answer seemed obvious: write a tool which could consume this data, and produce an iCal file as output.  I could then subscribe to the generated calendar, and voila!  No more missed garbage days!

### Why Can't Things Be Easy?

Unfortunately, things got a little tricky once we started digging into the data.  It turns out that the city is subdivided into a series of zones.  Each of these zones then has one or more garbage pickup days, and so one's individual pickup schedule varies based on your geographic location in the city.  As such, the pickup schedule data is organized as a simple table as follows:

||Zone||Day||Date||

So, now we have a problem: how do we determine the zone and day for a given household?

Well, it turns out the city provides the zone/day data as a geographic overlay, in the form of a [KML](http://en.wikipedia.org/wiki/KML) data file.  KML is a rather complex XML dialect which can be used to represent geographic data, and is used in, among other placed, Google Maps, Google Earth, and so forth.  But, it's a standard, and there are standard tools for handling it, so a gold star for the city!

Alright, so now we have the geographic data, we just need to parse that file, and then based on household location, identify the appropriate zone and day, and extract the correct schedule information.  This should be easy...

### A Solution

The first question was one of language.  I knew I needed a few things:

1. Access to a decent web framework, so I could quickly slap together a (preferably REST) web service.
2. Something to parse the KML data.
3. Something to do point-in-polygon tests, so that, given the boundaries of a zone and a household lat/long, I could determine if the household was in that zone.
4. A CSV library would be handy (this is the form the schedule data takes).
5. A library for generating iCalendar files.

And, in addition, given this was a quick learning project, I figured it'd be nice to choose something I haven't written much code in.  In the end, I settled on Python, and in particular:

1. [CherryPy](http://www.cherrypy.org/) - A simple, lightweight web framework with support for REST built in.
2. [libkml](http://code.google.com/p/libkml/) - A KML library with (poorly documented) Python bindings.
3. [RosettaCode RayCasting Algorithm](http://rosettacode.org/wiki/Ray-casting_algorithm) - Code that implements the standard raycasting point-in-polygon test (I could've written this myself, but... why?)
4. Python's standard CSV module.
5. [vobject](http://vobject.skyhouseconsulting.com/) - A python library for parsing and generating iCalendar files.

Now, it turns out the hardest bit was in ingesting the KML file.  The libkml bindings, while functional, are **awful**.  They aren't terribly pythonic, they're horribly documented, and the examples and tests provide no coverage of the API.  As a result, I ended up reading a lot of SWIG binding definition files, in order to determine the method calls available in the object model provided.  But, eventually, I was able to figure out how to extract both the zone metadata (name, day, etc), and the polygon definitions, and with that, it was fairly easy to write a small library to identify a household zone based on their latitude and longitude.

After that, the rest was really pretty easy:  the code determines the user's zone, downloads the schedule data in CSV form, identifies the rows for that household, and then spits out an iCalendar file containing that schedule data.  Voila, done!  The service is available here:

http://api.b-ark.ca/garbage/schedule?latitude=&longitude=

Just enter your lat/long, and you should get a valid iCal file back.  Nice!  And even better, it took me roughly a day to slap the whole thing together.

### Getting Fancy

Upon posting about this on [Google+](https://plus.google.com/u/0/101627457317589343111), another friend of mine pointed out that it was rather onerous to expect the user to go look up the lat/long of their household in order to use the service.  This got me thinking of alternatives... wouldn't it be great if the user could just provide their address, and the service could do the rest?

Well, happy days, it turns out Google offers a free REST API for [geocoding](http://code.google.com/apis/maps/documentation/geocoding/) (the technical term for the process of mapping an address to a latitude/longitude pair (or vice versa)).  Just hit the service with a street address, and they'll hand you back geographic data in the form of a JSON or XML document.  Nice!

About ten lines of code later (with the help of Python's minidom module), I had a service which could take an address, get the lat/long automatically, and return the appropriate iCal file.  You can hit this version here:

http://api.b-ark.ca/garbage/schedule?address=

Just append your address to the URL, and you could get an iCal file back.  Thanks Google!

**Update**:

BTW, if you want to take a look at the (quite simple) code, you can check it out on [github](https://github.com/fancypantalons/Garbage).

