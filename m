Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52514 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbbDAQRv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 12:17:51 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Date: Wed, 1 Apr 2015 18:17:48 +0200
References: <201504011342.56546.sweet_f_a@gmx.de> <20150401133842.GA1800@newbook>
In-Reply-To: <20150401133842.GA1800@newbook>
Cc: Isaac Dunham <ibid.ag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504011817.48428.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 01 April 2015, Isaac Dunham wrote:
> On Wed, Apr 01, 2015 at 01:42:56PM +0200, Ruediger Meier wrote:
> > Hi,
> >
> > I wonder about some hardcoded binary paths.
> >
> > Example swapon.c:
> >
> > #define PATH_MKSWAP    "/sbin/mkswap"
> >
> > There are a two problems.
> > 1. It's wrong. We should use $sbindir from configure.
> > 2. When called from our test-suite it will use a wrong (or
> >    non-existend, broken) binary. This happens in test
> > swapon/fixpgsz.
> >
> > The question is how to fix this.
> >
> > I would prefer to use "mkwsap" from the same directory like swapon
> > or to simply execvp "mkswap" from PATH. But don't know if we want
> > this. If we really want to keep a hardcoded sbindir then we would
> > need "#ifdef TEST_PROGRAM".
> >
> > Any comments?
>
> The approach that seems obvious to me (assuming you want to keep the
> hardcoded path) is:
> -add -DSBINDIR="$sbindir" to CFLAGS

Yes, this would be easy. But my preferred logic would be like this

If "swapon" was called from PATH then just take mkswap from PATH too.
If "/whatever/path/swapon" was called then look for mkswap in the same 
path.

Maybe both cases also with or without fallback $sbindir, /sbin or $PATH.

I guess we should agree how somthing like this should be handeled in 
general. "eject" is also using hardcoded "/bin/umount". 

> -in the testsuite, run tests in a private mount namespace, where you
> can bind-mount $sbindir.
>
> However, I'm guessing this would have to be done with a union mount,
> and there are probably problems like what to do if sbindir is
> non-existent down to / (eg, sbindir=/util-linux/rootcommmands on a
> standard Linux) -- creating a union mount over / may be a Bad Thing.

Ah interesting, somthing like this would be nice to run all the tests 
for a real installtion!

Instead of "union mount over /" you could do it over a bind mount of /.
Then "make install DESTDIR=/mnt/union_mount/" and 
chroot /mnt/union_mount/ to run the tests there.

But usually I run the tests on virtual machines anyway where a 
real "make install" is possible. Just our test-suite would need the 
feature to use the installed binarys only. Should be simple to add.

cu,
Rudi
