Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdGCMH4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 08:07:56 -0400
Date: Mon, 3 Jul 2017 14:07:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: fputs() vs puts()
Message-ID: <20170703120752.25fkjobw6dxgqo2w@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <20170629201231.vjxp6mkecuqoalfo@ws.net.home>
 <1d036b95-430d-839f-031c-31b80e6e2b4f@gmx.com>
 <201707031030.22137.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201707031030.22137.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 10:30:21AM +0200, Ruediger Meier wrote:
> On Friday 30 June 2017, J William Piggott wrote:
> > On 06/29/2017 04:12 PM, Karel Zak wrote:
> > > On Thu, Jun 29, 2017 at 10:46:50AM -0400, J William Piggott wrote:
> > >>>    (William, can you update your "standardize USAGE_COLUMNS"
> > >>> patches? Please.)
> > >>
> > >> Sure, one clarification please: you want only the columns header
> > >> in all caps? So:
> > >>
> > >> Usage:
> > >> Options:
> > >> Functions:
> > >> Commands:
> > >> COLUMNS:
> > >
> > > ha.. that's a good question. Suggestions?
> > >
> > > For example coreutils project uses uppercase for keywords only, for
> > > example dd(1)
> > >
> > >     Each FLAG symbol may be:
> > >        ...
> > >     Each CONV symbol may be:
> > >        ...
> > >
> > > it seems like original Rudi's idea
> > >
> > >     Available COLUMNS:
> >
> > But they also use:
> > of=FILE
> > conv=CONVS
> >
> > So we cannot completely follow that paradigm. The above are not
> > option args, and you do not want option args in all caps.
> >
> > The columns situation is unique, we don't have to play follow the
> > leader.
> >
> > Comparing:
> >
> >         --output <list>    COLUMNS to display (see below)
> >         ...
> >         Available COLUMNS:

For me it looks better (including esthetical point of view ;-)

But wait with it...

> > With:
> >         --output <list>    columns to display (see Columns:)
> >         ...
> >         Columns:
> >
> >
> > What does the reader learn by yelling COLUMNS at them.
>
> It's just de-facto standard for "--help/man"-like technical 
> documentation. If you would write html or info docs, then you would not 
> use capital letters but links to click on.
> 
> Compare:
> 
> $ man bash | grep -i EXPANSION
> $ man bash | grep  EXPANSION
> 
> or
> 
> $ xz --help | grep -i FILE
> $ xz --help | grep FILE 
> 
> It's a very useful style and users *use* this by case-sensitive search 
> in less or grep. This style is not always used 100% consistently but 
> I'm happy whenever I see it, saves me a lot of time usually.

 Maybe it would be possible to convince me that coreutils way for
 options arguments is the right way :-))
 
 I mean:

   --output COLUMNS      
   --length SIZE
   --net[=FILE]

 ...etc. The question is how to compose the option string to minimize
 duplication and inform about a format, for example

   --output COLUMNS    list of columns to display (see below)

  
 Note that on many places we for example for SIZE accept suffixes
 (MiB, GiB...) but this info is nowhere in the --help output.

 And note that I like the William's idea with the explicit reader
 redirection "(see below)".

 Maybe Rudy is right and it's time to think about it for this release
 if we already decided to cleanup usage().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
