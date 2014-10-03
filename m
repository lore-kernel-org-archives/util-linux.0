Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:53740 "EHLO
	resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbaJCT6e (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Oct 2014 15:58:34 -0400
Date: Fri, 3 Oct 2014 15:58:29 -0400
Message-Id: <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: francis.moro@gmail.com, util-linux@vger.kernel.org
In-reply-to: <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
	(worley@alum.mit.edu)
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: worley@alum.mit.edu (Dale R. Worley)

> Then I detached the loopback device, re-attached it, and this time,
> the partition devices were *not* created, and /var/log/messages did
> not have the "loop0: p1 p2" message.
> 
> Given that the message starts "kernel:", I suspect that the udev
> behavior is triggered by the kernel detecting the partition table, and
> that is not happening.  So it looks like it's a kernel bug.

I tried that again, after updating to kernel 3.14.19-100.fc19.x86_64,
and it worked this time.

Dale
