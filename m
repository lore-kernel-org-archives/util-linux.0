Return-Path: util-linux-owner@vger.kernel.org
Received: from colo.foxharp.net ([166.84.7.52]:56196 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760011Ab2C3M4P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Mar 2012 08:56:15 -0400
To: util-linux@vger.kernel.org
Subject: [PATCH]  rtcwake:  only invoke RTC_AIE_ON/OFF ioctls in pairs
From: Paul Fox <pgf@laptop.org>
Cc: Karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 30 Mar 2012 08:48:43 -0400
Message-ID: <11482.1333111723@foxharp.boston.ma.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

on a system using the rtc-mmp.c driver (and presumably others),
rtcwake always gives a warning message when it completes:
    disable rtc alarm interupt: Invalid argument

the EINVAL is because the rtc-mmp driver doesn't implement the
rtc->ops->alarm_irq_enable() member function, so ioctl(RTC_AIE_OFF)
will always fail.  note that since ioctl(RTC_WKALM_SET) is preferred
over RTC_ALM_SET/RTC_AIE_ON, no corresponding call to RTC_AIE_ON was
ever made in the first place.

the patch below is probably the correct way to avoid this warning, and
to eliminate the mismatched AIE_ON/AIE_OFF pair.

a less disruptive patch would simply ignore an EINVAL error return
from that ioctl.

paul


>From 915d629a3a396ac9581c25ca7e8960782d8e7ff9 Mon Sep 17 00:00:00 2001
From: Paul Fox <pgf@laptop.org>
Date: Fri, 30 Mar 2012 08:16:50 -0400
Subject: [PATCH] rtcwake:  only invoke RTC_AIE_ON/OFF ioctls in pairs

many rtc drivers don't implement the RTC_AIE_ON/OFF ioctls at all --
so if we never tried to enable the alarm interrupt, don't try to
disable it later.

Signed-off-by: Paul Fox <pgf@laptop.org>
---
 sys-utils/rtcwake.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 4aa5057..4ac0964 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -63,6 +63,7 @@ enum ClockMode {
 
 static unsigned		verbose;
 static unsigned		dryrun;
+static unsigned		ioctl_aie_on;  // ioctl(AIE_ON) succeeded
 enum ClockMode		clock_mode = CM_AUTO;
 
 static struct option long_options[] = {
@@ -241,6 +242,7 @@ static int setup_alarm(int fd, time_t *wakeup)
 				warn(_("enable rtc alarm failed"));
 				return -1;
 			}
+			ioctl_aie_on = 1;
 		} else {
 			warn(_("set rtc wake alarm failed"));
 			return -1;
@@ -613,7 +615,8 @@ int main(int argc, char **argv)
 		suspend_system(suspend);
 	}
 
-	if (!dryrun && ioctl(fd, RTC_AIE_OFF, 0) < 0)
+	if (!dryrun && ioctl_aie_on && ioctl(fd, RTC_AIE_OFF, 0) < 0)
+			
 		warn(_("disable rtc alarm interrupt failed"));
 
 	close(fd);
-- 
1.7.5.4



=---------------------
 paul fox, pgf@laptop.org
