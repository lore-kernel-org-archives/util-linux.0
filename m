Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:34201 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbaIGMn2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:28 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so13722303wev.20
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/17] last: improve code readability by renaming variable names
Date: Sun,  7 Sep 2014 13:42:55 +0100
Message-Id: <1410093785-17537-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index fb82f31..54d9e1f 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -376,9 +376,9 @@ static void trim_trailing_spaces(char *s)
 /*
  *	Show one line of information on screen
  */
-static int list(const struct last_control *ctl, struct utmp *p, time_t t, int what)
+static int list(const struct last_control *ctl, struct utmp *p, time_t logout_time, int what)
 {
-	time_t		secs, tmp, epoch;
+	time_t		secs, utmp_time, now;
 	char		logintime[LAST_TIMESTAMP_LEN];
 	char		logouttime[LAST_TIMESTAMP_LEN];
 	char		length[LAST_TIMESTAMP_LEN];
@@ -417,22 +417,25 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	/*
 	 *	Calculate times
 	 */
-	tmp = p->UL_UT_TIME;
+	utmp_time = p->UL_UT_TIME;
 
-	if (ctl->present && (ctl->present < tmp || (0 < t && t < ctl->present)))
-		return 0;
-
-	if (time_formatter(ctl, &logintime[0], sizeof(logintime), &tmp, 0) < 0 ||
-	    time_formatter(ctl, &logouttime[0], sizeof(logouttime), &t, 1) < 0)
+	if (ctl->present) {
+		if (ctl->present < utmp_time)
+			return 0;
+		if (0 < logout_time && logout_time < ctl->present)
+			return 0;
+	}
+	if (time_formatter(ctl, &logintime[0], sizeof(logintime), &utmp_time, 0) < 0 ||
+	    time_formatter(ctl, &logouttime[0], sizeof(logouttime), &logout_time, 1) < 0)
 		errx(EXIT_FAILURE, _("preallocation size exceeded"));
 
-	secs = t - p->UL_UT_TIME;
+	secs  = logout_time - utmp_time;
 	mins  = (secs / 60) % 60;
 	hours = (secs / 3600) % 24;
 	days  = secs / 86400;
 
-	epoch = time(NULL);
-	if (t == epoch) {
+	now = time(NULL);
+	if (logout_time == now) {
 		if (ctl->time_fmt > LAST_TIMEFTM_SHORT_CTIME) {
 			sprintf(logouttime, "  still running");
 			length[0] = 0;
-- 
2.1.0

