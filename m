Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49754 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbaI0P3U (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Sep 2014 11:29:20 -0400
Message-ID: <5426D7CA.6050400@gmx.com>
Date: Sat, 27 Sep 2014 11:29:14 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/7] hwclock: hctosys drift compensation II COMMENTS
References: <5426D4C2.4060403@gmx.com>
In-Reply-To: <5426D4C2.4060403@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Update source comments and --help output for the
hwclock: hctosys drift compensation II patch.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 59 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0dd9ad6..08e79e8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -683,11 +683,9 @@ set_hardware_clock_exact(const time_t sethwtime,
 }
 
 /*
- * Put the time "systime" on standard output in display format. Except if
+ * Put the time "hwctime" on standard output in display format. Except if
  * hclock_valid == false, just tell standard output that we don't know what
  * time it is.
- *
- * Include in the output the adjustment "sync_duration".
  */
 static void
 display_time(const bool hclock_valid, struct timeval hwctime)
@@ -1021,7 +1019,14 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 	        struct timeval lastCalib;
 
 		lastCalib = t2tv(adjtime_p->last_calib_time);
-
+		/*
+		 * Correction to apply to the current drift factor.
+		 *
+		 * Simplified: uncorrected_drift / days_since_calibration.
+		 *
+		 * hclocktime is fully corrected with the current drift factor.
+		 * Its difference from nowtime is the missed drift correction.
+		 */
 		factor_adjust = time_diff(nowtime, hclocktime) /
 				(time_diff(nowtime, lastCalib) / sec_per_day);
 
@@ -1056,16 +1061,12 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 }
 
 /*
- * Do the drift adjustment calculation.
- *
- * The way we have to set the clock, we need the adjustment in two parts:
+ * Calculate the drift correction currently needed for the
+ * Hardware Clock based on the last time it was adjusted,
+ * and the current drift factor, as stored in the adjtime file.
  *
- *	1) an integer number of seconds (return as *adjustment_p)
- *	2) a positive fraction of a second (less than 1) (return as *retro_p)
+ * The total drift adjustment needed is stored at tdrift_p.
  *
- * The sum of these two values is the adjustment needed. Positive means to
- * advance the clock or insert seconds. Negative means to retard the clock
- * or remove seconds.
  */
 static void
 calculate_adjustment(const double factor,
@@ -1160,24 +1161,21 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)
  * Do not update anything if the Hardware Clock does not currently present a
  * valid time.
  *
- * Arguments <factor> and <last_time> are current values from the adjtime
- * file.
+ * <hclock_valid> means the Hardware Clock contains a valid time.
  *
- * <hclock_valid> means the Hardware Clock contains a valid time, and that
- * time is <hclocktime>.
+ * <hclocktime> is the drift corrected time read from the Hardware Clock.
  *
- * <read_time> is the current system time (to be precise, it is the system
- * time at the time <hclocktime> was read, which due to computational delay
- * could be a short time ago).
+ * <read_time> was the system time when the <hclocktime> was read, which due
+ * to computational delay could be a short time ago. It is used to define a
+ * trigger point for setting the Hardware Clock. The fractional part of the
+ * Hardware clock set time is subtracted from read_time to 'refer back', or
+ * delay, the trigger point.  Fractional parts must be accounted for in this
+ * way, because the Hardware Clock can only be set to a whole second.
  *
  * <universal>: the Hardware Clock is kept in UTC.
  *
  * <testing>:  We are running in test mode (no updating of clock).
  *
- * We do not bother to update the clock if the adjustment would be less than
- * one second. This is to avoid cumulative error and needless CPU hogging
- * (remember we use an infinite loop for some timing) if the user runs us
- * frequently.
  */
 static void
 do_adjustment(struct adjtime *adjtime_p,
@@ -1265,11 +1263,11 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 	 */
 	bool hclock_valid = FALSE;
 	/*
-	 * The time the hardware clock had just after we
-	 * synchronized to its next clock tick when we
-	 * started up. Defined only if hclock_valid is true.
+	 * Tick synchronized time read from the Hardware Clock and
+	 * then drift correct for all operations except --show.
 	 */
 	struct timeval hclocktime = { 0, 0 };
+	/* Total Hardware Clock drift correction needed. */
 	struct timeval tdrift;
 	/* local return code */
 	int rc = 0;
@@ -1325,6 +1323,14 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 				return EX_IOERR;
 		}
 	}
+	/*
+	 * Calculate Hardware Clock drift for --predict with the user
+	 * supplied --date option time, and with the time read from the
+	 * Hardware Clock for all other operations.  Apply drift correction
+	 * to the Hardware Clock time for everything except --show and
+	 * --predict.  For --predict negate the drift correction, because we
+	 * want to 'predict' a future Hardware Clock time that includes drift.
+	 */
 	hclocktime = predict ? t2tv(set_time) : hclocktime;
 	calculate_adjustment(adjtime.drift_factor,
 			     adjtime.last_adj_time,
@@ -1544,6 +1550,7 @@ static void usage(const char *fmt, ...)
 	fputs(_("\nFunctions:\n"), usageto);
 	fputs(_(" -h, --help           show this help text and exit\n"
 		" -r, --show           read hardware clock and print result\n"
+		"     --get            read hardware clock and print drift corrected result\n"
 		"     --set            set the RTC to the time given with --date\n"), usageto);
 	fputs(_(" -s, --hctosys        set the system time from the hardware clock\n"
 		" -w, --systohc        set the hardware clock from the current system time\n"
