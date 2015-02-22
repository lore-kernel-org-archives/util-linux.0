Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51430 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBVOmk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:40 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so21163147wgg.11
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:39 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/13] rtcwake: improve coding style
Date: Sun, 22 Feb 2015 14:42:17 +0000
Message-Id: <1424616139-638-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 140 +++++++++++++---------------------------------------
 1 file changed, 34 insertions(+), 106 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 7f1e351..e6f2170 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -19,29 +19,27 @@
  * That flag should not be needed on systems with adjtime support.
  */
 
-#include <stdio.h>
-#include <getopt.h>
+#include <errno.h>
 #include <fcntl.h>
+#include <getopt.h>
 #include <libgen.h>
+#include <linux/rtc.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <time.h>
-
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
 
-#include <linux/rtc.h>
-
+#include "c.h"
+#include "closestream.h"
 #include "nls.h"
-#include "xalloc.h"
 #include "pathnames.h"
 #include "strutils.h"
-#include "c.h"
-#include "closestream.h"
 #include "timeutils.h"
+#include "xalloc.h"
 
 #ifndef RTC_AF
 # define	RTC_AF	0x20	/* Alarm interrupt */
@@ -147,12 +145,10 @@ static int is_wakeup_enabled(const char *devname)
 	fclose(f);
 	if (!s)
 		return 0;
-
 	s = strchr(buf, '\n');
 	if (!s)
 		return 0;
 	*s = 0;
-
 	/* wakeup events could be disabled or not supported */
 	return strcmp(buf, "enabled") == 0;
 }
@@ -162,16 +158,13 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 	struct tm	tm = { 0 };
 	struct rtc_time	rtc;
 
-	/* this process works in RTC time, except when working
-	 * with the system clock (which always uses UTC).
-	 */
+	/* this process works in RTC time, except when working with the
+	 * system clock (which always uses UTC). */
 	if (ctl->clock_mode == CM_UTC)
 		setenv("TZ", "UTC", 1);
 	tzset();
-
-	/* read rtc and system clocks "at the same time", or as
-	 * precisely (+/- a second) as we can read them.
-	 */
+	/* read rtc and system clocks "at the same time", or as precisely
+	 * (+/- a second) as we can read them. */
 	if (ioctl(fd, RTC_RD_TIME, &rtc) < 0) {
 		warn(_("read rtc time failed"));
 		return -1;
@@ -181,10 +174,8 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 		warn(_("read system time failed"));
 		return -1;
 	}
-
-	/* convert rtc_time to normal arithmetic-friendly form,
-	 * updating tm.tm_wday as used by asctime().
-	 */
+	/* convert rtc_time to normal arithmetic-friendly form, updating
+	 * tm.tm_wday as used by asctime(). */
 	tm.tm_sec = rtc.tm_sec;
 	tm.tm_min = rtc.tm_min;
 	tm.tm_hour = rtc.tm_hour;
@@ -193,20 +184,16 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 	tm.tm_year = rtc.tm_year;
 	tm.tm_isdst = -1;  /* assume the system knows better than the RTC */
 	ctl->rtc_time = mktime(&tm);
-
 	if (ctl->rtc_time == (time_t)-1) {
 		warn(_("convert rtc time failed"));
 		return -1;
 	}
-
 	if (ctl->verbose) {
 		/* Unless the system uses UTC, either delta or tzone
 		 * reflects a seconds offset from UTC.  The value can
-		 * help sort out problems like bugs in your C library.
-		 */
+		 * help sort out problems like bugs in your C library. */
 		printf("\tdelta   = %ld\n", ctl->sys_time - ctl->rtc_time);
 		printf("\ttzone   = %ld\n", timezone);
-
 		printf("\ttzname  = %s\n", tzname[daylight]);
 		gmtime_r(&ctl->rtc_time, &tm);
 		printf("\tsystime = %ld, (UTC) %s",
@@ -214,7 +201,6 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 		printf("\trtctime = %ld, (UTC) %s",
 				(long) ctl->rtc_time, asctime(&tm));
 	}
-
 	return 0;
 }
 
@@ -223,36 +209,31 @@ static int setup_alarm(struct rtcwake_control *ctl, int fd, time_t *wakeup)
 	struct tm		*tm;
 	struct rtc_wkalrm	wake;
 
-	/* The wakeup time is in POSIX time (more or less UTC).
-	 * Ideally RTCs use that same time; but PCs can't do that
-	 * if they need to boot MS-Windows.  Messy...
+	/* The wakeup time is in POSIX time (more or less UTC).  Ideally
+	 * RTCs use that same time; but PCs can't do that if they need to
+	 * boot MS-Windows.  Messy...
 	 *
-	 * When clock_mode == CM_UTC this process's timezone is UTC,
-	 * so we'll pass a UTC date to the RTC.
+	 * When clock_mode == CM_UTC this process's timezone is UTC, so
+	 * we'll pass a UTC date to the RTC.
 	 *
-	 * Else clock_mode == CM_LOCAL so the time given to the RTC
-	 * will instead use the local time zone.
-	 */
+	 * Else clock_mode == CM_LOCAL so the time given to the RTC will
+	 * instead use the local time zone. */
 	tm = localtime(wakeup);
-
 	wake.time.tm_sec = tm->tm_sec;
 	wake.time.tm_min = tm->tm_min;
 	wake.time.tm_hour = tm->tm_hour;
 	wake.time.tm_mday = tm->tm_mday;
 	wake.time.tm_mon = tm->tm_mon;
 	wake.time.tm_year = tm->tm_year;
-	/* wday, yday, and isdst fields are unused by Linux */
+	/* wday, yday, and isdst fields are unused */
 	wake.time.tm_wday = -1;
 	wake.time.tm_yday = -1;
 	wake.time.tm_isdst = -1;
-
 	wake.enabled = 1;
-
 	if (!ctl->dryrun && ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
 		warn(_("set rtc wake alarm failed"));
 		return -1;
 	}
-
 	return 0;
 }
 
@@ -264,12 +245,10 @@ static int is_suspend_available(const int suspend)
 
 	if (!f)
 		return -1;
-
 	if (fgets(buf, sizeof buf, f) == NULL)
 		rc = -1;
 	else
 		rc = strstr(buf, mode_str[suspend]) != NULL;
-
 	fclose(f);
 	return rc;
 }
@@ -282,18 +261,15 @@ static void suspend_system(struct rtcwake_control *ctl, int suspend)
 		warn(_("cannot open %s"), SYS_POWER_STATE_PATH);
 		return;
 	}
-
 	if (!ctl->dryrun) {
 		fprintf(f, "%s\n", mode_str[suspend]);
 		fflush(f);
 	}
-
 	/* this executes after wake from suspend */
 	if (close_stream(f))
 		errx(EXIT_FAILURE, _("write error"));
 }
 
-
 static int read_clock_mode(struct rtcwake_control *ctl)
 {
 	FILE *fp;
@@ -303,7 +279,6 @@ static int read_clock_mode(struct rtcwake_control *ctl)
 	fp = fopen(ctl->adjfile, "r");
 	if (!fp)
 		return -1;
-
 	/* skip lines */
 	do {
 		if ((ch = fgetc(fp)) == EOF || 0 < give_up--) {
@@ -313,28 +288,21 @@ static int read_clock_mode(struct rtcwake_control *ctl)
 		if (ch == '\n' && --lines == 0)
 			break;
 	} while (1);
-
 	/* read third line */
 	if (!fgets(linebuf, sizeof linebuf, fp)) {
 		fclose(fp);
 		return -1;
 	}
-
 	if (strncmp(linebuf, "UTC", 3) == 0)
 		ctl->clock_mode = CM_UTC;
 	else if (strncmp(linebuf, "LOCAL", 5) == 0)
 		ctl->clock_mode = CM_LOCAL;
 	else if (ctl->verbose)
 		warnx(_("unexpected third line in: %s: %s"), ctl->adjfile, linebuf);
-
 	fclose(fp);
-
 	return 0;
 }
 
-/**
- * print basic alarm settings
- */
 static int print_alarm(struct rtcwake_control *ctl, int fd)
 {
 	struct rtc_wkalrm wake;
@@ -345,12 +313,10 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 		warn(_("read rtc alarm failed"));
 		return -1;
 	}
-
 	if (wake.enabled != 1 || wake.time.tm_year == -1) {
 		printf(_("alarm: off\n"));
 		return 0;
 	}
-
 	tm.tm_sec = wake.time.tm_sec;
 	tm.tm_min = wake.time.tm_min;
 	tm.tm_hour = wake.time.tm_hour;
@@ -358,16 +324,13 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 	tm.tm_mon = wake.time.tm_mon;
 	tm.tm_year = wake.time.tm_year;
 	tm.tm_isdst = -1;  /* assume the system knows better than the RTC */
-
 	alarm = mktime(&tm);
 	if (alarm == (time_t)-1) {
 		warn(_("convert time failed"));
 		return -1;
 	}
-
 	/* 0 if both UTC, or expresses diff if RTC in local time */
 	alarm += ctl->sys_time - ctl->rtc_time;
-
 	printf(_("alarm: on  %s"), ctime(&alarm));
 	return 0;
 }
@@ -422,20 +385,16 @@ int main(int argc, char **argv)
 		.clock_mode = CM_AUTO,
 		0
 	};
-
-	char		*devname = DEFAULT_DEVICE;
-	unsigned	seconds = 0;
-	int		suspend = STANDBY_MODE;
-
-	int		rc = EXIT_SUCCESS;
-	int		t;
-	int		fd;
-	time_t		alarm = 0;
-
+	char *devname = DEFAULT_DEVICE;
+	unsigned seconds = 0;
+	int suspend = STANDBY_MODE;
+	int rc = EXIT_SUCCESS;
+	int t;
+	int fd;
+	time_t alarm = 0;
 	enum {
 		OPT_DATE = CHAR_MAX + 1
 	};
-
 	static const struct option long_options[] = {
 		{"adjfile",     required_argument,      0, 'A'},
 		{"auto",	no_argument,		0, 'a'},
@@ -457,7 +416,6 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
-
 	while ((t = getopt_long(argc, argv, "A:ahd:lm:ns:t:uVv",
 					long_options, NULL)) != EOF) {
 		switch (t) {
@@ -465,41 +423,32 @@ int main(int argc, char **argv)
 			/* for better compatibility with hwclock */
 			ctl.adjfile = optarg;
 			break;
-
 		case 'a':
 			ctl.clock_mode = CM_AUTO;
 			break;
-
 		case 'd':
 			devname = optarg;
 			break;
-
 		case 'l':
 			ctl.clock_mode = CM_LOCAL;
 			break;
-
 		case 'm':
 			if ((suspend = get_mode(optarg)) == ERROR_MODE)
 				errx(EXIT_FAILURE, _("unrecognized suspend state '%s'"), optarg);
 			break;
-
 		case 'n':
 			ctl.dryrun = 1;
 			break;
-
 		case 's':
 			/* alarm time, seconds-to-sleep (relative) */
 			seconds = strtou32_or_err(optarg, _("invalid seconds argument"));
 			break;
-
 		case 't':
 			/* alarm time, time_t (absolute, seconds since epoc) */
 			alarm = strtou32_or_err(optarg, _("invalid time argument"));
 			break;
-
 		case OPT_DATE:
-		{
-			/* alarm time, see timestamp format from manual */
+		{	/* alarm time, see timestamp format from manual */
 			usec_t p;
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
@@ -509,22 +458,18 @@ int main(int argc, char **argv)
 		case 'u':
 			ctl.clock_mode = CM_UTC;
 			break;
-
 		case 'v':
 			ctl.verbose = 1;
 			break;
-
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
-
 		case 'h':
 			usage(stdout);
 		default:
 			usage(stderr);
 		}
 	}
-
 	if (ctl.clock_mode == CM_AUTO) {
 		if (read_clock_mode(&ctl) < 0) {
 			printf(_("%s: assuming RTC uses UTC ...\n"),
@@ -535,34 +480,27 @@ int main(int argc, char **argv)
 	if (ctl.verbose)
 		printf("%s",  ctl.clock_mode == CM_UTC ? _("Using UTC time.\n") :
 				_("Using local time.\n"));
-
 	if (!alarm && !seconds && suspend < DISABLE_MODE) {
 		warnx(_("must provide wake time (see --seconds, --time, and --date options)"));
 		usage(stderr);
 	}
-
 	/* device must exist and (if we'll sleep) be wakeup-enabled */
 	fd = open_dev_rtc(devname);
-
 	if (suspend != ON_MODE && suspend != NO_MODE && !is_wakeup_enabled(devname))
 		errx(EXIT_FAILURE, _("%s not enabled for wakeup events"), devname);
-
 	/* relative or absolute alarm time, normalized to time_t */
 	if (get_basetimes(&ctl, fd) < 0)
 		exit(EXIT_FAILURE);
 	if (ctl.verbose)
 		printf(_("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n"),
 				alarm, ctl.sys_time, ctl.rtc_time, seconds);
-
 	if (suspend < DISABLE_MODE) {
 		if (suspend < OFF_MODE && is_suspend_available(suspend) <= 0) {
 			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"),
 			     mode_str[suspend]);
 		}
-
-		/* care about alarm setup only if the show|disable
-		 * modes are not set
-		 */
+		/* care about alarm setup only if the show or disable
+		 * modes are not set */
 		if (alarm) {
 			if (alarm < ctl.sys_time)
 				errx(EXIT_FAILURE, _("time doesn't go backward to %s"),
@@ -570,10 +508,8 @@ int main(int argc, char **argv)
 			alarm += ctl.sys_time - ctl.rtc_time;
 		} else
 			alarm = ctl.rtc_time + seconds + 1;
-
 		if (setup_alarm(&ctl, fd, &alarm) < 0)
 			exit(EXIT_FAILURE);
-
 		if (suspend == NO_MODE || suspend == ON_MODE)
 			printf(_("%s: wakeup using %s at %s"),
 				program_invocation_short_name, devname,
@@ -585,14 +521,12 @@ int main(int argc, char **argv)
 		fflush(stdout);
 		xusleep(10 * 1000);
 	}
-
 	switch (suspend) {
 	case NO_MODE:
 		if (ctl.verbose)
 			printf(_("suspend mode: no; leaving\n"));
 		ctl.dryrun = 1;	/* to skip disabling alarm at the end */
 		break;
-
 	case OFF_MODE:
 	{
 		char *arg[5];
@@ -606,10 +540,8 @@ int main(int argc, char **argv)
 		arg[i++] = "-P";
 		arg[i++] = "now";
 		arg[i]   = NULL;
-
 		if (!ctl.dryrun) {
 			execv(arg[0], arg);
-
 			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
 			rc = EXIT_FAILURE;
 		}
@@ -621,7 +553,6 @@ int main(int argc, char **argv)
 
 		if (ctl.verbose)
 			printf(_("suspend mode: on; reading rtc\n"));
-
 		if (!ctl.dryrun) {
 			do {
 				t = read(fd, &data, sizeof data);
@@ -640,7 +571,6 @@ int main(int argc, char **argv)
 		if (ctl.verbose)
 			printf(_("suspend mode: disable; disabling alarm\n"));
 		break;
-
 	case SHOW_MODE:
 		if (ctl.verbose)
 			printf(_("suspend mode: show; printing alarm info\n"));
@@ -648,7 +578,6 @@ int main(int argc, char **argv)
 			rc = EXIT_FAILURE;
 		ctl.dryrun = 1;	/* don't really disable alarm in the end, just show */
 		break;
-
 	default:
 		if (ctl.verbose)
 			printf(_("suspend mode: %s; suspending system\n"), mode_str[suspend]);
@@ -670,7 +599,6 @@ int main(int argc, char **argv)
 			}
 		}
 	}
-
 	close(fd);
 	return rc;
 }
-- 
2.3.0

