Return-Path: sweet_f_a@gmx.de
Subject: Re: remove stderr usage (was: [PATCH] uuidparse)
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>,
 util-linux@vger.kernel.org
References: <20170618172536.21544-1-kerolasa@iki.fi>
 <201706191155.23149.sweet_f_a@gmx.de>
 <072f3a28-9fd9-dc68-adcf-d35081437d0c@gmx.com>
 <201706192103.01740.sweet_f_a@gmx.de>
 <fa11835d-6ce5-1e2c-befd-29538fedf97a@gmx.com>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <8b27f49b-a986-a83f-b049-59e4e46b6cd2@gmx.de>
Date: Mon, 19 Jun 2017 22:39:09 +0200
MIME-Version: 1.0
In-Reply-To: <fa11835d-6ce5-1e2c-befd-29538fedf97a@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 06/19/2017 09:47 PM, J William Piggott wrote:> 
> 
> On 06/19/2017 03:03 PM, Ruediger Meier wrote:
>> On Monday 19 June 2017, J William Piggott wrote:
>>> On 06/19/2017 05:55 AM, Ruediger Meier wrote:
>>>> On Monday 19 June 2017, Karel Zak wrote:
>>>>> On Mon, Jun 19, 2017 at 11:22:48AM +0200, Ruediger Meier wrote:
>>>
>>>   -->8
>>>
>>> On a related note: could we add USAGE_*_NN with no trailing newline
>>> for use with puts() on new/converted commands? For example:
>>>
>>> #define USAGE_HEADER        _("\nUsage:\n")
>>> #define USAGE_HEADER_NN     _("\nUsage:")
>>
>> My plan is to remove the trailing newline from USAGE_HEADER and friends
>> when no usage() funtion needs to use fputs() anymore.
> 
> I got the impression from the other discussion that legacy apps would
> continue to use fputs() so that their strings would not have to be
> modified. But I guess they won't need to use it for USAGE_*, if that is
> what you mean.
> 
> Removing the trailing newline from USAGE_* will mean changing
> fputs(USAGE_*) to puts(USAGE_*) in every command project wide, yes?

I don't know yet. I thought we could do the next huge cosmetic puts patch
semi-automatic in UL and also in the translation project. I will figure
out after this first step of boring work is done. ;)

cu,
Rudi
