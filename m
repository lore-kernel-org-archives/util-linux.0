Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:40606 "EHLO
	resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaJFPrD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Oct 2014 11:47:03 -0400
Date: Mon, 6 Oct 2014 11:47:00 -0400
Message-Id: <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Francis Moreau <francis.moro@gmail.com>
CC: util-linux@vger.kernel.org
In-reply-to: <54304C03.6020309@gmail.com> (francis.moro@gmail.com)
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com> <542F065C.2080505@gmail.com> <54304C03.6020309@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Francis Moreau <francis.moro@gmail.com>

> Ok, so IMHO I think that losetup(8) should issue its own
> ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
> since it can fail silently. This way it can check the return value of
> ioctl() and moght choose to do it again in case the return value is -EBUSY.
> 
> Or indicates in the man page that the -P can fail silently.

It's not clear to me why the kernel would be expected to check itself
for partitions in this manner.  If losetup does not get the -P option,
it seems like the kernel should not check.

In any case, it seems like a good idea to make sure that either the
kernel does things reliably, or losetup ensures that it happens
reliably.

Dale
