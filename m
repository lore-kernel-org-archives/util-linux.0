Return-Path: elseifthen@gmx.com
Subject: Re: fputs() vs puts()
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <201706282129.41161.sweet_f_a@gmx.de>
 <20170629085114.66lbbszwxnooszbb@ws.net.home>
 <201706291237.19507.sweet_f_a@gmx.de>
 <20170629105313.psiy2vw63spibaan@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4a405fc3-7afc-b1f5-e902-849d5b1699de@gmx.com>
Date: Thu, 29 Jun 2017 10:46:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170629105313.psiy2vw63spibaan@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/29/2017 06:53 AM, Karel Zak wrote:
> On Thu, Jun 29, 2017 at 12:37:19PM +0200, Ruediger Meier wrote:
>>> than introduce another function. (It was also reason why I was not
>>> sure with print_usage_help_options(), but it resolves more issues.)
>>
>> I can still change it to be used like MAN_TAIL, then we are consistent 
>> again.
>>
>>   print_usage_help_options(16);
>>   vs.
>>   printf( USAGE_HELP_OPTIONS(16) );
> 
> Yes, I have no strong opinion about it, but somehow to have libc stuff
> without any extra abstraction in the code seems always better.
> 
>>> For me it's about:
>>>
>>>     * nice usage() output
>>>     * usage() function readability
>>>     * all without extra complexity (random contributor has to be able
>>>       add new option easily)
>>>     * translators-friendly (minimize changes, keep it open as much as
>>>       possible)
>>
>>
>> I see it all like you, so let's stop code cosmetics unless we have real 
>> changes. I'll send a patch for boilerpalate.c only. and maybe the 
>> mentioned help_options macro.
> 
> I just pushed wipefs and uuidgen with puts(), it seems good. So my
> suggestion
> 
>  1) use libc output functions if possible
>  2) use puts() for new tools or after massive changes in usage()
>  3) don't use puts() for already translated usage()
>  4) use  
>         --output <list>    COLUMNS to display (see below)
>         ...
>         COLUMNS:
> 
> 
>    (William, can you update your "standardize USAGE_COLUMNS" patches? Please.)

Sure, one clarification please: you want only the columns header in all
caps? So:

Usage:
Options:
Functions:
Commands:
COLUMNS:


> 
>  5) "perfect is the enemy of good" (your new (or first) tatto...)
> 
>  6) keep our maintainer happy and send patches with new regression
>     tests, improve stability, implement new features, etc. :)
> 
>     Karel
> 
