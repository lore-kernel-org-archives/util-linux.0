Return-Path: elseifthen@gmx.com
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <204525f7-850d-f70e-0c6b-585cb8759963@gmx.com>
Date: Mon, 8 Jan 2018 20:17:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 01/08/2018 05:21 AM, Karel Zak wrote:
> On Tue, Jan 02, 2018 at 09:53:18AM -0500, J William Piggott wrote:
>> Having not received any reply, I went ahead with the
>> implementation, with one change involving Karel's original
>> request for volunteers. Specifically, the first and last bullet
>> points; which where:
>>
>> * keep the current default "British Empire" behavior (Gregorian since
>>   September 1752)
>>
>> * later (after warning in release notes) we can make --gregorian as
>>   the default
>>
>> During implementation I considered these issues:
>>
>> * to do that we'd be creating two new options --iso, and an
>>   alias --gregorian; these would become non-functional once
>>   they were made the default. Just like the current situation
>>   with --one and --sunday.
> 
> It's not so unusual to have command line options for default behavior,
> and it's good idea to use these options for example in scripts to be
> independent on the current defaults.
> 

Having options for defaults is required if there is a way to change the
defaults. In this case there is not. If you want to add ~/.calrc and/or
/etc/calrc, then the options would have some meaning; as things stand
they only add confusion, IMO. It might be a nice feature to have a
config file for cal.  For example, I have cal aliased to cal -3.

>> * this change is unlikely to affect downstream maintainers
>>
>> * end users are the ones that may be caught out by it
>>
>> * a release note warning that some future version of cal(1)
>>   will change the default output is unlikely to reach the end
>>   users.
> 
> I have no clue how many users care and read our ReleaseNotes, but
> important is that they have opportunity to do that and they have
> always time to adopt to changes. This is how I promised that this 
> project will be maintained. 

A promise is a promise ;) I really just wanted to avoid adding options
that would later become default and meaningless, but we'd be stuck with
them forever. Seemed like a bad way to go ... to me.

> 
>> Indirectly, the current tests are broken. I think this
>> supports some of the changes in this patch set:
>>
>> The tests author seemed to believe that the -1 and -s options
>> actually do something, despite the 'expected' output showing
>> otherwise. While testing this patch set I thought the same
>> thing; I tried to figure out what these two options do; which
>> is nothing. I think this is good evidence to support removing
>> them.
> 
> It's bug that -1/--one does nothing and this bug should be fixed. The
> -s seems to set ctl->weekstart (and it would be probably more robust
> to compare it with SUNDAY rather than with zero in code).

Right, but since -s and -m; -1, -3, -y, and -Y should be mutually
exclusive, -s and -1 do nothing (unless there exists a calrc).

> 
>> The tests author also seems to believe that the -j option
>> switches from the Gregorian calendar system to the Julian
>> calendar system. Making comments to that affect and using it
>> in tests involving the year 1752; a year which uses both
>> calendar systems. I think this is good evidence to support
>> renaming --julian to --ordinal.
>>
>> If developers for the project are being confused by these
>> options, than what chance do end users have? So that's my case
>> for making these changes.
> 
> This is good point. I think the problem is that nowhere in the man
> page has been described all the history and differences between
> calendars.
  
That, and because someone decided to call Gregorian calendars with
ordinal days, Julian calendars. What were they thinking! I understand
the relationship between ordinal days and Astronomical Julian Days, but
Julian Calendars already existed. Talk about namespace violations. I
have the impression that this problem is beginning to be recognized and
that CS is slowly migrating from julian in favor of ordinal.

>> Also while pounding on cal(1), to see if these patches broke
>> anything, I found a few other issues and fixed them as well.
>> The man page was quite sparse, for example having no explanation
>> for the -w argument, so rewrote much of it.
> 
> Thanks.
> 
>> v2 to v3 changelog
>> * make proleptic Gregorian the default
>> * extensive man page updates
>> * rename --julian to --ordinal
> 
> Yes, this is mess...
>

A mess? Awe, it's not that bad ;) I understand you must keep your
promise with regard to warning before changing the default behavior; but
you think renaming --julian to --ordinal is not good?

>> * add private (for now) --caesar option for exclusive Julian calendar
> 
>> * allow -w to accept its argument
>> * update mutually exclusive options
>> * add short versions for the new options
>> * remove non-functional options
>> * fix broken week calculations
> 
> Thanks!
> 
>>
>> v1 to v2 changelog
>>  * fix typo in v1
>>  * move REFORMATION_YEAR to the control struct
>>  * add more about the --1752-reform option to man page
>>  * add a second patch with minor style and wording changes
> 
> Thanks. I'll work on cal(1) in next days and use us much as possible
> from your patches. 
> 
> Thanks for patience, I understand that you want to be a little bit
> more aggressive with the changes and do it in the "best way" now, but
> I'd like to be a little bit more conservative :-)

It sounds like you have no choice ;)

> 
>     Karel
> 
