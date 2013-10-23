Return-Path: tommi.kyntola@gmail.com
Message-ID: <52677330.8070308@gmail.com>
Date: Wed, 23 Oct 2013 09:56:48 +0300
From: Tommi Kyntola <tommi.kyntola@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux-ng@vger.kernel.org
Subject: Re: [RFC/PATCH] week numbers for cal
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com> <20131022103214.GG15115@x2.net.home>
In-Reply-To: <20131022103214.GG15115@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>



On 10/22/13 13:32, Karel Zak wrote:
> On Sat, Oct 05, 2013 at 11:59:54PM +0300, Tommi Kyntola wrote:
>> I keep trying -w with cal from time to time and I finally decided it's
>> about time to do something about it. I'm not sure if this is something
>> you'd be interested in incorporating into util-linux cal, but it's
>> something I wanted, so here it is. There's gcal of course, but I only
>> wanted a toothpick not the whole forest.
>
> Applied, thanks.
 >
> Comments:
>
> * please, next time always use space around operators and after
>    commas, things like
>
>              week_number(xd&~TODAY_FLAG,month+which_cal+1,year,wflag);
>
>    are horrible.


Oh, sorry, I thought we might have gone one more iteration cleaning it up
a bit once you were done with the earlier release.

Not that code cleanliness was a design goal at any point and the code seemed
a little stale to begin with. Frankly, I was expecting responses more along
the lines of "that's hardly needed".

Next time, I'll keep it nice even before the RFC.

> * I don't understand this feature:
>
>             /* In some years (e.g. 2010 in ISO mode) it's possible to
>              * have a remnant of week 53 starting the year yet the year
>              * in question ends during 52, in this case we're assuming
>              * that early remnant is being referred to if 53 is given
>              * as argument.  */
>
>   For example:
>
>          $ LANG=de_DE.UTF8 ./cal --week=53 2009
>               Dezember 2009
>             Mo Di Mi Do Fr Sa So
>          49     1  2  3  4  5  6
>          50  7  8  9 10 11 12 13
>          51 14 15 16 17 18 19 20
>          52 21 22 23 24 25 26 27
>          53 28 29 30 31
>
>    it's correct, let's try the next year:
>
>          $ LANG=de_DE.UTF8 ./cal --week=53 2010
>                Januar 2010
>             Mo Di Mi Do Fr Sa So
>          53              1  2  3
>           1  4  5  6  7  8  9 10
>           2 11 12 13 14 15 16 17
>           3 18 19 20 21 22 23 24
>           4 25 26 27 28 29 30 31
>
>    oh... week 53 of the year 2010 in January 2010, but week 52 is December:
>
>          $ LANG=de_DE.UTF8 ./cal --week=52 2010
>               Dezember 2010
>             Mo Di Mi Do Fr Sa So
>          48        1  2  3  4  5
>          49  6  7  8  9 10 11 12
>          50 13 14 15 16 17 18 19
>          51 20 21 22 23 24 25 26
>          52 27 28 29 30 31
>
>
>   It seems pretty strange to interpret --week=53 2010 as last week
>   of the year 2009. I think it would be more intuitive to interpret
>
>        cal --week=53 2010
>
>   as invalid week number (or for another years expect this week after
>   week 52).
>
>   Note that I'm talking about command line --week=53 interpretations, the
>   week numbers in the output are correct of course.

That was a tricky one. It did initially fail with invalid argument,
as it does with years that don't have that remnant in January (e.g. 2006),
but to me it seemed stranger to fail with --week=53 when it still shows up
in -y output. These two only differ in highlighting:
cal -my --week 2010
cal -my --week=53 2010

But I certainly understand your point and I think you're right, it probably
makes more sense to follow the numbering definitions and make it only show
up weeks with Thursdays in it (in ISO mode).

One can drop the extra check (when month > 12) and errx straight up to make it
error with 53 when the only part of 53 with present is in January.

cheers,
Tommi Kyntola
