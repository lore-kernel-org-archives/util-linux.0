Return-Path: elseifthen@gmx.com
Subject: Re: fputs() vs puts()
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <201706282129.41161.sweet_f_a@gmx.de>
 <20170629085114.66lbbszwxnooszbb@ws.net.home>
 <201706291237.19507.sweet_f_a@gmx.de>
 <20170629105313.psiy2vw63spibaan@ws.net.home>
 <4a405fc3-7afc-b1f5-e902-849d5b1699de@gmx.com>
 <20170629201231.vjxp6mkecuqoalfo@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Message-ID: <1d036b95-430d-839f-031c-31b80e6e2b4f@gmx.com>
Date: Fri, 30 Jun 2017 14:29:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170629201231.vjxp6mkecuqoalfo@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 06/29/2017 04:12 PM, Karel Zak wrote:
> On Thu, Jun 29, 2017 at 10:46:50AM -0400, J William Piggott wrote:
>>>    (William, can you update your "standardize USAGE_COLUMNS" patches? Please.)
>>
>> Sure, one clarification please: you want only the columns header in all
>> caps? So:
>>
>> Usage:
>> Options:
>> Functions:
>> Commands:
>> COLUMNS:
> 
> ha.. that's a good question. Suggestions? 
> 
> For example coreutils project uses uppercase for keywords only, for
> example dd(1)
> 
>     Each FLAG symbol may be:
>        ...
>     Each CONV symbol may be:
>        ...
> 
> it seems like original Rudi's idea
> 
>     Available COLUMNS:


But they also use:
of=FILE
conv=CONVS

So we cannot completely follow that paradigm. The above are not option
args, and you do not want option args in all caps.

The columns situation is unique, we don't have to play follow the leader.

Comparing:

        --output <list>    COLUMNS to display (see below)
        ...
        Available COLUMNS:

With:
        --output <list>    columns to display (see Columns:)
        ...
        Columns:


What does the reader learn by yelling COLUMNS at them. Sometimes a vague
reference like 'see below' is required. In this case the reader can be
told exactly what they a looking for. It also keeps our usage() headings
consistent.

The two are not so different; I just think my solution is less
ambiguous, is easier to read, and looks a bit cleaner.

It's your call to make Karel.


> 
> it's more compatible with the rest than alone "COLUMNS". So I vote
> this one.
> 
>     Karel
> 
