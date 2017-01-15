Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34185 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAOKRc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 15 Jan 2017 05:17:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so23016180wmi.1
        for <util-linux@vger.kernel.org>; Sun, 15 Jan 2017 02:17:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] last: use --time-format instruction when printing wtmp creation time
Date: Sun, 15 Jan 2017 10:17:18 +0000
Message-Id: <20170115101718.8885-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes --time-format=iso timestamp to look the same as login/logout
times.  When --time-format=noformat is used the file creation time not
printed.  There is no change to default format.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c             | 18 +++++++++++++++---
 tests/expected/utmp/last-nodns |  4 +---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 7c243f147..484e18e80 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -874,11 +874,23 @@ static void process_wtmp_file(const struct last_control *ctl,
 		}
 	}
 
-	{
-		char* tmp = xstrdup(filename);
-		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
+	if (ctl->time_fmt != LAST_TIMEFTM_NONE) {
+		struct last_timefmt *fmt;
+		char timestr[LAST_TIMESTAMP_LEN];
+		size_t len;
+		char *tmp = xstrdup(filename);
+
+		fmt = &timefmts[ctl->time_fmt];
+		if (time_formatter(fmt->in_fmt, timestr,
+				   sizeof(timestr), &begintime) < 0)
+			errx(EXIT_FAILURE, _("preallocation size exceeded"));
+		len = strlen(timestr) - 1;
+		if (timestr[len] == '\n')
+			timestr[len] = '\0';
+		printf(_("\n%s begins %s\n"), basename(tmp), timestr);
 		free(tmp);
 	}
+
 	fclose(fp);
 
 	for (p = ulist; p; p = next) {
diff --git a/tests/expected/utmp/last-nodns b/tests/expected/utmp/last-nodns
index cb7cfde09..e92366266 100644
--- a/tests/expected/utmp/last-nodns
+++ b/tests/expected/utmp/last-nodns
@@ -91,8 +91,6 @@ init     foo          five                (01:00)
 login    foo          six                 (01:00)
 user_pro foo          seven               (01:00)
 accounti foo          nine                (01:00)
-
-wtmp-a begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
 torvalds linux        hobby            1991-08-26T00:57:08+0000   gone - no logout
@@ -109,7 +107,7 @@ login    foo          six              2013-08-28T06:00:00+0000 - 2013-08-28T07:
 user_process foo          seven            2013-08-28T05:00:00+0000 - 2013-08-28T06:00:00+0000  (01:00)
 accounting foo          nine             2013-08-28T03:00:00+0000 - 2013-08-28T04:00:00+0000  (01:00)
 
-wtmp-a begins Wed Aug 28 03:00:00 2013
+wtmp-a begins 2013-08-28T03:00:00+0000
 ~~~ since and until ~~~
 oldtime  foo          four             Wed Aug 28 08:00    gone - no logout
 init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
-- 
2.11.0

