Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33563 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaAUWFM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 21 Jan 2014 17:05:12 -0500
Received: by mail-wg0-f54.google.com with SMTP id x13so8413797wgg.33
        for <util-linux@vger.kernel.org>; Tue, 21 Jan 2014 14:05:10 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] last: make session gone determination more robust
Date: Tue, 21 Jan 2014 22:05:05 +0000
Message-Id: <1390341905-23864-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier determination that used kill with signal zero to pid was prone to
false positive reports, due reuse of pid space and unrelated processes.
New function is_phantom() tries do a little bit better job, but fails to
be perfect.  It seems linking to gether utmp session start time or
terminal id with /proc/<pid>/ information is not as simple as one might
hope.

Reported-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 5550dcb..e4a8497 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <utmp.h>
+#include <pwd.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
@@ -572,6 +573,26 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static int is_phantom(struct utmp *ut)
+{
+	struct passwd *pw;
+	char path[32];
+	FILE *f;
+	unsigned int loginuid, ret = 0;
+
+	pw = getpwnam(ut->ut_name);
+	if (!pw)
+		return 1;
+	sprintf(path, "/proc/%u/loginuid", ut->ut_pid);
+	if (!(f = fopen(path, "r")))
+		return 1;
+	if (fscanf(f, "%u", &loginuid) != 1)
+		ret = 1;
+	fclose(f);
+	if (!ret && pw->pw_uid != loginuid)
+		return 1;
+	return ret;
+}
 
 static void process_wtmp_file(const struct last_control *ctl)
 {
@@ -766,9 +787,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 				if (!lastboot) {
 					c = R_NOW;
 					/* Is process still alive? */
-					if (ut.ut_pid > 0 &&
-					    kill(ut.ut_pid, 0) != 0 &&
-					    errno == ESRCH)
+					if (is_phantom(&ut))
 						c = R_PHANTOM;
 				} else
 					c = whydown;
-- 
1.8.5.3

