Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:46198 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaD0UF7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:05:59 -0400
Received: by mail-we0-f169.google.com with SMTP id k48so62718wev.14
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:05:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/12] last: fix is_phantom() detection
Date: Sun, 27 Apr 2014 21:05:29 +0100
Message-Id: <1398629138-31718-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The /proc/<pid>/loginuid is not always available, and when so a running
session should not be determined to be gone.  This is a regression from
commit mentioned in reference.

Sessions that have started before previous system boot, and did not log
out meanwhile, will be marked as gone.  It is fair to say that these
sessions are most likely result of a wtmp corruption.

Reference: 404fa3f93c00c7e130f5a0ec963b2dc6a3743986
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 5122f8e..ed10586 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -94,6 +94,7 @@ struct last_control {
 	unsigned int altc;	/* Number of alternative files */
 	unsigned int alti;	/* Index number of the alternative file */
 
+	struct timeval boot_time; /* system boot time */
 	time_t since;		/* at what time to start displaying the file */
 	time_t until;		/* at what time to stop displaying the file */
 	time_t present;		/* who where present at time_t */
@@ -573,19 +574,24 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int is_phantom(struct utmp *ut)
+static int is_phantom(const struct last_control *ctl, struct utmp *ut)
 {
 	struct passwd *pw;
 	char path[32];
 	FILE *f;
-	unsigned int loginuid, ret = 0;
+	unsigned int loginuid;
+	int ret = 0;
 
+	if (ut->UL_UT_TIME < ctl->boot_time.tv_sec)
+		return 1;
 	pw = getpwnam(ut->ut_name);
 	if (!pw)
 		return 1;
 	sprintf(path, "/proc/%u/loginuid", ut->ut_pid);
-	if (!(f = fopen(path, "r")))
+	if (access(path, R_OK) == 0 && !(f = fopen(path, "r")))
 		return 1;
+	else
+		return ret;
 	if (fscanf(f, "%u", &loginuid) != 1)
 		ret = 1;
 	fclose(f);
@@ -787,7 +793,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 				if (!lastboot) {
 					c = R_NOW;
 					/* Is process still alive? */
-					if (is_phantom(&ut))
+					if (is_phantom(ctl, &ut))
 						c = R_PHANTOM;
 				} else
 					c = whydown;
@@ -980,6 +986,7 @@ int main(int argc, char **argv)
 	}
 
 	for (; ctl.alti < ctl.altc; ctl.alti++) {
+		get_boot_time(&ctl.boot_time);
 		process_wtmp_file(&ctl);
 		free(ctl.altv[ctl.alti]);
 	}
-- 
1.9.2

