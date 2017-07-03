Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
To: Ruediger Meier <ruediger.meier@ga-group.nl>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
 <201707031051.27992.ruediger.meier@ga-group.nl>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <05bbcea5-5f5a-4767-7d98-6b0a4e6575a6@gmx.com>
Date: Mon, 3 Jul 2017 11:35:01 -0400
MIME-Version: 1.0
In-Reply-To: <201707031051.27992.ruediger.meier@ga-group.nl>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 07/03/2017 04:51 AM, Ruediger Meier wrote:
> On Sunday 02 July 2017, J William Piggott wrote:
>>
>> Signed-off-by: J William Piggott <elseifthen@gmx.com>
>> ---
>>  sys-utils/hwclock.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index eeb68e7..19d7652 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1238,7 +1238,8 @@ usage(const struct hwclock_control *ctl)
>>  #endif
>>  	puts(_("     --update-drift   update the RTC drift factor"));
>>  	printf(_(
>> -	       "     --noadjfile      do not use %1$s\n"
>> +	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
>> +	printf(_(
>>  	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
>>  	puts(_("     --test           dry run; use -D to view what would have happened"));
>>  	puts(_(" -D, --debug          use debug mode"));
> 
> What about
> 
> 
> 
> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> What about the mentioned whitespaces for puts() to get printf
> on one line? 
> 
>   puts(  _("     --update-drift   update the RTC drift factor"));
>   printf(_("     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
>   printf(_("     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
>   puts(  _("     --test           dry run; use -D to view what would have happened"));
>   puts(  _(" -D, --debug          use debug mode"));

Sure, if that is what Karel wants (it can be a separate patch).

The only thing that I don't like about that choice is that it can cause
puts() lines to wrap that otherwise would not. Since puts() is a lot
more common than printf(), it seems like putting the alignment burden on
printf() makes more sense.

But I don't have a strong opinion about it. Whatever Karel wants is fine
with me.

Make the change Karel?


> 
> cu,
> Rudi
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
