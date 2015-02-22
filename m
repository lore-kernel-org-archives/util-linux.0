Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:39090 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBVOmi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:38 -0500
Received: by wesx3 with SMTP id x3so13610209wes.6
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/13] rtcwake: do not overwrite device name
Date: Sun, 22 Feb 2015 14:42:15 +0000
Message-Id: <1424616139-638-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This improves error messaging, and allows freeing path to device when it
is not needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index f951c9c..7f1e351 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -49,7 +49,7 @@
 
 #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
 #define SYS_POWER_STATE_PATH	"/sys/power/state"
-#define DEFAULT_DEVICE		"/dev/rtc0"
+#define DEFAULT_DEVICE		"rtc0"
 
 enum rtc_modes {	/* manual page --mode option explains these. */
 	STANDBY_MODE = 0,
@@ -137,7 +137,7 @@ static int is_wakeup_enabled(const char *devname)
 	FILE	*f;
 
 	/* strip the '/dev/' from the devname here */
-	snprintf(buf, sizeof buf, RTC_PATH, devname + strlen("/dev/"));
+	snprintf(buf, sizeof buf, RTC_PATH, devname);
 	f = fopen(buf, "r");
 	if (!f) {
 		warn(_("cannot open %s"), buf);
@@ -395,6 +395,25 @@ static int get_mode(const char *optarg)
 	return ERROR_MODE;
 }
 
+static int open_dev_rtc(const char *devname)
+{
+	int fd;
+	char *devpath;
+	size_t len = strlen(devname);
+
+	devpath = xmalloc(sizeof "/dev/" + len);
+	memcpy(devpath, "/dev/", sizeof "/dev/");
+	memcpy(devpath + strlen("/dev/"), devname, len + 1);
+#ifdef O_CLOEXEC
+	fd = open(devpath, O_RDONLY | O_CLOEXEC);
+#else
+	fd = open(devpath, O_RDONLY);
+#endif
+	if (fd < 0)
+		err(EXIT_FAILURE, _("%s: unable to find device"), devpath);
+	free(devpath);
+	return fd;
+}
 
 int main(int argc, char **argv)
 {
@@ -522,29 +541,12 @@ int main(int argc, char **argv)
 		usage(stderr);
 	}
 
-	/* when devname doesn't start with /dev, append it */
-	if (strncmp(devname, "/dev/", strlen("/dev/")) != 0) {
-		char *new_devname;
-
-		new_devname = xmalloc(strlen(devname) + strlen("/dev/") + 1);
-
-		strcpy(new_devname, "/dev/");
-		strcat(new_devname, devname);
-		devname = new_devname;
-	}
+	/* device must exist and (if we'll sleep) be wakeup-enabled */
+	fd = open_dev_rtc(devname);
 
 	if (suspend != ON_MODE && suspend != NO_MODE && !is_wakeup_enabled(devname))
 		errx(EXIT_FAILURE, _("%s not enabled for wakeup events"), devname);
 
-	/* this RTC must exist and (if we'll sleep) be wakeup-enabled */
-#ifdef O_CLOEXEC
-	fd = open(devname, O_RDONLY | O_CLOEXEC);
-#else
-	fd = open(devname, O_RDONLY);
-#endif
-	if (fd < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), devname);
-
 	/* relative or absolute alarm time, normalized to time_t */
 	if (get_basetimes(&ctl, fd) < 0)
 		exit(EXIT_FAILURE);
-- 
2.3.0

