Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425404AbcBRO2l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 09:28:41 -0500
Date: Thu, 18 Feb 2016 15:28:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/15] include: provide MAP_ANONYMOUS on OSX
Message-ID: <20160218142840.byj7vceugyirolea@ws.net.home>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
 <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
 <20160218132130.i3egpqw3lv7i653w@ws.net.home>
 <201602181510.19403.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602181510.19403.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 18, 2016 at 03:10:19PM +0100, Ruediger Meier wrote:
> On Thursday 18 February 2016, Karel Zak wrote:
> > On Thu, Feb 18, 2016 at 02:12:47PM +0100, Ruediger Meier wrote:
> > > +#if defined __APPLE__
> > > +# define _DARWIN_C_SOURCE
> > > +#endif
> > > +
> 
> This one is needed before including sys/mman.h. Don't know whether it 
> would be better to define _DARWIN_C_SOURCE globally in compiler 
> commandline (via configure for systems where it's needed)!?

config.h is always included before anything else, so if
_DARWIN_C_SOURCE has no any side effect then it seems like a good
solution. For example we use config.h to define _GNU_SOURCE etc.
(see AC_USE_SYSTEM_EXTENSIONS aitoconf macro).

> > >  #include <stdio.h>
> > >  #include <stdarg.h>
> > >  #include <stdint.h>
> > > @@ -62,6 +66,10 @@
> > >  #define XALLOC_EXIT_CODE FSCK_EX_ERROR
> > >  #include "xalloc.h"
> > >
> > > +#if !defined MAP_ANONYMOUS && defined MAP_ANON
> > > +# define MAP_ANONYMOUS  (MAP_ANON)
> > > +#endif
> >
> > What about to move this to include/c.h where we already have some
> > portability ifdefs?
> 
> Would be nice to hide MAP_ANONYMOUS definition to include/c.h. But as 
> long as _DARWIN_C_SOURCE will not be globally defined we would also 
> need to include sys/mman.h there, right?
> 
> BTW here is how "dateutils" does it. Using a macro CHECK_MAP_ANON to get 
> defines MAP_ANON_NEEDS_DARWIN_SOURCE and MAP_ANON_NEEDS_ALL_SOURCE
> https://github.com/hroptatyr/dateutils/blob/master/m4/sxe-mmap.m4
> https://github.com/hroptatyr/dateutils/blob/master/src/prchunk.c

seems also as possible way

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
