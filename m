Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: fputs() vs puts()
Date: Mon, 3 Jul 2017 14:38:33 +0200
Cc: J William Piggott <elseifthen@gmx.com>,
 util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com> <201707031030.22137.sweet_f_a@gmx.de> <20170703120752.25fkjobw6dxgqo2w@ws.net.home>
In-Reply-To: <20170703120752.25fkjobw6dxgqo2w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201707031438.33652.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 03 July 2017, Karel Zak wrote:
> On Mon, Jul 03, 2017 at 10:30:21AM +0200, Ruediger Meier wrote:
> > On Friday 30 June 2017, J William Piggott wrote:
> > > On 06/29/2017 04:12 PM, Karel Zak wrote:
> > > > On Thu, Jun 29, 2017 at 10:46:50AM -0400, J William Piggott wrote:
> > > >>>    (William, can you update your "standardize USAGE_COLUMNS"
> > > >>> patches? Please.)
> > > >>
> > > >> Sure, one clarification please: you want only the columns
> > > >> header in all caps? So:
> > > >>
> > > >> Usage:
> > > >> Options:
> > > >> Functions:
> > > >> Commands:
> > > >> COLUMNS:
> > > >
> > > > ha.. that's a good question. Suggestions?
> > > >
> > > > For example coreutils project uses uppercase for keywords only,
> > > > for example dd(1)
> > > >
> > > >     Each FLAG symbol may be:
> > > >        ...
> > > >     Each CONV symbol may be:
> > > >        ...
> > > >
> > > > it seems like original Rudi's idea
> > > >
> > > >     Available COLUMNS:
> > >
> > > But they also use:
> > > of=FILE
> > > conv=CONVS
> > >
> > > So we cannot completely follow that paradigm. The above are not
> > > option args, and you do not want option args in all caps.
> > >
> > > The columns situation is unique, we don't have to play follow the
> > > leader.
> > >
> > > Comparing:
> > >
> > >         --output <list>    COLUMNS to display (see below)
> > >         ...
> > >         Available COLUMNS:
>
> For me it looks better (including esthetical point of view ;-)
>
> But wait with it...
>
> > > With:
> > >         --output <list>    columns to display (see Columns:)
> > >         ...
> > >         Columns:
> > >
> > >
> > > What does the reader learn by yelling COLUMNS at them.
> >
> > It's just de-facto standard for "--help/man"-like technical
> > documentation. If you would write html or info docs, then you would
> > not use capital letters but links to click on.
> >
> > Compare:
> >
> > $ man bash | grep -i EXPANSION
> > $ man bash | grep  EXPANSION
> >
> > or
> >
> > $ xz --help | grep -i FILE
> > $ xz --help | grep FILE
> >
> > It's a very useful style and users *use* this by case-sensitive
> > search in less or grep. This style is not always used 100%
> > consistently but I'm happy whenever I see it, saves me a lot of
> > time usually.
>
>  Maybe it would be possible to convince me that coreutils way for
>  options arguments is the right way :-))
>
>  I mean:
>
>    --output COLUMNS
>    --length SIZE
>    --net[=FILE]
>
>  ...etc. The question is how to compose the option string to minimize
>  duplication and inform about a format, for example
>
>    --output COLUMNS    list of columns to display (see below)
>
>
>  Note that on many places we for example for SIZE accept suffixes
>  (MiB, GiB...) but this info is nowhere in the --help output.

Coreutils is using some of these capitalized words really as
system-wide keywords. For example SIZE:

  The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
  Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

BTW this is my only coreutils patch to make the size description
human understandable and let it fit into two 80 char columns. ;)

There was a big discussion about this here in bug#9939
https://lists.gnu.org/archive/html/bug-coreutils/2011-11/threads.html#00002


>  And note that I like the William's idea with the explicit reader
>  redirection "(see below)".

Yep, IMO the "see below" is good *always* if the overall text is a bit
longer. In case there are only a few lines or if obvious (like FILE), it
*may* be skipped, I would say.

>  Maybe Rudy is right and it's time to think about it for this release
>  if we already decided to cleanup usage().
>
>     Karel
