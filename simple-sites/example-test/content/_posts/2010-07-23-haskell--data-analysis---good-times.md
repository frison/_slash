---
layout: article
title: Haskell + Data Analysis -> Good Times
author: Brett Kosinski
date: 2010-07-23 02:00:00 -0700
category: [ hacking, haskell ]
no_fediverse: true
---

So, as part of my ongoing obsession with toying with unusual programming languages, Haskell has periodically popped on and off my radar.  The problem is, it's rare that I find a problem where I feel like sitting down and figuring out how to solve it in Haskell, particularly since Haskell's strengths and weaknesses don't often mesh with the kinds of ad-hoc programming I tend to do (for example, Haskell **sucks** for text parsing, primarily due to performance constraints, and I find much of the random coding I do involves high-volume text processing).

But all that has changed due to an interesting problem we've been fighting with at work.  You see, on one of our production servers, we're having performance problems.  And so the first thing we did was find a way to collect telemetry.  Of course, the first cut dumped out raw CSV files, which are a pain in the butt to manipulate in interesting ways, and as a result, I found myself writing a lot of Perl to deal with the data we received.  Not fun.

Finally, after days of this, I decided to write a new tool that collects telemetry as we were doing before, but rather than using CSV, stores the data in an [SQLite](http://www.sqlite.org) database, thus making the information a hell of a lot easier to manipulate.  "But now you need to analyze that database!", you say.  Ahh yes, you're quite right, and normally I might turn to Perl to do just that.  However, it turns out, Haskell is more or less perfect for that very job.

See, Haskell just so happens to have [HDBC](http://wiki.github.com/jgoerzen/hdbc/), which is really the Haskell equivalent to Perl's DBI.  And there just happens to be an [SQLite HDBC driver](http://hackage.haskell.org/package/HDBC-sqlite3) available, which provides a nice functional interface to the underlying database.  With this combination, querying the database and manipulating its contents becomes exceedingly easy.  And in particular, because of Haskell's laziness, we can do much of our processing in a streaming fashion, rather than bulk loading large amounts of data for processing.

For example, suppose we have a table as follows:

||ID||Date||Value||

Where you may have multiple rows for a given date.  Now say you want to take that table, and group it so that all the rows for the same date are collected together.  Well, in Perl, you'd probably set up a loop, track the previous and next rows, build a list in memory, and output the results as you go, and that would work out just fine.  But it's tedious.  Haskell, on the other hand, makes this all remarkably easy.

First, let's back up.  What we really want to do is take a list of items, and then group them together based on some kind of splitting function.  It may be a list of integers, a list of strings, or a list of database rows.  But in the end, it's really all the same thing.  Well, you could define a function like that as follows:

```haskell
~> splitWhen :: (a -> a -> Bool) -> [a] -> ([a], [a])                                                     
splitWhen func [] = ([], [])                                                                           
splitWhen func (head:[]) = ([head], [])                                                                
splitWhen func (first:second:rest)                                                                     
  | func first second = (first:result, remainder)                                                       
  | otherwise         = ([first], second:rest)                                                          
  where (result, remainder) = splitWhen func (second:rest)                                             
                                                                                                        
~> splitList :: (a -> a -> Bool) -> [a] -> [[a]]                                                           
splitList func [] = []                                                                                  
splitList func lst = group:(splitList func remainder)                                                   
  where (group, remainder) = splitWhen func lst  
```

So, first we define **splitWhen**, which is a function that takes:

1. A test function.
2. A list.

The test function is applied to each pair of items in the list, starting at the beginning, and the list is split at the point where the function returns false.  **splitList** then uses **splitWhen** to break a whole list into groups.  So, for example:

```haskell
splitList (\x y -> x < y) [ 1, 2, 1, 3 ]
```

Returns

    [ [1, 2] [1, 3] ]

But this code has another interesting property that may not be obvious to someone unused to Haskell: these functions are lazy.  That means they only do work as elements are requested from the list.  For example, given this code:

```haskell
take 5 $ splitWhen (\x y -> x < y) [ sin x | x <- [ 1 .. ] ]
```

The second part of this statement generates an infinite list of the sin() values of the whole numbers starting from 1.  And splitWhen operates on that list.  If this weren't Haskell, this code would run forever, but because Haskell evaluates statements lazily, this only returns the first 5 groups, as follows:

    [
      [0.8414709848078965, 0.9092974268256817],
      [0.1411200080598672],
      [-0.7568024953079282],
      [-0.9589242746631385, -0.27941549819892586, 0.6569865987187891, 0.9893582466233818],
      [0.4121184852417566]
    ]

Nice!  As an aside, this is one of the more interesting aspects of Haskell: it encourages you to write reusable functions like this.  

So, let's apply this to a database query.  Well, it turns out, that's dead simple.  You'd just do something like:

```haskell
conn <- connectSqlite3 "database.db"
stmt <- prepare conn "SELECT Date, Value FROM theTable ORDER BY Date"
execute stmt []
groups <- (splitWhen (\(adate:rest) (bdate:rest) -> adate == bdate)) `liftM` (fetchAllRows stmt)

putStrLn $ take 5 groups
```

Yeah, okay, this is a little dense.  The first few lines prepare our query.  No big deal there.  It's the last line where the magic really happens.  First, let's start on the far right.  Here we see the function **fetchAllRows** being called.  That function returns the rows generated from the query, but it does so **lazily**.  So rows are only retrieved from the database as they're needed.  We then apply the splitWhen function to the results (ignore the liftM, that has to do with Monads, and you probably don't want to know...).  And then we take 5 groups from the result.  Voila!  In a surprisingly small amount of code, a huge chunk of which is nicely generic and reusable, we can do what, in Perl, would likely take dozens of lines of code.  Pretty nice!

