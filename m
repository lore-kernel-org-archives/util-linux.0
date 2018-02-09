Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751058AbeBIMfR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Feb 2018 07:35:17 -0500
Date: Fri, 9 Feb 2018 13:35:10 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: cal(1) summary
Message-ID: <20180209123510.4i7hsuxi67pbzmj5@ws.net.home>
References: <20180130153954.yi3p2muaw5k6t5rt@ws.net.home>
 <7511ce85-1b8d-7296-7053-82641305f98d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7511ce85-1b8d-7296-7053-82641305f98d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:03:22PM -0500, J William Piggott wrote:
> 
> 
> On 01/30/2018 10:39 AM, Karel Zak wrote:
> > 
> > Maybe we need to summarize all ongoing issues, regressions, and
> > features etc. I'm a little bit losing in all the changes ;-)
> 
> There's plenty more in the queue. Try these for example:
> cal 1969-12-31
> cal --months 36 --span
> 
> > I have also fixed some things and updated regression tests.
> > 
> > * -y header
> >     - not sure if we need a change here to use "Month Year" in all
> >       cases (???)
> 
> IMO, keeping the year header is choosing aesthetics over usefulness. I
> see no basis for breaking the output format for a very narrow set of
> conditions: 12 months from January. Not for 13 months, which includes
> the same amount of repetition. Not for 11 months, not when starting with

We're talking about situation when you explicitly ask for --year. In
this case it really does not make sense to have "Month YYYY". I don't
think we need a change here.

> > * -1
> >     - has to behave like cal with no option (FIXED)
> 
> I don't understand what this means. What was broken and how did you fix
> it?

We had talked about it, yflag has been enabled in same cases:

./cal -1 2018
                               2018

       January
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31

fixed by commit 37bd991f774f8cd10a70b44f6818484c77607f8b.

> > * -3|-1|-n<N> <year>   default month issue
> >     - let's use the current month if year specified (seems FIXED)
> 
> I don't see any basis for expecting 'cal -n6 1752' to imply the current
> system month. If a specific month is desired, it only takes two
> additional key strokes.

Think about it as about additional feature. You can ask for month 

    cal -n6 Jan 1752

and without "Jan" for the current month. Simple way how to support two
use-cases.

> > * add --calendar-system-header on|off (default *OFF*)
> 
> IMO, this is needed information.

It really should not be printed by default. The calendar system makes
sense for old dates only. The cal(1) support UK reform for pretty long
time and it seems people are fine without the header.

I have nothing against the header, but it should not be printed by
default.

> How about this default behavior: Gregorian is assumed and the header is
> only displayed for Julian or Mixed?

We was fine without the header in last 30 years, I think we can live
without it (by default) in next years too :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
