Return-Path: dave@gnu.org
Subject: Re: [PATCH] mount: use common libs
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110914144539.GA1829@nb.net.home>
References: <1315926455.3703.2.camel@offbook>
	 <20110914144539.GA1829@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 14:06:28 -0300
Message-ID: <1316019988.2605.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-09-14 at 16:45 +0200, Karel Zak wrote:
> On Tue, Sep 13, 2011 at 12:07:35PM -0300, Davidlohr Bueso wrote:
> > --- a/mount/devname.c
> > +++ b/mount/devname.c
> > @@ -2,6 +2,7 @@
> >  
> >  #include "devname.h"
> >  #include "sundries.h"		/* for xstrdup */
> > +#include "xalloc.h"
> 
>  It would be better to include xalloc.h in sunders.h only.
> 
> > -static void
> > -die_if_null(void *t) {
> > -	if (t == NULL)
> > -		die(EX_SYSERR, _("not enough memory"));
>             ^^^^^^^^
> > -}

The reason I kept this silly function was because gcc complains about
freeing const char * variables, which is quite correct. What do you
think about un consitifying them and getting rid of die_if_null()?

-Davidlohr

> 
>  it means that you have to use:
> 
>  #define XALLOC_EXIT_CODE   EX_SYSERR
>  #include "xalloc.h"
> 
>  to keep it backwardly compatible.
> 
>     Karel
> 
