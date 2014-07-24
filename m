Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f45.google.com ([209.85.192.45]:46786 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866AbaGXR0c (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 13:26:32 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so3651819qge.18
        for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 10:26:32 -0700 (PDT)
Date: Thu, 24 Jul 2014 13:26:27 -0400
From: Dave Reisner <d@falconindy.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix switch_root/pivot_root cut-n-paste error in
 configure.ac
Message-ID: <20140724172627.GC519@rampage>
References: <1406137142-15441-1-git-send-email-andreas@fatal.se>
 <20140724165226.GB519@rampage>
 <20140724171924.GA21736@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140724171924.GA21736@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 24, 2014 at 07:19:24PM +0200, Andreas Henriksson wrote:
> Hello Dave Reisner!
> 
> On Thu, Jul 24, 2014 at 12:52:26PM -0400, Dave Reisner wrote:
> > Is this really correct? Seems to me like the check should simply be
> > removed. In sys-utils/pivot_root.c, we have the following:
> > 
> >   #define pivot_root(new_root,put_old) syscall(SYS_pivot_root,new_root,put_old)
> > 
> > So, the subsequent check for the syscall seems like the only necessary
> > check needed. As is, I think that u-l now fails to build in places where
> > the pivot_root wrapper doesn't exist in the libc, but the syscall exists
> > (does such a platform even exist?).
> 
> I cought this when trying to build on Debian GNU/kFreeBSD (with incorrect
> configure flags for that platform) where the SYS_pivot_root check
> failed the build.
> Not knowing anything about non-linux architectures myself it was not obvious
> to me why this was.
> 
> Passing --disable-pivot_root fixed the build and it would be more
> obvious that this is the correct thing to do if it was pointed out that
> this is only expected to work on Linux.
> I consider the UL_REQUIRES_LINUX check as a more obvious
> way to point out this error so people like myself doesn't need to
> spend so much time scratching their heads over this.
> 
> From what I can tell, Linux is the only system offering this syscall anyway.
> Do you know of any non-linux system offering this?
> If not, then I think the check is still correct and helpful.

Ah, I wrongly assumed what UL_REQUIRES_LINUX does. Makes more sense
having now read the .m4 file, and I agree with your fix.

d
