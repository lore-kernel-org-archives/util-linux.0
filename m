Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdHSATS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Aug 2017 20:19:18 -0400
Subject: [PATCH 2/6] hwclock: remove set_system_clock_timezone()
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9b497c68-bbb8-5f95-1de9-1acbcc5368a1@gmx.com>
Date: Fri, 18 Aug 2017 20:19:15 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Remove set_system_clock_timezone() because the previous patch
moved its functionality into set_system_clock().

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 89 -----------------------------------------------------
 1 file changed, 89 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e49f1a1..ddd6413 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -641,95 +641,6 @@ set_system_clock(const struct hwclock_control *ctl,
 }
 
 /*
- * Reset the System Clock from local time to UTC, based on its current value
- * and the timezone unless universal is TRUE.
- *
- * Also set the kernel time zone value to the value indicated by the TZ
- * environment variable and/or /usr/lib/zoneinfo/, interpreted as tzset()
- * would interpret them.
- *
- * If 'testing' is true, don't actually update anything -- just say we would
- * have.
- */
-static int set_system_clock_timezone(const struct hwclock_control *ctl)
-{
-	int retcode;
-	struct timeval tv;
-	struct tm *broken;
-	int minuteswest;
-
-	gettimeofday(&tv, NULL);
-	if (ctl->debug) {
-		struct tm broken_time;
-		char ctime_now[200];
-
-		broken_time = *gmtime(&tv.tv_sec);
-		strftime(ctime_now, sizeof(ctime_now), "%Y/%m/%d %H:%M:%S",
-			 &broken_time);
-		printf(_("Current system time: %ld = %s\n"), tv.tv_sec,
-		       ctime_now);
-	}
-
-	broken = localtime(&tv.tv_sec);
-#ifdef HAVE_TM_GMTOFF
-	minuteswest = -broken->tm_gmtoff / 60;	/* GNU extension */
-#else
-	minuteswest = timezone / 60;
-	if (broken->tm_isdst)
-		minuteswest -= 60;
-#endif
-
-	if (ctl->debug) {
-		struct tm broken_time;
-		char ctime_now[200];
-
-		gettimeofday(&tv, NULL);
-		if (!ctl->universal)
-			tv.tv_sec += minuteswest * 60;
-
-		broken_time = *gmtime(&tv.tv_sec);
-		strftime(ctime_now, sizeof(ctime_now), "%Y/%m/%d %H:%M:%S",
-			 &broken_time);
-
-		printf(_("Calling settimeofday:\n"));
-		printf(_("\tUTC: %s\n"), ctime_now);
-		printf(_("\ttv.tv_sec = %ld, tv.tv_usec = %ld\n"),
-		       tv.tv_sec, tv.tv_usec);
-		printf(_("\ttz.tz_minuteswest = %d\n"), minuteswest);
-	}
-	if (ctl->testing) {
-		printf(_
-		       ("Test mode: clock was not changed\n"));
-		retcode = 0;
-	} else {
-		const struct timezone tz_utc = { 0, 0 };
-		const struct timezone tz = { minuteswest, 0 };
-		const struct timeval *tv_null = NULL;
-		int rc = 0;
-
-		/* The first call to settimeofday after boot will assume the systemtime
-		 * is in localtime, and adjust it according to the given timezone to
-		 * compensate. If the systemtime is in fact in UTC, then this is wrong
-		 * so we first do a dummy call to make sure the time is not shifted.
-		 */
-		if (ctl->universal)
-			rc = settimeofday(tv_null, &tz_utc);
-
-		/* Now we set the real timezone. Due to the above dummy call, this will
-		 * only warp the systemtime if the RTC is not in UTC. */
-		if (!rc)
-			rc = settimeofday(tv_null, &tz);
-
-		if (rc) {
-			warn(_("settimeofday() failed"));
-			retcode = 1;
-		} else
-			retcode = 0;
-	}
-	return retcode;
-}
-
-/*
  * Refresh the last calibrated and last adjusted timestamps in <*adjtime_p>
  * to facilitate future drift calculations based on this set point.
  *
