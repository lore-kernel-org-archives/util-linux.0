Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:63761 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBVOmn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:43 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so11710484wib.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/13] rtcwake: read accepted mode strings from /sys/power/state
Date: Sun, 22 Feb 2015 14:42:19 +0000
Message-Id: <1424616139-638-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 96 ++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 52 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 32a0ba0..b838f13 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -51,29 +51,16 @@
 #define DEFAULT_DEVICE		"rtc0"
 
 enum rtc_modes {	/* manual page --mode option explains these. */
-	STANDBY_MODE = 0,
-	MEM_MODE,
-	FREEZE_MODE,
-	DISK_MODE,	/* end of Documentation/power/states.txt modes  */
+	ERROR_MODE = 0,	/* invalid user input */
+	SYSFS_MODE,
 	OFF_MODE,
 	NO_MODE,
 	ON_MODE,	/* smaller <- read the code */
 	DISABLE_MODE,	/* greater <- to understand */
 	SHOW_MODE,
-	ERROR_MODE	/* invalid user input */
 };
 
-/* what system power mode to use?  for now handle only standardized mode
- * names; eventually when systems define their own state names, parse
- * /sys/power/state
- *
- * "on" is used just to test the RTC alarm mechanism, bypassing all the
- * wakeup-from-sleep infrastructure.  */
-static const char *mode_str[] = {
-	[STANDBY_MODE] = "standby",
-	[MEM_MODE] = "mem",
-	[FREEZE_MODE] = "freeze",
-	[DISK_MODE] = "disk",
+static const char *rtcwake_mode_string[] = {
 	[OFF_MODE] = "off",
 	[NO_MODE] = "no",
 	[ON_MODE] = "on",
@@ -88,6 +75,7 @@ enum clock_modes {
 };
 
 struct rtcwake_control {
+	char *mode_str;			/* name of the requested mode */
 	char *adjfile;			/* adjtime file path */
 	enum clock_modes clock_mode;	/* hwclock timezone */
 	time_t sys_time;		/* system time */
@@ -238,23 +226,35 @@ static int setup_alarm(struct rtcwake_control *ctl, int fd, time_t *wakeup)
 	return 0;
 }
 
-static int is_suspend_available(const int suspend)
+static int is_suspend_available(const char *name)
 {
-	int rc;
-	char buf[32];
-	FILE *f = fopen(SYS_POWER_STATE_PATH, "r");
+	int rc = 0;
+	char *line = NULL, *s, *p;
+	size_t sz = 0;
+	FILE *fp = fopen(SYS_POWER_STATE_PATH, "r");
 
-	if (!f)
-		return -1;
-	if (fgets(buf, sizeof buf, f) == NULL)
-		rc = -1;
-	else
-		rc = strstr(buf, mode_str[suspend]) != NULL;
-	fclose(f);
+	if (!fp)
+		return 0;
+	if (getline(&line, &sz, fp) == -1) {
+		fclose(fp);
+		return 0;
+	}
+	s = line;
+	while (1) {
+		p = strsep(&s, " ");
+		if (p == NULL || *p == '\0')
+			break;
+		if (!strcmp(p, name)) {
+			rc = 1;
+			break;
+		}
+	}
+	free(line);
+	fclose(fp);
 	return rc;
 }
 
-static void suspend_system(struct rtcwake_control *ctl, int suspend)
+static void suspend_system(struct rtcwake_control *ctl)
 {
 	FILE	*f = fopen(SYS_POWER_STATE_PATH, "w");
 
@@ -263,7 +263,7 @@ static void suspend_system(struct rtcwake_control *ctl, int suspend)
 		return;
 	}
 	if (!ctl->dryrun) {
-		fprintf(f, "%s\n", mode_str[suspend]);
+		fprintf(f, "%s\n", ctl->mode_str);
 		fflush(f);
 	}
 	/* this executes after wake from suspend */
@@ -338,23 +338,17 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 
 static int get_mode(const char *optarg)
 {
-	if (!strcmp(optarg, mode_str[STANDBY_MODE]))
-		return STANDBY_MODE;
-	if (!strcmp(optarg, mode_str[MEM_MODE]))
-		return MEM_MODE;
-	if (!strcmp(optarg, mode_str[DISK_MODE]))
-		return DISK_MODE;
-	if (!strcmp(optarg, mode_str[ON_MODE]))
+	if (is_suspend_available(optarg))
+		return SYSFS_MODE;
+	if (!strcmp(optarg, rtcwake_mode_string[ON_MODE]))
 		return ON_MODE;
-	if (!strcmp(optarg, mode_str[NO_MODE]))
+	if (!strcmp(optarg, rtcwake_mode_string[NO_MODE]))
 		return NO_MODE;
-	if (!strcmp(optarg, mode_str[OFF_MODE]))
+	if (!strcmp(optarg, rtcwake_mode_string[OFF_MODE]))
 		return OFF_MODE;
-	if (!strcmp(optarg, mode_str[FREEZE_MODE]))
-		return FREEZE_MODE;
-	if (!strcmp(optarg, mode_str[DISABLE_MODE]))
+	if (!strcmp(optarg, rtcwake_mode_string[DISABLE_MODE]))
 		return DISABLE_MODE;
-	if (!strcmp(optarg, mode_str[SHOW_MODE]))
+	if (!strcmp(optarg, rtcwake_mode_string[SHOW_MODE]))
 		return SHOW_MODE;
 	return ERROR_MODE;
 }
@@ -382,13 +376,14 @@ static int open_dev_rtc(const char *devname)
 int main(int argc, char **argv)
 {
 	struct rtcwake_control ctl = {
+		.mode_str = "suspend",		/* default mode */
 		.adjfile = _PATH_ADJTIME,
 		.clock_mode = CM_AUTO,
 		0
 	};
 	char *devname = DEFAULT_DEVICE;
 	unsigned seconds = 0;
-	int suspend = STANDBY_MODE;
+	int suspend = SYSFS_MODE;
 	int rc = EXIT_SUCCESS;
 	int t;
 	int fd;
@@ -442,6 +437,7 @@ int main(int argc, char **argv)
 		case 'm':
 			if ((suspend = get_mode(optarg)) == ERROR_MODE)
 				errx(EXIT_FAILURE, _("unrecognized suspend state '%s'"), optarg);
+			ctl.mode_str = optarg;
 			break;
 		case 'n':
 			ctl.dryrun = 1;
@@ -502,12 +498,8 @@ int main(int argc, char **argv)
 		printf(_("alarm %ld, sys_time %ld, rtc_time %ld, seconds %u\n"),
 				alarm, ctl.sys_time, ctl.rtc_time, seconds);
 	if (suspend < DISABLE_MODE) {
-		if (suspend < OFF_MODE && is_suspend_available(suspend) <= 0) {
-			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"),
-			     mode_str[suspend]);
-		}
-		/* care about alarm setup only if the show or disable
-		 * modes are not set */
+		/* perform alarm setup when the show or disable modes are
+		 * not set */
 		if (alarm) {
 			if (alarm < ctl.sys_time)
 				errx(EXIT_FAILURE, _("time doesn't go backward to %s"),
@@ -523,7 +515,7 @@ int main(int argc, char **argv)
 				ctime(&alarm));
 		else
 			printf(_("%s: wakeup from \"%s\" using %s at %s"),
-				program_invocation_short_name, mode_str[suspend], devname,
+				program_invocation_short_name, ctl.mode_str, devname,
 				ctime(&alarm));
 		fflush(stdout);
 		xusleep(10 * 1000);
@@ -587,9 +579,9 @@ int main(int argc, char **argv)
 		break;
 	default:
 		if (ctl.verbose)
-			printf(_("suspend mode: %s; suspending system\n"), mode_str[suspend]);
+			printf(_("suspend mode: %s; suspending system\n"), ctl.mode_str);
 		sync();
-		suspend_system(&ctl, suspend);
+		suspend_system(&ctl);
 	}
 
 	if (!ctl.dryrun) {
-- 
2.3.0

