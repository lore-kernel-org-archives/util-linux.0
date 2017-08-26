Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33146 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbdHZMiM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 26 Aug 2017 08:38:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id z91so1344492wrc.0
        for <util-linux@vger.kernel.org>; Sat, 26 Aug 2017 05:38:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] hwclock: remove bool type definition
Date: Sat, 26 Aug 2017 13:38:07 +0100
Message-Id: <20170826123807.7549-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use plain int instead of type defining it to a boolean, and use numbers to
signify true or false as we do everywhere else in this source tree.  And in
hwclock-cmos.c file booleans weren't even needed, to the related code is
removed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock-cmos.c | 14 +++++---------
 sys-utils/hwclock.c      | 35 +++++++++++++++++++----------------
 sys-utils/hwclock.h      |  2 --
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index cdbc88b03..f7e8a1811 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -277,10 +277,9 @@ static int synchronize_to_clock_tick_cmos(const struct hwclock_control *ctl
 static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 				    __attribute__((__unused__)), struct tm *tm)
 {
-	bool got_time = FALSE;
 	unsigned char status = 0, pmbit = 0;
 
-	while (!got_time) {
+	while (1) {
 		/*
 		 * Bit 7 of Byte 10 of the Hardware Clock value is the
 		 * Update In Progress (UIP) bit, which is on while and 244
@@ -310,7 +309,7 @@ static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 			 * consider this a good clock read .
 			 */
 			if (tm->tm_sec == hclock_read(0))
-				got_time = TRUE;
+				break;
 		}
 		/*
 		 * Yes, in theory we could have been running for 60 seconds
@@ -403,16 +402,13 @@ static struct clock_ops cmos_interface = {
 };
 
 /*
- * return &cmos if cmos clock present, NULL otherwise choose this
- * construction to avoid gcc messages about unused variables
+ * return &cmos if cmos clock present, NULL otherwise.
  */
 struct clock_ops *probe_for_cmos_clock(void)
 {
-	static const int have_cmos =
 #if defined(__i386__) || defined(__x86_64__)
-	    TRUE;
+	return &cmos_interface;
 #else
-	    FALSE;
+	return NULL;
 #endif
-	return have_cmos ? &cmos_interface : NULL;
 }
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 31cd02767..0b8444156 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -105,7 +105,7 @@ struct adjtime {
 	 * structure is not what's in the disk file (because it has been
 	 * updated since read from the disk file).
 	 */
-	bool dirty;
+	int dirty;
 	/* line 1 */
 	double drift_factor;
 	time_t last_adj_time;
@@ -170,16 +170,16 @@ static struct timeval time_inc(struct timeval addend, double increment)
 	return newtime;
 }
 
-static bool
+static int
 hw_clock_is_utc(const struct hwclock_control *ctl,
 		const struct adjtime adjtime)
 {
-	bool ret;
+	int ret;
 
 	if (ctl->utc)
-		ret = TRUE;	/* --utc explicitly given on command line */
+		ret = 1;	/* --utc explicitly given on command line */
 	else if (ctl->local_opt)
-		ret = FALSE;	/* --localtime explicitly given */
+		ret = 0;	/* --localtime explicitly given */
 	else
 		/* get info from adjtime file - default is UTC */
 		ret = (adjtime.local_utc != LOCAL);
@@ -306,10 +306,12 @@ static int synchronize_to_clock_tick(const struct hwclock_control *ctl)
  * case, we return the same fictional value mktime() does as *systime_p and
  * return *valid_p == true.
  */
-static void
+static int
 mktime_tz(const struct hwclock_control *ctl, struct tm tm,
-	  bool *valid_p, time_t *systime_p)
+	  time_t *systime_p)
 {
+	int valid;
+
 	if (ctl->universal)
 		*systime_p = timegm(&tm);
 	else
@@ -321,14 +323,14 @@ mktime_tz(const struct hwclock_control *ctl, struct tm tm,
 		 * (however, not containing valid values does _not_ imply
 		 * mktime() returns -1).
 		 */
-		*valid_p = FALSE;
+		valid = 0;
 		if (ctl->debug)
 			printf(_("Invalid values in hardware clock: "
 				 "%4d/%.2d/%.2d %.2d:%.2d:%.2d\n"),
 			       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			       tm.tm_hour, tm.tm_min, tm.tm_sec);
 	} else {
-		*valid_p = TRUE;
+		valid = 1;
 		if (ctl->debug)
 			printf(_
 			       ("Hw clock time : %4d/%.2d/%.2d %.2d:%.2d:%.2d = "
@@ -336,6 +338,7 @@ mktime_tz(const struct hwclock_control *ctl, struct tm tm,
 			       tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min,
 			       tm.tm_sec, (long)*systime_p);
 	}
+	return valid;
 }
 
 /*
@@ -346,7 +349,7 @@ mktime_tz(const struct hwclock_control *ctl, struct tm tm,
  */
 static int
 read_hardware_clock(const struct hwclock_control *ctl,
-		    bool * valid_p, time_t *systime_p)
+		    int *valid_p, time_t *systime_p)
 {
 	struct tm tm;
 	int err;
@@ -360,7 +363,7 @@ read_hardware_clock(const struct hwclock_control *ctl,
 		       ("Time read from Hardware Clock: %4d/%.2d/%.2d %02d:%02d:%02d\n"),
 		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
 		       tm.tm_min, tm.tm_sec);
-	mktime_tz(ctl, tm, valid_p, systime_p);
+	*valid_p = mktime_tz(ctl, tm, systime_p);
 
 	return 0;
 }
@@ -749,7 +752,7 @@ adjust_drift_factor(const struct hwclock_control *ctl,
 
 	adjtime_p->not_adjusted = 0;
 
-	adjtime_p->dirty = TRUE;
+	adjtime_p->dirty = 1;
 }
 
 /*
@@ -873,7 +876,7 @@ do_adjustment(const struct hwclock_control *ctl, struct adjtime *adjtime_p,
 						  -(hclocktime.tv_usec / 1E6)));
 		adjtime_p->last_adj_time = hclocktime.tv_sec;
 		adjtime_p->not_adjusted = 0;
-		adjtime_p->dirty = TRUE;
+		adjtime_p->dirty = 1;
 	}
 }
 
@@ -921,7 +924,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	 * The Hardware Clock gives us a valid time, or at
 	 * least something close enough to fool mktime().
 	 */
-	bool hclock_valid = FALSE;
+	int hclock_valid = 0;
 	/*
 	 * Tick synchronized time read from the Hardware Clock and
 	 * then drift corrected for all operations except --show.
@@ -938,7 +941,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	if ((ctl->set || ctl->systohc || ctl->adjust) &&
 	    (adjtime->local_utc == UTC) != ctl->universal) {
 		adjtime->local_utc = ctl->universal ? UTC : LOCAL;
-		adjtime->dirty = TRUE;
+		adjtime->dirty = 1;
 	}
 	/*
 	 * Negate the drift correction, because we want to 'predict' a
@@ -1379,7 +1382,7 @@ int main(int argc, char **argv)
 			hwclock_exit(&ctl, rc);
 	} else
 		/* Avoid writing adjtime file if we don't have to. */
-		adjtime.dirty = FALSE;
+		adjtime.dirty = 0;
 	ctl.universal = hw_clock_is_utc(&ctl, adjtime);
 	rc = manipulate_clock(&ctl, set_time, startup_time, &adjtime);
 	hwclock_exit(&ctl, rc);
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 6943d8d79..215cf9302 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -53,8 +53,6 @@ struct clock_ops {
 extern struct clock_ops *probe_for_cmos_clock(void);
 extern struct clock_ops *probe_for_rtc_clock(const struct hwclock_control *ctl);
 
-typedef int bool;
-
 /* hwclock.c */
 extern int debug;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
-- 
2.14.1

