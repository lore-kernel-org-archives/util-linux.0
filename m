Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56731 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752391AbdFUOzm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 10:55:42 -0400
Date: Wed, 21 Jun 2017 16:55:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] hwclock: update --help content and grammar
Message-ID: <20170621145537.5kwvb3zws26awlye@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <bf8f26c6-c0d8-2190-38ed-456dfe0fe58a@gmx.com>
 <20170620085143.cu5dpcobcr3t254m@ws.net.home>
 <201706211505.04914.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706211505.04914.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 21, 2017 at 03:05:04PM +0200, Ruediger Meier wrote:
> On Tuesday 20 June 2017, Karel Zak wrote:
> > On Sun, Jun 18, 2017 at 08:45:09PM -0400, J William Piggott wrote:
> > > Signed-off-by: J William Piggott <elseifthen@gmx.com>
> > > ---
> > >  include/c.h         |  4 ++--
> > >  sys-utils/hwclock.c | 48
> > > +++++++++++++++++++++--------------------------- 2 files changed,
> > > 23 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/include/c.h b/include/c.h
> > > index 9c19965..bd073fc 100644
> > > --- a/include/c.h
> > > +++ b/include/c.h
> > > @@ -319,8 +319,8 @@ static inline int xusleep(useconds_t usec)
> > >  #define USAGE_OPTIONS    _("\nOptions:\n")
> > >  #define USAGE_FUNCTIONS  _("\nFunctions:\n")
> > >  #define USAGE_SEPARATOR    "\n"
> > > -#define USAGE_HELP       _(" -h, --help     display this help and
> > > exit\n") -#define USAGE_VERSION    _(" -V, --version  output
> > > version information and exit\n") +#define USAGE_HELP       _(" -h,
> > > --help     display this information and exit\n")
> >
> >  "display this help and exit\n"
> > or
> >  "display help information and exit\n"
> >
> > sounds better than "this information".
> 
> IMO "this" is important because it makes clear that running --help would 
> not give you any better information than the one you see already.
> 
> Compare this:
> $ xz --help | grep help
>   -h, --help        display this short help and exit
>   -H, --long-help   display the long help (lists also the ...
> 
> $ xz --long-help | grep help
>   -h, --help        display the short help (lists only the basic ...
>   -H, --long-help   display this long help and exit
> 
> 
> Our old errtryhelp, USAGE_HELP and USAGE_VERSION were 100% the same like 
> coreutils. This was a nice consensus and even a bit shorter.
> 
> Anyways, instead of improving the grammer and correctness I would rather 
> make these trivial option descriptions as short as possible, like
> 
>  -h, --help     display this help
>  -V, --version  show version
> 
> Everybody knows what these options do when they exist.

Good points, please, send a patch. It would be also nice to add any
comment to the c.h to avoid future updates on this area.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
