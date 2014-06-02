Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbaFBJIn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 05:08:43 -0400
Date: Mon, 2 Jun 2014 11:08:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Csaba Kos <csaba.kos@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] deadlock in script
Message-ID: <20140602090840.GL9000@x2.net.home>
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com>
 <20140530091503.GE9000@x2.net.home>
 <CADhtO=8Kj763OzRRSFgOXcD+h1QUeRn7uJXqCms0TBY8=RWEBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADhtO=8Kj763OzRRSFgOXcD+h1QUeRn7uJXqCms0TBY8=RWEBA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 30, 2014 at 06:52:20PM +0900, Csaba Kos wrote:
> On Fri, May 30, 2014 at 6:15 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
> >> diff --git a/term-utils/script.c b/term-utils/script.c
> >> index e5d239c..32906d0 100644
> >> --- a/term-utils/script.c
> >> +++ b/term-utils/script.c
> >> @@ -36,6 +36,9 @@
> >>   * - added Native Language Support
> >>   *
> >>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added "q"-option
> >> + *
> >> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
> >> + * - fixed a rare deadlock after child termination
> >>   */
> >>
> >>  /*
> >> @@ -114,6 +117,8 @@ int       tflg = 0;
> >>  int  forceflg = 0;
> >>  int  isterm;
> >>
> >> +sigset_t block_mask, unblock_mask;
> >
> >  This declaration shadows declaration in main() where is also block_mask and
> >  unblock_mask -- I guess it's not expected.
> 
> Sorry, I goofed when updating my patch to the current master. Thanks
> for the careful review! Updated patch attached.

 All applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
