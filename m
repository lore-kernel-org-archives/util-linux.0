Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] deadlock in script
Date: Mon, 2 Jun 2014 11:37:59 +0200
Cc: Csaba Kos <csaba.kos@gmail.com>, util-linux@vger.kernel.org
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com> <CADhtO=8Kj763OzRRSFgOXcD+h1QUeRn7uJXqCms0TBY8=RWEBA@mail.gmail.com> <20140602090840.GL9000@x2.net.home>
In-Reply-To: <20140602090840.GL9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406021138.00417.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Karel Zak wrote:
> On Fri, May 30, 2014 at 06:52:20PM +0900, Csaba Kos wrote:
> > On Fri, May 30, 2014 at 6:15 PM, Karel Zak <kzak@redhat.com> wrote:
> > > On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
> > >> diff --git a/term-utils/script.c b/term-utils/script.c
> > >> index e5d239c..32906d0 100644
> > >> --- a/term-utils/script.c
> > >> +++ b/term-utils/script.c
> > >> @@ -36,6 +36,9 @@
> > >>   * - added Native Language Support
> > >>   *
> > >>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added
> > >> "q"-option + *
> > >> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
> > >> + * - fixed a rare deadlock after child termination
> > >>   */
> > >>
> > >>  /*
> > >> @@ -114,6 +117,8 @@ int       tflg = 0;
> > >>  int  forceflg = 0;
> > >>  int  isterm;
> > >>
> > >> +sigset_t block_mask, unblock_mask;
> > >
> > >  This declaration shadows declaration in main() where is also
> > > block_mask and unblock_mask -- I guess it's not expected.
> >
> > Sorry, I goofed when updating my patch to the current master.
> > Thanks for the careful review! Updated patch attached.
>
>  All applied, thanks!
>
>     Karel

Could this already fix the TODO in
tests/ts/script/race (6cae66ea)?:

# TODO see comments about script design
# https://github.com/karelzak/util-linux/pull/62
TS_KNOWN_FAIL="yes"


cu,
Rudi
