Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47674 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVOm1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:27 -0500
Received: by mail-wi0-f182.google.com with SMTP id l15so11676034wiw.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/13] rtcwake: remove RTC_ALM_READ and RTC_ALM_SET compatibility
Date: Sun, 22 Feb 2015 14:42:10 +0000
Message-Id: <1424616139-638-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The RTC_WKALM_RD and RTC_WKALM_SET have avaRilable since 2.6.17, and
preferred way since 2007.  Keeping the availability to old interface is
no longer needed.

Reference: https://github.com/torvalds/linux/commit/e824290e5dcfaf2120da587b16d10dfdff8d5d3e
Reference: https://github.com/torvalds/linux/commit/f8245c26886c912627ebc49f714e4491261224c4
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 42 ++++++------------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 5f4b602..a0e3151 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -250,24 +250,9 @@ static int setup_alarm(struct rtcwake_control *ctl, int fd, time_t *wakeup)
 
 	wake.enabled = 1;
 
-	/* First try the preferred RTC_WKALM_SET */
 	if (!ctl->dryrun && ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
-		wake.enabled = 0;
-		/* Fall back on the non-preferred way of setting wakeups; only
-		* works for alarms < 24 hours from now */
-		if ((ctl->rtc_time + (24 * 60 * 60)) > *wakeup) {
-			if (ioctl(fd, RTC_ALM_SET, &wake.time) < 0) {
-				warn(_("set rtc alarm failed"));
-				return -1;
-			}
-			if (ioctl(fd, RTC_AIE_ON, 0) < 0) {
-				warn(_("enable rtc alarm failed"));
-				return -1;
-			}
-		} else {
-			warn(_("set rtc wake alarm failed"));
-			return -1;
-		}
+		warn(_("set rtc wake alarm failed"));
+		return -1;
 	}
 
 	return 0;
@@ -358,19 +343,9 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 	struct tm tm;
 	time_t alarm;
 
-	 /* First try the preferred RTC_WKALM_RD */
 	if (ioctl(fd, RTC_WKALM_RD, &wake) < 0) {
-		/* Fall back on the non-preferred way of reading wakeups; only
-		 * works for alarms < 24 hours from now
-		 *
-		 * set wake.enabled to 1 and determine from value of the year-1
-		 * means disabled
-		 */
-		wake.enabled = 1;
-		if (ioctl(fd, RTC_ALM_READ, &wake.time) < 0) {
-			warn(_("read rtc alarm failed"));
-			return -1;
-		}
+		warn(_("read rtc alarm failed"));
+		return -1;
 	}
 
 	if (wake.enabled != 1 || wake.time.tm_year == -1) {
@@ -673,16 +648,11 @@ int main(int argc, char **argv)
 	}
 
 	if (!ctl.dryrun) {
-		/* try to disable the alarm with the preferred RTC_WKALM_RD and
-		 * RTC_WKALM_SET calls, if it fails fall back to RTC_AIE_OFF
-		 */
 		struct rtc_wkalrm wake;
 
 		if (ioctl(fd, RTC_WKALM_RD, &wake) < 0) {
-			if (ioctl(fd, RTC_AIE_OFF, 0) < 0) {
-				warn(_("disable rtc alarm interrupt failed"));
-				rc = EXIT_FAILURE;
-			}
+			warn(_("read rtc alarm failed"));
+			rc = EXIT_FAILURE;
 		} else {
 			wake.enabled = 0;
 			if (ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
-- 
2.3.0

