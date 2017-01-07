Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wj0-f194.google.com ([209.85.210.194]:32974 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933032AbdAGXGc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 7 Jan 2017 18:06:32 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so82099022wjc.0
        for <util-linux@vger.kernel.org>; Sat, 07 Jan 2017 15:06:31 -0800 (PST)
Date: Sat, 7 Jan 2017 23:06:23 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: J William Piggott <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org
Subject: Re: pull: hwclock 27 changes
In-Reply-To: <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
Message-ID: <alpine.LNX.2.20.1701072212010.9096@imuri>
References: <20161231214107.8658-1-kerolasa@iki.fi> <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com> <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 7 Jan 2017, J William Piggott wrote:

> Below is a monolithic review of the pull request using reverse quoting
> so the code is easier to view/highlight.
> 
> Edit: I sent this once and it choked somewhere. So below is highly
> redacted version.

Thank you JWP so much for review. I am sure Karel is also happy to see 
other than himself reading changes. After your review there is new remote 
branch in my repository

  git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed

that has in almost all changes 'Reviewed-by: J William Piggott 
<elseifthen@gmx.com>'. Notice also that the latest update is not 100% 
ready. We have question of --compare open, and 'hwclock: move command-line 
options to control structure' has issue that is not yet corrected yet.

These are the differences so far with former 'hwclock' branch.

-- snip
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 008bfba38..411ec433a 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -261,7 +261,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 #else
 		rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
 #endif
-		if (rc == 0) {
+		if (rc != -1) {
 			/*
 			 * Just reading rtc_fd fails on broken hardware: no
 			 * update interrupt comes and a bootscript with a
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2c92fbf71..797f51423 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -655,7 +655,8 @@ display_time(const bool hclock_valid, struct timeval hwctime)
  * If anything goes wrong (and many things can), we return return code 10
  * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
  */
-static int interpret_date_string(const struct hwclock_control *ctl, time_t * const time_p)
+static int interpret_date_string(const struct hwclock_control *ctl,
+				 time_t *const time_p)
 {
 	FILE *date_child_fp = NULL;
 	char *date_command = NULL;
@@ -673,7 +674,7 @@ static int interpret_date_string(const struct hwclock_control *ctl, time_t * con
 	/* Quotes in date_opt would ruin the date command we construct. */
 	if (strchr(ctl->date_opt, '"') != NULL ||
 	    strchr(ctl->date_opt, '`') != NULL ||
-	    strstr(ctl->date_opt, "$(") != NULL) {
+	    strchr(ctl->date_opt, '$') != NULL) {
 		warnx(_
 		      ("The value of the --date option is not a valid date.\n"
 		       "In particular, it contains illegal character(s)."));
@@ -1031,9 +1032,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
 	exact_adjustment =
 	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
 	    + not_adjusted;
-	tdrift_p->tv_sec = (int) exact_adjustment;
-	if (exact_adjustment < 0)
-		tdrift_p->tv_sec--;
+	tdrift_p->tv_sec = (int) floor(exact_adjustment);
 	tdrift_p->tv_usec = (exact_adjustment -
 				 (double)tdrift_p->tv_sec) * 1E6;
 	if (ctl->debug) {
@@ -1052,7 +1051,8 @@ calculate_adjustment(const struct hwclock_control *ctl,
  * But if the contents are clean (unchanged since read from disk), don't
  * bother.
  */
-static void save_adjtime(const struct hwclock_control *ctl, const struct adjtime *adjtime)
+static void save_adjtime(const struct hwclock_control *ctl,
+			 const struct adjtime *adjtime)
 {
 	char *content;		/* Stuff to write to disk file */
 	FILE *fp;
@@ -1181,7 +1181,7 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
  * Return rc == 0 if everything went OK, rc != 0 if not.
  */
 static int
-manipulate_clock(const struct hwclock_control *ctl, time_t set_time,
+manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		 const struct timeval startup_time, struct adjtime *adjtime)
 {
 	/* The time at which we read the Hardware Clock */
-- snip

There are replies to feedback below. I can only hope your email client is 
helping to find them as this message is a bit long.

> commit c7a8f56920c738a90038cd6baaaec676c642b926
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Dec 31 21:29:27 2016 +0000
> 
>     hwclock: remove trailing dot from messages that include system error message
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > 
> > Nice, thank you.
> > 
> > FWIW, I think this should apply to all message strings. (Apparently these
> > types of changes annoy translators :)
> >

Correct. That is why I left most of the strings alone, but the few that 
ended with dot and had trailing system error output were too ugly. With 
a dot they look like:

hwclock: important message.: system error

That 'trailing' dot is not at the end of the line, but before : making it 
to be untolerable.

> commit 3d3444cfc24c843e9efc65a56e78f8060d438a7c
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Wed Jul 27 19:47:38 2016 +0100
> 
>     hwclock: make --date=argument less prone to injection
>     
>     This change should not improve security much.  One hopes hwclock --set is
>     restricted for root only.  Where hwclock is allowed to run via sudo, or has
>     setuid setup, there is a pretty easy privilege escalation via subshell.
>     
>     $ sudo ./hwclock --set --date='2000-10-20$(touch /tmp/hwclock.inject)'
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 9a5cb8f..2c92fbf 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -671,10 +671,12 @@ static int interpret_date_string(const struct hwclock_control *ctl, time_t * con
>  	}
>  
>  	/* Quotes in date_opt would ruin the date command we construct. */
> -	if (strchr(ctl->date_opt, '"') != NULL) {
> +	if (strchr(ctl->date_opt, '"') != NULL ||
> +	    strchr(ctl->date_opt, '`') != NULL ||
> +	    strstr(ctl->date_opt, "$(") != NULL) {
>  		warnx(_
>  		      ("The value of the --date option is not a valid date.\n"
> -		       "In particular, it contains quotation marks."));
> +		       "In particular, it contains illegal character(s)."));
>  		return retcode;
>  	}
> 
> > 
> > Nice, thank you. I think just $ would have been enough.
> > 

Good point. Banning variables is likely a good idea to avoid variable 
contents smuggling explosive content.  Changed in proposed way.

> commit fec97d35eb42601a347d5cac7ddd5b1d422edbbe
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Tue Jul 26 14:34:30 2016 +0100
> 
>     hwclock: fix rtc atexit registration
>     
>     Commit 27f9db17bd57b85947445c03e2cd9dda36ca377f missed a minus sign from
>     comparison.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
> index 9a67027..7e1a945 100644
> --- a/sys-utils/hwclock-rtc.c
> +++ b/sys-utils/hwclock-rtc.c
> @@ -138,7 +138,7 @@ static int open_rtc(const struct hwclock_control *ctl)
>  		if (rtc_dev_fd < 0)
>  			rtc_dev_name = *fls;	/* default for error messages */
>  	}
> -	if (rtc_dev_fd != 1)
> +	if (rtc_dev_fd != -1)
>  		atexit(close_rtc);
>  	return rtc_dev_fd;
>  }
> 
> > 
> > Nice catch, thank you.
> > 
> 
> 
> commit 6f62eca023c0ec187a369cc668a962c696fd1107
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Tue Jul 26 08:33:32 2016 +0100
> 
>     hwclock: clarify cmos inb and outb preprocessor directives
>     
>     The cmos only works when architecture is i386, x86_64, or alpha.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit d9ccb70cafaac62fd6c8294fbba3b3ab385d3537
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Tue Jul 26 10:52:15 2016 +0100
> 
>     hwclock: try RTCGET and RTCSET only when normal rtc fails
>     
>     The RTCGET and RTCSET are in use for sparcs with sbus, so try them as
>     fallback rather than always.
>     
>     Reference: https://github.com/torvalds/linux/blob/master/fs/compat_ioctl.c#L967-L974
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
> index fc1dfc3..9a67027 100644
> --- a/sys-utils/hwclock-rtc.c
> +++ b/sys-utils/hwclock-rtc.c
> @@ -158,28 +158,31 @@ static int do_rtc_read_ioctl(int rtc_fd, struct tm *tm)
>  {
>  	int rc = -1;
>  	char *ioctlname;
> -
>  #ifdef __sparc__
>  	/* some but not all sparcs use a different ioctl and struct */
>  	struct sparc_rtc_time stm;
> +#endif
> 
>  8< -------
> 
> > 
> > Can't this be in the sparc ifdef just after this?
> > 
> > Otherwise looks OK, thank you.
> > 

That would mix declaration and code. Kept as is.

> commit 08e959db08840871979b00036d85aa6941f9fa76
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Tue Jul 26 08:54:00 2016 +0100
> 
>     hwclock: stream line synchronize_to_clock_tick_rtc()
>     
>     Flip if clauses to hit common case first.  This should be easier and quicker
>     to read and run.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
> index f54e263..fc1dfc3 100644
> --- a/sys-utils/hwclock-rtc.c
> +++ b/sys-utils/hwclock-rtc.c
> 
>  8< -------
> 
> @@ -287,26 +276,34 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
>  			tv.tv_sec = 10;
>  			tv.tv_usec = 0;
>  			rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
> -			ret = 1;
> -			if (rc == -1)
> -				warn(_("select() to %s to wait for clock tick failed"),
> -				     rtc_dev_name);
> +			if (0 < rc)
> +				ret = 0;
>  			else if (rc == 0) {
>  				if (ctl->debug)
>  					printf(_("select() to %s to wait for clock tick timed out"),
>  					       rtc_dev_name);
>  			} else
> -				ret = 0;
> +				warn(_("select() to %s to wait for clock tick failed"),
> +				     rtc_dev_name);
>  			/* Turn off update interrupts */
>  			rc = ioctl(rtc_fd, RTC_UIE_OFF, 0);
>  			if (rc == -1)
>  				warn(_("ioctl() to %s to turn off update interrupts failed"),
>  				     rtc_dev_name);
> 
> > 
> > 
> > The /* Turn off update interrupts */ code was the success block. You
> > didn't move it up to your new success block at 'if (0 < rc)'.  The
> > interrupts will never be turned off with this patch.
> > 
> > 
> 
>  8< -------

I looked this change, and especially result of the change, again as I 
could not anymore tell what that diff does. This did indeed need change; 
ioctl returns not -1 when it is successful, so I am checking that rather 
than if it returns 0. Content of the 'success' block is left asis.

Notice that I did not include your review signature to this change because 
I it does not sound you would be too happy about that before another look.

> commit bb08719b0160d560defe091e60687d5d1240e88c
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 24 22:33:01 2016 +0100
> 
>     hwclock: improve coding style
>     
>     Make string constants to be symbolical declarations.  Use longer variable
>     name for rtc and cmos function pointer values.  Exclude code that is
>     architecture specific with preprocessor directives.  And remove message
>     duplication.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit 80b6f08f52e21205f41de0a51a26abd4034cf0cf
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 23 12:20:03 2016 +0100
> 
>     docs: deprecate hwclock --compare option
>     
>     Earlier commit clarified arithmetics that implement hwclock --compare
>     option, and that functionality feels like rubbish in - rubbish out.  This
>     surely cannot be correct way to find frequency offset and/or tick.  Even if
>     in principle doing calculations this way makes sense, the measurements are
>     prone to get skew due scheduling and other environment effects.  Therefore
>     mark this option deprecated.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index de68e43..58b5158 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -45,6 +45,9 @@ discussion below, under
>  Periodically compare the Hardware Clock to the System Time and output
>  the difference every 10 seconds.  This will also print the frequency
>  offset and tick.
> +.IP
> +The compare output is not a good measurement of offset or tick.
> +This functionality is deprecated, and will be removed in future.
>  .
>  .TP
>  .B \-\-getepoch
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 774701f..9a5cb8f 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1385,6 +1385,9 @@ static inline time_t get_times(const struct hwclock_control *ctl,
>  /*
>   * Compare the system and CMOS time and output the drift
>   * in 10 second intervals.
> + *
> + * FIXME: remove this function, unused functions, related option parsing,
> + * and manual entry when ever after 2019-07-01.
>   */
>  static int compare_clock(const struct hwclock_control *ctl)
>  {
> 
> > 
> > 
> > I tried to convince Karel of this long ago. This code has been broken
> > from day one, so nobody can be using it. IMO, it should be removed now.
> > 
> > 

I agree. --compare is broken. I think there are couple options.

1) remove --compare code, and mention in manual page it's gone
2) keep the code, but deprecate it
3) keep the code, and fix it (but how???)
4) keep the broken code and whistle happy days theme song
5) something else

I am 60-40 leaning towards recommending removal. If we don't remove rest 
of my 40 goes to deprecate. Karel, I think we need maintainer advice.

> commit 2c2bfd4828ced9f3ca1f0288d6447a0bd8f62bba
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Fri Jul 22 22:45:35 2016 +0100
> 
>     hwclock: use integer arithmetics in compare_clock()
>     
>     Almost all floating point arithmetics are now converted to interger
>     arithmetics in compare_clock().  In same go variables names are renamed to
>     be hopefully a little more easier to understand.  The second time
>     substraction got new comment because it took a while to understand out what
>     the code tried to do.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> 
>  8< -------
> 
> > 
> > Not reviewing. It's pointless as --compare is still broken.
> > 
> > 

ACK. See my reply above.

> commit 1ab5409350480e7eb1b4c063eae75f8bb35d6bfe
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 22:04:32 2016 +0100
> 
>     hwclock: remove division by zero [asan]
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Not reviewing.
> > 
> > 
> 
> 
> 
> commit 8a0279382b4be44a173a8e9419a7fd211fcb1443
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 17:10:48 2016 +0100
> 
>     hwclock: add debugging to open_rtc()
>     
>     Earlier when open_rtc() returned -1 the char *rtc_dev_name end up having
>     NULL that made it unsuitable to be used in error message.  Now one can debug
>     what paths the open_rtc() tries to use when one has to debug why 'cannot
>     open rtc device' happen.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> 
> > 
> > Nice, thank you.
> > 
> > 
> 
> 
> commit 4c4965c0e98da9e6b4e64de4c1dff7d41eb81018
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 16:35:40 2016 +0100
> 
>     hwclock: remove magic constants from interpret_date_string()
>     
>     The constants function returned were not used.  In same go clean up
>     execution flow a little bit.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> > 
> > Nice, thank you.
> > 
> 
> 
> commit 1d3829c027cb5e09e698b803a42a523d49f7815f
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 16:14:16 2016 +0100
> 
>     hwclock: use symbolic magic values passed in between functions
>     
>     The manipulate_clock() is seeing return value from
>     busywait_for_rtc_clock_tick().
>     
>     And the get_permissions_cmos() can see i386_iopl() return value.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> > 
> 
> 
> commit 017de7d8231aaaf8cd57fa9b0887e949c9c4c683
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 13:25:40 2016 +0100
> 
>     hwclock: initialize struct adjtime members
>     
>     Avoid any change of using uninitialized values.  By looks of it the earlier
>     code did take care of that, but was less obvious about the fact.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> > 
> > s/change/chance/
> > 
> > Above is the important change, but as long as you're fixing that:
> > 
> > s/By looks of it/It looks like/
> > s/but/but it/
> 
> 
>  8< -------
> 
> > 
> > Otherwise nice, thank you.
> > 

Updated.

> commit c4e533646fef70dbd8ae2bbc2e3becb1954b5353
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 12:49:12 2016 +0100
> 
>     hwclock: alloate date_resp parsing buffer in interpret_date_string()
>     
>     This makes overflowing the variable in question impossible.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit 573a993964bd695b68c62a9eb75fdd312ad3f836
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 12:12:52 2016 +0100
> 
>     hwclock: simplify save_adjtime() execution flow
>     
>     Return early to avoid excessive nesting.  In same go remove any change of
>     overflow by using appropriate allocation.  And update variable names to be
>     easier to understand.
> 
> > 
> > s/change/chance/
> > 
> 
>  8< -------
> 
> > 
> > Otherwise looks OK, thank you.
> > 

Updated.

> commit 285ac4c3899d0876f53591962ac5119607d71474
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 11:30:40 2016 +0100
> 
>     hwclock: remove dead code and other minor fixes
>     
>     Use #ifdef rather than #if to avoid undefined preprocessor identifier
>     warning.
>     
>     Remove dead code.  The #if 0 ensured the code has not been used for long
>     time, which is good because the linux/mc146818rtc.h is not been part of
>     user-api for long time.
>     
>     Value of the adjtime_p->last_calib_time is checked if it has value of zero,
>     so testing none-zero bit later is necessarily true, and therefore does not
>     need to be checked.
>     
>     And at the and remove unnecessary boolean variable.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Looks OK, thank you.
> > 
> 
> 
> 
> commit 509ac719dbe1bcc4a761f694497493525da39e25
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 17 09:09:33 2016 +0100
> 
>     docs: add instructions how to avoid alpha epoc Y2020 bug
>     
>     Recommend setting epoch using command line to for Alpha to avoid
>     autodetection that is doomed to afail after 2020.
>     
>     Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/alpha/kernel/rtc.c?id=85d0b3a573d8b711ee0c96199ac24a0f3283ed68
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
> index 9d9a42a..cf26064 100644
> --- a/sys-utils/hwclock-cmos.c
> +++ b/sys-utils/hwclock-cmos.c
> @@ -203,15 +203,16 @@ void set_cmos_epoch(const struct hwclock_control *ctl)
>  #endif
>  
>  	/*
> -	 * The kernel source today says: read the year.
> +	 * The automatic epoc determination in kernel
> +	 * linux/arch/alpha/kernel/rtc.c
>  	 *
>  	 * If it is in  0-19 then the epoch is 2000.
>  	 * If it is in 20-47 then the epoch is 1980.
>  	 * If it is in 48-69 then the epoch is 1952.
>  	 * If it is in 70-99 then the epoch is 1928.
>  	 *
> -	 * Otherwise the epoch is 1900.
> -	 * TODO: Clearly, this must be changed before 2019.
> +	 * Alpha users should explicitly define epoc using rtc kernel module
> +	 * option rtc epoc=<year>
>  	 */
>  	/*
>  	 * See whether we are dealing with SRM or MILO, as they have
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index 9534c19..de68e43 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -466,6 +466,14 @@ For example, on a Digital Unix machine:
>  .IP "" 4
>  .B hwclock\ \-\-setepoch\ \-\-epoch=1952
>  .RE
> +.IP
> +Beginning January 1, 2020 automatic epoc determination in kernel for systems
> +using 1900 will fail.  In these cases it is recommended to specify epoc
> +explicitly with kernel module option.
> +.RS
> +.IP "" 4
> +.B options rtc epoch=1900
> +.RE
>  .
>  .TP
>  .B \-\-funky\-toy
> 
> 
> > 
> > I don't like this one because:
> > 
> > Despite Richard's "doomed to fail" comment, I don't think util-linux
> > should document that as a fact. The heuristics could be updated. If the
> > kernel is still supporting DEC in 2019 it seems like they should
> > update them. It would be more work to remove the code than to adjust
> > the numbers.
> > 
> > Also the patch has some errors:
> > 
> > * The possible failure applies to more than 'systems using 1900'.
> > 
> > * The Alpha rtc driver cannot be built as a module; I believe
> > epoch={year} is a kernel command line argument only.
> > 
> > * The heuristics in drivers/char/rtc.c are slightly different than
> > what the patch references in linux/arch/alpha/kernel/rtc.c. I don't
> > know which one wins. They both differ from how they are described in
> > the hwclock-cmos.c comments, from which this patch deletes the 1900
> > possibility.
> > 
> > The Alpha auto epoch detect has nothing to do with hwclock --setepoch
> > --epoch {year}. That is all done via rtc and can only set it manually.
> > Auto detecting the epoch only affects using --directisa on Alpha
> > machines. Direct access requires hwclock to handle the epoch offset
> > internally, because we're bypassing the kernel. So hwclock-cmos.c has
> > to figure out what to use. It tries heuristics and, ironically, it
> > tries to use the kernel's auto detect via the rtc driver. Why use
> > direct access if you have a working rtc interface!
> > 
> > It is undocumented, but when using --directisa on alpha --epoch {year}
> > can be used to bypass auto detect. So --epoch {year} would be used for
> > all functions. The man-page says it can only be used with --setepoch.
> > I have no way to test this, so until now I have not documented it.
> > 

I left the change as-is for now, making the branch in it's current state 
not to be ready. How about if I read carefully what you said above, 
rethink what I thought earlier, and reply later.

> commit 6deb1326df19a87a97a5e77550f87c31a0367c92
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 22:15:54 2016 +0100
> 
>     hwclock: move error messages to determine_clock_access_method()
>     
>     This makes main() a little bit shorter.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1189,17 +1189,24 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
>  
>  	if (ctl->directisa)
>  		ur = probe_for_cmos_clock();
> -
>  #ifdef __linux__
>  	if (!ur)
>  		ur = probe_for_rtc_clock(ctl);
>  #endif
> +	if (ur) {
> +		if (ctl->debug)
> +			puts(ur->interface_name);
>  
> -	if (ctl->debug) {
> -		if (ur)
> -			puts(_(ur->interface_name));
> -		else
> +	} else {
> +		if (ctl->debug)
>  			printf(_("No usable clock interface found.\n"));
> +		warnx(_("Cannot access the Hardware Clock via "
> +			"any known method."));
> 
> > 
> > warnx( indentation is wrong.
> > 
> 
>  8< -------
> 
> > 
> > Otherwise looks OK, thank you.
> > 
> 
> 
> commit bf8f8287b095f9b1401253ecea46bab5ac96d811
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 20:18:19 2016 +0100
> 
>     hwclock: clarify set_cmos_epoch() code
>     
>     Variable set_epoc is unnecessary, and removal of it makes it obvious what is
>     happening in this function.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Looks OK, thank you.
> > 
> 
> 
> commit 59aff057349335cd089c34bb0eaa972cf60ff96a
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 16:45:07 2016 +0100
> 
>     hwclock: move command-line options to control structure
>     
>     The control structure is read-only everywhere else but in main().  Almost
>     all changes are about how variables are referred, with one exception.  Calls
>     to read_adjtime() from manipulate_clock() and compare_clock() are moved to
>     main().  This way it is possible to keep variable that tells if hwclock is
>     using UTC-0 be part of control structure.
>     
>     Changes within #ifdef __alpha__ segments were tested by flipping the
>     preprocessor directivive otherway around and getting good compilaton all the
>     way to the point where linking on none-alpha system failed.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> 
>  8< -------
> 
> @@ -1087,51 +1074,51 @@ calculate_adjustment(const double factor,
>   * But if the contents are clean (unchanged since read from disk), don't
>   * bother.
>   */
> -static void save_adjtime(const struct adjtime adjtime, const bool testing)
> +static void save_adjtime(const struct hwclock_control *ctl, const struct adjtime *adjtime)
> 
> 
> > 
> > Wraps, this line is too long.
> > 

Wrapping is now done earlier here and where interpret_date_string() 
declared.

>  8< -------
> 
> @@ -1226,16 +1211,9 @@ static void determine_clock_access_method(const bool user_requests_ISA)
>   * Return rc == 0 if everything went OK, rc != 0 if not.
>   */
>  static int
> -manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
> -		 const bool set, const time_t set_time,
> -		 const bool hctosys, const bool systohc, const bool systz,
> -		 const struct timeval startup_time,
> -		 const bool utc, const bool local_opt, const bool update,
> -		 const bool testing, const bool predict, const bool get)
> +manipulate_clock(const struct hwclock_control *ctl, time_t set_time,
> +		 const struct timeval startup_time, struct adjtime *adjtime)
> 
> 
> > 
> > Should be: const time_t set_time
> > 

Changd.

>  8< -------
> 
> @@ -1255,32 +1233,27 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
>  	/* local return code */
>  	int rc = 0;
>  
> -	if (!systz && !predict) {
> +	if (!ctl->systz && !ctl->predict) {
>  		no_auth = ur->get_permissions();
>  		if (no_auth)
>  			return EX_NOPERM;
>  	}
>  
> -	if (!noadjfile && !(systz && (utc || local_opt))) {
> -		rc = read_adjtime(&adjtime);
> -		if (rc)
> -			return rc;
> -	} else {
> -		/* A little trick to avoid writing the file if we don't have to */
> -		adjtime.dirty = FALSE;
> 
> > 
> > You have to move the above to where you read_adjtime in main. The
> > concept behind --systz is speed, so we don't want to read the file
> > then unless they also are changing timescales from the command line.
> > It is not intended to use --systz for changing timescales, so that
> > shouldn't happen. More importantly, hwclock depends on *adjtime having
> > default values when using --noadjfile. For example comparing the
> > patched version to master using the --get function:
> 
> ./hwclock-master --get --debug --noadjfile --utc | grep -E 'Calculated|2017\-'; ./hwclock-sami --get --debug --noadjfile --utc | grep -E 'Calculated|2017\-'
> Calculated Hardware Clock drift is 0.000000 seconds
> 2017-01-06 10:11:32.294942-0500
> Calculated Hardware Clock drift is 1.325654 seconds
> 2017-01-06 10:11:34.339980-0500
> 
> > 
> > 
> > 
> 
> +	if ((ctl->set || ctl->systohc || ctl->adjust) &&
> +	    (adjtime->local_utc == UTC) != ctl->universal) {
> +		adjtime->local_utc = ctl->universal ? UTC : LOCAL;
> +		adjtime->dirty = TRUE;
>  	}
>  
> -	universal = hw_clock_is_utc(utc, local_opt, adjtime);
> -
> -	if ((set || systohc || adjust) &&
> -	    (adjtime.local_utc == UTC) != universal) {
> -		adjtime.local_utc = universal ? UTC : LOCAL;
> -		adjtime.dirty = TRUE;
> +	if (ctl->noadjfile || (ctl->systz && (ctl->utc || ctl->local_opt))) {
> +		/* A little trick to avoid writing the file if we don't have to */
> +		adjtime->dirty = FALSE;
> 
> > 
> > So the above addition won't be here.
> > 

This issue is not corrected yet. It's getting a bit too late in my 
timezone to do change that requires concentration. I will send notify to 
email list when necessary update is done.

>  8< -------
> 
> > 
> > This is really nice Sami, thanks.  I volunteered to work on
> > refactoring hwclock long ago and have not yet found time to get to it.
> > This patch_set goes a long way to that goal.
> > 
> 
> 
> commit a5edff19900950a2b0b0ee95461c77ae2a38328c
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 13:43:35 2016 +0100
> 
>     hwclock: remove unnecessary type casts
>     
>     Most of the casts did nothing, with exception of couple printouts where
>     format specifier is updated to match with the variable type.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit df8c1aa40b0f08350bb0e4a6dbb14a2b6a57b42f
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 13:23:28 2016 +0100
> 
>     hwclock: do not hardcode date command magic string twice
>     
>     Variable 'magic' already contains string 'seconds-into-epoch'.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit 1b65c7fb412c117cef326789ebcbf9beb0d81e56
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 12:57:25 2016 +0100
> 
>     hwclock: remove hwclock_exit() indirection
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit 00999f9555fbf68e4f1957c55bde5a99aa5e8484
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sat Jul 16 12:50:53 2016 +0100
> 
>     hwclock: remove FLOOR macro
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 1d193a5..b517dcb 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -92,8 +92,6 @@ static int hwaudit_on;
>  /* The struct that holds our hardware access routines */
>  struct clock_ops *ur;
>  
> -#define FLOOR(arg) ((arg >= 0 ? (int) arg : ((int) arg) - 1));
> -
>  /* Maximal clock adjustment in seconds per day.
>     (adjtime() glibc call has 2145 seconds limit on i386, so it is good enough for us as well,
>     43219 is a maximal safe value preventing exact_adjustment overflow.) */
> @@ -1068,7 +1066,9 @@ calculate_adjustment(const double factor,
>  	exact_adjustment =
>  	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
>  	    + not_adjusted;
> -	tdrift_p->tv_sec = FLOOR(exact_adjustment);
> +	tdrift_p->tv_sec = (int) exact_adjustment;
> +	if (exact_adjustment < 0)
> +		tdrift_p->tv_sec--;
>  	tdrift_p->tv_usec = (exact_adjustment -
>  				 (double)tdrift_p->tv_sec) * 1E6;
>  	if (debug) {
> 
> 
> > 
> > If I look at this change in 5 years, the intent will not be clear. If
> > I see FLOOR() I'll know exactly what it is. What's wrong with having a
> > floor macro? It could be a floor function, if you don't like it as a
> > macro?
> > 

I should have read Makefile.am earlier to notice that floor(3) can be used 
here without adding libm linking, it is already linked to hwclock! After 
noticing that FLOOR() to floor() change was done.

> commit 6a8b954f5a7d2ab782047f15ae0da0b25c7aed8d
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Tue Jul 12 22:21:10 2016 +0100
> 
>     lib: add timegm() portability function to lib/timeutils.c
>     
>     Local timegm() is a replacement function in cases it is missing from libc
>     implementation.  Hopefully the replacement is never, or very rarely, used.
>     
>     CC: Ruediger Meier <ruediger.meier@ga-group.nl>
>     CC: J William Piggott <elseifthen@gmx.com>
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> commit c6fa71e3af966af9376c96a69f78d2547ea00cc2
> Author: Sami Kerola <kerolasa@iki.fi>
> Date:   Sun Jul 10 20:09:55 2016 +0100
> 
>     hwclock: remove UTC-0 localization hack
>     
>     Use timegm(3) instead rather than re-implement same functionality with
>     mktime(3) combined with removal of TZ localization.
>     
>     Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  8< -------
> 
> > 
> > Nice, thank you.
> > 
> 
> 
> 

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
