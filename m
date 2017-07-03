Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 2/5] hwclock: usage() use program_invocation_short_name
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <d0d5b0b9-184d-7733-3116-406c9033d927@gmx.com>
 <201707031046.45954.sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4db0cbb6-9a55-8926-8c78-a6ee88fdf0bf@gmx.com>
Date: Mon, 3 Jul 2017 11:14:09 -0400
MIME-Version: 1.0
In-Reply-To: <201707031046.45954.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 07/03/2017 04:46 AM, Ruediger Meier wrote:
> On Sunday 02 July 2017, J William Piggott wrote:
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  sys-utils/hwclock.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 8b1e2f3..eeb68e7 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1203,7 +1203,7 @@ static void __attribute__((__noreturn__))
>>  usage(const struct hwclock_control *ctl)
>>  {
>>  	fputs(USAGE_HEADER, stdout);
>> -	puts(_(" hwclock [function] [option...]"));
>> +	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
>>  
>>  	fputs(USAGE_SEPARATOR, stdout);
>>  	puts(_("Query or set the RTC (Real Time Clock / Hardware Clock)"));
>> @@ -1222,8 +1222,10 @@ usage(const struct hwclock_control *ctl)
>>  #endif
>>  	puts(_("     --predict        predict the drifted RTC time according to --date"));
>>  	fputs(USAGE_OPTIONS, stdout);
>> -	puts(_(" -u, --utc            inform hwclock the RTC timescale is UTC"));
>> -	puts(_(" -l, --localtime      inform hwclock the RTC timescale is Local"));
>> +	printf(_(
>> +	       " -u, --utc            inform %s the RTC timescale is UTC\n"), program_invocation_short_name);
>> +	printf(_(
>> +	       " -l, --localtime      inform %s the RTC timescale is Local\n"), program_invocation_short_name);
>>  #ifdef __linux__
>>  	printf(_(
>>  	       " -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);
> 
> I'm not sure if this makes really sense. I wouldn't overuse the program
> name in general. And in this case I would rather remove the reduntant
> term "inform hwclock" as *all* options "inform hwclock" about something. 

Most options are requesting a behavior. Some are giving the command
configuration information, 'informing'.

The reason for the stressing the point here is because when these options
are used elsewhere they are requesting an behavior. For example:

$ date
Mon Jul  3 10:49:12 EDT 2017
$ date --utc
Mon Jul  3 14:49:18 UTC 2017

It is reasonable that users might make the same assumption for hwclock
since it is, to some degree, an analog of 'date'. But they would not get
the expected result.

This unique situation also causes the options to have different affects
depending on the function. It would be nice to make them mutually
exclusive with 'read' functions, but if there is no /etc/adjtime file
then they are needed, well --localtime is needed.

So I am stressing that these options are giving hwclock information
about the Hardware Clock that it otherwise has no way of determining; as
opposed to telling hwclock to use the specified timescale for it's
actions, like displaying the Hardware Clock time in utc.

I think the name choice for these options is unfortunate, but it is what
it is.


> 
> cu,
> Rudi
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
