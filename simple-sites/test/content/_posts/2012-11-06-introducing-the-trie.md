---
layout: article
title: Introducing the Trie
author: Brett Kosinski
date: 2012-11-06 02:00:00 -0700
category: [ algorithms ]
no_fediverse: true
---

So in the kickoff post of my series on data structures and algorithms I'd like to begin with a relatively simple but handy little data structure: the trie. If you want to jump ahead and look at a very simplistic implementation of a trie data structure (only the insert and dump operations have been completed), I've put my experimental code up on GitHub [here](https://github.com/fancypantalons/Algorithms).

A clever little play on the word re*trie*val (though I, and many others, insist on pronouncing it "try"... suck it etymology), a trie is a key-value store represented as an n-ary tree, except that unlike a typical key-value store, no one node stores the key itself.  Instead, the **path** to the value within the tree is defined by the characters/bits/what-have-you that define the key itself.  Yeah, that's pretty abstract, why don't we just look at an example:

{% digraph Trie %}
size="5,5";
root [shape="circle"];

a1 [label="", shape="circle"];
l1 [label="", shape="circle"];
l2 [label="", shape="circle"];
o [label="", shape="circle"];
t [label="", shape="circle"];
e [label="", shape="circle"];
n1 [label="", shape="circle"];
b [label="", shape="circle"];
a2 [label="", shape="circle"];

allow [shape="circle"];
alloy [shape="circle"];
alter [shape="circle"];
ant [shape="circle"];
bad [shape="circle"];
bar [shape="circle"];

root -> a1 [label=" a"];
a1 -> l1 [label=" l"];
l1 -> l2 [label=" l"];
l2 -> o [label=" o"];
o -> allow [label=" w"];
o -> alloy [label=" y"];

l1 -> t [label=" t"];
t -> e [label=" e"];
e -> alter [label=" r"];

a1 -> n1 [label=" n"];
n1 -> ant [label=" t"];

root -> b [label=" b"];
b -> a2 [label=" a"];
a2 -> bad [label=" d"];
a2 -> bar [label=" r"];
{% enddigraph %}

In this construction I've chosen the following set of keys:

* allow
* alter
* alloy
* ant
* bad
* bar

As you can see, each character in the key is used to label an edge in the tree, while the nodes store the values associated with that key (note, in this example I've chosen to use the keys as values as well... this entirely artificial, and a bit confusing.  Just remember, those values could be absolutely anything.)  [^1]  Typically these keys are strings, as depicted here, although it's entirely possible to build a bit-wise trie that can be keyed off of arbitrary strings of bits.  To find the value for a key, you take each character and, starting with the root node, transition through the graph until the target node is found.  Or, as pseudo-code:

    find(root_node, key):
      current_node = root_node
      current_key = key
   
      while (current_key.length > 0):
        character = current_key[0]
   
         if current_node.has_edge_for(character):
           current_node = current_node.get_get_for(character).endpoint
         else
           throw "ERMAGERD"
   
       return current_node.value

Strangely, a very similar algorithm can be used for both inserts and deletes.

## Some Interesting Properties

The trie offers a number of interesting advantages over traditional key-value stores such as hash tables and binary search trees:

1. As mentioned previously, they have the peculiar feature that inserts, deletes, and lookups use very similar codepaths, and thus have very similar performance characteristics.  As such, in applications where these operations are performed with equal frequency, the trie can provide better overall performance than other more traditional key-value stores.
2. Lookup performance is a factor of key length as opposed to key distribution or dataset size.  As such, for lookups they often outperform both hash tables and BSTs.
3. They are quite space efficient for short keys, as key prefixes are shared between edges, resulting in compression of the graph.
4. They enable longest-prefix matching.  Given a candidate key, a trie can be used to perform a closest fit search with the same performance as an exact search.
5. Pre-order traversal of the graph generates an ordered list of the keys (in fact, this implementation is a form of radix sort).
6. Unlike hashes, there's no need to design a hash function, and collisions can only occur if identical keys are inserted multiple times.

## Applications

Because tries are well-suited to fuzzy matching algorithms, they often see use in spell checking implementations or other areas involving fuzzy matching against a dictionary.  In addition, the trie forms the core of Radix/PATRICIA and Suffix Trees, both of which are interesting enough to warrant separate posts of their own.  Stay tuned!

## References

* [Trie](http://en.wikipedia.org/wiki/Trie)
* [http://www.allisons.org/ll/AlgDS/Tree/Trie/](http://www.allisons.org/ll/AlgDS/Tree/Trie/)
* [http://xlinux.nist.gov/dads//HTML/trie.html](http://xlinux.nist.gov/dads//HTML/trie.html)

[^1]: Interestingly, if you looked at this example graph, you'd be forgiven for assuming it was an illustration of a finite state machine, with the characters in the key triggering transitions to deeper levels of the graph.

