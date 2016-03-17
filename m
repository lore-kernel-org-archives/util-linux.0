Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:50857 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932903AbcCQTse (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 15:48:34 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Benno Schulenberg <bensberg@justemail.net>
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 20:48:26 +0100
Cc: "Util-Linux" <util-linux@vger.kernel.org>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com> <201603171818.52599.sweet_f_a@gmx.de> <1458239000.908653.552257010.7074E741@webmail.messagingengine.com>
In-Reply-To: <1458239000.908653.552257010.7074E741@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603172048.26734.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Benno Schulenberg wrote:
> On Thu, Mar 17, 2016, at 18:18, Ruediger Meier wrote:
> > Could you show us
> > $ cat /proc/sysvipc/shm

>   key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime
>     0     131072  1600     393216  1409   921      2  1000  1000  1000  1000 1458201259          0 1458201259

Ok, nowadays we have just two more columns at the end: "rss" and "swap".
Could be fixed probably. We have also still fallback code for the old
syscall which is used if there is no /proc at all.

Actually it was on my imaginary TODO list to review all /proc scanf
code for robustness against future column additions.

>
> > Generally I think we should make a statement about "what is the
> > minimum kernel version" for util-linux.
>
> A statement.  And let the tests check the version and print
> a warning in case it's too old.

Actually a failed test is the best "warning" (based on facts rather
than parsed version numbers):
  FAILED == "Stop! something is wrong with ul and your system."

But IMO ok to give users a hint like "your kernel might be too old".
This warning could be repeated when there are failed tests.

On the other hand this reminds me about all these wrong >2.6 version
checks, and why uname26 was invented :)

> > Two years ago I decided for myself that
> > I should fix bugs for newer kernels first. On the other hand 2.6.32
> > would have been worth to support because it was officially
> > maintained from 2009 until last month!
>
> I'm not expecting you to fix things.  It's just nice to put
> things in a harsher environment and see how they hold up.  :)

> > I guess the kernel syscall does not return error thus our fallocate
> > succeed but the file is empty. It's a kernel bug we can't fix. Or
> > should we add a stat() call to validate the syscall?
>
> That sounds like a good idea: check, and double check.
>
> Benno


