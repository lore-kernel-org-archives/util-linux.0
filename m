Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:45987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbeBHSDk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Feb 2018 13:03:40 -0500
Subject: Re: cal(1) summary
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20180130153954.yi3p2muaw5k6t5rt@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7511ce85-1b8d-7296-7053-82641305f98d@gmx.com>
Date: Thu, 8 Feb 2018 13:03:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180130153954.yi3p2muaw5k6t5rt@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/30/2018 10:39 AM, Karel Zak wrote:
> 
> Maybe we need to summarize all ongoing issues, regressions, and
> features etc. I'm a little bit losing in all the changes ;-)

There's plenty more in the queue. Try these for example:
cal 1969-12-31
cal --months 36 --span

> I have also fixed some things and updated regression tests.
> 
> * -y header
>     - not sure if we need a change here to use "Month Year" in all
>       cases (???)

IMO, keeping the year header is choosing aesthetics over usefulness. I
see no basis for breaking the output format for a very narrow set of
conditions: 12 months from January. Not for 13 months, which includes
the same amount of repetition. Not for 11 months, not when starting with
any other month. Breaking the output format is unfriendly to machine and
human. Example, several full year outputs are being tabbed between;
there are no visual clues to distinguish between them, because the year
header has scrolled off the screen. Why it's machine hostile I think is
obvious.

The only argument in favor of a year header is to avoid repetition.
Anyone with such an affliction will have trouble with cal's output
anyway; repetition is inherent to the calendar systems being used. As a
purely rhetorical argument: the days of the the week are unnecessarily
repeated each month. Lets have a "Su Mo Tu We Th Fr Sa" top header too.
How about 1-28, the same every month. Argh, I can't stand this
repetition.  Sounds ridiculous; the year header sounds equally so to me.

This is a design choice made purely on aesthetics; something that is
prevalent in gui and web design. It would be refreshing to have some
place (the command line) to avoid such practice.

> * -1
>     - has to behave like cal with no option (FIXED)

I don't understand what this means. What was broken and how did you fix
it?
 
> * -3|-1|-n<N> <year>   default month issue
>     - let's use the current month if year specified (seems FIXED)

I don't see any basis for expecting 'cal -n6 1752' to imply the current
system month. If a specific month is desired, it only takes two
additional key strokes.

In the real world if an announcement said: 'bus ticket prices will
increase by one dollar in 2019'. January is implied. If it were to say:
'bus ticket prices have gone up one dollar. The current date is implied.
I think this is intuitive and expected behavior.

POSIX establishes this same concept. No date argument implies the
current date. A year date argument implies January.

Ironically, date(1) assumes the current month also; it seems to have a
habit of ignoring POSIX.

> 
> * add --calendar-system-header on|off (default *OFF*)

IMO, this is needed information. If date(1) were capable of using
multiple calendar systems (as POSIX requires), it would be imperative to
have some indication of which one was being shown. IMO, the same is true
for cal. The catalyst for this work was the redhat bug:

Bug 1518861 -
 Cal and Date do not correspond for dates before 14 September 1752

Had this header existed, and been on by default, the reason they
differed would have been obvious.

Putting the onus on the user to know which reform date is currently
selected, exactly what that date is, and which calendar system is used
before and after that date is unreasonable, IMO.

How about this default behavior: Gregorian is assumed and the header is
only displayed for Julian or Mixed?

> 
> * support another (non-UK) --reforms <name>
>     - let's postpone this until next release
> 
> * remove tailing extra blank like (reported by Mike year ago;-)
>     - FIXED
> 
> * extra blank space after last month column
>     - FIXED 
>     - for old versions see (cal -y  | sed 's/ /*/g')
> 
> * update regression tests
>     - FIXED
>     - (!) Please, next time I'll ignore patches (sets) where is no
>           update for our tests.
> * ???
> 
>     Karel
> 
