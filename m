Return-Path: pgf@laptop.org
To: Karel Zak <kzak@redhat.com>
Subject: Re: rtcwake doesn't reset wakealarm
From: Paul Fox <pgf@laptop.org>
cc: Giacomo <giacomo.perale@gmail.com>, util-linux@vger.kernel.org
In-reply-to: <20120912103130.GC17256@x2.net.home> (sfid-20120912_063136_766982_A2A635B3)
References: <loom.20120911T131040-30@post.gmane.org> <loom.20120912T113440-886@post.gmane.org> <20120912100916.GB17256@x2.net.home> <20120912103130.GC17256@x2.net.home> (sfid-20120912_063136_766982_A2A635B3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 13 Sep 2012 12:31:47 -0400
Message-Id: <20120913163147.8C9502E8B1A@grass.foxharp.boston.ma.us>
List-ID: <util-linux.vger.kernel.org>

thanks for cc'ing me.  my apologies for both the breakage (it seemed
so simple! :-) and the delay in reply.

i see you've committed a fix for this yesterday:  i'll try to test
it soon and make sure it's okay.

i might have proposed a slightly different (and i think simpler)
change.  i would revert my original patch, and instead, simply remove
the failure case of RTC_AIE_OFF -- i.e., this:
    if (!dryrun && ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
	    warn(_("disable rtc alarm interrupt failed"));
becomes this:
    if (!dryrun)
    	    ioctl(fd, RTC_AIE_OFF, 0);

my bug was always a cosmetic one -- on a platform which doesn't
implement RTC_AIE_XXX at all, the original code causes a spurious
call, but worse, a spurious message.

paul


karel wrote:
 > On Wed, Sep 12, 2012 at 12:09:16PM +0200, Karel Zak wrote:
 > > 
 > >  Let's add Paul to CC ;-)
 > > 
 > > On Wed, Sep 12, 2012 at 09:52:14AM +0000, Giacomo wrote:
 > > > Giacomo <giacomo.perale@...> writes:
 > > > 
 > > > > I recently upgraded to util-linux 2.22 and I noticed that powertop started
 > > > > reporting about 50-60 wakeups per second caused by rtc (interrupt 8). 
 > > > > 
 > > > > I quickly found out that this happened when I used rtcwake to wake up the
 > > > > machine, and that after the reboot /sys/class/rtc/rtc0/wakealarm was still 
 > > > > set to the scheduled wakeup time (now in the past). 
 > > > > 
 > > > > After a quick investigation I discovered that this is caused by commit
 > > > > 1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only invoke RTC_AIE_ON/OFF
 > > > > ioctls in pairs"): my system uses RTC_WKALM_SET so ioctl_aie_on stays false and
 > > > > RTC_AIE_OFF doesn't get called.
 > > > > 
 > > > 
 > > > Hi,
 > > > 
 > > > that commit also broke "disable". This is what happens on my system:
 > 
 >  Please, test the patch below. I hope it fixes the problem.
 > 
 >     Karel
 > 
 > 
 > 
 > >From 7413ac3f50102236415267f19b23f9839a6403b0 Mon Sep 17 00:00:00 2001
 > From: Karel Zak <kzak@redhat.com>
 > Date: Wed, 12 Sep 2012 12:22:13 +0200
 > Subject: [PATCH] rtcwake: reset wakealarm
 > 
 > > I recently upgraded to util-linux 2.22 and I noticed that powertop
 > > started reporting about 50-60 wakeups per second caused by rtc
 > > (interrupt 8).
 > >
 > > I quickly found out that this happened when I used rtcwake to wake
 > > up the machine, and that after the reboot
 > > /sys/class/rtc/rtc0/wakealarm was still set to the scheduled wakeup
 > > time (now in the past).
 > >
 > > After a quick investigation I discovered that this is caused by
 > > commit 1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only
 > > invoke RTC_AIE_ON/OFF ioctls in pairs"): my system uses
 > > RTC_WKALM_SET so ioctl_aie_on stays false and RTC_AIE_OFF doesn't
 > > get called.
 > 
 > Reported-by: Giacomo <giacomo.perale@gmail.com>
 > Signed-off-by: Karel Zak <kzak@redhat.com>
 > ---
 >  sys-utils/rtcwake.c |   12 +++++++-----
 >  1 files changed, 7 insertions(+), 5 deletions(-)
 > 
 > diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
 > index 0e16bd3..6e2701a 100644
 > --- a/sys-utils/rtcwake.c
 > +++ b/sys-utils/rtcwake.c
 > @@ -64,7 +64,7 @@ enum ClockMode {
 >  
 >  static unsigned		verbose;
 >  static unsigned		dryrun;
 > -static unsigned		ioctl_aie_on;  /* ioctl(AIE_ON) succeeded */
 > +static unsigned		alarm_on;  /* RTC_ALM_SET+RTC_AIE_ON or RTC_WKALM_SET */
 >  enum ClockMode		clock_mode = CM_AUTO;
 >  
 >  static struct option long_options[] = {
 > @@ -243,12 +243,13 @@ static int setup_alarm(int fd, time_t *wakeup)
 >  				warn(_("enable rtc alarm failed"));
 >  				return -1;
 >  			}
 > -			ioctl_aie_on = 1;
 > +			alarm_on = 1;
 >  		} else {
 >  			warn(_("set rtc wake alarm failed"));
 >  			return -1;
 >  		}
 > -	}
 > +	} else if (!dryrun)
 > +		alarm_on = 1;
 >  
 >  	return 0;
 >  }
 > @@ -524,6 +525,7 @@ int main(int argc, char **argv)
 >  				alarm, sys_time, rtc_time, seconds);
 >  
 >  	if (strcmp(suspend, "show") && strcmp(suspend, "disable")) {
 > +
 >  		if (strcmp(suspend, "no") && strcmp(suspend, "on") &&
 >  		    strcmp(suspend, "off") && is_suspend_available(suspend) <= 0) {
 >  			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"), suspend);
 > @@ -598,7 +600,7 @@ int main(int argc, char **argv)
 >  		}
 >  
 >  	} else if (strcmp(suspend, "disable") == 0) {
 > -		/* just break, alarm gets disabled in the end */
 > +		alarm_on = 1;  /* alarm gets disabled in the end */
 >  		if (verbose)
 >  			printf(_("suspend mode: disable; disabling alarm\n"));
 >  
 > @@ -616,7 +618,7 @@ int main(int argc, char **argv)
 >  		suspend_system(suspend);
 >  	}
 >  
 > -	if (!dryrun && ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
 > +	if (!dryrun && alarm_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
 >  		warn(_("disable rtc alarm interrupt failed"));
 >  
 >  	close(fd);
 > -- 
 > 1.7.7.6

=---------------------
 paul fox, pgf@laptop.org
