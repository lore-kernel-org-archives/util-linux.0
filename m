Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60536 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbaINT3d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Sep 2014 15:29:33 -0400
Message-ID: <5415EC97.4060305@gmx.com>
Date: Sun, 14 Sep 2014 15:29:27 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/2] hwclock: hctosys drift compensation
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Allowing hctosys to drift compensate facilitates:

More precise setting of the System Clock early in
the boot process when --adjust cannot be used
because the file system is not writeable.

Applies sub second drift corrections immediately,
where as --adjust cannot.

Reduces boot time by not calling hwclock multiple
times, e.g., --hctosys early before fsck when the
file system is read-only, then --adjust later when
the file system is read-write and --hctosys again
for drift correction.

Use of --adjust elsewhere may no longer be necessary.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 99 +++++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 474e04f..ef7bd89 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -437,6 +437,45 @@ mktime_tz(struct tm tm, const bool universal,
 }
 
 /*
+ * Do the drift adjustment calculation.
+ *
+ * The way we have to set the clock, we need the adjustment in two parts:
+ *
+ *	1) an integer number of seconds (return as *adjustment_p)
+ *	2) a positive fraction of a second (less than 1) (return as *retro_p)
+ *
+ * The sum of these two values is the adjustment needed. Positive means to
+ * advance the clock or insert seconds. Negative means to retard the clock
+ * or remove seconds.
+ */
+static void
+calculate_adjustment(const double factor,
+		     const time_t last_time,
+		     const double not_adjusted,
+		     const time_t systime, int *adjustment_p, double *retro_p)
+{
+	double exact_adjustment;
+
+	exact_adjustment =
+	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
+	    + not_adjusted;
+	*adjustment_p = FLOOR(exact_adjustment);
+
+	*retro_p = exact_adjustment - (double)*adjustment_p;
+	if (debug) {
+		printf(P_("Time since last adjustment is %d second\n",
+			"Time since last adjustment is %d seconds\n",
+		       (int)(systime - last_time)),
+		       (int)(systime - last_time));
+		printf(P_("Need to insert %d second and refer time back "
+			 "%.6f seconds ago\n",
+			 "Need to insert %d seconds and refer time back "
+			 "%.6f seconds ago\n", *adjustment_p),
+			 *adjustment_p, *retro_p);
+	}
+}
+
+/*
  * Read the hardware clock and return the current time via <tm> argument.
  *
  * Use the method indicated by <method> argument to access the hardware
@@ -793,7 +832,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 }
 
 /*
- * Set the System Clock to time 'newtime'.
+ * Set the System Clock to time 'newtime' plus any drift correction.
  *
  * Also set the kernel time zone value to the value indicated by the TZ
  * environment variable and/or /usr/lib/zoneinfo/, interpreted as tzset()
@@ -807,8 +846,8 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
  * have.
  */
 static int
-set_system_clock(const bool hclock_valid, const time_t newtime,
-		 const bool testing)
+set_system_clock(struct adjtime *adjtime_p, const bool hclock_valid,
+		 const time_t newtime, const bool testing)
 {
 	int retcode;
 
@@ -834,6 +873,16 @@ set_system_clock(const bool hclock_valid, const time_t newtime,
 		if (broken->tm_isdst)
 			minuteswest -= 60;
 #endif
+		int adjustment;
+		/* Number of seconds the Hardware Clock has drifted. */
+		double retro;
+		/* Fraction of second the Hardware Clock has drifted. */
+		calculate_adjustment(adjtime_p->drift_factor,
+				     adjtime_p->last_adj_time,
+				     adjtime_p->not_adjusted,
+				     newtime, &adjustment, &retro);
+		tv.tv_sec += adjustment;
+		tv.tv_usec += retro * 1E6;
 
 		if (debug) {
 			printf(_("Calling settimeofday:\n"));
@@ -1072,45 +1121,6 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 }
 
 /*
- * Do the drift adjustment calculation.
- *
- * The way we have to set the clock, we need the adjustment in two parts:
- *
- *	1) an integer number of seconds (return as *adjustment_p)
- *	2) a positive fraction of a second (less than 1) (return as *retro_p)
- *
- * The sum of these two values is the adjustment needed. Positive means to
- * advance the clock or insert seconds. Negative means to retard the clock
- * or remove seconds.
- */
-static void
-calculate_adjustment(const double factor,
-		     const time_t last_time,
-		     const double not_adjusted,
-		     const time_t systime, int *adjustment_p, double *retro_p)
-{
-	double exact_adjustment;
-
-	exact_adjustment =
-	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
-	    + not_adjusted;
-	*adjustment_p = FLOOR(exact_adjustment);
-
-	*retro_p = exact_adjustment - (double)*adjustment_p;
-	if (debug) {
-		printf(P_("Time since last adjustment is %d second\n",
-			"Time since last adjustment is %d seconds\n",
-		       (int)(systime - last_time)),
-		       (int)(systime - last_time));
-		printf(P_("Need to insert %d second and refer time back "
-			 "%.6f seconds ago\n",
-			 "Need to insert %d seconds and refer time back "
-			 "%.6f seconds ago\n", *adjustment_p),
-			 *adjustment_p, *retro_p);
-	}
-}
-
-/*
  * Write the contents of the <adjtime> structure to its disk file.
  *
  * But if the contents are clean (unchanged since read from disk), don't
@@ -1313,7 +1323,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 	}
 
 	if (!noadjfile
-	    && (adjust || set || systohc || (!utc && !local_opt) || predict)) {
+	    && (adjust || set || systohc ||
+	        hctosys || (!utc && !local_opt) || predict)) {
 		rc = read_adjtime(&adjtime);
 		if (rc)
 			return rc;
@@ -1393,7 +1404,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 					    hclock_valid, hclocktime, (double)
 					    read_time.tv_usec / 1E6);
 	} else if (hctosys) {
-		rc = set_system_clock(hclock_valid, hclocktime, testing);
+		rc = set_system_clock(&adjtime, hclock_valid, hclocktime, testing);
 		if (rc) {
 			printf(_("Unable to set system clock.\n"));
 			return rc;


