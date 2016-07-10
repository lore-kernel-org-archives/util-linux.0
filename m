Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34905 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbcGJUCr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Jul 2016 16:02:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id k123so13826980wme.2
        for <util-linux@vger.kernel.org>; Sun, 10 Jul 2016 13:02:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] hwclock: remove UTC-0 localization hack
Date: Sun, 10 Jul 2016 21:02:42 +0100
Message-Id: <20160710200242.2706-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no need to re-implement timegm() by removing TZ localization for a
moment, just use timegm(3) instead.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e98c2c0..bcaab8b 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -388,27 +388,11 @@ static void
 mktime_tz(struct tm tm, const bool universal,
 	  bool * valid_p, time_t * systime_p)
 {
-	time_t mktime_result;	/* The value returned by our mktime() call */
-	char *zone;		/* Local time zone name */
-
-	/*
-	 * We use the C library function mktime(), but since it only works
-	 * on local time zone input, we may have to fake it out by
-	 * temporarily changing the local time zone to UTC.
-	 */
-	zone = getenv("TZ");	/* remember original time zone */
-	if (universal) {
-		/* Set timezone to UTC */
-		setenv("TZ", "", TRUE);
-		/*
-		 * Note: tzset() gets called implicitly by the time code,
-		 * but only the first time. When changing the environment
-		 * variable, better call tzset() explicitly.
-		 */
-		tzset();
-	}
-	mktime_result = mktime(&tm);
-	if (mktime_result == -1) {
+	if (universal)
+		*systime_p = timegm(&tm);
+	else
+		*systime_p = mktime(&tm);
+	if (*systime_p == -1) {
 		/*
 		 * This apparently (not specified in mktime() documentation)
 		 * means the 'tm' structure does not contain valid values
@@ -416,7 +400,6 @@ mktime_tz(struct tm tm, const bool universal,
 		 * mktime() returns -1).
 		 */
 		*valid_p = FALSE;
-		*systime_p = 0;
 		if (debug)
 			printf(_("Invalid values in hardware clock: "
 				 "%4d/%.2d/%.2d %.2d:%.2d:%.2d\n"),
@@ -424,7 +407,6 @@ mktime_tz(struct tm tm, const bool universal,
 			       tm.tm_hour, tm.tm_min, tm.tm_sec);
 	} else {
 		*valid_p = TRUE;
-		*systime_p = mktime_result;
 		if (debug)
 			printf(_
 			       ("Hw clock time : %4d/%.2d/%.2d %.2d:%.2d:%.2d = "
@@ -432,12 +414,6 @@ mktime_tz(struct tm tm, const bool universal,
 			       tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min,
 			       tm.tm_sec, (long)*systime_p);
 	}
-	/* now put back the original zone. */
-	if (zone)
-		setenv("TZ", zone, TRUE);
-	else
-		unsetenv("TZ");
-	tzset();
 }
 
 /*
-- 
2.9.0

