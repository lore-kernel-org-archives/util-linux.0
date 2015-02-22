Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57022 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbBVOmZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:25 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so21162517wgg.11
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/13] rtcwake: enumerate constant mode strings
Date: Sun, 22 Feb 2015 14:42:08 +0000
Message-Id: <1424616139-638-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 126 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 48 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 8b5f69c..372e620 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -52,7 +52,37 @@
 #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
 #define SYS_POWER_STATE_PATH	"/sys/power/state"
 #define DEFAULT_DEVICE		"/dev/rtc0"
-#define DEFAULT_MODE		"standby"
+
+enum rtc_modes {	/* manual page --mode option explains these. */
+	STANDBY_MODE = 0,
+	MEM_MODE,
+	FREEZE_MODE,
+	DISK_MODE,	/* end of Documentation/power/states.txt modes  */
+	OFF_MODE,
+	NO_MODE,
+	ON_MODE,	/* smaller <- read the code */
+	DISABLE_MODE,	/* greater <- to understand */
+	SHOW_MODE,
+	ERROR_MODE	/* invalid user input */
+};
+
+/* what system power mode to use?  for now handle only standardized mode
+ * names; eventually when systems define their own state names, parse
+ * /sys/power/state
+ *
+ * "on" is used just to test the RTC alarm mechanism, bypassing all the
+ * wakeup-from-sleep infrastructure.  */
+static const char *mode_str[] = {
+	[STANDBY_MODE] = "standby",
+	[MEM_MODE] = "mem",
+	[FREEZE_MODE] = "freeze",
+	[DISK_MODE] = "disk",
+	[OFF_MODE] = "off",
+	[NO_MODE] = "no",
+	[ON_MODE] = "on",
+	[DISABLE_MODE] = "disable",
+	[SHOW_MODE] = "show"
+};
 
 enum clock_modes {
 	CM_AUTO,
@@ -243,7 +273,7 @@ static int setup_alarm(struct rtcwake_control *ctl, int fd, time_t *wakeup)
 	return 0;
 }
 
-static int is_suspend_available(const char *suspend)
+static int is_suspend_available(const int suspend)
 {
 	int rc;
 	char buf[32];
@@ -255,13 +285,13 @@ static int is_suspend_available(const char *suspend)
 	if (fgets(buf, sizeof buf, f) == NULL)
 		rc = -1;
 	else
-		rc = strstr(buf, suspend) != NULL;
+		rc = strstr(buf, mode_str[suspend]) != NULL;
 
 	fclose(f);
 	return rc;
 }
 
-static void suspend_system(struct rtcwake_control *ctl, const char *suspend)
+static void suspend_system(struct rtcwake_control *ctl, int suspend)
 {
 	FILE	*f = fopen(SYS_POWER_STATE_PATH, "w");
 
@@ -271,7 +301,7 @@ static void suspend_system(struct rtcwake_control *ctl, const char *suspend)
 	}
 
 	if (!ctl->dryrun) {
-		fprintf(f, "%s\n", suspend);
+		fprintf(f, "%s\n", mode_str[suspend]);
 		fflush(f);
 	}
 
@@ -372,6 +402,30 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 	return 0;
 }
 
+static int get_mode(const char *optarg)
+{
+	if (!strcmp(optarg, mode_str[STANDBY_MODE]))
+		return STANDBY_MODE;
+	if (!strcmp(optarg, mode_str[MEM_MODE]))
+		return MEM_MODE;
+	if (!strcmp(optarg, mode_str[DISK_MODE]))
+		return DISK_MODE;
+	if (!strcmp(optarg, mode_str[ON_MODE]))
+		return ON_MODE;
+	if (!strcmp(optarg, mode_str[NO_MODE]))
+		return NO_MODE;
+	if (!strcmp(optarg, mode_str[OFF_MODE]))
+		return OFF_MODE;
+	if (!strcmp(optarg, mode_str[FREEZE_MODE]))
+		return FREEZE_MODE;
+	if (!strcmp(optarg, mode_str[DISABLE_MODE]))
+		return DISABLE_MODE;
+	if (!strcmp(optarg, mode_str[SHOW_MODE]))
+		return SHOW_MODE;
+	return ERROR_MODE;
+}
+
+
 int main(int argc, char **argv)
 {
 	struct rtcwake_control ctl = {
@@ -382,7 +436,7 @@ int main(int argc, char **argv)
 
 	char		*devname = DEFAULT_DEVICE;
 	unsigned	seconds = 0;
-	char		*suspend = DEFAULT_MODE;
+	int		suspend = STANDBY_MODE;
 
 	int		rc = EXIT_SUCCESS;
 	int		t;
@@ -417,8 +471,9 @@ int main(int argc, char **argv)
 			/* for better compatibility with hwclock */
 			ctl.adjfile = optarg;
 			break;
+
 		case 'a':
-			/* CM_AUTO is default */
+			ctl.clock_mode = CM_AUTO;
 			break;
 
 		case 'd':
@@ -429,31 +484,9 @@ int main(int argc, char **argv)
 			ctl.clock_mode = CM_LOCAL;
 			break;
 
-			/* what system power mode to use?  for now handle only
-			 * standardized mode names; eventually when systems
-			 * define their own state names, parse
-			 * /sys/power/state.
-			 *
-			 * "on" is used just to test the RTC alarm mechanism,
-			 * bypassing all the wakeup-from-sleep infrastructure.
-			 */
 		case 'm':
-			if (strcmp(optarg, "standby") == 0
-					|| strcmp(optarg, "mem") == 0
-					|| strcmp(optarg, "disk") == 0
-					|| strcmp(optarg, "on") == 0
-					|| strcmp(optarg, "no") == 0
-					|| strcmp(optarg, "off") == 0
-					|| strcmp(optarg, "freeze") == 0
-					|| strcmp(optarg, "disable") == 0
-					|| strcmp(optarg, "show") == 0
-			   ) {
-				suspend = optarg;
-				break;
-			}
-
-			errx(EXIT_FAILURE, _("unrecognized suspend state '%s'"),
-									optarg);
+			if ((suspend = get_mode(optarg)) == ERROR_MODE)
+				errx(EXIT_FAILURE, _("unrecognized suspend state '%s'"), optarg);
 			break;
 
 		case 'n':
@@ -502,9 +535,7 @@ int main(int argc, char **argv)
 		printf("%s",  ctl.clock_mode == CM_UTC ? _("Using UTC time.\n") :
 				_("Using local time.\n"));
 
-	if (!alarm && !seconds && strcmp(suspend,"disable") &&
-				  strcmp(suspend,"show")) {
-
+	if (!alarm && !seconds && suspend < DISABLE_MODE) {
 		warnx(_("must provide wake time (see -t and -s options)"));
 		usage(stderr);
 	}
@@ -520,8 +551,7 @@ int main(int argc, char **argv)
 		devname = new_devname;
 	}
 
-	if (strcmp(suspend, "on") != 0 && strcmp(suspend, "no") != 0
-			&& !is_wakeup_enabled(devname))
+	if (suspend != ON_MODE && suspend != NO_MODE && !is_wakeup_enabled(devname))
 		errx(EXIT_FAILURE, _("%s not enabled for wakeup events"), devname);
 
 	/* this RTC must exist and (if we'll sleep) be wakeup-enabled */
@@ -540,10 +570,10 @@ int main(int argc, char **argv)
 		printf(_("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n"),
 				alarm, ctl.sys_time, ctl.rtc_time, seconds);
 
-	if (strcmp(suspend, "show") && strcmp(suspend, "disable")) {
-		if (strcmp(suspend, "no") && strcmp(suspend, "on") &&
-		    strcmp(suspend, "off") && is_suspend_available(suspend) <= 0) {
-			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"), suspend);
+	if (suspend < DISABLE_MODE) {
+		if (suspend < OFF_MODE && is_suspend_available(suspend) <= 0) {
+			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"),
+			     mode_str[suspend]);
 		}
 
 		/* care about alarm setup only if the show|disable
@@ -560,24 +590,24 @@ int main(int argc, char **argv)
 		if (setup_alarm(&ctl, fd, &alarm) < 0)
 			exit(EXIT_FAILURE);
 
-		if (strcmp(suspend, "no") == 0 || strcmp(suspend, "on") == 0)
+		if (suspend == NO_MODE || suspend == ON_MODE)
 			printf(_("%s: wakeup using %s at %s"),
 				program_invocation_short_name, devname,
 				ctime(&alarm));
 		else
 			printf(_("%s: wakeup from \"%s\" using %s at %s"),
-				program_invocation_short_name, suspend, devname,
+				program_invocation_short_name, mode_str[suspend], devname,
 				ctime(&alarm));
 		fflush(stdout);
 		xusleep(10 * 1000);
 	}
 
-	if (strcmp(suspend, "no") == 0) {
+	if (suspend == NO_MODE) {
 		if (ctl.verbose)
 			printf(_("suspend mode: no; leaving\n"));
 		ctl.dryrun = 1;	/* to skip disabling alarm at the end */
 
-	} else if (strcmp(suspend, "off") == 0) {
+	} else if (suspend == OFF_MODE) {
 		char *arg[5];
 		int i = 0;
 
@@ -597,7 +627,7 @@ int main(int argc, char **argv)
 			rc = EXIT_FAILURE;
 		}
 
-	} else if (strcmp(suspend, "on") == 0) {
+	} else if (suspend == ON_MODE) {
 		unsigned long data;
 
 		if (ctl.verbose)
@@ -615,12 +645,12 @@ int main(int argc, char **argv)
 			} while (!(data & RTC_AF));
 		}
 
-	} else if (strcmp(suspend, "disable") == 0) {
+	} else if (suspend == DISABLE_MODE) {
 		/* just break, alarm gets disabled in the end */
 		if (ctl.verbose)
 			printf(_("suspend mode: disable; disabling alarm\n"));
 
-	} else if(strcmp(suspend,"show") == 0) {
+	} else if (suspend == SHOW_MODE) {
 		if (ctl.verbose)
 			printf(_("suspend mode: show; printing alarm info\n"));
 		if (print_alarm(&ctl, fd))
@@ -629,7 +659,7 @@ int main(int argc, char **argv)
 
 	} else {
 		if (ctl.verbose)
-			printf(_("suspend mode: %s; suspending system\n"), suspend);
+			printf(_("suspend mode: %s; suspending system\n"), mode_str[suspend]);
 		sync();
 		suspend_system(&ctl, suspend);
 	}
-- 
2.3.0

