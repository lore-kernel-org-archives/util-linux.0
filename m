Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbaFBJ5a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 05:57:30 -0400
Date: Mon, 2 Jun 2014 11:57:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Csaba Kos <csaba.kos@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] deadlock in script
Message-ID: <20140602095723.GO9000@x2.net.home>
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com>
 <CADhtO=8Kj763OzRRSFgOXcD+h1QUeRn7uJXqCms0TBY8=RWEBA@mail.gmail.com>
 <20140602090840.GL9000@x2.net.home>
 <201406021138.00417.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406021138.00417.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 02, 2014 at 11:37:59AM +0200, Ruediger Meier wrote:
> On Monday 02 June 2014, Karel Zak wrote:
> > On Fri, May 30, 2014 at 06:52:20PM +0900, Csaba Kos wrote:
> > > On Fri, May 30, 2014 at 6:15 PM, Karel Zak <kzak@redhat.com> wrote:
> > > > On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
> > > >> diff --git a/term-utils/script.c b/term-utils/script.c
> > > >> index e5d239c..32906d0 100644
> > > >> --- a/term-utils/script.c
> > > >> +++ b/term-utils/script.c
> > > >> @@ -36,6 +36,9 @@
> > > >>   * - added Native Language Support
> > > >>   *
> > > >>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added
> > > >> "q"-option + *
> > > >> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
> > > >> + * - fixed a rare deadlock after child termination
> > > >>   */
> > > >>
> > > >>  /*
> > > >> @@ -114,6 +117,8 @@ int       tflg = 0;
> > > >>  int  forceflg = 0;
> > > >>  int  isterm;
> > > >>
> > > >> +sigset_t block_mask, unblock_mask;
> > > >
> > > >  This declaration shadows declaration in main() where is also
> > > > block_mask and unblock_mask -- I guess it's not expected.
> > >
> > > Sorry, I goofed when updating my patch to the current master.
> > > Thanks for the careful review! Updated patch attached.
> >
> >  All applied, thanks!
> >
> >     Karel
> 
> Could this already fix the TODO in
> tests/ts/script/race (6cae66ea)?:

 That's a good question, maybe, try it :-)

 Locally I don't see any issue (although the test takes a lot of time
 due to count=1000, I'm still curious if we really need so many
 iterations in the test).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
