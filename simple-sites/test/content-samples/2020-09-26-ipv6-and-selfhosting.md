---
layout: article
title:  "IPv6 and self-hosting"
summary: "A little post about how I've used IPv6 and a dual-stack VPS to address common networking issues when hosting services at home."
author: Brett Kosinski
date:   2020-10-11 16:17:13 -0600
category: [ ipv6, selfhosting ]
syndicate_to: [ twitter ]
no_fediverse: true
---

Many of the non-critical services I run--messaging, RSS, home automation--run on an Intel NUC I've hidden away at home.  This has advantages over a VPS in that if I need additional resources, I can just add some memory or storage rather than having to move to a new service tier and paying that much more every month.  Plus, given how much I'm working and using these services at home, having them hosted locally means higher perceived performance due to lower latency.

Unfortunately, connectivity for services hosted on a residential broadband connection is always a pain in the butt.  While over the years my residential broadband connection has been incredibly stable, I still face the challenge of changing IP addresses.  And yes, I can set up dynamic DNS, but I've always found it relatively fragile (not to mention an enormous hack).  Additionally, you have to contend with ISPs potentially blocking ports and so forth.  And finally there's all the issues with NAT, reverse port mappings, internal and external DNS record management, and on and on.  Basically it's painful and brittle.

On what might seem like an unrelated note, IPv6 is still gradually getting deployed.  Certainly mobile networks use v6 extensively, but outside that space adoption is still pretty nascent.  As a result, it's always been a bit questionable if deploying v6 at home is worth the trouble (minus the novelty and bragging rights).

But it turns out that, with a VPS and an IPv6 tunnel, you can dramatically simplify the process of hosting services on a residential broadband connection.  As a result, this has proven to be the "killer app" that has driven me to truly adopt v6 at home.

<!-- more -->

# Basic setup

The process starts with setting up IPv6 connectivity at home.  As most people don't have native IPv6 access at home, that typically means setting up an IPv6-over-IPv4 tunnel using a provider like [Hurricane Electric](https://www.tunnelbroker.net)[^1].  In effect, a (free!) service like HE allows you to set up a kind of bridge that attaches your home network to the IPv6-enabled internet.  Conceptually it looks something like this:

{% digraph IPv6-1 %}
rankdir = "LR"
graph [ bgcolor = "transparent" ]
node [ margin = 0.2, shape = "box" ]

subgraph cluster_world {
  gateway [ label = "IPv6 Gateway" ]
  client [ label = "IPv6 Client" ]

  client -> gateway

  label = "IPv6 Internet"
  margin = 20
}

subgraph cluster_home {
  router [ label = "Home Firewall" ]
  server [ label = "Server" ]

  router -> server

  label = "IPv6 Home Network"
  margin = 20
}

gateway -> router [ dir = "both", label = "v6 over v4\n", color = "currentColor:currentColor" ]

{% enddigraph %}

This does require your home router to support IPv6 tunnels, but that feature is increasingly common these days.

With this setup, every device within your home will receive a publicly routed IPv6 address.  As a result, to set up access to those internal services, you just need to set up rules in your firewall to enable traffic to pass.

The final step is to get yourself a domain and set up AAAA DNS records for those services so that you can get access to them easily by name.

And with that you should be self-hosting IPv6-connected services!  In general this means you should have access to those services from any mobile device, as well as some more modern ISPs.

Edit:  There is one thing I missed, here, which is how to deal with DHCP-assigned IPv4 addresses on the residential side, which is, of course, the entire point here.  The Hurricane Electric tunnel setup requires the IP address of the origination point of the tunnel for the purpose of whitelisting.  But if your IPv4 address changes, that would require a manual update of the tunnel configuration.

Fortunately, HE offers [an endpoint](https://forums.he.net/index.php?topic=1994.0) you can use to automatically update the endpoint.  You can use this along with a script to update the tunnel configuration when your DHCP address is assigned.

For the astute readers, yes, this bears a lot of resemblance to updating dynamic DNS records.  However, with this method you don't have to worry about DNS recording caching and so forth.

# IPv4 connectivity

Obviously the one big problem with using IPv6 for self-hosting services is the lack of ubiquitous v6 connectivity.  For example, when I was working in the office--in the before time, the long long ago--we lacked IPv6 connectivity and so those services would be inaccessible to me.

To solve this, I set up a dual-stack (i.e. both IPv4 and IPv6) VPS hosted on the public internet that serves as a public v4-v6 gateway for my services[^2].  For my purpose I'm using a [linode](https://www.linode.com) instance.

On that server I installed Apache and set it up as a reverse proxy.  Then, for each service I want to access I:

1. Set up an A record that points to the v4 gateway.
2. Configure Apache to reverse proxy traffic.  Because the v4 gateway is v6-capable, this just means redirecting traffic to the public DNS record, knowing that it'll resolve the AAAA record and send the traffic to the right place.

Visually this looks like this:

{% digraph IPv6-2 %}
rankdir = "LR"
graph [ bgcolor = "transparent" ]
node [ margin = 0.2, shape = "box" ]

subgraph cluster_world_v4 {
  v4gateway [ label = "Apache Proxy" ]
  v4client [ label = "IPv4 Client" ]

  v4client -> v4gateway

  label = "IPv4 Internet"
  margin = 20
}

subgraph cluster_world {
  gateway [ label = "IPv6 Gateway" ]
  client [ label = "IPv6 Client" ]

  client -> gateway

  label = "IPv6 Internet"
  margin = 20
}

subgraph cluster_home {
  router [ label = "Home Firewall" ]
  server [ label = "Server" ]

  router -> server

  label = "IPv6 Home Network"
  margin = 20
}

v4gateway -> gateway

gateway -> router [ dir = "both", label = "v6 over v4\n", color = "currentColor:currentColor" ]

{% enddigraph %}

Once you've got this set up, you should have full IPv4 and IPv6 connectivity to those services without any monkeying around with dynamic DNS or being frustrated by IP address changes, NAT/port mapping shenanigans, and so forth.

# Let's Encrypt TLS enablement

First off, to be clear, setting up home services with TLS and some form of authentication is critical.  Self-hosting services means you're owning all the security consequences.  And unless you can afford to run a DMZ at home, those consequences may impact the rest of the devices on your network.

In my case, that means:

1. All inbound traffic goes to a single proxy server.  That server currently doubles as an SSH jump box, and runs a local Apache reverse proxy that directs traffic to those internal services.  No other services run on this node.
2. The firewall is configured to allow externally originating traffic to pass *only* to the proxy server, and only for ports running services I'm intending to expose to the world.
3. All services are TLS encrypted.
4. All services are protected using HTTP basic auth using strong passwords.
5. Services that support it are also configured with their own application level authentication.
6. Fail2ban is used on the proxy node to block repeated login attempt failures.
7. All services are running on Debian stable and patched up.

In the not-so-recent past, TLS would have been the sticking point, here, due to the cost of getting a certificate issued.  Fortunately, these days, TLS enablement is free thanks to [Let's Encrypt](https://letsencrypt.org) and the EFF `certbot` project.  However, using `certbot` in this configuration gets a little tricky.

First off, it's important to understand that, in this configuration, we have two web servers, the home proxy and the VPS proxy.  That means we need to have TLS enabled on both of those servers, as they are each individually terminating TLS-enabled communications with clients.[^3]  And that means we need certificates issued on both servers.

To understand why this causes trouble, it's important to understand how `certbot` works.  To validate that you have control over your domain, the tool publishes some data in the `.well-known` directory on your web server.  The Let's Encrypt service then validates those files before proceeding with certificate issuance.

The problem is, in this circumstance, the TLS endpoint differs depending on whether you're connecting over IPv4 or IPv6!  Remember, we have an A record and an AAAA record for the same domain pointing to *different* places.  But if we're going to run `certbot` on both servers, for the same domain, how do we ensure accesses to the `.well-known` directory go to the right server without manual steps?

My solution to this is... well, a bit hacky[^4].

On the VPS I set up Apache to *not* proxy the `.well-known` directory.  This ensures that runs of `certbot` on the VPS will result in the local files being served up.[^5]

Then, at the home proxy, I have any accesses to the `.well-known` directory reverse proxied *back out to the VPS*.

{% digraph IPv6-2 %}
rankdir = "LR"
graph [ bgcolor = "transparent" ]
node [ margin = 0.2, shape = "box" ]

subgraph cluster_world_v4 {
  v4gateway [ label = "Apache Proxy" ]
  v4client [ label = "IPv4 Client" ]

  v4client -> v4gateway

  label = "IPv4 Internet"
  margin = 20
}

subgraph cluster_world {
  gateway [ label = "IPv6 Gateway" ]
  client [ label = "Let's Encrypt" ]

  client -> gateway [ label = ".well-known/*" ]

  label = "IPv6 Internet"
  margin = 20
}

subgraph cluster_home {
  router [ label = "Home Firewall" ]
  proxy [ label = "Apache Proxy" ]
  server [ label = "Server" ]

  router -> proxy
  proxy -> server

  label = "IPv6 Home Network"
  margin = 20
}

v4gateway -> gateway

gateway -> router [ dir = "both", label = "v6 over v4\n", color = "currentColor:currentColor" ]

proxy -> v4gateway [ label = ".well-known/*" ]

{% enddigraph %}

This all means that when running `certbot` on the VPS, the following happens:

1. `certbot` drops the files in the `.well-known` directory on the VPS.
2. Let's Encrypt tries to access those files using IPv6.
3. The request goes to my *home* proxy thanks to the published AAAA record.
4. The home proxy reverse proxies the request back to the VPS where the files are served up.
5. Certificate issuance completes.

Okay, great!

But, what about when I need to run `certbot` on the home proxy to issue certificates for IPv6 clients?  Without changes, this breaks, because the files in the `.well-known` directory will be served up from the VPS instead of the local proxy.

Well, `certbot` supports the idea of "hooks".  Hooks are scripts that are run at various stages of the certificate renewal process.  So, on my home proxy, I've set up the following `pre` script:

```sh
#!/bin/bash

# Normally we redirect any accesses to the ".well-known" directory to the VPS
# so that certificate renewals work there.
#
# But when doing a local renewal, we need to temporarily disable those directs
# and then re-enable afterward.

(cd /etc/apache2/sites-enabled; perl -pi -e "s/ProxyPass/#ProxyPass/" *.ca.conf)
systemctl restart apache2
```
This disables reverse proxying of the `.well-known` directory when the renewal kicks off, ensuring that any files placed there by `certbot` running on the proxy are served up locally.

Later, in a `deploy` hook we reverse the changes.

# Summing up

While on its face, this setup looks a bit complex, in practice it's a lot more simple and stable compared to a traditional setup using dynamic DNS and NAT port forwarding.  The use of an IPv6 tunnel effectively creates a stable path for accessing services hosted within the home.  A public IPv4-to-IPv6 gateway ensures that v4 clients also have a stable endpoint they can hit.

Meanwhile, network access is governed with simple firewall rules--no port forwarding required!  Apache reverse proxying then provides a single point of contact that can be used to introduce authentication, control access with fail2ban, and so forth.

I've been using this setup for about a year now and I'm extremely happy with it!  And it's all thanks to Hurricane Electric and IPv6.

[^1]: To be honest, even if my ISP provided native IPv6, I'd probably still use a tunnel service like Hurricane Electric.  As v6 is rolled out, ISPs seem to be handing out /64's with periodically rotating prefixes for no clear reason beyond naked profiteering.  Hurricane Electric, by contrast, allocates fixed /64 or /48 prefixes with no shenanigans.
[^2]: So why not just use this VPS to run my services?  Well, first off, a proxy doesn't require a lot of resources, so I can run it on the lowest tier configuration linode offers.  Second, again, running on my own gear offers a lot more flexibility in terms of expandability and so forth.  Finally, for some of those services, I want to be able to access them directly over my high speed home network (e.g. motionEye for security cameras).
[^3]: This also means that, on the VPS proxy, we need Apache configured with `SSLProxyEngine on`.
[^4]: And depends on the fact that Let's Encrypt is IPv6-enabled and therefore attempts IPv6 connections first.
[^5]: You also need to run `certbot` using the `--webroot` configuration setting so that it drops the files wherever the proxy will serve them up.
