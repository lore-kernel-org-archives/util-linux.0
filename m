Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdAHV2h (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 8 Jan 2017 16:28:37 -0500
Subject: Re: pull: hwclock 27 changes
To: Sami Kerola <kerolasa@iki.fi>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
Date: Sun, 8 Jan 2017 16:21:32 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1701072212010.9096@imuri>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/07/2017 06:06 PM, Sami Kerola wrote:
> On Sat, 7 Jan 2017, J William Piggott wrote:
> 

 8< ------

> 
> These are the differences so far with former 'hwclock' branch.
> 
> -- snip
> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
> index 008bfba38..411ec433a 100644
> --- a/sys-utils/hwclock-rtc.c
> +++ b/sys-utils/hwclock-rtc.c
> @@ -261,7 +261,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
>  #else
>  		rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
>  #endif
> -		if (rc == 0) {
> +		if (rc != -1) {


The former worked for a long time, but this is better I think.
Nice catch, Sami.


>  			/*
>  			 * Just reading rtc_fd fails on broken hardware: no
>  			 * update interrupt comes and a bootscript with a
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 2c92fbf71..797f51423 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -655,7 +655,8 @@ display_time(const bool hclock_valid, struct timeval hwctime)
>   * If anything goes wrong (and many things can), we return return code 10
>   * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
>   */
> -static int interpret_date_string(const struct hwclock_control *ctl, time_t * const time_p)
> +static int interpret_date_string(const struct hwclock_control *ctl,
> +				 time_t *const time_p)


Sorry for nitpicking. I know you didn't write this, but as long as
you're making a change here, shouldn't it be: const time_t *time_p?


>  {
>  	FILE *date_child_fp = NULL;
>  	char *date_command = NULL;
> @@ -673,7 +674,7 @@ static int interpret_date_string(const struct hwclock_control *ctl, time_t * con
>  	/* Quotes in date_opt would ruin the date command we construct. */
>  	if (strchr(ctl->date_opt, '"') != NULL ||
>  	    strchr(ctl->date_opt, '`') != NULL ||
> -	    strstr(ctl->date_opt, "$(") != NULL) {
> +	    strchr(ctl->date_opt, '$') != NULL) {
>  		warnx(_
>  		      ("The value of the --date option is not a valid date.\n"
>  		       "In particular, it contains illegal character(s)."));
> @@ -1031,9 +1032,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
>  	exact_adjustment =
>  	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
>  	    + not_adjusted;
> -	tdrift_p->tv_sec = (int) exact_adjustment;
> -	if (exact_adjustment < 0)
> -		tdrift_p->tv_sec--;
> +	tdrift_p->tv_sec = (int) floor(exact_adjustment);


Is the cast required now?


>  	tdrift_p->tv_usec = (exact_adjustment -
>  				 (double)tdrift_p->tv_sec) * 1E6;
>  	if (ctl->debug) {
> @@ -1052,7 +1051,8 @@ calculate_adjustment(const struct hwclock_control *ctl,
>   * But if the contents are clean (unchanged since read from disk), don't
>   * bother.
>   */
> -static void save_adjtime(const struct hwclock_control *ctl, const struct adjtime *adjtime)
> +static void save_adjtime(const struct hwclock_control *ctl,
> +			 const struct adjtime *adjtime)
>  {
>  	char *content;		/* Stuff to write to disk file */
>  	FILE *fp;
> @@ -1181,7 +1181,7 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
>   * Return rc == 0 if everything went OK, rc != 0 if not.
>   */
>  static int
> -manipulate_clock(const struct hwclock_control *ctl, time_t set_time,
> +manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
>  		 const struct timeval startup_time, struct adjtime *adjtime)
>  {
>  	/* The time at which we read the Hardware Clock */
> -- snip

Changes look good Sami, thank you.


> 
> There are replies to feedback below. I can only hope your email client is 
> helping to find them as this message is a bit long.
> 
>> commit c7a8f56920c738a90038cd6baaaec676c642b926
>> Author: Sami Kerola <kerolasa@iki.fi>
>> Date:   Sat Dec 31 21:29:27 2016 +0000
>>
>>     hwclock: remove trailing dot from messages that include system error message
>>     
>>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>>
>>> Nice, thank you.
>>>
>>> FWIW, I think this should apply to all message strings. (Apparently these
>>> types of changes annoy translators :)
>>>
> 
> Correct. That is why I left most of the strings alone, but the few that 
> ended with dot and had trailing system error output were too ugly. With 
> a dot they look like:
> 
> hwclock: important message.: system error
> 
> That 'trailing' dot is not at the end of the line, but before : making it 
> to be untolerable.
>

I wasn't objecting. I understand the reason and think that your change is
good. I was only commenting that I'd like to see more of it ;)

 8< -----

>>
>>
>> commit d9ccb70cafaac62fd6c8294fbba3b3ab385d3537
>> Author: Sami Kerola <kerolasa@iki.fi>
>> Date:   Tue Jul 26 10:52:15 2016 +0100
>>
>>     hwclock: try RTCGET and RTCSET only when normal rtc fails
>>     
>>     The RTCGET and RTCSET are in use for sparcs with sbus, so try them as
>>     fallback rather than always.
>>     
>>     Reference: https://github.com/torvalds/linux/blob/master/fs/compat_ioctl.c#L967-L974
>>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>
>> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
>> index fc1dfc3..9a67027 100644
>> --- a/sys-utils/hwclock-rtc.c
>> +++ b/sys-utils/hwclock-rtc.c
>> @@ -158,28 +158,31 @@ static int do_rtc_read_ioctl(int rtc_fd, struct tm *tm)
>>  {
>>  	int rc = -1;
>>  	char *ioctlname;
>> -
>>  #ifdef __sparc__
>>  	/* some but not all sparcs use a different ioctl and struct */
>>  	struct sparc_rtc_time stm;
>> +#endif
>>
>>  8< -------
>>
>>>
>>> Can't this be in the sparc ifdef just after this?
>>>
>>> Otherwise looks OK, thank you.
>>>
> 
> That would mix declaration and code. Kept as is.

You mean keeping declarations at the top, I see. We break that rule
sometimes. I think the code would look nicer in this case. But I don't
have a strong opinion about it. It's fine your way.

> 
>> commit 08e959db08840871979b00036d85aa6941f9fa76
>> Author: Sami Kerola <kerolasa@iki.fi>
>> Date:   Tue Jul 26 08:54:00 2016 +0100
>>
>>     hwclock: stream line synchronize_to_clock_tick_rtc()
>>     
>>     Flip if clauses to hit common case first.  This should be easier and quicker
>>     to read and run.
>>     
>>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>
>> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
>> index f54e263..fc1dfc3 100644
>> --- a/sys-utils/hwclock-rtc.c
>> +++ b/sys-utils/hwclock-rtc.c
>>
>>  8< -------
>>
>> @@ -287,26 +276,34 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
>>  			tv.tv_sec = 10;
>>  			tv.tv_usec = 0;
>>  			rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
>> -			ret = 1;
>> -			if (rc == -1)
>> -				warn(_("select() to %s to wait for clock tick failed"),
>> -				     rtc_dev_name);
>> +			if (0 < rc)
>> +				ret = 0;
>>  			else if (rc == 0) {
>>  				if (ctl->debug)
>>  					printf(_("select() to %s to wait for clock tick timed out"),
>>  					       rtc_dev_name);
>>  			} else
>> -				ret = 0;
>> +				warn(_("select() to %s to wait for clock tick failed"),
>> +				     rtc_dev_name);
>>  			/* Turn off update interrupts */
>>  			rc = ioctl(rtc_fd, RTC_UIE_OFF, 0);
>>  			if (rc == -1)
>>  				warn(_("ioctl() to %s to turn off update interrupts failed"),
>>  				     rtc_dev_name);
>>
>>>
>>>
>>> The /* Turn off update interrupts */ code was the success block. You
>>> didn't move it up to your new success block at 'if (0 < rc)'.  The
>>> interrupts will never be turned off with this patch.
>>>
>>>
>>
>>  8< -------
> 
> I looked this change, and especially result of the change, again as I 
> could not anymore tell what that diff does. This did indeed need change; 
> ioctl returns not -1 when it is successful, so I am checking that rather 
> than if it returns 0. Content of the 'success' block is left asis.
> 
> Notice that I did not include your review signature to this change because 
> I it does not sound you would be too happy about that before another look.
> 

Doh, again I missed that "} else" was a shorthand statement. I seemed to
be blind to them that day. Of course we want the interrupts turned off
whether select() succeeds or fails. Sorry, my bad.

So this looks good to me, including your new change.  Thank you.


 8< --------- 
