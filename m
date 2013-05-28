Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933785Ab3E1Ntd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 May 2013 09:49:33 -0400
Date: Tue, 28 May 2013 15:49:25 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0000] pull: cal the branch four
Message-ID: <20130528134925.GC30341@x2.net.home>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
 <51A2533B.9060905@bernhard-voelker.de>
 <CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 26, 2013 at 07:55:55PM +0100, Sami Kerola wrote:
> On 26 May 2013 19:23, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> > On 05/26/2013 11:14 AM, Sami Kerola wrote:
> >> The cal branch I have in my git has got fixes to issues reviewed earlier,
> >> and I hope all works.  Based on that I decided to get rid of upper cal
> >> year limit, 9999, and replace it with unsigned long.  I know the change
> >> does not make much practical sense, the point of the change is that where
> >> there is no need to have artificial limits to a random magic number they
> >> should not exist.
> >
> > unsigned years ... hmm, not that this would work today, but what about BC
> > years? E.g. on what weekday did Julius Caesar die (March 15th, 44 BC, [1])?
> > Maybe a future improvement (... having to make years signed again)?
> >
> > [1] http://en.wikipedia.org/wiki/Julius_Caesar
> 
> Hi Berny,
> 
> You are right. I'll make the year to be signed, and make error to be
> displayed, for now, if negative year is defined.
> 
> BTW I tried the Tøndering's algorithm negative years and it gave odd
> and obviously wrong results. If someone who is part of this list is
> interested of mathematical puzzles making the negative year weekday
> determination to work should be interesting challenge.

 If I good remember from "my previous life" than for example
 PostgreSQL uses Julian calendar for unlimited datetime calculations.

 See  https://github.com/postgres/postgres/blob/master/src/backend/utils/adt/datetime.c

 and date2j(), j2date() and j2day() functions. Anyway, I have no clue
 if the calculations are correct (in regards to reformation 1752).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
