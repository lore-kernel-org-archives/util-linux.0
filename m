Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:54396 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbcBROKZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 09:10:25 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 07/15] include: provide MAP_ANONYMOUS on OSX
Date: Thu, 18 Feb 2016 15:10:19 +0100
Cc: util-linux@vger.kernel.org
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de> <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de> <20160218132130.i3egpqw3lv7i653w@ws.net.home>
In-Reply-To: <20160218132130.i3egpqw3lv7i653w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201602181510.19403.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 18 February 2016, Karel Zak wrote:
> On Thu, Feb 18, 2016 at 02:12:47PM +0100, Ruediger Meier wrote:
> > +#if defined __APPLE__
> > +# define _DARWIN_C_SOURCE
> > +#endif
> > +

This one is needed before including sys/mman.h. Don't know whether it 
would be better to define _DARWIN_C_SOURCE globally in compiler 
commandline (via configure for systems where it's needed)!?

> >  #include <stdio.h>
> >  #include <stdarg.h>
> >  #include <stdint.h>
> > @@ -62,6 +66,10 @@
> >  #define XALLOC_EXIT_CODE FSCK_EX_ERROR
> >  #include "xalloc.h"
> >
> > +#if !defined MAP_ANONYMOUS && defined MAP_ANON
> > +# define MAP_ANONYMOUS  (MAP_ANON)
> > +#endif
>
> What about to move this to include/c.h where we already have some
> portability ifdefs?

Would be nice to hide MAP_ANONYMOUS definition to include/c.h. But as 
long as _DARWIN_C_SOURCE will not be globally defined we would also 
need to include sys/mman.h there, right?

BTW here is how "dateutils" does it. Using a macro CHECK_MAP_ANON to get 
defines MAP_ANON_NEEDS_DARWIN_SOURCE and MAP_ANON_NEEDS_ALL_SOURCE
https://github.com/hroptatyr/dateutils/blob/master/m4/sxe-mmap.m4
https://github.com/hroptatyr/dateutils/blob/master/src/prchunk.c

cu,
Rudi
