Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 4/4] lib/timeutils: add common ISO timestamp masks
To: Karel Zak <kzak@redhat.com>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
 <661c0a48-59bb-8263-9fd7-c1ef80b160f2@gmx.com>
 <20171023094959.dxlot6uqj5pvymwk@ws.net.home>
 <54ed1151-d782-815c-c986-1ae6ea9d20fe@gmx.com>
 <20171024093728.cwri5elvpqxk6tl7@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8421ce81-278a-65d9-9470-bc86e3103b73@gmx.com>
Date: Tue, 24 Oct 2017 12:19:59 -0400
MIME-Version: 1.0
In-Reply-To: <20171024093728.cwri5elvpqxk6tl7@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 10/24/2017 05:37 AM, Karel Zak wrote:
> On Mon, Oct 23, 2017 at 03:54:19PM -0400, J William Piggott wrote:
>>> Would be possible to use ISO_8601_* to compose ISO_TIMESTAMP_*
>>> macros? Your hardcoded magic 0x constants make the header file
>>> less readable. I mean
>>>
>>>   ISO_TIMESTAMP = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE
>>
>> We could eliminate wrapping by dropping the unnecessary 8601. Using the
>> longest example:
>>
>> 	ISO_TIMESTAMP_COMMA_GT = ISO_TIMESTAMP_COMMA | ISO_GMTIME | ISO_T
>  
> OK, although ISO_T seems pretty generic :-)
> 
>>> and it would be also nice to add somehow info about "usec" to the
>>> macro name (see ISO_TIMESTAMP vs. ISO_TIMESTAMP_COMMA).
>>
>> 8601 only uses comma or dot for the radix character; so 'COMMA/DOT'
>> imply the presence of a fractional part.
>>
>>> What about:
>>>
>>>     - use "U" prefix for usec times
>>>     - use "GM_" prefix for GMTIME
>>>
>>> for example:
>>>
>>>    ISO_TIMESTAMP           = ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE,
>>>    ISO_UTIMESTAMP_DOT      = ISO_TIMESTAMP | ISO_8601_DOTUSEC,
>>>    ISO_UTIMESTAMP_COMMA    = ISO_TIMESTAMP | ISO_8601_ISO_8601_COMMAUSEC,
>>>    ISO_GM_UTIMESTAMP_COMMA = ISO_UTIMESTAMP_COMMA | ISO_8601_GMTIME
>>>
>>> and so on.
>>
>> IMO the macros are easier to remember, write, and read, if they all
>> begin the same and the optional parts are suffixes. All of the masks are
>> basic ISO Timestamps (date time timezone), the rest are minor variations.
> 
> I have a problem if I have to use more suffixes, the order of the
> suffixes is not obvious. The idea behind ISO_8601_* with in code has
> been to keep it readable:

>From a readability standpoint the order doesn't matter; the order is set
by the standard. The reader only needs to know what the suffixes mean.
There are only four: COMMA, DOT, T, and G. Their meanings seem clear to me.

The current implementation puts the items out of order as well, for
example uuidparse.c has: 
ISO_8601_DATE |
ISO_8601_TIME |
ISO_8601_COMMAUSEC |
ISO_8601_TIMEZONE |
ISO_8601_SPACE,

SPACE is out of order, but it doesn't matter. The standard defines
where it goes. As long as the reader understands that SPACE defines the
date and time delimiter all is good.

Anyway, I'm not clear on what you want me to do. You didn't comment on
my idea that naming the radix point implies usec. Why define a radix
point if there is no fractional part, it makes no sense. If you agree
with that, then your only remaining change request is moving the _G
suffix to _GM prefix.  Is that the only change you want? If yes, then
I'll make it so. IMO, it degrades readability, but you have the hammer.


> 
>     strtime_iso(ISO_8601_DATE | ISO_8601_TIME | ISO_8601_TIMEZONE)
> 
> is so easy to read...
> 
>     Karel
> 
