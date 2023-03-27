---
layout: article
title: Fun with Puppeteer
author: Brett Kosinski
date: 2018-01-01 02:00:00 -0700
category: [ personalarchiving ]
no_fediverse: true
---

In the past web scraping involved a lot of offline scripting and parsing of HTML, either through a library or, for quick and dirty work, manual string transformations.  The work was always painful, and as the web has become more dynamic, this offline approach has gone from painful to essentially impossible... you simply cannot scrape the contents of a website without a Javascript engine and a DOM implementation.

The next generation of web scraping came in the form of tools like Selenium.  Selenium uses a scripting language, along with a browser-side driver, to automate browser interactions.  The primary use case for this particular stack is actually web testing, but it allows scraping by taking advantage of a full browser to load dynamic content.  This allows you to simulate human interactions with the site, enabling scraping of even the most dynamic sites out there.

Then came [PhantomJS](http://phantomjs.org/).  PhantomJS took browser automation to the next level by wrapping a headless browser engine in a Javascript API.  Using Javascript, you could then instantiate a browser, load a site, and interact with the page using standard DOM APIs.  No longer did you need a secondary scripting language or a browser driver... in fact, you didn't even need a GUI!  Again, one of the primary use cases for this kind of technology is testing, but site automation in general, and scraping in particular, are excellent use cases for Phantom.

And then the Chrome guys came along and gave us [Puppeteer](https://github.com/GoogleChrome/puppeteer).

Puppeteer is essentially PhantomJS but using the Chromium browser engine, delivered as an npm you can run atop node.  Current benchmarks indicate Puppeteer is faster and uses less memory while using a more up-to-date browser engine.

You might wonder why I started playing with Puppeteer.

Well, it turns out Google Groups is sitting on a pretty extensive archive of old Usenet posts, some of which I've written, all of which date back to as early as '94.  I wanted to archive those posts for myself, but discovered Groups provides no mechanism or API for pulling bulk content from their archive.

For shame!

Fortunately, Puppeteer made this a pretty easy nut to crack, such that it was just challenging enough to be fun, but easy enough to be done in a day.  And thus I had the perfect one-day project during my holiday!  The resulting script is roughly 100 lines of Javascript that is mostly reliable (unless Groups takes an unusually long time loading some of its content):

```javascript
const puppeteer = require('puppeteer')
const fs = require('fs')

async function run() {
  var browser = await puppeteer.launch({ headless: true });

  async function processPage(url) {
    const page = await browser.newPage();

    await page.goto(url);
    await page.addScriptTag({url: 'https://code.jquery.com/jquery-3.2.1.min.js'});
    await page.waitForFunction('$(".F0XO1GC-nb-Y").find("[dir=\'ltr\']").length > 0');
    await page.waitForFunction('$(".F0XO1GC-nb-Y").find("._username").text().length > 0');

    await page.exposeFunction('escape', async () => {
      page.keyboard.press('Escape');
    });

    await page.exposeFunction('log', async (message) => {
      console.log(message);
    });

    var messages = await page.evaluate(async () => {
      function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
      }

      var res = []

      await sleep(5000);

      var messages = $(".F0XO1GC-nb-Y");
      var texts = messages.find("[dir='ltr']").filter("div");

      for (let msg of messages.get()) {
        // Open the message menu
        $(msg).find(".F0XO1GC-k-b").first().click();

        await sleep(100);

        // Find the link button
        $(":contains('Link')").filter("span").click();

        await sleep(100);

        // Grab the URL
        var msgurl = $(".F0XO1GC-Cc-b").filter("input").val().replace(
          "https://groups.google.com/d/", 
          "https://groups.google.com/forum/message/raw?"
        ).replace("msg/", "msg=");

        await sleep(100);

        // Now close the thing
        window.escape();       

        var text;

        await $.get(msgurl, (data) => text = data);

        res.push({
          'username': $(msg).find("._username").text(),
          'date': $(msg).find(".F0XO1GC-nb-Q").text(),
          'url': msgurl,
          'message': text
        });

        window.log("Message: " + res.length);
      };

      return JSON.stringify({
        'group': $(".F0XO1GC-mb-x").find("a").first().text(),
        'count': res.length,
        'subject': $(".F0XO1GC-mb-Y").text(),
        'messages': res
      }, null, 4);
    });

    await page.close();

    return messages;
  }

  for (let url of urls) {
    var parts = url.split("/");
    var id = parts[parts.length - 1];

    console.log("Loading URL: " + url);

    fs.writeFile("messages/" + id + ".json", await processPage(url), function(err) {
      if (err) {
        return console.log(err);
      }

      console.log("Done");
    });
  }

  browser.close();
}

run()
```

The interactions, here, are actually fairly complex.  Each Google Groups message has a drop-down menu that you can use to get a link to the message itself.  Some minor transformations to that URL then get you a link to the raw message contents.  So this script loads the URL containing the thread, and then one-by-one, opens the menu, activates the popup to get the link, performs an Ajax call to get the message content, then scrapes out some relevant metadata and adds the result to a collection.  The collection is then serialized out to JSON.

It works remarkably well for a complete hack job!
