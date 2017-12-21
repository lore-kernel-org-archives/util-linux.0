Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55508 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdLURdW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 21 Dec 2017 12:33:22 -0500
Subject: Re: [PATCH] cal: add --iso and --1782-reform format options
To: Karel Zak <kzak@redhat.com>
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
 <9f5b10fe-1286-3aa7-a170-7a30b9e577a3@gmx.com>
 <20171221141332.dk6i3oj3qr44k35l@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ebe6a8d2-99c6-82bb-c40c-273976c6aacf@gmx.com>
Date: Thu, 21 Dec 2017 12:33:20 -0500
MIME-Version: 1.0
In-Reply-To: <20171221141332.dk6i3oj3qr44k35l@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 12/21/2017 09:13 AM, Karel Zak wrote:
> On Tue, Dec 19, 2017 at 09:32:49PM -0500, J William Piggott wrote:
>> -#define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
>> +/* Dec 19 2017 - After an appropriate mourning period change 1752 to -1 making
>> + * the default output format the proleptic Gregorian calendar
>> + */
>> +int reformation_year = 1752;
> 
> Wow, I have to appreciate this really nice hack, it's way how to keep
> the change as small as possible ;-)
> 
> ... but I'm not sure this way is elegant from code consistence,
> extendability, and for readers. 
> 
> We have control struct where is "julian" flag. It would be probably
> better to use the control struct for all the things around calendars.

It's your call, but it seems unnecessary to me. The reformation_year doesn't
need to be passed around that much. The Julian flag has nothing to do with the
Julian calendar output. See below.

> 
>  * add enum CAL_TYPE_{JULIAN,GREGORIAN,GB1752,...}
>  * use the enum in cal_control (and remove julian flag)
>  * set calendar type in getopt code block

See below Julian option

> 
>  * use the same prefix (e.g. GB1752_*) for all the "British Empire"
>    specific reform macros (including NUMBER_MISSING_DAYS and YDAY_AFTER_MISSING)
> 
>  * in code use switch(ctl->calendar) { case CAL_TYPE .... } to keep is
>    readable ;-)
> 
>  * yes, it will require to use cal_control in small functions like
>    leap_year(), but IMHO it's better than hide all in magic reformation_year
>    global variable
> 
> BTW, in theory it would be possible to support more reforms, for
> example Greece 1923 (16-Feb -> 1-Mar), etc. Maybe the region of the
> reform should be somehow within the command line option --reform-1752-GB
> --reform-1923-GR, etc.

Possible, but it would mean a lot of changes. There are hardcoded checks
for the current Gregorian epoch. It would be much simpler if the epoch was set
to a full year I think. It would eliminate checking month and day of the epoch
and dropping of days out of the calendar. Then if someone wanted to compare the
calendars for the month of the change they just print one with
-1 --epoch-reform=1751 and one with -1 --epoch-reform=1753 and look at the
difference. Or there could be an option to automagically display the month in
Julian and Gregorian side-by-side. I think this would simplify the algorithm
for using multiple Gregorian epochs (and would probably look better than the
mess that gets printed for the months around the epoch now).

> 
>> @@ -279,6 +284,8 @@ int main(int argc, char **argv)
>>  		{"year", no_argument, NULL, 'y'},
>>  		{"week", optional_argument, NULL, 'w'},
>>  		{"color", optional_argument, NULL, OPT_COLOR},
>> +		{"iso", no_argument, NULL, OPT_ISO},
> 
> --iso seems like good idea, but --gregorian alias would be also nice
> as we already have --julian.

That would be confusing because the Julian option has nothing to do with the
Julian calendar output; There is no option for a Julian calendar, that is
controlled strictly by the reform epoch.  Julian is a terrible name for that
option. It should have been called ordinal dates or day-of-year. The option
applies to both Julian and Gregorian calendar output.

Although Julian is used as synonym for ordinal dates, for example in the posix
TZ definition, it's ambiguous. There is Julian (calendar) date, (astronomical)
Julian date, (modified) Julia date, (ordinal) Julian date, and more; all
completely different things. They should have stopped at Julian calendar IMO,
and named the rest something else.

--iso and --1752-reform are not choosing between a Gregorian or Julian calendar
output; they are choosing Gregorian epoch or no Gregorian epoch. There is no
option for users to choose Gregorian vs Julian calendar output.

Using --gregorian implies a legitimate Gregorian calendar using an epoch. It would
need to be --proleptic-gregorian which is a bit long; ISO 8601 requires
using proleptic Gregorian dates so it is a nice alternate.

I originally implemented this patch using --chesterfield instead of
--1752-reform; I really wanted to keep it ;) But, I knew you'd object.

Anyway, I want to work on hwclock so I'll have to bow out on anymore work on
cal(1) for now ((kicking self for being distracted by this waste of time)).



> 
>     Karel
> 
