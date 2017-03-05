Return-Path: elseifthen@gmx.com
Subject: Re: [V3 PULL] hwclock: remove date(1)
To: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>,
        Karel Zak <kzak@redhat.com>
References: <a1415b5d-4046-3b34-5836-40ce1a835a41@gmx.com>
 <d3087e72-f787-a7d0-6a2f-dfd0941a8ed9@draigBrady.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e0068e87-7cb4-9993-53c3-f71c4cca474b@gmx.com>
Date: Sun, 5 Mar 2017 09:09:28 -0500
MIME-Version: 1.0
In-Reply-To: <d3087e72-f787-a7d0-6a2f-dfd0941a8ed9@draigBrady.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


On 03/04/2017 08:12 PM, Pádraig Brady wrote:
> On 04/03/17 13:56, J William Piggott wrote:
>>
>> Everyone,
>>  Here's the latest branch for adding parse-date.
>>
>> Karel,
>> I have changed a few things since the last working branch I sent you.  I
>> moved the API from parse-date.h to timeutils.h. Cleaned up the code some
>> more and made more style conversion. Added documentation and fixed
>> hwclock.8.in.
>>
>> I've tested the parser pretty thoroughly now, including using odd input
>> listed in bug fixes. It passed for all of them.
>>
>> Here are examples of the problem related to the latest gnulib
>> parse_datetime() commit; which was actually caused by changes in
>> coreutils not gnulib.
>>
>> BROKEN
>> TZ="Europe/London" date -d 'TZ="Australia/Perth" 2016-08-15 07:00'
>> Mon Aug 15 07:00:00 AWST 2016
>>
>> CORRECT
>> TZ="Europe/London" date -d 'TZ="Australia/Perth" 2016-08-15 07:00'
>> Mon Aug 15 00:00:00 BST 2016
> 
> Sorry for jumping in here.

Hello Pádraig, no worries.

> Are you saying there are issues with the current code in gnulib?

Nope, I'm saying that the latest gnulib commit regarding
parse_datetime() (gnulib-4e6e16b), which I intentionally omitted from
the version I based this parse_date() submission upon (gnulib-dd7a871),
does not cause this version of parse_date() to be broken. I'm not making a
comment about the state of coreutils nor gnulib, sorry if I implied that
somehow.


> 
> Note the TZ issue in date(1) was added in coreutils-8.26 with:
> http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=v8.25-15-gdf88fce
> That was fixed with a minimal fix in coreutils-8.26 in Fedora.
> coreutils-8.27 will be released in a few days with a different fix
> that incorporated changes in parse_datetime in gnulib.
> 
> thanks,
> Pádraig
> 
