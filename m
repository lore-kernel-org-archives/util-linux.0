Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33269 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbBVOmh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:37 -0500
Received: by mail-wg0-f43.google.com with SMTP id z12so21331361wgg.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/13] rtcwake: clean up struct tm initializations
Date: Sun, 22 Feb 2015 14:42:14 +0000
Message-Id: <1424616139-638-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index c3e0eb6..f951c9c 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -159,7 +159,7 @@ static int is_wakeup_enabled(const char *devname)
 
 static int get_basetimes(struct rtcwake_control *ctl, int fd)
 {
-	struct tm	tm;
+	struct tm	tm = { 0 };
 	struct rtc_time	rtc;
 
 	/* this process works in RTC time, except when working
@@ -185,7 +185,6 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 	/* convert rtc_time to normal arithmetic-friendly form,
 	 * updating tm.tm_wday as used by asctime().
 	 */
-	memset(&tm, 0, sizeof tm);
 	tm.tm_sec = rtc.tm_sec;
 	tm.tm_min = rtc.tm_min;
 	tm.tm_hour = rtc.tm_hour;
@@ -339,8 +338,7 @@ static int read_clock_mode(struct rtcwake_control *ctl)
 static int print_alarm(struct rtcwake_control *ctl, int fd)
 {
 	struct rtc_wkalrm wake;
-	struct rtc_time rtc;
-	struct tm tm;
+	struct tm tm = { 0 };
 	time_t alarm;
 
 	if (ioctl(fd, RTC_WKALM_RD, &wake) < 0) {
@@ -353,15 +351,12 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 		return 0;
 	}
 
-	rtc = wake.time;
-
-	memset(&tm, 0, sizeof tm);
-	tm.tm_sec = rtc.tm_sec;
-	tm.tm_min = rtc.tm_min;
-	tm.tm_hour = rtc.tm_hour;
-	tm.tm_mday = rtc.tm_mday;
-	tm.tm_mon = rtc.tm_mon;
-	tm.tm_year = rtc.tm_year;
+	tm.tm_sec = wake.time.tm_sec;
+	tm.tm_min = wake.time.tm_min;
+	tm.tm_hour = wake.time.tm_hour;
+	tm.tm_mday = wake.time.tm_mday;
+	tm.tm_mon = wake.time.tm_mon;
+	tm.tm_year = wake.time.tm_year;
 	tm.tm_isdst = -1;  /* assume the system knows better than the RTC */
 
 	alarm = mktime(&tm);
-- 
2.3.0

