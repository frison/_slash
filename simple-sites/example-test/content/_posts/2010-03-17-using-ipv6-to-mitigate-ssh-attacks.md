---
layout: article
title: Using IPv6 to mitigate SSH attacks
author: Brett Kosinski
date: 2010-03-17 02:00:00 -0700
category: [ ipv6, hacking ]
no_fediverse: true
---

So, one of the ongoing issues that anyone with a public-facing server has to deal with is a barrage of SSH login attempts.  Now, normally this isn't a problem, as a decent sysadmin will use fairly strong passwords (or disable password-based logins entirely), disable root logins, and so forth.  But it's certainly an irritant, and so it's worth implementing something to mitigate the issue.

Now, traditionally, there are a few general approaches people take:

1. Use iptables or something similar to throttle inbound ssh connection attempts.
2. Coupled with the previous, implement tarpitting (this slows down ssh responses, which means the attacker wastes resources on your server).
3. Implement something like [fail2ban](http://www.fail2ban.org/) to automatically detect attacks and dynamically add them to a set of block rules (managed with something like iptables).
4. Move SSH to a non-standard port.

All of these work reasonably well, and particularly for the lazy, something like fail2ban on Ubuntu is dead easy to deploy and works quite nicely.  Of course, there's always the chance that you lock yourself out if you fail at a few login attempts, so it's not without it's risks.

But I recently discovered a fifth option which, at least at this stage of IPv6 growth, works incredibly well:  disable inbound SSH over IPv4.  See, most attackers aren't v6 connected.  Meanwhile, acquiring v6 connectivity remotely is usually just a matter of running a Teredo tunneling client.  The result is perfectly workable remote accessibility, while the number of SSH attacks is cut down to essentially zero.

Of course, this won't last forever.  In the future, v6 is likely to get deployed more widely, and I suspect I'll start seeing v6-based ssh attacks.  But until then, this solution is dead simple to deploy and works great!

**Update:**

And naturally, just a day after I finish writing this, I decided to fiddle around with NX for remotely accessing this server, and lo and behold, NX doesn't support IPv6. :)  So, I'm back to using fail2ban, until NX can get their act together (though, to be fair, latency over my v6 tunnel has an unfortunate negative impact on NX performance, and so I'm not sure I'd use v6 even if I could).

