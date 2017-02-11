Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdBKQtp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 11 Feb 2017 11:49:45 -0500
Subject: Re: [PATCH 0/3] hwclock: remove date(1)
To: kerolasa@gmail.com
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <3499d175-981d-3d73-c530-ddfcaf81eea6@gmx.com>
Date: Sat, 11 Feb 2017 11:49:29 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/11/2017 06:24 AM, Sami Kerola wrote:
> On 10 February 2017 at 20:58, J William Piggott <elseifthen@gmx.com> wrote:
>> This branch adds the parse_datetime module from the gnu
>> portability library.
> 
> Assuming gnulib integration is wanted then replacing bootstrap process,
> deduplicating pieces of code in include/ with gnulib versions would be in
> todo list.  For example why one would keep util-linux xmalloc() when gnulib
> provides the same.  Same is true for close_stdout(), and many other
> functions.

Yes, I agree. For example your recent timegm() is covered and I'm sure
many others.

Considering the number of projects using it, and presumably a large base
of contributors, the solutions may be more complete then util-linux's
roll-your-own portability solutions?

There are a number of gnulib modules I see for possible use in hwclock,
like clock-time for example (which is already available to it with this
patch set).

> 
> While code reuse is good idea I have doubts if this really is direction
> where to go to.  It feels like gnulib integration is a big change, and easy
> only when done incomplete or inadequate way.  Choosing the former is a bit
> risky - I assume it is really difficult to know how much coding resource
> will stick around doing the needed, how long it might take when reviews and
> testing is included to a timeline.
> 
> Poor intergration has it's obvious problems.  Duplication of 'same' code,
> leading to confusion which code paths are used where.  This can result bugs
> that are easy to miss, e.g., end up being part of releases. 

It seems to me all of these are good reasons to introduce gnulib slowly
and incrementally.  To expose only a little of the project at a time,
then if something bad happens it's not so catastrophic. As a first step
only adding it only to the hwclock stanza should give a level of
isolation to the rest of the project. Then as time permits it can slowly
be expanded until full integration is achieved.

With each incremental step time can taken to carefully check what should
be replaced and removed.

> If the
> integration is kept minimal then we might result in adding 25k lines of code
> to replace one exec() that has worked fairly OK for years.  That in inself
> feels awkward.

Keeping it minimal could be temporary. The idea would be continue to
implement more of gnulib as time allows.

If we want to settle for 'worked fairly OK' then there's no need to
refactor it. I think I'd rather see --date require a fixed format than
leave this insecure date(1) call there.

> 
> If asked would I be interested of gnulib challenge I would say yes, with a
> catch, there is only so few hours per week I have time for this so without a
> lot of people saying 'yes, lets do this' timeline getting integration
> completed becomes unacceptably long.
>

This is why incremental is the better way to go. If we make it all
or nothing. It will be nothing.


