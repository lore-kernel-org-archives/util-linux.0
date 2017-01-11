Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34678 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbdAKVoh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 11 Jan 2017 16:44:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so979658wmi.1
        for <util-linux@vger.kernel.org>; Wed, 11 Jan 2017 13:44:36 -0800 (PST)
Date: Wed, 11 Jan 2017 21:44:20 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: J William Piggott <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org
Subject: Re: pull: hwclock 27 changes
In-Reply-To: <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
Message-ID: <alpine.LNX.2.20.1701112055190.2589@imuri>
References: <20161231214107.8658-1-kerolasa@iki.fi> <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com> <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com> <alpine.LNX.2.20.1701072212010.9096@imuri> <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 8 Jan 2017, J William Piggott wrote:

> > @@ -655,7 +655,8 @@ display_time(const bool hclock_valid, struct timeval hwctime)
> >   * If anything goes wrong (and many things can), we return return code 10
> >   * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
> >   */
> > -static int interpret_date_string(const struct hwclock_control *ctl, time_t * const time_p)
> > +static int interpret_date_string(const struct hwclock_control *ctl,
> > +				 time_t *const time_p)
> 
> 
> Sorry for nitpicking. I know you didn't write this, but as long as
> you're making a change here, shouldn't it be: const time_t *time_p?

Nope. That will make pointer value read-only, and that would cause 
following error.

sys-utils/hwclock.c:720:11: error: assignment of read-only location '*time_p'
   *time_p = seconds_since_epoch;

Code we have makes the pointer read-only, but leaves value writeable.

> > @@ -1031,9 +1032,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
> >  	exact_adjustment =
> >  	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
> >  	    + not_adjusted;
> > -	tdrift_p->tv_sec = (int) exact_adjustment;
> > -	if (exact_adjustment < 0)
> > -		tdrift_p->tv_sec--;
> > +	tdrift_p->tv_sec = (int) floor(exact_adjustment);
> 
> Is the cast required now?

floor(3) will return double, tv_sec is time_t. Yes I should and have 
fixed the cast from int to time_t.

> >> @@ -158,28 +158,31 @@ static int do_rtc_read_ioctl(int rtc_fd, struct tm *tm)
> >>  {
> >>  	int rc = -1;
> >>  	char *ioctlname;
> >> -
> >>  #ifdef __sparc__
> >>  	/* some but not all sparcs use a different ioctl and struct */
> >>  	struct sparc_rtc_time stm;
> >> +#endif
> >>
> >>  8< -------
> >>
> >>>
> >>> Can't this be in the sparc ifdef just after this?
> >>>
> >>> Otherwise looks OK, thank you.
> >>>
> > 
> > That would mix declaration and code. Kept as is.
> 
> You mean keeping declarations at the top, I see. We break that rule
> sometimes. I think the code would look nicer in this case. But I don't
> have a strong opinion about it. It's fine your way.

Since C99 it is allowed to mix declarations and code, but quite franky I 
find it irritating when declarations are hidden somewhere halfway down 
function. Same story with #defines they should be at top of the file after 
#includes before any functions - and no where else. IMHO these sort of 
conventios make code reading, and understanding, easier.

-- snip

There is now new commit that removes --compare option, and all related 
stuff. Naturally the earlier integer arithmetics change and deprecation in 
manual page are removed from changes.

https://github.com/kerolasa/lelux-utiliteetit/commit/d3e33557e6794446c712ca264e54fe4b186a17ca

----------------------------------------------------------------
The following changes since commit 89958178f6d6ebe0944d423feaea66be521fff43:
  If mtab support is disabled, disable ro/rw mtab checks (2017-01-10 17:32:32 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
for you to fetch changes up to d3e33557e6794446c712ca264e54fe4b186a17ca:
  hwclock: remove --compare option (2017-01-11 21:04:36 +0000)
----------------------------------------------------------------

Thank you JWP for reviews, I hope I did not miss anything but if I did let 
me know and I will follow up. Even better if everyone agrees that this is 
now good enough to be merged, and we can move forward with other updates 
such as adjtimex(8) work.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
