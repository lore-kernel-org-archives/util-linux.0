Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36318 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVOmd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:33 -0500
Received: by mail-wg0-f42.google.com with SMTP id n12so21296034wgh.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:32 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/13] rtcwake: improve read_clock_mode()
Date: Sun, 22 Feb 2015 14:42:11 +0000
Message-Id: <1424616139-638-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make skipping two lines more robust, and add message about unexpected
adjfile contents when running with --verbose.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index a0e3151..790863f 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -47,8 +47,6 @@
 #define	RTC_AF	0x20
 #define	RTC_UF	0x10
 
-#define MAX_LINE		1024
-
 #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
 #define SYS_POWER_STATE_PATH	"/sys/power/state"
 #define DEFAULT_DEVICE		"/dev/rtc0"
@@ -299,26 +297,25 @@ static void suspend_system(struct rtcwake_control *ctl, int suspend)
 static int read_clock_mode(struct rtcwake_control *ctl)
 {
 	FILE *fp;
-	char linebuf[MAX_LINE];
+	char ch, linebuf[8];
+	int lines = 2, give_up = 0xffff;
 
 	fp = fopen(ctl->adjfile, "r");
 	if (!fp)
 		return -1;
 
-	/* skip first line */
-	if (!fgets(linebuf, MAX_LINE, fp)) {
-		fclose(fp);
-		return -1;
-	}
-
-	/* skip second line */
-	if (!fgets(linebuf, MAX_LINE, fp)) {
-		fclose(fp);
-		return -1;
-	}
+	/* skip lines */
+	do {
+		if ((ch = fgetc(fp)) == EOF || 0 < give_up--) {
+			fclose(fp);
+			return -1;
+		}
+		if (ch == '\n' && --lines == 0)
+			break;
+	} while (1);
 
 	/* read third line */
-	if (!fgets(linebuf, MAX_LINE, fp)) {
+	if (!fgets(linebuf, sizeof linebuf, fp)) {
 		fclose(fp);
 		return -1;
 	}
@@ -327,6 +324,8 @@ static int read_clock_mode(struct rtcwake_control *ctl)
 		ctl->clock_mode = CM_UTC;
 	else if (strncmp(linebuf, "LOCAL", 5) == 0)
 		ctl->clock_mode = CM_LOCAL;
+	else if (ctl->verbose)
+		warnx(_("unexpected third line in: %s: %s"), ctl->adjfile, linebuf);
 
 	fclose(fp);
 
-- 
2.3.0

