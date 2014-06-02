Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] deadlock in script
Date: Mon, 2 Jun 2014 12:03:22 +0200
Cc: Csaba Kos <csaba.kos@gmail.com>, util-linux@vger.kernel.org
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com> <201406021138.00417.sweet_f_a@gmx.de> <20140602095723.GO9000@x2.net.home>
In-Reply-To: <20140602095723.GO9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406021203.22906.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Karel Zak wrote:
> On Mon, Jun 02, 2014 at 11:37:59AM +0200, Ruediger Meier wrote:
> > On Monday 02 June 2014, Karel Zak wrote:
> > > On Fri, May 30, 2014 at 06:52:20PM +0900, Csaba Kos wrote:
> > > > On Fri, May 30, 2014 at 6:15 PM, Karel Zak <kzak@redhat.com> wrote:
> > > > > On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
> > > > >> diff --git a/term-utils/script.c b/term-utils/script.c
> > > > >> index e5d239c..32906d0 100644
> > > > >> --- a/term-utils/script.c
> > > > >> +++ b/term-utils/script.c
> > > > >> @@ -36,6 +36,9 @@
> > > > >>   * - added Native Language Support
> > > > >>   *
> > > > >>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added
> > > > >> "q"-option + *
> > > > >> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
> > > > >> + * - fixed a rare deadlock after child termination
> > > > >>   */
> > > > >>
> > > > >>  /*
> > > > >> @@ -114,6 +117,8 @@ int       tflg = 0;
> > > > >>  int  forceflg = 0;
> > > > >>  int  isterm;
> > > > >>
> > > > >> +sigset_t block_mask, unblock_mask;
> > > > >
> > > > >  This declaration shadows declaration in main() where is also
> > > > > block_mask and unblock_mask -- I guess it's not expected.
> > > >
> > > > Sorry, I goofed when updating my patch to the current master.
> > > > Thanks for the careful review! Updated patch attached.
> > >
> > >  All applied, thanks!
> > >
> > >     Karel
> >
> > Could this already fix the TODO in
> > tests/ts/script/race (6cae66ea)?:
>
>  That's a good question, maybe, try it :-)
>
>  Locally I don't see any issue (although the test takes a lot of time
>  due to count=1000, I'm still curious if we really need so many
>  iterations in the test).
>

Hm, I could still catch one again:
--- tests/expected/script/race      2014-05-27 11:12:51.367615962 +0200
+++ tests/output/script/race  2014-06-02 11:34:54.509072271 +0200
@@ -1 +1 @@
-all bingos seen
+only 996 of 1000 bingos seen

Actually it seems to be easy to get it failed on NFS mount. But I've grepped
a lot of my other build logs and couldn't find any script failure within the
last weeks.

cu,
Rudi
