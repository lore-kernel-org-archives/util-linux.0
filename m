Return-Path: elseifthen@gmx.com
Message-ID: <5426D7F9.4030306@gmx.com>
Date: Sat, 27 Sep 2014 11:30:01 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 6/7] hwclock: Add --update option
References: <5426D4C2.4060403@gmx.com>
In-Reply-To: <5426D4C2.4060403@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


There are cases where we need to refresh the
timestamps in the adjtime file without updating the
drift factor.

For example, with ntpd and an Eleven Minute Mode
kernel, we need to call systohc at shutdown to
facilitate drift correction.  With the current
behavior hwclock will clobber the drift factor to
near zero, because the Hardware Clock and System
Clock are synced by Eleven Minute Mode.  What
actually needs to be done is refresh the adjtime
file timestamps and not calculate a new drift
factor.

Because it is a manual process to craft a good
Hardware Clock drift factor, that is, there is no
automated method that will produce a good drift
factor, this patch changes the default drift
calculation behavior to off, and it is turned on
by using the --update option. Once we have a good
drift factor for a given machine we do not want
anything clobbering it, including an administrator
forgetting to turn off recalculation. A system
administrator should make a concious effort in
telling hwclock with the --update option that
(s)he wants to recalculate the drift factor.

Without using the --update option with calibrate
operations only the timestamps are refreshed in
the adjtime file. With the --update option the old
default behavior of refreshing the timestamps and
updating the drift factor is performed.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 62 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 42f54c2..c5c3560 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -980,12 +980,13 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
 }
 
 /*
- * Update the drift factor in <*adjtime_p> to reflect the fact that the
- * Hardware Clock was calibrated to <nowtime> and before that was set to
- * <hclocktime>.
+ * Refresh the last calibrated and last adjusted timestamps in <*adjtime_p>
+ * to facilitate future drift calculations based on this set point.
  *
- * We record in the adjtime file the time at which we last calibrated the
- * clock so we can compute the drift rate each time we calibrate.
+ * With the --update option:
+ * Update the drift factor in <*adjtime_p> based on the fact that the
+ * Hardware Clock was just calibrated to <nowtime> and before that was
+ * set to the <hclocktime> time scale.
  *
  * EXCEPT: if <hclock_valid> is false, assume Hardware Clock was not set
  * before to anything meaningful and regular adjustments have not been done,
@@ -995,9 +996,20 @@ static void
 adjust_drift_factor(struct adjtime *adjtime_p,
 		    const struct timeval nowtime,
 		    const bool hclock_valid,
-		    const struct timeval hclocktime)
+		    const struct timeval hclocktime,
+		    const bool update)
 {
-	if (!hclock_valid) {
+	if (!update) {
+		/*
+		 * Because the update option introduced new behavior to hwclock
+		 * we warn when it is not used. After a reasonable introduction
+		 * period this could be removed.
+		 */
+		warnx(_("--update option is now required to update drift factor."));
+		if (debug)
+			printf(_("Not adjusting drift factor because the "
+				 "--update option was not used.\n"));
+	} else if (!hclock_valid) {
 		if (debug)
 			printf(_("Not adjusting drift factor because the "
 				 "Hardware Clock previously contained "
@@ -1015,14 +1027,15 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 				 "calibration.\n"));
 	} else if (adjtime_p->last_calib_time != 0) {
 		/*
-		 * At adjustment time we adjust the hardware clock according
-		 * to the contents of /etc/adjtime.
+		 * At adjustment time we drift correct the hardware clock
+		 * according to the contents of the adjtime file and refresh
+		 * its last adjusted timestamp.
 		 *
-		 * At calibration time we set the hardware clock and update
-		 * /etc/adjtime, that is, for each calibration (except the
-		 * first) we also do an adjustment.
+		 * At calibration time we set the Hardware Clock and refresh
+		 * both timestamps in <*adjtime_p>.
 		 *
-		 * We are now at calibration time.
+		 * Here, with the --update option, we also update the drift
+		 * factor in <*adjtime_p>.
 		 *
 		 * Let us do computation in doubles. (Floats almost suffice,
 		 * but 195 days + 1 second equals 195 days in floats.)
@@ -1261,7 +1274,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 		 const bool set, const time_t set_time,
 		 const bool hctosys, const bool systohc, const bool systz,
 		 const struct timeval startup_time,
-		 const bool utc, const bool local_opt,
+		 const bool utc, const bool local_opt, const bool update,
 		 const bool testing, const bool predict, const bool get)
 {
 	/* Contents of the adjtime file, or what they should be. */
@@ -1366,7 +1379,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 			adjust_drift_factor(&adjtime,
 					    time_inc(t2tv(set_time), time_diff
 						     (read_time, startup_time)),
-					    hclock_valid, hclocktime);
+					    hclock_valid, hclocktime, update);
 	} else if (adjust) {
 		if (tdrift.tv_sec > 0 || tdrift.tv_sec < -1)
 			do_adjustment(&adjtime, hclock_valid,
@@ -1390,7 +1403,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 					 reftime, universal, testing);
 		if (!noadjfile)
 			adjust_drift_factor(&adjtime, nowtime,
-					    hclock_valid, hclocktime);
+					    hclock_valid, hclocktime, update);
 	} else if (hctosys) {
 		rc = set_system_clock(hclock_valid, hclocktime,
 				      testing, universal);
@@ -1594,10 +1607,11 @@ static void usage(const char *fmt, ...)
 		"     --epoch <year>   specifies the year which is the beginning of the\n"
 		"                        hardware clock's epoch value\n"), _PATH_RTC_DEV);
 	fprintf(usageto, _(
+		"     --update         update drift factor in %s\n"
 		"     --noadjfile      do not access %s; this requires the use of\n"
 		"                        either --utc or --localtime\n"
 		"     --adjfile <file> specifies the path to the adjust file;\n"
-		"                        the default is %s\n"), _PATH_ADJTIME, _PATH_ADJTIME);
+		"                        the default is %s\n"), _PATH_ADJTIME, _PATH_ADJTIME, _PATH_ADJTIME);
 	fputs(_("     --test           do not update anything, just show what would happen\n"
 		" -D, --debug          debugging mode\n" "\n"), usageto);
 #ifdef __alpha__
@@ -1641,7 +1655,7 @@ int main(int argc, char **argv)
 	/* The options debug, badyear and epoch_option are global */
 	bool show, set, systohc, hctosys, systz, adjust, getepoch, setepoch,
 	    predict, compare, get;
-	bool utc, testing, local_opt, noadjfile, directisa;
+	bool utc, testing, local_opt, update, noadjfile, directisa;
 	char *date_opt;
 #ifdef __alpha__
 	bool ARCconsole, Jensen, SRM, funky_toy;
@@ -1661,7 +1675,8 @@ int main(int argc, char **argv)
 		OPT_SET,
 		OPT_SETEPOCH,
 		OPT_SYSTZ,
-		OPT_TEST
+		OPT_TEST,
+		OPT_UPDATE
 	};
 
 	static const struct option longopts[] = {
@@ -1702,6 +1717,7 @@ int main(int argc, char **argv)
 		{"systz",	0, 0, OPT_SYSTZ},
 		{"predict-hc",	0, 0, OPT_PREDICT_HC},
 		{"get",		0, 0, OPT_GET},
+		{"update",      0, 0, OPT_UPDATE},
 		{NULL,		0, NULL, 0}
 	};
 
@@ -1711,6 +1727,7 @@ int main(int argc, char **argv)
 		  OPT_SET, OPT_SETEPOCH, OPT_SYSTZ },
 		{ 'u', OPT_LOCALTIME},
 		{ OPT_ADJFILE, OPT_NOADJFILE },
+		{ OPT_NOADJFILE, OPT_UPDATE },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -1745,7 +1762,7 @@ int main(int argc, char **argv)
 
 	/* Set option defaults */
 	show = set = systohc = hctosys = systz = adjust = noadjfile = predict =
-	    compare = get = FALSE;
+	    compare = get = update = FALSE;
 	getepoch = setepoch = utc = local_opt = directisa = testing = debug = FALSE;
 #ifdef __alpha__
 	ARCconsole = Jensen = SRM = funky_toy = badyear = FALSE;
@@ -1838,6 +1855,9 @@ int main(int argc, char **argv)
 		case OPT_GET:
 			get = TRUE;		/* --get */
 			break;
+		case OPT_UPDATE:
+			update = TRUE;		/* --update */
+			break;
 #ifdef __linux__
 		case 'f':
 			rtc_dev_name = optarg;	/* --rtc */
@@ -1952,7 +1972,7 @@ int main(int argc, char **argv)
 	} else
 		rc = manipulate_clock(show, adjust, noadjfile, set, set_time,
 			      hctosys, systohc, systz, startup_time, utc,
-			      local_opt, testing, predict, get);
+			      local_opt, update, testing, predict, get);
 
 	hwclock_exit(rc);
 	return rc;		/* Not reached */
