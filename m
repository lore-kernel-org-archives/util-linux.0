Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:47079 "EHLO
	resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752595AbaJCOhQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Oct 2014 10:37:16 -0400
Date: Fri, 3 Oct 2014 10:29:04 -0400
Message-Id: <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Francis Moreau <francis.moro@gmail.com>
CC: util-linux@vger.kernel.org
In-reply-to: <542E7000.3040309@gmail.com> (francis.moro@gmail.com)
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Francis Moreau <francis.moro@gmail.com>
> 
> I have a disk image file which is using GPT and embeds 2 partitions.
> 
> I'm setting up a loop device with:
> 
>  $ losetup -P -f disk.img
> 
> and expect the partition devices (loop0p[12] for example) to be
> automatically created.

I tried to reproduce this problem myself (on Fedora 19 with a
3.14.17-100.fc19.x86_64 kernel).

I created a disk image file and used gdisk to install two partitions
on it, then detached the file from the loopback device.

The first time I re-attached it, /dev/loop0p{1,2} were created, as
expected.  The only message that shows up in /var/log/messages is:

    Oct  3 10:20:03 hobgoblin kernel: [560334.624034]  loop0: p1 p2

Then I detached the loopback device, re-attached it, and this time,
the partition devices were *not* created, and /var/log/messages did
not have the "loop0: p1 p2" message.

Given that the message starts "kernel:", I suspect that the udev
behavior is triggered by the kernel detecting the partition table, and
that is not happening.  So it looks like it's a kernel bug.

Dale
