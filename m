Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:51021 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbcCQRS7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 13:18:59 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Benno Schulenberg <bensberg@justemail.net>
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 18:18:52 +0100
Cc: "Util-Linux" <util-linux@vger.kernel.org>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com> <201603171350.44094.sweet_f_a@gmx.de> <1458233386.879328.552147938.0BC34E2C@webmail.messagingengine.com>
In-Reply-To: <1458233386.879328.552147938.0BC34E2C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603171818.52599.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Benno Schulenberg wrote:
> On Thu, Mar 17, 2016, at 13:50, Ruediger Meier wrote:
> > I have some guesses about "ipcs" and "fallocate" but some more
> > questions:
> >
> > 1. Which kernel version?
>
> 2.6.32

Hehe my guess was right.

I've noticed already 2 years ago on Debian 6 that our scanf code in 
ipc_shm_get_info() is not compatible to this kernel version. (2.6.34 
worked AFAIR.)

Could you show us
$ cat /proc/sysvipc/shm

Maybe it's easy to fix.

Generally I think we should make a statement about "what is the minimum 
kernel version" for util-linux. Two years ago I decided for myself that 
I should fix bugs for newer kernels first. On the other hand 2.6.32 
would have been worth to support because it was officially maintained 
from 2009 until last month!

> > 2. Which file system? (findmnt -n -o FSTYPE -T tests/output)
>
> ext3

ext3 is not supported but the system call should return an error and the 
test should look like this:
   misc: fallocate ... SKIPPED ('ext3' not supported)

I guess the kernel syscall does not return error thus our fallocate 
succeed but the file is empty. It's a kernel bug we can't fix. Or 
should we add a stat() call to validate the syscall?

> > 3. Is /proc mounted?
>
> $ ./findmnt -n -t proc
> /proc  none   proc   rw,nosuid,nodev,noexec,relatime
>
> > 4  grep "FALL" config.h
>
> #define HAVE_FALLOCATE 1
> #define HAVE_LINUX_FALLOC_H 1
>
> Benno


