---
date: 2023-01-31 11:15:44.434111365 -05:00
layout: note
title: How have I only just learned...
author: Brett Kosinski
category:
- programming
---
How have I only just learned of Hyrum's Law:

https://www.hyrumslaw.com/

> With a sufficient number of users of an API, it does not matter what you promise in the contract: all observable behaviors of your system will be depended on by somebody.

To wit: We had an internal API between two components. At one point, as part of a perf optimization, the ordering of the data changed. Well, the other component was relying on that ordering. Oops!