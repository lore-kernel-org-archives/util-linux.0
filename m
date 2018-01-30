Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeA3Kox (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 05:44:53 -0500
Date: Tue, 30 Jan 2018 11:44:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] cal: honor num_months when only a year argument
Message-ID: <20180130104449.thsi7jf4sqf3zbn7@ws.net.home>
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
 <201801241524.02617.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801241524.02617.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 03:24:02PM +0100, Ruediger Meier wrote:
> On Monday 22 January 2018, J William Piggott wrote:
> > I don't know if this was an oversight or an overzealous
> > interpretation of POSIX. Just in case, I'll address the
> > POSIX possibility. POSIX description for cal(1) says:
> >
> >   If only the year operand is given, cal shall produce a
> >   calendar for all twelve months in the given calendar year.
> >
> > It also says that cal(1) has no options, so in that context
> > if an option is given then it should be expected to override
> > POSIX behavior.
> 
> We still don't need to fight against POSIX.
> 
> "cal -1" behaves like POSIX cal without options.
> "cal -3" behaves like POSIX except that it prints 3 months whereever  
> POSIX would print only 1.
> 
> > Before patched all of these command displayed a full year:
> > cal -1 2020
> > cal -3 2020
> > cal -n6 2020
> 
> Seriously, I find the new behavior quiet useless and unwanted. In past 

Well, old behavior is pretty strange too.

$ cal  -V
cal from util-linux 2.30.2

$ cal --three  2012
                               2012

        July                  August                September
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
                1  2       1  2  3  4  5  6                1  2  3
 3  4  5  6  7  8  9    7  8  9 10 11 12 13    4  5  6  7  8  9 10
10 11 12 13 14 15 16   14 15 16 17 18 19 20   11 12 13 14 15 16 17
17 18 19 20 21 22 23   21 22 23 24 25 26 27   18 19 20 21 22 23 24
24 25 26 27 28 29 30   28 29 30 31            25 26 27 28 29 30
31
       October               November               December
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
                   1          1  2  3  4  5                1  2  3
 2  3  4  5  6  7  8    6  7  8  9 10 11 12    4  5  6  7  8  9 10
 9 10 11 12 13 14 15   13 14 15 16 17 18 19   11 12 13 14 15 16 17
16 17 18 19 20 21 22   20 21 22 23 24 25 26   18 19 20 21 22 23 24
23 24 25 26 27 28 29   27 28 29 30            25 26 27 28 29 30 31
30 31
       January               February                 March
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7             1  2  3  4                1  2  3
 8  9 10 11 12 13 14    5  6  7  8  9 10 11    4  5  6  7  8  9 10
15 16 17 18 19 20 21   12 13 14 15 16 17 18   11 12 13 14 15 16 17
22 23 24 25 26 27 28   19 20 21 22 23 24 25   18 19 20 21 22 23 24
29 30 31               26 27 28 29            25 26 27 28 29 30 31

        April                   May                   June
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7          1  2  3  4  5                   1  2
 8  9 10 11 12 13 14    6  7  8  9 10 11 12    3  4  5  6  7  8  9
15 16 17 18 19 20 21   13 14 15 16 17 18 19   10 11 12 13 14 15 16
22 23 24 25 26 27 28   20 21 22 23 24 25 26   17 18 19 20 21 22 23
29 30                  27 28 29 30 31         24 25 26 27 28 29 30


... I don't understand why July etc.


> it seemed to work fine to have such alias in ~./profile
> 
>   alias cal="cal -3"

Nice.


> But now "cal -3 2019" always shows Dec, Jan, Feb. Can't believe that any 
> user finds this useful. At least it should output of the "current" 
> months of the given year. But I wouldn't change this at all. It's just 
> an annoying incompatible change without any benefit.

This is good point. I think -1 and -3 should print the current month
if the month is no specified.



    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
