Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/2] hwclock: rename --debug option to --verbose
To: Karel Zak <kzak@redhat.com>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <25e935d3-37ff-a02b-8e5e-30f41dd88ae0@gmx.com>
Date: Sun, 24 Dec 2017 15:37:36 -0500
MIME-Version: 1.0
In-Reply-To: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Warn on --debug; do not fallthrough because
the message is lost in the verbose output.

Coauthored-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/deprecated.txt | 12 ++++++++
 sys-utils/hwclock-rtc.c      | 10 +++---
 sys-utils/hwclock.8.in       | 15 ++++++---
 sys-utils/hwclock.c          | 73 +++++++++++++++++++++++---------------------
 sys-utils/hwclock.h          |  3 +-
 5 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 34ea698da..f1ec8953d 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -2,6 +2,18 @@ The following is a list of commands or features that are deprecated.  All
 deprecated utils are in maintenance mode and we keep them in source tree for
 backward compatibility only.
 
+what:  hwclock --debug
+why:   renamed to --verbose, and may be repurposed later.
+since: v2.32
+
+--------------------------
+
+what:  hwclock -v for version
+why:   renamed to -V
+since: v2.20 (was repurposed to verbose in v2.32)
+
+--------------------------
+
 what:  column --columns
 why:   renamed to --output-width
 since: v2.30
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index cdd7d80d6..ef95d9807 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -124,7 +124,7 @@ static int open_rtc(const struct hwclock_control *ctl)
 		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
 	} else {
 		for (i = 0; i < ARRAY_SIZE(fls); i++) {
-			if (ctl->debug)
+			if (ctl->verbose)
 				printf(_("Trying to open: %s\n"), fls[i]);
 			rtc_dev_fd = open(fls[i], O_RDONLY);
 
@@ -208,7 +208,7 @@ static int busywait_for_rtc_clock_tick(const struct hwclock_control *ctl,
 	int rc;
 	struct timeval begin, now;
 
-	if (ctl->debug) {
+	if (ctl->verbose) {
 		printf("ioctl(%d, RTC_UIE_ON, 0): %s\n",
 		       rtc_fd, strerror(errno));
 		printf(_("Waiting in loop for time from %s to change\n"),
@@ -358,7 +358,7 @@ static int set_hardware_clock_rtc(const struct hwclock_control *ctl,
 		hwclock_exit(ctl, EXIT_FAILURE);
 	}
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("ioctl(%s) was successful.\n"), ioctlname);
 
 	return 0;
@@ -407,7 +407,7 @@ int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 		return 1;
 	}
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("ioctl(%d, RTC_EPOCH_READ, epoch_p) to %s succeeded.\n"),
 		       rtc_fd, rtc_dev_name);
 
@@ -442,7 +442,7 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 		return 1;
 	}
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("ioctl(%d, RTC_EPOCH_SET, %lu) to %s succeeded.\n"),
 		       rtc_fd, epoch, rtc_dev_name);
 
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index d88feb07b..b9f618973 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -281,10 +281,9 @@ parameters should be observed.
 .
 .TP
 .BR \-D ", " \-\-debug
-Display a lot of information about what
-.B \%hwclock
-is doing internally.  Some of its functions are complex and this output
-can help you understand how the program works.
+.RB Use\  \-\-verbose .
+.RB The\  \%\-\-debug\  option
+has been deprecated and may be repurposed or removed in a future release.
 .
 .TP
 .B \-\-directisa
@@ -374,7 +373,7 @@ must be specified when using this option.
 .B \-\-test
 Do not actually change anything on the system, that is, the Clocks or
 .I @ADJTIME_PATH@
-.RB ( \%\-\-debug
+.RB ( \%\-\-verbose
 is implicit with this option).
 .
 .TP
@@ -430,6 +429,12 @@ option.  Despite it not working, the resulting drift correction factor
 would be invalid anyway.
 .RE
 .
+.TP
+.BR \-v ", " \-\-verbose
+Display more details about what
+.B \%hwclock
+is doing internally.
+.
 .SH NOTES
 .
 .SS Clocks in a Linux System
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 71d2b17b7..0dc1d2369 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -179,7 +179,7 @@ hw_clock_is_utc(const struct hwclock_control *ctl,
 	else
 		/* get info from adjtime file - default is UTC */
 		ret = (adjtime.local_utc != LOCAL);
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("Assuming hardware clock is kept in %s time.\n"),
 		       ret ? _("UTC") : _("local"));
 	return ret;
@@ -236,7 +236,7 @@ static int read_adjtime(const struct hwclock_control *ctl,
 		}
 	}
 
-	if (ctl->debug) {
+	if (ctl->verbose) {
 		printf(_
 		       ("Last drift adjustment done at %ld seconds after 1969\n"),
 		       (long)adjtime_p->last_adj_time);
@@ -268,12 +268,12 @@ static int synchronize_to_clock_tick(const struct hwclock_control *ctl)
 {
 	int rc;
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("Waiting for clock tick...\n"));
 
 	rc = ur->synchronize_to_clock_tick(ctl);
 
-	if (ctl->debug) {
+	if (ctl->verbose) {
 		if (rc)
 			printf(_("...synchronization failed\n"));
 		else
@@ -317,14 +317,14 @@ mktime_tz(const struct hwclock_control *ctl, struct tm tm,
 		 * mktime() returns -1).
 		 */
 		valid = 0;
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Invalid values in hardware clock: "
 				 "%4d/%.2d/%.2d %.2d:%.2d:%.2d\n"),
 			       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			       tm.tm_hour, tm.tm_min, tm.tm_sec);
 	} else {
 		valid = 1;
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_
 			       ("Hw clock time : %4d/%.2d/%.2d %.2d:%.2d:%.2d = "
 				"%ld seconds since 1969\n"), tm.tm_year + 1900,
@@ -351,7 +351,7 @@ read_hardware_clock(const struct hwclock_control *ctl,
 	if (err)
 		return err;
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_
 		       ("Time read from Hardware Clock: %4d/%.2d/%.2d %02d:%02d:%02d\n"),
 		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
@@ -379,7 +379,7 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 	else
 		localtime_r(&newtime, &new_broken_time);
 
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("Setting Hardware Clock to %.2d:%.2d:%.2d "
 			 "= %ld seconds since 1969\n"),
 		       new_broken_time.tm_hour, new_broken_time.tm_min,
@@ -474,7 +474,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 		double ticksize;
 
 		/* FOR TESTING ONLY: inject random delays of up to 1000ms */
-		if (ctl->debug >= 10) {
+		if (ctl->verbose >= 10) {
 			int usec = random() % 1000000;
 			printf(_("sleeping ~%d usec\n"), usec);
 			xusleep(usec);
@@ -486,7 +486,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 		prevsystime = nowsystime;
 
 		if (ticksize < 0) {
-			if (ctl->debug)
+			if (ctl->verbose)
 				printf(_("time jumped backward %.6f seconds "
 					 "to %ld.%06ld - retargeting\n"),
 				       ticksize, nowsystime.tv_sec,
@@ -494,7 +494,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 			/* The retarget is handled at the end of the loop. */
 		} else if (deltavstarget < 0) {
 			/* deltavstarget < 0 if current time < target time */
-			if (ctl->debug >= 9)
+			if (ctl->verbose >= 9)
 				printf(_("%ld.%06ld < %ld.%06ld (%.6f)\n"),
 				       nowsystime.tv_sec,
 				       nowsystime.tv_usec,
@@ -510,7 +510,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 			 * We missed our window.  Increase the tolerance and
 			 * aim for the next opportunity.
 			 */
-			if (ctl->debug)
+			if (ctl->verbose)
 				printf(_("missed it - %ld.%06ld is too far "
 					 "past %ld.%06ld (%.6f > %.6f)\n"),
 				       nowsystime.tv_sec,
@@ -538,7 +538,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 		    + (int)(time_diff(nowsystime, refsystime)
 			    - RTC_SET_DELAY_SECS /* don't count this */
 			    + 0.5 /* for rounding */);
-	if (ctl->debug)
+	if (ctl->verbose)
 		printf(_("%ld.%06ld is close enough to %ld.%06ld (%.6f < %.6f)\n"
 			 "Set RTC to %ld (%ld + %d; refsystime = %ld.%06ld)\n"),
 		       nowsystime.tv_sec, nowsystime.tv_usec,
@@ -607,7 +607,7 @@ set_system_clock(const struct hwclock_control *ctl,
 	localtime_r(&newtime.tv_sec, &broken);
 	minuteswest = -get_gmtoff(&broken) / 60;
 
-	if (ctl->debug) {
+	if (ctl->verbose) {
 		if (ctl->hctosys && !ctl->universal)
 			printf(_("Calling settimeofday(NULL, %d) to set "
 				 "persistent_clock_is_local.\n"), minuteswest);
@@ -662,17 +662,17 @@ adjust_drift_factor(const struct hwclock_control *ctl,
 		    const struct timeval hclocktime)
 {
 	if (!ctl->update) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Not adjusting drift factor because the "
 				 "--update-drift option was not used.\n"));
 	} else if (adjtime_p->last_calib_time == 0) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Not adjusting drift factor because last "
 				 "calibration time is zero,\n"
 				 "so history is bad and calibration startover "
 				 "is necessary.\n"));
 	} else if ((hclocktime.tv_sec - adjtime_p->last_calib_time) < 4 * 60 * 60) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Not adjusting drift factor because it has "
 				 "been less than four hours since the last "
 				 "calibration.\n"));
@@ -710,14 +710,14 @@ adjust_drift_factor(const struct hwclock_control *ctl,
 
 		drift_factor = adjtime_p->drift_factor + factor_adjust;
 		if (fabs(drift_factor) > MAX_DRIFT) {
-			if (ctl->debug)
+			if (ctl->verbose)
 				printf(_("Clock drift factor was calculated as "
 					 "%f seconds/day.\n"
 					 "It is far too much. Resetting to zero.\n"),
 				       drift_factor);
 			drift_factor = 0;
 		} else {
-			if (ctl->debug)
+			if (ctl->verbose)
 				printf(_("Clock drifted %f seconds in the past "
 					 "%f seconds\nin spite of a drift factor of "
 					 "%f seconds/day.\n"
@@ -761,7 +761,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
 	tdrift_p->tv_sec = (time_t) floor(exact_adjustment);
 	tdrift_p->tv_usec = (exact_adjustment -
 				 (double)tdrift_p->tv_sec) * 1E6;
-	if (ctl->debug) {
+	if (ctl->verbose) {
 		printf(P_("Time since last adjustment is %ld second\n",
 			"Time since last adjustment is %ld seconds\n",
 		       (systime - last_time)),
@@ -790,7 +790,7 @@ static int save_adjtime(const struct hwclock_control *ctl,
 		  adjtime->last_calib_time,
 		  (adjtime->local_utc == LOCAL) ? "LOCAL" : "UTC");
 
-	if (ctl->debug){
+	if (ctl->verbose){
 		printf(_("New %s data:\n%s"),
 		       ctl->adj_file_name, content);
 	}
@@ -836,11 +836,11 @@ do_adjustment(const struct hwclock_control *ctl, struct adjtime *adjtime_p,
 	      const struct timeval read_time)
 {
 	if (adjtime_p->last_adj_time == 0) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Not setting clock because last adjustment time is zero, "
 				 "so history is bad.\n"));
 	} else if (fabs(adjtime_p->drift_factor) > MAX_DRIFT) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("Not setting clock because drift factor %f is far too high.\n"),
 				adjtime_p->drift_factor);
 	} else {
@@ -864,16 +864,16 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
 		ur = probe_for_rtc_clock(ctl);
 #endif
 	if (ur) {
-		if (ctl->debug)
+		if (ctl->verbose)
 			puts(ur->interface_name);
 
 	} else {
-		if (ctl->debug)
+		if (ctl->verbose)
 			printf(_("No usable clock interface found.\n"));
 		warnx(_("Cannot access the Hardware Clock via "
 			"any known method."));
-		if (!ctl->debug)
-			warnx(_("Use the --debug option to see the "
+		if (!ctl->verbose)
+			warnx(_("Use the --verbose option to see the "
 				"details of our search for an access "
 				"method."));
 		hwclock_exit(ctl, EXIT_FAILURE);
@@ -922,7 +922,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 				     hclocktime.tv_sec, &tdrift);
 		hclocktime = time_inc(hclocktime, (double)
 				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
-		if (ctl->debug) {
+		if (ctl->verbose) {
 			printf(_ ("Target date:   %ld\n"), set_time);
 			printf(_ ("Predicted RTC: %ld\n"), hclocktime.tv_sec);
 		}
@@ -1077,8 +1077,8 @@ usage(void)
 	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
 	printf(_(
 	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
-	puts(_("     --test           dry run; implies --debug"));
-	puts(_(" -D, --debug          display more details"));
+	puts(_("     --test           dry run; implies --verbose"));
+	puts(_(" -v, --verbose        display more details"));
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(22));
 	printf(USAGE_MAN_TAIL("hwclock(8)"));
@@ -1125,6 +1125,7 @@ int main(int argc, char **argv)
 		{ "version",      no_argument,       NULL, 'V'            },
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
+		{ "verbose",      no_argument,       NULL, 'v'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
 #if defined(__linux__) && defined(__alpha__)
 		{ "getepoch",     no_argument,       NULL, OPT_GETEPOCH   },
@@ -1192,7 +1193,10 @@ int main(int argc, char **argv)
 
 		switch (c) {
 		case 'D':
-			ctl.debug++;
+			warnx(_("use --verbose, --debug has been deprecated."));
+			break;
+		case 'v':
+			ctl.verbose++;
 			break;
 		case 'a':
 			ctl.adjust = 1;
@@ -1245,7 +1249,7 @@ int main(int argc, char **argv)
 			break;
 		case OPT_TEST:
 			ctl.testing = 1;	/* --test */
-			ctl.debug++;
+			ctl.verbose++;
 			break;
 		case OPT_DATE:
 			ctl.date_opt = optarg;	/* --date */
@@ -1274,8 +1278,7 @@ int main(int argc, char **argv)
 			ctl.rtc_dev_name = optarg;	/* --rtc */
 			break;
 #endif
-		case 'v':			/* --version */
-		case 'V':
+		case 'V':			/* --version */
 			out_version();
 			return 0;
 		case 'h':			/* --help */
@@ -1324,7 +1327,7 @@ int main(int argc, char **argv)
 	}
 #endif
 
-	if (ctl.debug) {
+	if (ctl.verbose) {
 		out_version();
 		printf(_("System Time: %ld.%06ld\n"),
 		       startup_time.tv_sec, startup_time.tv_usec);
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 215cf9302..570bfe439 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -18,7 +18,7 @@ struct hwclock_control {
 #ifdef __linux__
 	char *rtc_dev_name;
 #endif
-	unsigned int debug;
+	unsigned int verbose;
 	unsigned int
 		hwaudit_on:1,
 		adjust:1,
@@ -54,7 +54,6 @@ extern struct clock_ops *probe_for_cmos_clock(void);
 extern struct clock_ops *probe_for_rtc_clock(const struct hwclock_control *ctl);
 
 /* hwclock.c */
-extern int debug;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
 
 /* rtc.c */
