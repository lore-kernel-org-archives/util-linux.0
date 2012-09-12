Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:39070 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792Ab2ILOdn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 10:33:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TBo0b-0001hA-OS
	for util-linux@vger.kernel.org; Wed, 12 Sep 2012 16:33:41 +0200
Received: from 94.247.8.10 ([94.247.8.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 16:33:41 +0200
Received: from giacomo.perale by 94.247.8.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 16:33:41 +0200
To: util-linux@vger.kernel.org
From: Giacomo <giacomo.perale@gmail.com>
Subject: Re: rtcwake doesn't reset wakealarm
Date: Wed, 12 Sep 2012 14:33:23 +0000 (UTC)
Message-ID: <loom.20120912T125253-285@post.gmane.org>
References: <loom.20120911T131040-30@post.gmane.org> <loom.20120912T113440-886@post.gmane.org> <20120912100916.GB17256@x2.net.home> <20120912103130.GC17256@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@...> writes:

> 
> On Wed, Sep 12, 2012 at 12:09:16PM +0200, Karel Zak wrote:
> > 
> >  Let's add Paul to CC 
> > 
> > On Wed, Sep 12, 2012 at 09:52:14AM +0000, Giacomo wrote:
> > > Giacomo <giacomo.perale@...> writes:
> > > 
> > > > After a quick investigation I discovered that this is caused by commit
> > > > 1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only invoke
> > > > RTC_AIE_ON/OFF
> > > > ioctls in pairs"): my system uses RTC_WKALM_SET so ioctl_aie_on stays
false and
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

Hi,

it should work but I'm afraid it won't fix Paul's original problem,
because even if RTC_AIE_ON fails RTC_AIE_OFF will still be called and generate
an error.

According to "man rtc", "when using [RTC_WKALM_RD,RTC_WKALM_SET], RTC_AIE_ON and
RTC_AIE_OFF are not used", so the right thing to do should be using RTC_AIE_OFF
to clear the alarm only when RTC_ALM_SET+RTC_AIE_ON was used to set it up (that
is, when ioctl_aie_on=1), and RTC_WKALM_SET with the "enabled" flag set to false
otherwise.

The attached patch works for me (I hope it doesn't get mangled in the posting,
you can find it on pastebin too: http://pastebin.com/wugHPx3w).

Giacomo


--- sys-utils/rtcwake.c	2012-07-23 23:21:56.466320628 +0200
+++ sys-utils/rtcwake.c	2012-09-12 16:13:40.927245246 +0200
@@ -388,6 +388,8 @@
 	unsigned	seconds = 0;
 	char		*suspend = DEFAULT_MODE;
 
+	struct rtc_wkalrm	wake;
+
 	int		rc = EXIT_SUCCESS;
 	int		t;
 	int		fd;
@@ -616,8 +618,23 @@
 		suspend_system(suspend);
 	}
 
-	if (!dryrun && ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
-		warn(_("disable rtc alarm interrupt failed"));
+	if (!dryrun) {
+		/* clear the alarm with RTC_AIE_OFF if RTC_ALM_SET+RTC_AIE_ON 
+		 * was used to enable it otherwise use the preferred RTC_WKALM_SET
+		 */
+		if (ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0) {
+			warn(_("disable rtc alarm interrupt failed"));
+		} else {
+			if (ioctl(fd, RTC_WKALM_RD, &wake) < 0)
+				warn(_("disable rtc alarm interrupt failed"));
+			else {
+				wake.enabled = 0;
+
+				if (ioctl(fd, RTC_WKALM_SET, &wake) < 0)
+					warn(_("disable rtc alarm interrupt failed"));
+			}
+		}
+	}
 
 	close(fd);
 	return rc;

