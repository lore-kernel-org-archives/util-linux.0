Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755928AbdLUCnr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 Dec 2017 21:43:47 -0500
Subject: Re: v2.32 cal(1)
To: Karel Zak <kzak@redhat.com>, Adam Sampson <ats@offog.org>
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
 <y2amv2ds6q0.fsf@offog.org> <20171220174241.7n4szla6vxwv3fum@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a81f3f7c-77fc-fd98-c440-e326be8ea4db@gmx.com>
Date: Wed, 20 Dec 2017 21:43:43 -0500
MIME-Version: 1.0
In-Reply-To: <20171220174241.7n4szla6vxwv3fum@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 12/20/2017 12:42 PM, Karel Zak wrote:
> On Wed, Dec 20, 2017 at 04:29:43PM +0000, Adam Sampson wrote:
>> Karel Zak <kzak@redhat.com> writes:
>>
>>> The problem is that year 1752 is very specific to British Empire and
>>> for example Catholic Europe moved to the Gregorian calendar in year
>>> 1582.
>> ...
>>> * later (after warning in release notes) we can make --gregorian as
>>>   the default
>>
>> The date of cal's switch is specified in POSIX as 1752, though:
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
>> (with a note that future versions may make this depend on the locale).
> 
> It sounds like too complicated semantic to depend on locale. Don't
> also forget that switch from one calendar to another means extra
> calculation (for example skip 11 days for British Empire way, etc).
> 
>> So if the default is changed, it would be worth noting the deviation
>> from POSIX in the man page, and maybe even defaulting to the old
> 
> Good point.
> 
>> behaviour if POSIXLY_CORRECT is defined, as, e.g., coreutils does for
>> other bits of dubious but mandated behaviour.
>>
>> I wonder if it might be more helpful just to report an error if cal is
>> run for a year prior to 1926 without explicitly specifying which
>> calendar to use?
> 
> I think we can follow the current default behavior for ever, and just
> add --iso/--gregorian for people who care.

I think the standard is being misunderstood.

Issue 2 required the Gregorian format:
_____________________________
http://pubs.opengroup.org/onlinepubs/007908799/xcu/cal.html

DESCRIPTION

    The cal utility writes a Gregorian calendar to standard output. If the year
    operand is specified, a calendar for that year is written. If no operands
    are specified, a calendar for the current month is written.
_____________________________



The reason for the change in issue 6 was to *allow* Julian:
_____________________________
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
Issue 6

The DESCRIPTION is updated to allow for traditional behavior for years before
the adoption of the Gregorian calendar.

_____________________________


There is no default format specified, only what cal(1) shall be capable of.

There is a similar requirement for Julian placed on date(1). Coreutils
date command not only defaults to proleptic Gregorian, but doesn't have
any Julian capability.

So I think having cal(1) default to proleptic Gregorian is not only
allowed by POSIX, but it should be expected to correlate with date(1).




> 
>     Karel
> 
