Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbaJXCuF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Oct 2014 22:50:05 -0400
Message-ID: <5449BE57.9040203@gmx.com>
Date: Thu, 23 Oct 2014 22:49:59 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/5] hwclock: clean up message periods/full stops
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


33% of message lines terminated with a period/full stop.
This is unsightly and difficult to read.  Removed the
full stops, as this appears to be util-linux's norm.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 98 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index ced1314..566ca91 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -241,7 +241,7 @@ hw_clock_is_utc(const bool utc, const bool local_opt,
 		/* get info from adjtime file - default is UTC */
 		ret = (adjtime.local_utc != LOCAL);
 	if (debug)
-		printf(_("Assuming hardware clock is kept in %s time.\n"),
+		printf(_("Assuming hardware clock is kept in %s time\n"),
 		       ret ? _("UTC") : _("local"));
 	return ret;
 }
@@ -317,7 +317,7 @@ static int read_adjtime(struct adjtime *adjtime_p)
 		adjtime_p->local_utc = UNKNOWN;
 		if (line3[0]) {
 			warnx(_("Warning: unrecognized third line in adjtime file\n"
-				"(Expected: `UTC' or `LOCAL' or nothing.)"));
+				"(Expected: `UTC' or `LOCAL' or nothing)"));
 		}
 	}

@@ -504,7 +504,7 @@ set_hardware_clock(const time_t newtime,
 		       new_broken_time.tm_sec, (long)newtime);

 	if (testing)
-		printf(_("Clock not changed - testing only.\n"));
+		printf(_("Clock not changed - testing only\n"));
 	else {
 		if (badyear) {
 			/*
@@ -571,7 +571,7 @@ set_hardware_clock_exact(const time_t sethwtime,
 	 * in the future) to both the time for which we are waiting and the
 	 * time that we will apply to the Hardware Clock, and start waiting
 	 * again.
-	 * 
+	 *
 	 * For example, the caller requests that we set the Hardware Clock to
 	 * 1:02:03, with reference time (current system time) = 6:07:08.250.
 	 * We want the Hardware Clock to update to 1:02:04 at 6:07:09.250 on
@@ -695,7 +695,7 @@ display_time(const bool hclock_valid, struct timeval hwctime)
 		warnx(_
 		      ("The Hardware Clock registers contain values that are "
 		       "either invalid (e.g. 50th day of month) or beyond the range "
-		       "we can handle (e.g. Year 2095)."));
+		       "we can handle (e.g. Year 2095)"));
 	else {
 		struct tm *lt;
 		char *format = "%c";
@@ -734,7 +734,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 	int rc;			/* local return code */

 	if (date_opt == NULL) {
-		warnx(_("No --date option specified."));
+		warnx(_("No --date option specified"));
 		return 14;
 	}

@@ -747,8 +747,8 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 	/* Quotes in date_opt would ruin the date command we construct. */
 	if (strchr(date_opt, '"') != NULL) {
 		warnx(_
-		      ("The value of the --date option is not a valid date.\n"
-		       "In particular, it contains quotation marks."));
+		      ("The value of the --date option is not a valid date\n"
+		       "In particular, it contains quotation marks"));
 		return 12;
 	}

@@ -759,7 +759,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)

 	date_child_fp = popen(date_command, "r");
 	if (date_child_fp == NULL) {
-		warn(_("Unable to run 'date' program in /bin/sh shell. "
+		warn(_("Unable to run 'date' program in /bin/sh shell "
 			    "popen() failed"));
 		return 10;
 	}
@@ -770,7 +770,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 		printf(_("response from date command = %s"), date_resp);
 	if (strncmp(date_resp, magic, sizeof(magic) - 1) != 0) {
 		warnx(_("The date command issued by %s returned "
-				  "unexpected results.\n"
+				  "unexpected results\n"
 				  "The command was:\n  %s\n"
 				  "The response was:\n  %s"),
 			program_invocation_short_name, date_command, date_resp);
@@ -782,7 +782,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 		if (rc < 1) {
 			warnx(_("The date command issued by %s returned "
 				"something other than an integer where the "
-				"converted time value was expected.\n"
+				"converted time value was expected\n"
 				"The command was:\n  %s\n"
 				"The response was:\n %s\n"),
 			      program_invocation_short_name, date_command,
@@ -793,7 +793,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 			*time_p = seconds_since_epoch;
 			if (debug)
 				printf(_("date string %s equates to "
-					 "%ld seconds since 1969.\n"),
+					 "%ld seconds since 1969\n"),
 				       date_opt, (long)*time_p);
 		}
 	}
@@ -831,7 +831,7 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,
 	if (!hclock_valid) {
 		warnx(_
 		      ("The Hardware Clock does not contain a valid time, so "
-		       "we cannot set the System Time from it."));
+		       "we cannot set the System Time from it"));
 		retcode = 1;
 	} else {
 		const struct timeval *tv_null = NULL;
@@ -856,7 +856,7 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,
 		}
 		if (testing) {
 			printf(_
-			       ("Not setting system clock because running in test mode.\n"));
+			       ("Not setting system clock because running in test mode\n"));
 			retcode = 0;
 		} else {
 			const struct timezone tz = { minuteswest, 0 };
@@ -872,7 +872,7 @@ set_system_clock(const bool hclock_valid, const struct timeval newtime,
 			if (rc) {
 				if (errno == EPERM) {
 					warnx(_
-					      ("Must be superuser to set system clock."));
+					      ("Must be superuser to set system clock"));
 					retcode = EX_NOPERM;
 				} else {
 					warn(_("settimeofday() failed"));
@@ -944,7 +944,7 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
 	}
 	if (testing) {
 		printf(_
-		       ("Not setting system clock because running in test mode.\n"));
+		       ("Not setting system clock because running in test mode\n"));
 		retcode = 0;
 	} else {
 		const struct timezone tz_utc = { 0, 0 };
@@ -968,7 +968,7 @@ static int set_system_clock_timezone(const bool universal, const bool testing)
 		if (rc) {
 			if (errno == EPERM) {
 				warnx(_
-				      ("Must be superuser to set system clock."));
+				      ("Must be superuser to set system clock"));
 				retcode = EX_NOPERM;
 			} else {
 				warn(_("settimeofday() failed"));
@@ -1003,23 +1003,23 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 	if (!update) {
 		if (debug)
 			printf(_("Not adjusting drift factor because the "
-				 "--update-drift option was not used.\n"));
+				 "--update-drift option was not used\n"));
 	} else if (!hclock_valid) {
 		if (debug)
 			printf(_("Not adjusting drift factor because the "
 				 "Hardware Clock previously contained "
-				 "garbage.\n"));
+				 "garbage\n"));
 	} else if (adjtime_p->last_calib_time == 0) {
 		if (debug)
 			printf(_("Not adjusting drift factor because last "
 				 "calibration time is zero,\n"
 				 "so history is bad and calibration startover "
-				 "is necessary.\n"));
+				 "is necessary\n"));
 	} else if ((hclocktime.tv_sec - adjtime_p->last_calib_time) < 4 * 60 * 60) {
 		if (debug)
 			printf(_("Not adjusting drift factor because it has "
 				 "been less than four hours since the last "
-				 "calibration.\n"));
+				 "calibration\n"));
 	} else if (adjtime_p->last_calib_time != 0) {
 		/*
 		 * At adjustment time we drift correct the hardware clock
@@ -1056,15 +1056,15 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 		if (fabs(drift_factor) > MAX_DRIFT) {
 			if (debug)
 				printf(_("Clock drift factor was calculated as "
-					 "%f seconds/day.\n"
-					 "It is far too much. Resetting to zero.\n"),
+					 "%f seconds/day\n"
+					 "It is far too much, resetting to zero\n"),
 				       drift_factor);
 			drift_factor = 0;
 		} else {
 			if (debug)
 				printf(_("Clock drifted %.1f seconds in the past "
 					 "%.1f seconds\nin spite of a drift factor of "
-					 "%f seconds/day.\n"
+					 "%f seconds/day\n"
 					 "Adjusting drift factor by %f seconds/day\n"),
 				       time_diff(nowtime, hclocktime),
 				       time_diff(nowtime, last_calib),
@@ -1139,7 +1139,7 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)

 		if (testing) {
 			printf(_
-			       ("Not updating adjtime file because of testing mode.\n"));
+			       ("Not updating adjtime file because of testing mode\n"));
 			printf(_("Would have written the following to %s:\n%s"),
 			       adj_file_name, newfile);
 		} else {
@@ -1170,7 +1170,7 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)
 			}
 			if (err)
 				warnx(_
-				      ("Drift adjustment parameters not updated."));
+				      ("Drift adjustment parameters not updated"));
 		}
 	}
 }
@@ -1207,7 +1207,7 @@ do_adjustment(struct adjtime *adjtime_p,
 {
 	if (!hclock_valid) {
 		warnx(_("The Hardware Clock does not contain a valid time, "
-			"so we cannot adjust it."));
+			"so we cannot adjust it"));
 		adjtime_p->last_calib_time = 0;	/* calibration startover is required */
 		adjtime_p->last_adj_time = 0;
 		adjtime_p->not_adjusted = 0;
@@ -1215,10 +1215,10 @@ do_adjustment(struct adjtime *adjtime_p,
 	} else if (adjtime_p->last_adj_time == 0) {
 		if (debug)
 			printf(_("Not setting clock because last adjustment time is zero, "
-				 "so history is bad.\n"));
+				 "so history is bad\n"));
 	} else if (fabs(adjtime_p->drift_factor) > MAX_DRIFT) {
 		if (debug)
-			printf(_("Not setting clock because drift factor %f is far too high.\n"),
+			printf(_("Not setting clock because drift factor %f is far too high\n"),
 				adjtime_p->drift_factor);
 	} else {
 		set_hardware_clock_exact(hclocktime.tv_sec,
@@ -1250,7 +1250,7 @@ static void determine_clock_access_method(const bool user_requests_ISA)
 		if (ur)
 			puts(_(ur->interface_name));
 		else
-			printf(_("No usable clock interface found.\n"));
+			printf(_("No usable clock interface found\n"));
 	}
 }

@@ -1375,7 +1375,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 				      hclocktime, read_time, universal, testing);
 		else
 			printf(_("Needed adjustment is less than one second, "
-				 "so not setting clock.\n"));
+				 "so not setting clock\n"));
 	} else if (systohc) {
 		struct timeval nowtime, reftime;
 		/*
@@ -1397,13 +1397,13 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 		rc = set_system_clock(hclock_valid, hclocktime,
 				      testing, universal);
 		if (rc) {
-			printf(_("Unable to set system clock.\n"));
+			printf(_("Unable to set system clock\n"));
 			return rc;
 		}
 	} else if (systz) {
 		rc = set_system_clock_timezone(universal, testing);
 		if (rc) {
-			printf(_("Unable to set system clock.\n"));
+			printf(_("Unable to set system clock\n"));
 			return rc;
 		}
 	} else if (predict) {
@@ -1411,7 +1411,7 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
 				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
 		if (debug) {
 			printf(_
-			       ("At %ld seconds after 1969, RTC is predicted to read %ld seconds after 1969.\n"),
+			       ("At %ld seconds after 1969, RTC is predicted to read %ld seconds after 1969\n"),
 			       set_time, (long)hclocktime.tv_sec);
 		}
 		display_time(TRUE, hclocktime);
@@ -1441,9 +1441,9 @@ manipulate_epoch(const bool getepoch __attribute__ ((__unused__)),
 		 const bool testing __attribute__ ((__unused__)))
 {
 	warnx(_("The kernel keeps an epoch value for the Hardware Clock "
-		"only on an Alpha machine.\nThis copy of hwclock was built for "
+		"only on an Alpha machine\nThis copy of hwclock was built for "
 		"a machine other than Alpha\n(and thus is presumably not running "
-		"on an Alpha now).  No action taken."));
+		"on an Alpha now)  No action taken"));
 }
 # else
 static void
@@ -1457,7 +1457,7 @@ manipulate_epoch(const bool getepoch,

 		if (get_epoch_rtc(&epoch, 0))
 			warnx(_
-			      ("Unable to get the epoch value from the kernel."));
+			      ("Unable to get the epoch value from the kernel"));
 		else
 			printf(_("Kernel is assuming an epoch value of %lu\n"),
 			       epoch);
@@ -1465,14 +1465,14 @@ manipulate_epoch(const bool getepoch,
 		if (epoch_opt == -1)
 			warnx(_
 			      ("To set the epoch value, you must use the 'epoch' "
-			       "option to tell to what value to set it."));
+			       "option to tell to what value to set it"));
 		else if (testing)
 			printf(_
-			       ("Not setting the epoch to %d - testing only.\n"),
+			       ("Not setting the epoch to %d - testing only\n"),
 			       epoch_opt);
 		else if (set_epoch_rtc(epoch_opt))
 			printf(_
-			       ("Unable to set the epoch value in the kernel.\n"));
+			       ("Unable to set the epoch value in the kernel\n"));
 	}
 }
 # endif		/* __alpha__ */
@@ -1878,8 +1878,8 @@ int main(int argc, char **argv)
 	}
 #endif
 	if (argc > 0) {
-		usage(_("%s takes no non-option arguments.  "
-			"You supplied %d.\n"), program_invocation_short_name,
+		usage(_("%s takes no non-option arguments\n"
+			"You supplied %d\n"), program_invocation_short_name,
 		      argc);
 	}

@@ -1900,8 +1900,8 @@ int main(int argc, char **argv)
 		rc = interpret_date_string(date_opt, &set_time);
 		/* (time-consuming) */
 		if (rc != 0) {
-			warnx(_("No usable set-to time.  "
-				"Cannot set clock."));
+			warnx(_("No usable set-to time,  "
+				"cannot set clock"));
 			hwclock_exit(EX_USAGE);
 		}
 	}
@@ -1916,15 +1916,15 @@ int main(int argc, char **argv)
 		/* program is designed to run setuid (in some situations) */
 		if (set || systohc || adjust) {
 			warnx(_("Sorry, only the superuser can change "
-				"the Hardware Clock."));
+				"the Hardware Clock"));
 			permitted = FALSE;
 		} else if (systz || hctosys) {
 			warnx(_("Sorry, only the superuser can change "
-				"the System Clock."));
+				"the System Clock"));
 			permitted = FALSE;
 		} else if (setepoch) {
 			warnx(_("Sorry, only the superuser can change the "
-				"Hardware Clock epoch in the kernel."));
+				"Hardware Clock epoch in the kernel"));
 			permitted = FALSE;
 		} else
 			permitted = TRUE;
@@ -1947,11 +1947,11 @@ int main(int argc, char **argv)
 		determine_clock_access_method(directisa);
 		if (!ur) {
 			warnx(_("Cannot access the Hardware Clock via "
-				"any known method."));
+				"any known method"));
 			if (!debug)
 				warnx(_("Use the --debug option to see the "
 					"details of our search for an access "
-					"method."));
+					"method"));
 			hwclock_exit(EX_SOFTWARE);
 		}
 	}
