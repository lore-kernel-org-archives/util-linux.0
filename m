Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 9/8] hwclock: fix hclock_valid test and error messages
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
 <3c5479c2-62fa-a220-6333-2e4b81108bd7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <aa40ca48-44cf-9c68-0c73-edf7f1ac5e10@gmx.com>
Date: Fri, 4 Aug 2017 09:33:33 -0400
MIME-Version: 1.0
In-Reply-To: <3c5479c2-62fa-a220-6333-2e4b81108bd7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Every hwclock operation that requires reading the RTC, tests
hclock_valid and prints a different warning. This redundancy
is unnecessary.

Move the warning to the RTC read block (the test was moved in
a previous patch in this set). This reduces function arguments
and is a significant code clean up. It will also benefit the
translators.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

This patch does not affect normal operations, so the man page change
was unnecessary. Removed man page change from this patch and pushed it
to the same branch of my repo:

The following changes since commit a6b1ec864a3eb1d27a8781fe99d65e4e6ac05e5b:

  libblkid: add support for UBI superblock (2017-08-03 14:11:21 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170724

for you to fetch changes up to 88d2a1a312445ba1cb540b960e2a9578b170e820:

  hwclock: fix hclock_valid test and error messages (2017-08-04 08:57:13 -0400)

----------------------------------------------------------------
J William Piggott (9):
      hwclock: move systz above init clocks read
      hwclock: move rtc permissions test
      hwclock: move drift correction and --predict
      hwclock: fix RTC read logic
      hwclock: correlate hclocktime instead of set_time.
      hwclock: update man page
      hwclock: restore select() timeout warning
      hwclock: remove busywait tristate return status
      hwclock: fix hclock_valid test and error messages

 sys-utils/hwclock-rtc.c |  16 ++-
 sys-utils/hwclock.8.in  |  26 +++--
 sys-utils/hwclock.c     | 257 ++++++++++++++++++++----------------------------
 sys-utils/hwclock.h     |   6 --
 4 files changed, 136 insertions(+), 169 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index df6b59e..910e39f 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -557,27 +557,15 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 	set_hardware_clock(ctl, newhwtime);
 }
 
-/*
- * Put the time "hwctime" on standard output in display format. Except if
- * hclock_valid == false, just tell standard output that we don't know what
- * time it is.
- */
 static void
-display_time(const bool hclock_valid, struct timeval hwctime)
+display_time(struct timeval hwctime)
 {
-	if (!hclock_valid)
-		warnx(_
-		      ("The Hardware Clock registers contain values that are "
-		       "either invalid (e.g. 50th day of month) or beyond the range "
-		       "we can handle (e.g. Year 2095)."));
-	else {
-		char buf[ISO_8601_BUFSIZ];
-
-		strtimeval_iso(&hwctime, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_DOTUSEC|
-					 ISO_8601_TIMEZONE|ISO_8601_SPACE,
-					 buf, sizeof(buf));
-		printf("%s\n", buf);
-	}
+	char buf[ISO_8601_BUFSIZ];
+
+	strtimeval_iso(&hwctime, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_DOTUSEC|
+				 ISO_8601_TIMEZONE|ISO_8601_SPACE,
+				 buf, sizeof(buf));
+	printf("%s\n", buf);
 }
 
 /*
@@ -593,66 +581,55 @@ display_time(const bool hclock_valid, struct timeval hwctime)
  * Clock's timescale configuration is changed then a reboot is required for
  * persistent_clock_is_local to be updated.
  *
- * EXCEPT: if hclock_valid is false, just issue an error message saying
- * there is no valid time in the Hardware Clock to which to set the system
- * time.
- *
  * If 'testing' is true, don't actually update anything -- just say we would
  * have.
  */
 static int
-set_system_clock(const struct hwclock_control *ctl, const bool hclock_valid,
+set_system_clock(const struct hwclock_control *ctl,
 		 const struct timeval newtime)
 {
 	int retcode;
 
-	if (!hclock_valid) {
-		warnx(_
-		      ("The Hardware Clock does not contain a valid time, so "
-		       "we cannot set the System Time from it."));
-		retcode = 1;
-	} else {
-		const struct timeval *tv_null = NULL;
-		struct tm *broken;
-		int minuteswest;
-		int rc = 0;
+	const struct timeval *tv_null = NULL;
+	struct tm *broken;
+	int minuteswest;
+	int rc = 0;
 
-		broken = localtime(&newtime.tv_sec);
+	broken = localtime(&newtime.tv_sec);
 #ifdef HAVE_TM_GMTOFF
-		minuteswest = -broken->tm_gmtoff / 60;	/* GNU extension */
+	minuteswest = -broken->tm_gmtoff / 60;	/* GNU extension */
 #else
-		minuteswest = timezone / 60;
-		if (broken->tm_isdst)
-			minuteswest -= 60;
+	minuteswest = timezone / 60;
+	if (broken->tm_isdst)
+		minuteswest -= 60;
 #endif
 
-		if (ctl->debug) {
-			printf(_("Calling settimeofday:\n"));
-			printf(_("\ttv.tv_sec = %ld, tv.tv_usec = %ld\n"),
-			       newtime.tv_sec, newtime.tv_usec);
-			printf(_("\ttz.tz_minuteswest = %d\n"), minuteswest);
-		}
-		if (ctl->testing) {
-			printf(_
-			       ("Test mode: clock was not changed\n"));
-			retcode = 0;
-		} else {
-			const struct timezone tz = { minuteswest, 0 };
+	if (ctl->debug) {
+		printf(_("Calling settimeofday:\n"));
+		printf(_("\ttv.tv_sec = %ld, tv.tv_usec = %ld\n"),
+		       newtime.tv_sec, newtime.tv_usec);
+		printf(_("\ttz.tz_minuteswest = %d\n"), minuteswest);
+	}
+	if (ctl->testing) {
+		printf(_
+		       ("Test mode: clock was not changed\n"));
+		retcode = 0;
+	} else {
+		const struct timezone tz = { minuteswest, 0 };
 
-			/* Set kernel persistent_clock_is_local so that 11 minute
-			 * mode does not clobber the Hardware Clock with UTC. This
-			 * is only available on first call of settimeofday after boot.
-			 */
-			if (!ctl->universal)
-				rc = settimeofday(tv_null, &tz);
-			if (!rc)
-				rc = settimeofday(&newtime, &tz);
-			if (rc) {
-				warn(_("settimeofday() failed"));
-				retcode = 1;
-			} else
-				retcode = 0;
-		}
+		/* Set kernel persistent_clock_is_local so that 11 minute
+		 * mode does not clobber the Hardware Clock with UTC. This
+		 * is only available on first call of settimeofday after boot.
+		 */
+		if (!ctl->universal)
+			rc = settimeofday(tv_null, &tz);
+		if (!rc)
+			rc = settimeofday(&newtime, &tz);
+		if (rc) {
+			warn(_("settimeofday() failed"));
+			retcode = 1;
+		} else
+			retcode = 0;
 	}
 	return retcode;
 }
@@ -754,27 +731,17 @@ static int set_system_clock_timezone(const struct hwclock_control *ctl)
  * Update the drift factor in <*adjtime_p> based on the fact that the
  * Hardware Clock was just calibrated to <nowtime> and before that was
  * set to the <hclocktime> time scale.
- *
- * EXCEPT: if <hclock_valid> is false, assume Hardware Clock was not set
- * before to anything meaningful and regular adjustments have not been done,
- * so don't adjust the drift factor.
  */
 static void
 adjust_drift_factor(const struct hwclock_control *ctl,
 		    struct adjtime *adjtime_p,
 		    const struct timeval nowtime,
-		    const bool hclock_valid,
 		    const struct timeval hclocktime)
 {
 	if (!ctl->update) {
 		if (ctl->debug)
 			printf(_("Not adjusting drift factor because the "
 				 "--update-drift option was not used.\n"));
-	} else if (!hclock_valid) {
-		if (ctl->debug)
-			printf(_("Not adjusting drift factor because the "
-				 "Hardware Clock previously contained "
-				 "garbage.\n"));
 	} else if (adjtime_p->last_calib_time == 0) {
 		if (ctl->debug)
 			printf(_("Not adjusting drift factor because last "
@@ -936,8 +903,6 @@ static void save_adjtime(const struct hwclock_control *ctl,
  * Do not update anything if the Hardware Clock does not currently present a
  * valid time.
  *
- * <hclock_valid> means the Hardware Clock contains a valid time.
- *
  * <hclocktime> is the drift corrected time read from the Hardware Clock.
  *
  * <read_time> was the system time when the <hclocktime> was read, which due
@@ -954,17 +919,10 @@ static void save_adjtime(const struct hwclock_control *ctl,
  */
 static void
 do_adjustment(const struct hwclock_control *ctl, struct adjtime *adjtime_p,
-	      const bool hclock_valid, const struct timeval hclocktime,
+	      const struct timeval hclocktime,
 	      const struct timeval read_time)
 {
-	if (!hclock_valid) {
-		warnx(_("The Hardware Clock does not contain a valid time, "
-			"so we cannot adjust it."));
-		adjtime_p->last_calib_time = 0;	/* calibration startover is required */
-		adjtime_p->last_adj_time = 0;
-		adjtime_p->not_adjusted = 0;
-		adjtime_p->dirty = TRUE;
-	} else if (adjtime_p->last_adj_time == 0) {
+	if (adjtime_p->last_adj_time == 0) {
 		if (ctl->debug)
 			printf(_("Not setting clock because last adjustment time is zero, "
 				 "so history is bad.\n"));
@@ -1061,7 +1019,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			printf(_ ("Target date:   %ld\n"), set_time);
 			printf(_ ("Predicted RTC: %ld\n"), hclocktime.tv_sec);
 		}
-		display_time(TRUE, hclocktime);
+		display_time(hclocktime);
 		return 0;
 	}
 
@@ -1089,8 +1047,10 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		read_hardware_clock(ctl, &hclock_valid, &hclocktime.tv_sec);
 		gettimeofday(&read_time, NULL);
 
-		if (!hclock_valid)
+		if (!hclock_valid) {
+			warnx(_("RTC read returned an invalid value."));
 			return EX_IOERR;
+		}
 		/*
 		 * Calculate and apply drift correction to the Hardware Clock
 		 * time for everything except --show
@@ -1106,16 +1066,15 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		 time_inc(hclocktime, time_diff(startup_time, read_time));
 	}
 	if (ctl->show || ctl->get) {
-		display_time(hclock_valid, startup_hclocktime);
+		display_time(startup_hclocktime);
 	} else if (ctl->set) {
 		set_hardware_clock_exact(ctl, set_time, startup_time);
 		if (!ctl->noadjfile)
 			adjust_drift_factor(ctl, adjtime, t2tv(set_time),
-					    hclock_valid, startup_hclocktime);
+					    startup_hclocktime);
 	} else if (ctl->adjust) {
 		if (tdrift.tv_sec > 0 || tdrift.tv_sec < -1)
-			do_adjustment(ctl, adjtime, hclock_valid,
-				      hclocktime, read_time);
+			do_adjustment(ctl, adjtime, hclocktime, read_time);
 		else
 			printf(_("Needed adjustment is less than one second, "
 				 "so not setting clock.\n"));
@@ -1133,9 +1092,9 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		set_hardware_clock_exact(ctl, (time_t) reftime.tv_sec, reftime);
 		if (!ctl->noadjfile)
 			adjust_drift_factor(ctl, adjtime, nowtime,
-					    hclock_valid, hclocktime);
+					    hclocktime);
 	} else if (ctl->hctosys) {
-		return set_system_clock(ctl, hclock_valid, hclocktime);
+		return set_system_clock(ctl, hclocktime);
 	}
 	if (!ctl->noadjfile)
 		save_adjtime(ctl, adjtime);
