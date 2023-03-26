---
layout: article
title:  "Privacy Inequality"
summary: "The idea of privacy as a modern form of inequality has been rattling around in my head for a while, now, and I wanted to jot down some thoughts, particularly in light of the recent rise of Mastodon."
author: Brett Kosinski
date:   2022-12-26 13:14:31 -0700
category: [ technology, politics, OwnYourData, SelfHosting ]
---
Typically, when people talk about inequality, they are focused on the obvious forms of socioeconomic inequality that result in advantages being conferred to some groups and withheld from others.  The most obvious example is economic inequality--the recognition that economic benefits accrue primarily to the wealthy.  But there's a wide range of other forms of inequality out there, most of which are incredibly old and are structural in nature.  For example, zoning laws frequently allow polluting industries to be built up next to minority communities, resulting in increasing [environmental inequality](https://www.nature.com/articles/d41586-022-01283-0).  Jobs occupied by those lower on the economic ladder are more likely to be subject to [unsafe workplaces](https://www.epi.org/unequalpower/publications/death-by-inequality-how-workers-lack-of-power-harms-their-health-and-safety/), resulting in health inequality.  And these same communities are the least likely to have the political and economic power to change these circumstances, an example of political inequality.

In the world of software and technology, we've seen the rise of [surveillance capitalism](https://en.wikipedia.org/wiki/Surveillance_capitalism), defined as the "widespread collection and commodification of personal data by corporations."  In this new world, individuals are, either unknowingly or voluntarily, subject to vast data collection operations which scoop up, collect, and connect these datasets.  These datasets are then fed into systems designed to derive additional data about individuals--data about their economical and political interests, personal relationships, consumption patterns, and so forth.

Today, these massive apparatus are then used to deliver hyper-targeted messages intended to influence purchasing decisions, voting decisions, and so forth (though just how effective these techniques are is the subject of significant debate).

However, the uses of these data are vast, and they'll soon be used (and in some cases are already being used) to influence things like hiring decisions, insurances rates, loan approvals, and so forth.  The result is that one poor choice, one incorrectly interpreted data point, one broken or biased algorithm, could result in individuals being denied access to critical social and economic infrastructure.

Until and unless governments catch up, these trends will only continue.  That means individuals have to protect themselves.

Unfortunately, protecting ones privacy requires knowledge, skills, and resources that are often the domain of a select few.  As a result, privacy itself is increasingly becoming a mark of privilege.

<!-- more -->

----

# The privilege of privacy

Data collection and monetization is an industry as old as modern marketing.  For example, credit reporting agencies like Experian have been collecting and monetizing consumer data for decades, having been involved in things like early direct mail advertising campaigns.

Unfortunately, the internet has supercharged this industry, and in response I've taken a wide range of steps to preserve my own privacy.

For years I've run a great deal of my own infrastructure, allowing me to retain control over my own data.  For those services I can't run or do not want to run, I've chosen privacy-preserving alternatives.  I've deployed various privacy-preserving tools to help protect me online.  And I've simply opted out of many online services, choosing to live without their benefits. 

But having the awareness, resources, and skills to make these choices puts me, and other folks like me in the tech industry, in a uniquely privileged position.

Operating ones own infrastructure requires a great deal of investment.  You first have to develop the knowledge and skills to operate that infrastructure.  Second, you need economic resources to buy necessary equipment, to pay for a suitable broadband connection, and so forth.  Finally, and most importantly, you need *time*.  Self-hosting as a practice is incredibly rewarding, but those services require installation, maintenance, and upgrades, and all of that requires a non-trivial amount of effort.

All of these things--learned expertise, and availability resources and time--are symptoms of privilege.

So what about choosing privacy-protecting alternatives for common services?  Well, that too requires expertise, first to be able to evaluate alternatives and pick something suitable, while second being able to integrate those services into ones life.  These types of services also often rely on subscriptions in lieu of subsidizing operations via data collection and monetization.

While the expertise, resources, and time required to use these services are less than those required for self-hosting, the barrier is still high enough to be deterring.

And this assumes privacy-protecting alternatives exist; an assumption that, in the current world of massive tech monopolies, is increasingly unlikely.

So what about privacy protecting tools like ad blockers, VPNs, features like Firefox containers, and so forth?  Fortunately, for the most basic protections--ad blocking and so forth--solutions are typically just a couple of clicks away, assuming you know enough to use them.  However, for anything even moderately advanced, users once again must have a non-trivial level of technology sophistication.

Lastly, one can always opt out.  Unfortunately, as technology has eaten the world, it's increasingly difficult to avoid surveillance capitalism ecosystems.  People have become used to services like Facebook, Instagram, Whatsapp, Twitter, and others, as a means of socializing and communicating.  Expecting people to opt out of these services, or to switch to more difficult-to-use alternatives, is entirely unreasonable, particularly where [network effects](https://en.wikipedia.org/wiki/Network_effect) reinforce platform dominance.  And even if a user does consciously opt out, data collection often happens without our ever being aware of it.

# Awareness asymmetry

In many industries, one of the greatest weapons of inequality is the inequality of knowledge, or what economists would call [information asymmetry](https://en.wikipedia.org/wiki/Information_asymmetry).  Information asymmetry creates in "an imbalance of power in transactions, which can sometimes cause the transactions to be inefficient, causing market failure in the worst case".

For example, a person who does not have knowledge of cars may be taken advantage of by an unscrupulous mechanic.  An investment advisor might direct a client to a suboptimal product whose sale results in some type of financial kickback.  Someone unfamiliar with the legal system might plea out on a charge because they don't understand all of their options.

Surveillance capitalism thrives on information asymmetry.  First, users may not be aware that their data is being collected and monetized, and therefore may not realize they need to protect themselves.  Second, even in those cases where users consent to data collection, they may not understand what they are consenting to.

Finally, and I think most importantly, people do not understand the long-term consequences of giving up their privacy for short-term economic benefit, thanks to the opacity of the systems in which this data is exploited.  I suspect many would be appalled by the idea that, say, a Tweet during their twenties might result in their insurance premiums being increased in their thirties.  But the reality is many have no idea that is a world we're careening toward.

The result is a basic asymmetry of awareness, where only the privileged few realize that privacy is something to be protected in the first place, let alone how to go about protecting themselves.

# What do we do?

First and foremost, it is critical that governments step up and pass laws that dramatically curtail surveillance capitalism.  Just as governments must regulate polluting industries, they must also regulate data collection and monetization.

The EU has long led the way with regulations like GDPR, which establishes new individual rights of data protection, ownership, and control, while also limiting how data may be collected and used, and mandating transparency within the ecosystem.  That's not to say GDPR is flawless, but it is critical that other governments in the world follow the EU's lead.

Second, we in the software world need to make it far easier for individuals to protect their own privacy.  Tools like ad blockers have been a great success, but widening the availability and ease of use of things like Firefox containers and so forth, is critical.

Third, we need to make it much easier for users to leverage privacy-protecting services that replace common infrastructure.  Self-hosting does not need to be as difficult as it is today.  Managed services like Wordpress and [Wallabag](https://www.wallabag.it/en) prove that inexpensive, easy-to-use, managed infrastructure is possible.  Of course, not everyone will want to go this route, but for those who do, we need to make it as easy as possible.

Fourth, as a community we need to build on successes like the recent rise of Mastodon to offer people easy-to-use, privacy-preserving alternatives to common services; alternatives that are not subsidized by surveillance capitalism.

Finally, and most importantly, each of us with the skills and expertise needs to educate our friends, family, colleagues, and the world at large about the importance of privacy protection; both how individuals can protect their own privacy, and how critically important it is that we vote for candidates that will pass those regulations that will ensure that privacy is not just a privilege reserved for the wealthy.

Otherwise, I fear we'll soon find ourselves in a world that's given rise to a de facto, privately controlled [social credit system](https://en.wikipedia.org/wiki/Social_Credit_System) that only those with privilege will be able to avoid.

[^1]: Though in a company that has worked hard to build tools and infrastructure that protect individual privacy rather than exploiting it.
