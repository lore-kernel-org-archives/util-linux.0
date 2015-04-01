Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63540 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbDAVHL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 17:07:11 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Date: Wed, 1 Apr 2015 22:06:52 +0100
Cc: util-linux@vger.kernel.org, Isaac Dunham <ibid.ag@gmail.com>
References: <201504011342.56546.sweet_f_a@gmx.de> <201504011817.48428.sweet_f_a@gmx.de> <20150401201051.GP25224@vapier>
In-Reply-To: <20150401201051.GP25224@vapier>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201504012306.52737.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 01 April 2015, Mike Frysinger wrote:
> On 01 Apr 2015 18:17, Ruediger Meier wrote:
> > On Wednesday 01 April 2015, Isaac Dunham wrote:
> > > On Wed, Apr 01, 2015 at 01:42:56PM +0200, Ruediger Meier wrote:
> > > > I wonder about some hardcoded binary paths.
> > > >
> > > > Example swapon.c:
> > > >
> > > > #define PATH_MKSWAP    "/sbin/mkswap"
> > > >
> > > > There are a two problems.
> > > > 1. It's wrong. We should use $sbindir from configure.
> > > > 2. When called from our test-suite it will use a wrong (or
> > > >    non-existend, broken) binary. This happens in test
> > > > swapon/fixpgsz.
> > > >
> > > > The question is how to fix this.
> > > >
> > > > I would prefer to use "mkwsap" from the same directory like
> > > > swapon or to simply execvp "mkswap" from PATH. But don't know
> > > > if we want this. If we really want to keep a hardcoded sbindir
> > > > then we would need "#ifdef TEST_PROGRAM".
> > > >
> > > > Any comments?
> > >
> > > The approach that seems obvious to me (assuming you want to keep
> > > the hardcoded path) is:
> > > -add -DSBINDIR="$sbindir" to CFLAGS
> >
> > Yes, this would be easy. But my preferred logic would be like this
> >
> > If "swapon" was called from PATH then just take mkswap from PATH
> > too. If "/whatever/path/swapon" was called then look for mkswap in
> > the same path.
> >
> > Maybe both cases also with or without fallback $sbindir, /sbin or
> > $PATH.
> >
> > I guess we should agree how somthing like this should be handeled
> > in general. "eject" is also using hardcoded "/bin/umount".
>
> seems like $PATH should always be used.  if you broke $PATH, well
> that's your fualt ... tools shouldn't generally be expected to work
> in the fact of hostile environments like this.
> -mike

I'd also like to use PATH (at least as fallback).

The only special thing here is IMO that mkswap and swapon belong to the 
same project. Should we try to use the right one per default?

Example:
UL is installed below /usr/local
PATH="/usr/local/sbin:/sbin"

Explicitly invoking the (old) globally installed /sbin/swapon should use 
the old /sbin/mkswap too or the new /usr/local/sbin/mkswap from PATH? 

Another point:
If "/sbin" is not in PATH should "sudo /sbin/swapon" find /sbin/mkswap 
or not?

cu,
Rudi




