Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:48968 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVOm0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:26 -0500
Received: by mail-wg0-f41.google.com with SMTP id b13so21270007wgh.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/13] rtcwake: replace long if else statement with switch case
Date: Sun, 22 Feb 2015 14:42:09 +0000
Message-Id: <1424616139-638-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 372e620..5f4b602 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -602,12 +602,15 @@ int main(int argc, char **argv)
 		xusleep(10 * 1000);
 	}
 
-	if (suspend == NO_MODE) {
+	switch (suspend) {
+	case NO_MODE:
 		if (ctl.verbose)
 			printf(_("suspend mode: no; leaving\n"));
 		ctl.dryrun = 1;	/* to skip disabling alarm at the end */
+		break;
 
-	} else if (suspend == OFF_MODE) {
+	case OFF_MODE:
+	{
 		char *arg[5];
 		int i = 0;
 
@@ -626,8 +629,10 @@ int main(int argc, char **argv)
 			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
 			rc = EXIT_FAILURE;
 		}
-
-	} else if (suspend == ON_MODE) {
+		break;
+	}
+	case ON_MODE:
+	{
 		unsigned long data;
 
 		if (ctl.verbose)
@@ -644,20 +649,23 @@ int main(int argc, char **argv)
 					printf("... %s: %03lx\n", devname, data);
 			} while (!(data & RTC_AF));
 		}
-
-	} else if (suspend == DISABLE_MODE) {
+		break;
+	}
+	case DISABLE_MODE:
 		/* just break, alarm gets disabled in the end */
 		if (ctl.verbose)
 			printf(_("suspend mode: disable; disabling alarm\n"));
+		break;
 
-	} else if (suspend == SHOW_MODE) {
+	case SHOW_MODE:
 		if (ctl.verbose)
 			printf(_("suspend mode: show; printing alarm info\n"));
 		if (print_alarm(&ctl, fd))
 			rc = EXIT_FAILURE;
 		ctl.dryrun = 1;	/* don't really disable alarm in the end, just show */
+		break;
 
-	} else {
+	default:
 		if (ctl.verbose)
 			printf(_("suspend mode: %s; suspending system\n"), mode_str[suspend]);
 		sync();
-- 
2.3.0

