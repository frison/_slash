---
layout: post
title:  "Welcome to Madness!"
date:   2023-02-20 23:39:52 -0500
categories: jekyll update
---
Here you'll find an code sample demonstrating to generate all permutations of the alphabet in ruby:

{% highlight ruby %}
def permutations(string)
  return [string] if string.length <= 1
  perms = permutations(string[1..-1])
  new_perms = []
  perms.each do |perm|
    (0..perm.length).each do |i|
      new_perms << perm.dup.insert(i, string[0])
    end
  end
  new_perms
end
{% endhighlight %}


{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
