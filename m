Return-Path: elseifthen@gmx.com
Message-ID: <5449BED0.9020103@gmx.com>
Date: Thu, 23 Oct 2014 22:52:00 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 3/5] hwclock: add message line breaks
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


Add line breaks to messages over 80 characters long.
Wrap message lines in source code as needed.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 566ca91..3ad3791 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -694,7 +694,7 @@ display_time(const bool hclock_valid, struct timeval hwctime)
 	if (!hclock_valid)
 		warnx(_
 		      ("The Hardware Clock registers contain values that are "
-		       "either invalid (e.g. 50th day of month) or beyond the range "
+		       "either invalid\n(e.g. 50th day of month) or beyond the range "
 		       "we can handle (e.g. Year 2095)"));
 	else {
 		struct tm *lt;
@@ -781,7 +781,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 			    &seconds_since_epoch);
 		if (rc < 1) {
 			warnx(_("The date command issued by %s returned "
-				"something other than an integer where the "
+				"something other\nthan an integer where the "
 				"converted time value was expected\n"
 				"The command was:\n  %s\n"
 				"The response was:\n %s\n"),
@@ -830,8 +830,8 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,

 	if (!hclock_valid) {
 		warnx(_
-		      ("The Hardware Clock does not contain a valid time, so "
-		       "we cannot set the System Time from it"));
+		      ("The Hardware Clock does not contain a valid time\n"
+		       "So we cannot set the System Time from it"));
 		retcode = 1;
 	} else {
 		const struct timeval *tv_null = NULL;
@@ -1018,7 +1018,7 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 	} else if ((hclocktime.tv_sec - adjtime_p->last_calib_time) < 4 * 60 * 60) {
 		if (debug)
 			printf(_("Not adjusting drift factor because it has "
-				 "been less than four hours since the last "
+				 "been\nless than four hours since the last "
 				 "calibration\n"));
 	} else if (adjtime_p->last_calib_time != 0) {
 		/*
@@ -1149,20 +1149,23 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)
 			adjfile = fopen(adj_file_name, "w");
 			if (adjfile == NULL) {
 				warn(_
-				     ("Could not open file with the clock adjustment parameters "
+				     ("Could not open file with the "
+				      "clock adjustment\nparameters "
 				      "in it (%s) for writing"), adj_file_name);
 				err = 1;
 			} else {
 				if (fputs(newfile, adjfile) < 0) {
 					warn(_
-					     ("Could not update file with the clock adjustment "
+					     ("Could not update file with "
+					      "the clock adjustment\n"
 					      "parameters (%s) in it"),
 					     adj_file_name);
 					err = 1;
 				}
 				if (close_stream(adjfile) != 0) {
 					warn(_
-					     ("Could not update file with the clock adjustment "
+					     ("Could not update file with "
+					      "the clock adjustment\n"
 					      "parameters (%s) in it"),
 					     adj_file_name);
 					err = 1;
@@ -1214,11 +1217,13 @@ do_adjustment(struct adjtime *adjtime_p,
 		adjtime_p->dirty = TRUE;
 	} else if (adjtime_p->last_adj_time == 0) {
 		if (debug)
-			printf(_("Not setting clock because last adjustment time is zero, "
+			printf(_("Not setting clock because last "
+				 "adjustment time is zero, "
 				 "so history is bad\n"));
 	} else if (fabs(adjtime_p->drift_factor) > MAX_DRIFT) {
 		if (debug)
-			printf(_("Not setting clock because drift factor %f is far too high\n"),
+			printf(_("Not setting clock because a drift "
+				 "factor of %f is far too high\n"),
 				adjtime_p->drift_factor);
 	} else {
 		set_hardware_clock_exact(hclocktime.tv_sec,
@@ -1410,8 +1415,8 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 		hclocktime = time_inc(hclocktime, (double)
 				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
 		if (debug) {
-			printf(_
-			       ("At %ld seconds after 1969, RTC is predicted to read %ld seconds after 1969\n"),
+			printf(_("At %ld seconds after 1969, RTC is predicted\n"
+				 "to read %ld seconds after 1969\n"),
 			       set_time, (long)hclocktime.tv_sec);
 		}
 		display_time(TRUE, hclocktime);
@@ -1464,7 +1469,7 @@ manipulate_epoch(const bool getepoch,
 	} else if (setepoch) {
 		if (epoch_opt == -1)
 			warnx(_
-			      ("To set the epoch value, you must use the 'epoch' "
+			      ("To set the epoch value, you must use the\n'epoch' "
 			       "option to tell to what value to set it"));
 		else if (testing)
 			printf(_
