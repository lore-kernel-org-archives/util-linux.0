Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaGYIkG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 04:40:06 -0400
Date: Fri, 25 Jul 2014 10:39:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix switch_root/pivot_root cut-n-paste error in
 configure.ac
Message-ID: <20140725083959.GP26781@x2.net.home>
References: <1406137142-15441-1-git-send-email-andreas@fatal.se>
 <20140724165226.GB519@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140724165226.GB519@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 24, 2014 at 12:52:26PM -0400, Dave Reisner wrote:
> On Wed, Jul 23, 2014 at 07:39:02PM +0200, Andreas Henriksson wrote:
> > The "linux only" check for pivot_root seems to suffer from
> > a cut-n-paste problem from the earlier switch_root part.
> > 
> > Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> > ---
> >  configure.ac | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index db53dff..aae2456 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -1193,7 +1193,7 @@ AC_ARG_ENABLE([pivot_root],
> >    [], [UL_DEFAULT_ENABLE([pivot_root], [check])]
> >  )
> >  UL_BUILD_INIT([pivot_root])
> > -UL_REQUIRES_LINUX([switch_root])
> > +UL_REQUIRES_LINUX([pivot_root])
> 
> Is this really correct? Seems to me like the check should simply be
> removed. 

 It's definitely better to check that the system is Linux before you
 start to check for something more complicated. There is logical "and"
 between all UL_REQUIRES_*, so the first unsuccessful check disabled
 the rest.

> In sys-utils/pivot_root.c, we have the following:
> 
>   #define pivot_root(new_root,put_old) syscall(SYS_pivot_root,new_root,put_old)
> 
> So, the subsequent check for the syscall seems like the only necessary
> check needed. As is, I think that u-l now fails to build in places where
> the pivot_root wrapper doesn't exist in the libc, but the syscall exists
> (does such a platform even exist?).

 There is no glibc wrapper at all, in code we always call the syscall
 and in configure.ac we check for SYS_pivot_root sycall on Linux.
 Nowhere we care about libc.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
