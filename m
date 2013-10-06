Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f172.google.com ([209.85.128.172]:63494 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab3JFRXL (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sun, 6 Oct 2013 13:23:11 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so3419158veb.3
        for <util-linux-ng@vger.kernel.org>; Sun, 06 Oct 2013 10:23:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
	<CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com>
Date: Sun, 6 Oct 2013 20:23:10 +0300
Message-ID: <CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com>
Subject: Re: [RFC/PATCH] week numbers for cal
From: Tommi Kyntola <tommi.kyntola@gmail.com>
To: kerolasa@gmail.com
Cc: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Oh, forgot the today flag. It has to be masked out before passing the
day to week_number().
Good catch and thanks for taking the time to look at it!

I fixed the flaw and redid the commits, this time with additional
changes to the man page, bash-completion etc.
(I fixed some cal related faulty translations from the fi.po while at
it, although I doubt anyone uses those here)

I can split the changes into smaller chunks if appropriate, but I'll
hold that until I get more feedback.

cheers,
Tommi Kyntola


On Sun, Oct 6, 2013 at 6:29 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> On 5 October 2013 21:59, Tommi Kyntola <tommi.kyntola@gmail.com> wrote:
>> I keep trying -w with cal from time to time and I finally decided it's
>> about time to do something about it. I'm not sure if this is something
>> you'd be interested in incorporating into util-linux cal, but it's
>> something I wanted, so here it is. There's gcal of course, but I only
>> wanted a toothpick not the whole forest.
>>
>> I added -w|--week for showing week numbers. It defaults to North
>> American numbering, because cal itself defaults to Sundays being the
>> first day of the week. With Monday first it uses the ISO-8601 week
>> numbers.
>>
>> I didn't worry too much about the implementation being as clean as
>> possible just yet, but should this be deemed worth a jack, I or anyone
>> else can take it to any direction.
>>
>> The three relevant patches are in my github:
>> https://github.com/Kynde/util-linux.git
>> https://github.com/Kynde/util-linux/commits
>>
>> Tommi Kyntola (4):
>>       cal: added two missing tests
>>       cal: added -w|--week for showing week numbers
>>       cal: tests for week number modes added
>>       cal: added more week number tests to cover various special cases
>>
>> The first that's on top of Karel's tree is a minor test fix for
>> bigyear and sep1752 which seemed to lack final their last tests.
>>
>>  misc-utils/cal.c            |  140 +++-
>>  tests/expected/cal/1mw      |   37 ++
>>  tests/expected/cal/3mw      |   37 ++
>>  tests/expected/cal/bigyear  |   51 ++
>>  tests/expected/cal/bigyearw |  257 ++++++++
>>  tests/expected/cal/colorw   |   55 ++
>>  tests/expected/cal/sep1752  |   51 ++
>>  tests/expected/cal/sep1752w |  249 ++++++++
>>  tests/expected/cal/weeknum  | 1485 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/expected/cal/yearw    |  177 ++++++
>>  tests/ts/cal/1mw            |   59 ++
>>  tests/ts/cal/3mw            |   58 ++
>>  tests/ts/cal/bigyear        |    1 +
>>  tests/ts/cal/bigyearw       |   96 +++
>>  tests/ts/cal/colorw         |   71 +++
>>  tests/ts/cal/sep1752        |    1 +
>>  tests/ts/cal/sep1752w       |   96 +++
>>  tests/ts/cal/weeknum        |   87 +++
>>  tests/ts/cal/yearw          |   58 ++
>>  19 files changed, 3037 insertions(+), 29 deletions(-)
>>
>> Please cc me as I'm not on the list.
>
> Hello Tommi,
>
> Thank you for the weekday contribution. Earlier the year I though I'll
> make this to work, but you were first.
>
> I had look of your patch set and found out peculiarity. If the first
> day of the week is highlighted the week number is calculated wrong.
>
> $ cal -w 6 10 2013
>       October 2013
>    Su Mo Tu We Th Fr Sa
> 39        1  2  3  4  5
> 147  6  7  8  9 10 11 12
> 41 13 14 15 16 17 18 19
> 42 20 21 22 23 24 25 26
> 43 27 28 29 30 31
>
> When day is not highlighted error does not occur.
>
> $ cal --color=never -w 13 10 2013
>
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/
