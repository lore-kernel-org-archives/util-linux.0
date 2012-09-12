Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:60813 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760689Ab2ILReC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 13:34:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TBqp7-0001wB-O5
	for util-linux@vger.kernel.org; Wed, 12 Sep 2012 19:34:01 +0200
Received: from host147-190-dynamic.50-79-r.retail.telecomitalia.it ([79.50.190.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 19:34:01 +0200
Received: from giacomo.perale by host147-190-dynamic.50-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 19:34:01 +0200
To: util-linux@vger.kernel.org
From: Giacomo <giacomo.perale@gmail.com>
Subject: Re: rtcwake doesn't reset wakealarm
Date: Wed, 12 Sep 2012 17:33:39 +0000 (UTC)
Message-ID: <loom.20120912T191123-580@post.gmane.org>
References: <loom.20120911T131040-30@post.gmane.org> <loom.20120912T113440-886@post.gmane.org> <20120912100916.GB17256@x2.net.home> <20120912103130.GC17256@x2.net.home> <loom.20120912T125253-285@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Giacomo <giacomo.perale@...> writes:

> 
> Karel Zak <kzak@...> writes:
> 
> > 
> > On Wed, Sep 12, 2012 at 12:09:16PM +0200, Karel Zak wrote:
> > > 
> > >  Let's add Paul to CC 
> > > 
> > 
> >  Please, test the patch below. I hope it fixes the problem.
> > 
> >     Karel
> > 
> 
> Hi,
> 
> it should work but I'm afraid it won't fix Paul's original problem,
> because even if RTC_AIE_ON fails RTC_AIE_OFF will still be called and 
> generate an error.
> 
> According to "man rtc", "when using [RTC_WKALM_RD,RTC_WKALM_SET], 
> RTC_AIE_ON and
> RTC_AIE_OFF are not used", so the right thing to do should be using 
> RTC_AIE_OFF
> to clear the alarm only when RTC_ALM_SET+RTC_AIE_ON was used to set it up 
> (that
> is, when ioctl_aie_on=1), and RTC_WKALM_SET with the "enabled" flag set to 
> false
> otherwise.
> 
> The attached patch works for me (I hope it doesn't get mangled in the 
> posting,
> you can find it on pastebin too: http://pastebin.com/wugHPx3w).
> 
> Giacomo
> 

That was needlessly complex. The issue never was "don't call RTC_AIE_OFF if you
didn't call RTC_AIE_ON before," it was "don't call RTC_AIE_OFF if it is not
supported." 

So to disable an alarm use the same logic used to enable it: first try
RTC_WKALM_SET with the "enabled" flag set to false, if it fails fall back to
RTC_AIE_OFF.

This patch works for me as well and it seems to me it's cleaner than my previous
one.

Giacomo

PS. if it's mangled http://pastebin.com/CUtVkfiQ

---

--- sys-utils/rtcwake.c	2012-07-23 23:21:56.466320628 +0200
+++ sys-utils/rtcwake.c	2012-09-12 19:22:07.772244322 +0200
@@ -64,7 +64,6 @@
 
 static unsigned		verbose;
 static unsigned		dryrun;
-static unsigned		ioctl_aie_on;  /* ioctl(AIE_ON) succeeded */
 enum ClockMode		clock_mode = CM_AUTO;
 
 static struct option long_options[] = {
@@ -243,7 +242,6 @@
 				warn(_("enable rtc alarm failed"));
 				return -1;
 			}
-			ioctl_aie_on = 1;
 		} else {
 			warn(_("set rtc wake alarm failed"));
 			return -1;
@@ -393,6 +391,8 @@
 	int		fd;
 	time_t		alarm = 0;
 
+	struct rtc_wkalrm	wake;
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -616,8 +616,23 @@
 		suspend_system(suspend);
 	}
 
-	if (!dryrun && ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
-		warn(_("disable rtc alarm interrupt failed"));
+	if (!dryrun) {
+		/* try to disable the alarm with the preferred RTC_WKALM_RD and 
+		 * RTC_WKALM_SET calls, if it fails fall back to RTC_AIE_OFF
+		 */
+		if (ioctl(fd, RTC_WKALM_RD, &wake) < 0) {
+			if (ioctl(fd, RTC_AIE_OFF, 0) < 0) {
+				warn(_("disable rtc alarm interrupt failed"));
+				rc = EXIT_FAILURE;
+			}
+		} else {
+			wake.enabled = 0;
+			if (ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
+				warn(_("disable rtc alarm interrupt failed"));
+				rc = EXIT_FAILURE;
+			}
+		}
+	}
 
 	close(fd);
 	return rc;




