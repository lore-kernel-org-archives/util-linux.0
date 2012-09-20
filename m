Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:56378 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2ITWC3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Sep 2012 18:02:29 -0400
Received: by weyx8 with SMTP id x8so1580476wey.19
        for <util-linux@vger.kernel.org>; Thu, 20 Sep 2012 15:02:28 -0700 (PDT)
From: Tom Gundersen <teg@jklm.no>
To: util-linux@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH] hwclock: don't warp the systemtime if the RTC is in UTC
Date: Thu, 20 Sep 2012 22:02:46 +0000
Message-Id: <1348178566-12850-1-git-send-email-teg@jklm.no>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A sideeffect of 839be2ba6b44fa9dc927f081d547ebadec9de19c is that we now
warp the systemtime according to the timezone, on the first call of
--systz. This is not always the correct thing to do, and causes a
regression for us in Arch Linux.

The behavior is correct if the RTC, and hence the systemtime, is
in localtime. However, if the systemtime is already in UTC we don't
want to touch it when we set the kernel timezone (which we still need to
do as some filesystems use this information).

An almost identical issue was also fixed in systemd commit
72edcff5db936e54cfc322d9392ec46e2428fd9b.

Signed-off-by: Tom Gundersen <teg@jklm.no>
---
 sys-utils/hwclock.8 | 11 +++++++----
 sys-utils/hwclock.c | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock.8 b/sys-utils/hwclock.8
index 07d9fc0..5c599ad 100644
--- a/sys-utils/hwclock.8
+++ b/sys-utils/hwclock.8
@@ -58,10 +58,12 @@ This is a good option to use in one of the system startup scripts.
 Set the Hardware Clock to the current System Time.
 .TP
 .B \-\-systz
-Reset the System Time based on the current timezone.
+Set the kernel's timezone and reset the System Time based on the current timezone.
 
-Also set the kernel's timezone value to the local timezone
-as indicated by the TZ environment variable and/or
+The system time is only reset on the first call after boot.
+
+The local timezone is taken to be what is
+indicated by the TZ environment variable and/or
 .IR /usr/share/zoneinfo ,
 as
 .BR tzset (3)
@@ -74,7 +76,8 @@ This is an alternate option to
 .B \-\-hctosys
 that does not read the hardware clock, and may be used in system startup
 scripts for recent 2.6 kernels where you know the System Time contains
-the Hardware Clock time.
+the Hardware Clock time. If the Hardware Clock is already in UTC, it is
+not reset.
 .TP
 .B \-\-adjust
 Add or subtract time from the Hardware Clock to account for systematic
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5a4c87e..351ce1f 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -772,7 +772,6 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
 	struct timeval tv;
 	struct tm *broken;
 	int minuteswest;
-	int rc;
 
 	gettimeofday(&tv, NULL);
 	if (debug) {
@@ -818,10 +817,24 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
 		       ("Not setting system clock because running in test mode.\n"));
 		retcode = 0;
 	} else {
+		const struct timezone tz_utc = { 0, 0 };
 		const struct timezone tz = { minuteswest, 0 };
 		const struct timeval *tv_null = NULL;
+		int rc = 0;
+
+		/* The first call to settimeofday after boot will assume the systemtime
+		 * is in localtime, and adjust it according to the given timezone to
+		 * compensate. If the systemtime is in fact in UTC, then this is wrong
+		 * so we first do a dummy call to make sure the time is not shifted.
+		 */
+		if (universal)
+			rc = settimeofday(tv_null, &tz_utc);
+
+		/* Now we set the real timezone. Due to the above dummy call, this will
+		 * only warp the systemtime if the RTC is not in UTC. */
+		if (!rc)
+			rc = settimeofday(tv_null, &tz);
 
-		rc = settimeofday(tv_null, &tz);
 		if (rc) {
 			if (errno == EPERM) {
 				warnx(_
-- 
1.7.12.1

