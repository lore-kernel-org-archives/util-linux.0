Return-Path: elseifthen@gmx.com
Message-ID: <553704DC.70400@gmx.com>
Date: Tue, 21 Apr 2015 22:18:04 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>
Subject: Re: hwclock's synchronize_to_clock_tick_rtc returns inconsistent
 values
References: <20150416203604.GA6523@fatal.se> <55344548.6050102@gmx.com> <20150420122132.GB27969@ws.net.home> <5535BADC.1020700@gmx.com>
In-Reply-To: <5535BADC.1020700@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>


Karel,

I pushed the patch to my repo, if you want to use it.


The following changes since commit a53e37f9d4c9b7b88f13e44f5c82a0ac92dbfd6a:

  sfdisk: don't use BLKRRPART to check loopdev usage (2015-04-17 10:32:48 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git sync-err

for you to fetch changes up to 9fb890c3c5fccf9a9a02b251dfa5332f427d4c78:

  hwclock: remove dead code (2015-04-21 16:46:23 -0400)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: regression fix
      hwclock: remove dead code

 sys-utils/hwclock-rtc.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)



On 04/20/2015 10:50 PM, J William Piggott wrote:
> 
> 
> On 04/20/2015 08:21 AM, Karel Zak wrote:
>> On Sun, Apr 19, 2015 at 08:16:08PM -0400, J William Piggott wrote:
>>>>                         rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
>>>>                         ret = 1;
>>>>                         if (rc == -1)
>>>>                                 warn(_("select() to %s to wait for clock tick
>>>> failed"),
>>>>                                      rtc_dev_name);
>>>>                         else if (rc == 0 && debug)
>>>>                                 printf(_("select() to %s to wait for clock
>>>> tick timed out"),
>>>>                                      rtc_dev_name);
>>>>                         else
>>>>                                 ret = 0;
>>>>
>>>
>>> Karel,
>>>
>>> The select time out still needs to return 1, so the debug test should
>>> have been a separate statement.
>>
>> Yes, the debug (-D) should bot affect how this code works, but it
>> seems that hwclock.c:manipulate_clock() assumes return 2 after 
>> time out and we already use "2" in busy wait version of the
>> synchronization. 
>>
> 
> Returning 2 will not fix this bug. When select times out, we need to
> error out on everything except set functions (even that exception has
> issues, because we need to also inhibit updating the drift factor then.
> Nobody has complained about that so it is not a priority to fix. I will
> look at it when refactoring).
> 
> hwclock.c:1326 should not be testing for "rc != 2", but that is for
> Alpha so I am concerned about changing it now either.
> 
> Previous to the commit that caused this regression, the behavior was to
> return 1, that was correct.
> 
> Removing the 'dead' code should be a separate commit from this
> regression fix, IMHO.
> 
> I do not think two message strings justify using a switch, it is
> inconsistent with the style of the rest of the code. I would just
> separate the debug test for now:
> 
> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
> index 78f42aa..b5ecc5a 100644
> --- a/sys-utils/hwclock-rtc.c
> +++ b/sys-utils/hwclock-rtc.c
> @@ -313,10 +313,11 @@ static int synchronize_to_clock_tick_rtc(void)
>                         if (rc == -1)
>                                 warn(_("select() to %s to wait for clock tick failed"),
>                                      rtc_dev_name);
> -                       else if (rc == 0 && debug)
> -                               printf(_("select() to %s to wait for clock tick timed out"),
> -                                    rtc_dev_name);
> -                       else
> +                       else if (rc == 0) {
> +                               if (debug)
> +                                       printf(_("select() to %s to wait for clock tick timed out"),
> +                                              rtc_dev_name);
> +                       } else
>                                 ret = 0;
>  #endif
>  
> 
> 
> I did some basic hwclock testing with the above patch, but I didn't come
> up with a quick way to force the select time out to test this specific
> change.
> 
> 
>>> I don't have time to patch and test this right now, but I can do it
>>> later if you want?
>>
>> See the patch below (note that patch also remove never used #ifdef
>> dead code).
>>
>>
>> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
>> index 78f42aa..3173591 100644
>> --- a/sys-utils/hwclock-rtc.c
>> +++ b/sys-utils/hwclock-rtc.c
>> @@ -280,18 +280,6 @@ static int synchronize_to_clock_tick_rtc(void)
>>  				       rtc_dev_name);
>>  			ret = busywait_for_rtc_clock_tick(rtc_fd);
>>  		} else if (rc == 0) {
>> -#ifdef Wait_until_update_interrupt
>> -			unsigned long dummy;
>> -
>> -			/* this blocks until the next update interrupt */
>> -			rc = read(rtc_fd, &dummy, sizeof(dummy));
>> -			ret = 1;
>> -			if (rc == -1)
>> -				warn(_("read() to %s to wait for clock tick failed"),
>> -				     rtc_dev_name);
>> -			else
>> -				ret = 0;
>> -#else
>>  			/*
>>  			 * Just reading rtc_fd fails on broken hardware: no
>>  			 * update interrupt comes and a bootscript with a
>> @@ -310,15 +298,22 @@ static int synchronize_to_clock_tick_rtc(void)
>>  			tv.tv_usec = 0;
>>  			rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
>>  			ret = 1;
>> -			if (rc == -1)
>> +
>> +			switch (rc) {
>> +			case -1: /* error */
>>  				warn(_("select() to %s to wait for clock tick failed"),
>>  				     rtc_dev_name);
>> -			else if (rc == 0 && debug)
>> -				printf(_("select() to %s to wait for clock tick timed out"),
>> -				     rtc_dev_name);
>> -			else
>> +				break;
>> +			case 0: /* timeout */
>> +				if (debug)
>> +					printf(_("select() to %s to wait for clock tick timed out"),
>> +					     rtc_dev_name);
>> +				ret = 2;
>> +				break;
>> +			default: /* success */
>>  				ret = 0;
>> -#endif
>> +				break;
>> +			}
>>  
>>  			/* Turn off update interrupts */
>>  			rc = ioctl(rtc_fd, RTC_UIE_OFF, 0);
>>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
