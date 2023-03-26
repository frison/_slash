---
layout: article
title:  "Handwired Alpha - Some basic keyboard theory"
author: Brett Kosinski
date:   2019-01-26 20:12:11 -0700
category: [ keyboards, alpha ]
no_fediverse: true
---

A keyboard is a surprisingly simple little device.  The basic operation is as follows:

1. The switches are wired together into a matrix of rows and columns.
2. The controller sends a signal down each column (or row).
3. The controller then checks for a return signal down each row (or column).
4. This information determines which key(s) have been pressed.
5. The controller then sends the keycode to the host machine.

Simple!

So, to construct a keyboard, one must:

1. Solder the switches into a matrix of rows and columns.
2. Solder the matrix to the controller.
3. Program the firmware of the controller so it understands the key matrix.
4. Then stuff everything into a case, grab a beer, and call it a day!

The only slightly tricky bit is the matrix itself.

For reasons that are very nicely explained by [this write-up](https://www.dribin.org/dave/keyboard/one_html/), each switch must be attached to a single diode that ensures that current can only cross the switch in one direction.  This arrangement ensures that multiple keys pressed together don't result in the matrix being misinterpreted by the controller.

The typical arrangement is to introduce a diode which allows current to flow from the column to the row, although either arrangement is workable so long as all diodes are arranged the same way.

The open source community has neatly solved the challenged of keyboard firmware.  So long as the controller makes use of a supported Arduino chipset, the open source [QMK firmware](http://qmk.fm) is an incredibly capable solution.  To make use of QMK, you simply configure it to understand the key matrix layout, and the associated GPIO pin assignments on the controller.  That information is enough to allow QMK to power the keyboard!

