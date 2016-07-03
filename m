Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34042 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so17569665wmz.1
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/15] write: make timestamp to be obviously just a clock time
Date: Sun,  3 Jul 2016 22:23:53 +0100
Message-Id: <20160703212358.1218-11-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

By looking the code one will had hard time knowing that a slice of ctime()
from characters 11 to 16 is HH:MM time format.  Use of strftime("%H:%M")
makes this a lot less mysterious.

In same go make \007 hex printouts to be \a that is the same thing: alarm.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 8288e9d..696a7a7 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -239,9 +239,10 @@ static void write_line(char *s)
  */
 static void do_write(const struct write_control *ctl)
 {
-	char *login, *pwuid, *time_stamp;
+	char *login, *pwuid, timestamp[6];
 	struct passwd *pwd;
 	time_t now;
+	struct tm *tm;
 	char path[PATH_MAX], *host, line[512];
 	struct sigaction sigact;
 
@@ -265,21 +266,21 @@ static void do_write(const struct write_control *ctl)
 	sigaction(SIGINT, &sigact, NULL);
 	sigaction(SIGHUP, &sigact, NULL);
 
-	/* print greeting */
 	host = xgethostname();
 	if (!host)
 		host = xstrdup("???");
 
-	now = time((time_t *) NULL);
-	time_stamp = ctime(&now);
-	time_stamp[16] = '\0';
-	printf("\r\n\007\007\007");
+	now = time((time_t *)NULL);
+	tm = localtime(&now);
+	strftime(timestamp, sizeof(timestamp), "%H:%M", tm);
+	/* print greeting */
+	printf("\r\n\a\a\a");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, ctl->src_tty, time_stamp + 11);
+		       login, host, pwuid, ctl->src_tty, timestamp);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, ctl->src_tty, time_stamp + 11);
+		       login, host, ctl->src_tty, timestamp);
 	free(host);
 	printf("\r\n");
 
-- 
2.9.0

