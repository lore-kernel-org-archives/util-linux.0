Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbbDAViN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 17:38:13 -0400
Date: Wed, 1 Apr 2015 23:38:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150401213800.GB2097@ws.net.home>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504012306.52737.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 01, 2015 at 10:06:52PM +0100, Ruediger Meier wrote:
> > > If "swapon" was called from PATH then just take mkswap from PATH
> > > too. If "/whatever/path/swapon" was called then look for mkswap in
> > > the same path.

It seems like over-engineering. The primary goal are regular
installations, the stuff in the test/ should not be a reason to change
important things in the utils. 

> > > Maybe both cases also with or without fallback $sbindir, /sbin or
> > > $PATH.
> > >
> > > I guess we should agree how somthing like this should be handeled
> > > in general. "eject" is also using hardcoded "/bin/umount".
> >
> > seems like $PATH should always be used.  if you broke $PATH, well

Yes, agree.
 
Note that we already have and use FS_SEARCH_PATH in mkfs, fsck and
mount (libmount), see --enable-fs-paths-default and  --enable-fs-paths-extra.

Maybe we can use it use FS_SEARCH_PATH also for mkswap in swapon, or use it
as fallback.

> The only special thing here is IMO that mkswap and swapon belong to the 
> same project. Should we try to use the right one per default?
> 
> Example:
> UL is installed below /usr/local
> PATH="/usr/local/sbin:/sbin"
> 
> Explicitly invoking the (old) globally installed /sbin/swapon should use 
> the old /sbin/mkswap too or the new /usr/local/sbin/mkswap from PATH? 

I'd like to avoid complex and not obvious semantic. It's fine to
follow PATH or harcoded FS_SEARCH_PATH.

> Another point:
> If "/sbin" is not in PATH should "sudo /sbin/swapon" find /sbin/mkswap 
> or not?

Is it really our problem? I don't think we have to provide solutions
for all crazy scenarios...

Note that for critical things (for example things important for system
boot, etc.) there should be always hardcoded fallback.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
