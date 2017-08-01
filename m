Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/8] hwclock: move drift correction and --predict
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ae9a3cf6-7eed-26c9-6247-bafa7d842cf8@gmx.com>
Date: Tue, 1 Aug 2017 09:16:02 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Move the predict branch above the RTC read branch.

Move drift correction into the RTC read branch, because it
requires an accurate RTC read, and it needs to be skipped for
operations that do not require an RTC read.

Simplify the RTC read branch test.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 57 +++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index ad9c502..1550dfe 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1042,15 +1042,34 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		adjtime->local_utc = ctl->universal ? UTC : LOCAL;
 		adjtime->dirty = TRUE;
 	}
+	/*
+	 * Negate the drift correction, because we want to 'predict' a
+	 * Hardware Clock time that includes drift.
+	 */
+	if (ctl->predict) {
+		hclocktime = t2tv(set_time);
+		calculate_adjustment(ctl, adjtime->drift_factor,
+				     adjtime->last_adj_time,
+				     adjtime->not_adjusted,
+				     hclocktime.tv_sec, &tdrift);
+		hclocktime = time_inc(hclocktime, (double)
+				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
+		if (ctl->debug) {
+			printf(_ ("Target date:   %ld\n"), set_time);
+			printf(_ ("Predicted RTC: %ld\n"), hclocktime.tv_sec);
+		}
+		display_time(TRUE, hclocktime);
+		return 0;
+	}
 
 	if (ctl->systz)
 		return set_system_clock_timezone(ctl);
 
-	if (!ctl->predict && ur->get_permissions())
+	if (ur->get_permissions())
 		return EX_NOPERM;
 
 	if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
-	    || (!ctl->noadjfile && !ctl->predict)) {
+	    || !ctl->noadjfile) {
 		/* data from HW-clock are required */
 		rc = synchronize_to_clock_tick(ctl);
 
@@ -1075,22 +1094,17 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			if (rc && !ctl->set && !ctl->systohc)
 				return EX_IOERR;
 		}
+		/*
+		 * Calculate and apply drift correction to the Hardware Clock
+		 * time for everything except --show
+		 */
+		calculate_adjustment(ctl, adjtime->drift_factor,
+				     adjtime->last_adj_time,
+				     adjtime->not_adjusted,
+				     hclocktime.tv_sec, &tdrift);
+		if (!ctl->show)
+			hclocktime = time_inc(tdrift, hclocktime.tv_sec);
 	}
-	/*
-	 * Calculate Hardware Clock drift for --predict with the user
-	 * supplied --date option time, and with the time read from the
-	 * Hardware Clock for all other operations.  Apply drift correction
-	 * to the Hardware Clock time for everything except --show and
-	 * --predict.  For --predict negate the drift correction, because we
-	 * want to 'predict' a future Hardware Clock time that includes drift.
-	 */
-	hclocktime = ctl->predict ? t2tv(set_time) : hclocktime;
-	calculate_adjustment(ctl, adjtime->drift_factor,
-			     adjtime->last_adj_time,
-			     adjtime->not_adjusted,
-			     hclocktime.tv_sec, &tdrift);
-	if (!ctl->show && !ctl->predict)
-		hclocktime = time_inc(tdrift, hclocktime.tv_sec);
 	if (ctl->show || ctl->get) {
 		display_time(hclock_valid,
 			     time_inc(hclocktime, -time_diff
@@ -1126,15 +1140,6 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 					    hclock_valid, hclocktime);
 	} else if (ctl->hctosys) {
 		return set_system_clock(ctl, hclock_valid, hclocktime);
-	} else if (ctl->predict) {
-		hclocktime = time_inc(hclocktime, (double)
-				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
-		if (ctl->debug) {
-			printf(_
-			       ("At %ld seconds after 1969, RTC is predicted to read %ld seconds after 1969.\n"),
-			       set_time, hclocktime.tv_sec);
-		}
-		display_time(TRUE, hclocktime);
 	}
 	if (!ctl->noadjfile)
 		save_adjtime(ctl, adjtime);
