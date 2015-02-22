Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:51788 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbBVOmX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:23 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so21133845wgh.12
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/13] rtcwake: add rtcwake_control and remove global variables
Date: Sun, 22 Feb 2015 14:42:07 +0000
Message-Id: <1424616139-638-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 131 +++++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index bf99a5b..8b5f69c 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -54,16 +54,21 @@
 #define DEFAULT_DEVICE		"/dev/rtc0"
 #define DEFAULT_MODE		"standby"
 
-enum ClockMode {
+enum clock_modes {
 	CM_AUTO,
 	CM_UTC,
 	CM_LOCAL
 };
 
-static char		*adjfile = _PATH_ADJTIME;
-static unsigned		verbose;
-static unsigned		dryrun;
-enum ClockMode		clock_mode = CM_AUTO;
+struct rtcwake_control {
+	char *adjfile;			/* adjtime file path */
+	enum clock_modes clock_mode;	/* hwclock timezone */
+	time_t sys_time;		/* system time */
+	time_t rtc_time;		/* hardware time */
+	unsigned int
+	 verbose:1,			/* verbose messaging */
+	 dryrun:1;			/* do not set alarm, suspend system, etc */
+};
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -123,11 +128,7 @@ static int is_wakeup_enabled(const char *devname)
 	return strcmp(buf, "enabled") == 0;
 }
 
-/* all times should be in UTC */
-static time_t	sys_time;
-static time_t	rtc_time;
-
-static int get_basetimes(int fd)
+static int get_basetimes(struct rtcwake_control *ctl, int fd)
 {
 	struct tm	tm;
 	struct rtc_time	rtc;
@@ -135,7 +136,7 @@ static int get_basetimes(int fd)
 	/* this process works in RTC time, except when working
 	 * with the system clock (which always uses UTC).
 	 */
-	if (clock_mode == CM_UTC)
+	if (ctl->clock_mode == CM_UTC)
 		setenv("TZ", "UTC", 1);
 	tzset();
 
@@ -146,8 +147,8 @@ static int get_basetimes(int fd)
 		warn(_("read rtc time failed"));
 		return -1;
 	}
-	sys_time = time(0);
-	if (sys_time == (time_t)-1) {
+	ctl->sys_time = time(0);
+	if (ctl->sys_time == (time_t)-1) {
 		warn(_("read system time failed"));
 		return -1;
 	}
@@ -163,33 +164,33 @@ static int get_basetimes(int fd)
 	tm.tm_mon = rtc.tm_mon;
 	tm.tm_year = rtc.tm_year;
 	tm.tm_isdst = -1;  /* assume the system knows better than the RTC */
-	rtc_time = mktime(&tm);
+	ctl->rtc_time = mktime(&tm);
 
-	if (rtc_time == (time_t)-1) {
+	if (ctl->rtc_time == (time_t)-1) {
 		warn(_("convert rtc time failed"));
 		return -1;
 	}
 
-	if (verbose) {
+	if (ctl->verbose) {
 		/* Unless the system uses UTC, either delta or tzone
 		 * reflects a seconds offset from UTC.  The value can
 		 * help sort out problems like bugs in your C library.
 		 */
-		printf("\tdelta   = %ld\n", sys_time - rtc_time);
+		printf("\tdelta   = %ld\n", ctl->sys_time - ctl->rtc_time);
 		printf("\ttzone   = %ld\n", timezone);
 
 		printf("\ttzname  = %s\n", tzname[daylight]);
-		gmtime_r(&rtc_time, &tm);
+		gmtime_r(&ctl->rtc_time, &tm);
 		printf("\tsystime = %ld, (UTC) %s",
-				(long) sys_time, asctime(gmtime(&sys_time)));
+				(long) ctl->sys_time, asctime(gmtime(&ctl->sys_time)));
 		printf("\trtctime = %ld, (UTC) %s",
-				(long) rtc_time, asctime(&tm));
+				(long) ctl->rtc_time, asctime(&tm));
 	}
 
 	return 0;
 }
 
-static int setup_alarm(int fd, time_t *wakeup)
+static int setup_alarm(struct rtcwake_control *ctl, int fd, time_t *wakeup)
 {
 	struct tm		*tm;
 	struct rtc_wkalrm	wake;
@@ -220,11 +221,11 @@ static int setup_alarm(int fd, time_t *wakeup)
 	wake.enabled = 1;
 
 	/* First try the preferred RTC_WKALM_SET */
-	if (!dryrun && ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
+	if (!ctl->dryrun && ioctl(fd, RTC_WKALM_SET, &wake) < 0) {
 		wake.enabled = 0;
 		/* Fall back on the non-preferred way of setting wakeups; only
 		* works for alarms < 24 hours from now */
-		if ((rtc_time + (24 * 60 * 60)) > *wakeup) {
+		if ((ctl->rtc_time + (24 * 60 * 60)) > *wakeup) {
 			if (ioctl(fd, RTC_ALM_SET, &wake.time) < 0) {
 				warn(_("set rtc alarm failed"));
 				return -1;
@@ -260,7 +261,7 @@ static int is_suspend_available(const char *suspend)
 	return rc;
 }
 
-static void suspend_system(const char *suspend)
+static void suspend_system(struct rtcwake_control *ctl, const char *suspend)
 {
 	FILE	*f = fopen(SYS_POWER_STATE_PATH, "w");
 
@@ -269,7 +270,7 @@ static void suspend_system(const char *suspend)
 		return;
 	}
 
-	if (!dryrun) {
+	if (!ctl->dryrun) {
 		fprintf(f, "%s\n", suspend);
 		fflush(f);
 	}
@@ -280,12 +281,12 @@ static void suspend_system(const char *suspend)
 }
 
 
-static int read_clock_mode(void)
+static int read_clock_mode(struct rtcwake_control *ctl)
 {
 	FILE *fp;
 	char linebuf[MAX_LINE];
 
-	fp = fopen(adjfile, "r");
+	fp = fopen(ctl->adjfile, "r");
 	if (!fp)
 		return -1;
 
@@ -308,9 +309,9 @@ static int read_clock_mode(void)
 	}
 
 	if (strncmp(linebuf, "UTC", 3) == 0)
-		clock_mode = CM_UTC;
+		ctl->clock_mode = CM_UTC;
 	else if (strncmp(linebuf, "LOCAL", 5) == 0)
-		clock_mode = CM_LOCAL;
+		ctl->clock_mode = CM_LOCAL;
 
 	fclose(fp);
 
@@ -320,7 +321,7 @@ static int read_clock_mode(void)
 /**
  * print basic alarm settings
  */
-static int print_alarm(int fd)
+static int print_alarm(struct rtcwake_control *ctl, int fd)
 {
 	struct rtc_wkalrm wake;
 	struct rtc_time rtc;
@@ -365,7 +366,7 @@ static int print_alarm(int fd)
 	}
 
 	/* 0 if both UTC, or expresses diff if RTC in local time */
-	alarm += sys_time - rtc_time;
+	alarm += ctl->sys_time - ctl->rtc_time;
 
 	printf(_("alarm: on  %s"), ctime(&alarm));
 	return 0;
@@ -373,6 +374,12 @@ static int print_alarm(int fd)
 
 int main(int argc, char **argv)
 {
+	struct rtcwake_control ctl = {
+		.adjfile = _PATH_ADJTIME,
+		.clock_mode = CM_AUTO,
+		0
+	};
+
 	char		*devname = DEFAULT_DEVICE;
 	unsigned	seconds = 0;
 	char		*suspend = DEFAULT_MODE;
@@ -408,7 +415,7 @@ int main(int argc, char **argv)
 		switch (t) {
 		case 'A':
 			/* for better compatibility with hwclock */
-			adjfile = optarg;
+			ctl.adjfile = optarg;
 			break;
 		case 'a':
 			/* CM_AUTO is default */
@@ -419,7 +426,7 @@ int main(int argc, char **argv)
 			break;
 
 		case 'l':
-			clock_mode = CM_LOCAL;
+			ctl.clock_mode = CM_LOCAL;
 			break;
 
 			/* what system power mode to use?  for now handle only
@@ -450,7 +457,7 @@ int main(int argc, char **argv)
 			break;
 
 		case 'n':
-			dryrun = 1;
+			ctl.dryrun = 1;
 			break;
 
 			/* alarm time, seconds-to-sleep (relative) */
@@ -466,11 +473,11 @@ int main(int argc, char **argv)
 			break;
 
 		case 'u':
-			clock_mode = CM_UTC;
+			ctl.clock_mode = CM_UTC;
 			break;
 
 		case 'v':
-			verbose++;
+			ctl.verbose = 1;
 			break;
 
 		case 'V':
@@ -484,15 +491,15 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (clock_mode == CM_AUTO) {
-		if (read_clock_mode() < 0) {
+	if (ctl.clock_mode == CM_AUTO) {
+		if (read_clock_mode(&ctl) < 0) {
 			printf(_("%s: assuming RTC uses UTC ...\n"),
 					program_invocation_short_name);
-			clock_mode = CM_UTC;
+			ctl.clock_mode = CM_UTC;
 		}
 	}
-	if (verbose)
-		printf("%s", clock_mode == CM_UTC ? _("Using UTC time.\n") :
+	if (ctl.verbose)
+		printf("%s",  ctl.clock_mode == CM_UTC ? _("Using UTC time.\n") :
 				_("Using local time.\n"));
 
 	if (!alarm && !seconds && strcmp(suspend,"disable") &&
@@ -527,11 +534,11 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("cannot open %s"), devname);
 
 	/* relative or absolute alarm time, normalized to time_t */
-	if (get_basetimes(fd) < 0)
+	if (get_basetimes(&ctl, fd) < 0)
 		exit(EXIT_FAILURE);
-	if (verbose)
+	if (ctl.verbose)
 		printf(_("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n"),
-				alarm, sys_time, rtc_time, seconds);
+				alarm, ctl.sys_time, ctl.rtc_time, seconds);
 
 	if (strcmp(suspend, "show") && strcmp(suspend, "disable")) {
 		if (strcmp(suspend, "no") && strcmp(suspend, "on") &&
@@ -543,14 +550,14 @@ int main(int argc, char **argv)
 		 * modes are not set
 		 */
 		if (alarm) {
-			if (alarm < sys_time)
+			if (alarm < ctl.sys_time)
 				errx(EXIT_FAILURE, _("time doesn't go backward to %s"),
 						ctime(&alarm));
-			alarm += sys_time - rtc_time;
+			alarm += ctl.sys_time - ctl.rtc_time;
 		} else
-			alarm = rtc_time + seconds + 1;
+			alarm = ctl.rtc_time + seconds + 1;
 
-		if (setup_alarm(fd, &alarm) < 0)
+		if (setup_alarm(&ctl, fd, &alarm) < 0)
 			exit(EXIT_FAILURE);
 
 		if (strcmp(suspend, "no") == 0 || strcmp(suspend, "on") == 0)
@@ -566,15 +573,15 @@ int main(int argc, char **argv)
 	}
 
 	if (strcmp(suspend, "no") == 0) {
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: no; leaving\n"));
-		dryrun = 1;	/* to skip disabling alarm at the end */
+		ctl.dryrun = 1;	/* to skip disabling alarm at the end */
 
 	} else if (strcmp(suspend, "off") == 0) {
 		char *arg[5];
 		int i = 0;
 
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: off; executing %s\n"),
 						_PATH_SHUTDOWN);
 		arg[i++] = _PATH_SHUTDOWN;
@@ -583,7 +590,7 @@ int main(int argc, char **argv)
 		arg[i++] = "now";
 		arg[i]   = NULL;
 
-		if (!dryrun) {
+		if (!ctl.dryrun) {
 			execv(arg[0], arg);
 
 			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
@@ -593,41 +600,41 @@ int main(int argc, char **argv)
 	} else if (strcmp(suspend, "on") == 0) {
 		unsigned long data;
 
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: on; reading rtc\n"));
 
-		if (!dryrun) {
+		if (!ctl.dryrun) {
 			do {
 				t = read(fd, &data, sizeof data);
 				if (t < 0) {
 					warn(_("rtc read failed"));
 					break;
 				}
-				if (verbose)
+				if (ctl.verbose)
 					printf("... %s: %03lx\n", devname, data);
 			} while (!(data & RTC_AF));
 		}
 
 	} else if (strcmp(suspend, "disable") == 0) {
 		/* just break, alarm gets disabled in the end */
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: disable; disabling alarm\n"));
 
 	} else if(strcmp(suspend,"show") == 0) {
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: show; printing alarm info\n"));
-		if (print_alarm(fd))
+		if (print_alarm(&ctl, fd))
 			rc = EXIT_FAILURE;
-		dryrun = 1;	/* don't really disable alarm in the end, just show */
+		ctl.dryrun = 1;	/* don't really disable alarm in the end, just show */
 
 	} else {
-		if (verbose)
+		if (ctl.verbose)
 			printf(_("suspend mode: %s; suspending system\n"), suspend);
 		sync();
-		suspend_system(suspend);
+		suspend_system(&ctl, suspend);
 	}
 
-	if (!dryrun) {
+	if (!ctl.dryrun) {
 		/* try to disable the alarm with the preferred RTC_WKALM_RD and
 		 * RTC_WKALM_SET calls, if it fails fall back to RTC_AIE_OFF
 		 */
-- 
2.3.0

