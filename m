Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:63835 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbaGVWBS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:18 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so286831wes.11
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/10] logger: refactor long if clause
Date: Tue, 22 Jul 2014 23:00:53 +0100
Message-Id: <1406066459-4816-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When if clause that continues throughout whole function it usually can be
shorten to immediate action, e.g., in this case return on the spot not at
end of the function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 65e468c..5506022 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -273,24 +273,22 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 	char buf[1000], pid[30], *cp, *tp;
 	time_t now;
 
-	if (fd > -1) {
-		if (logflags & LOG_PID)
-			snprintf(pid, sizeof(pid), "[%d]", getpid());
-		else
-			pid[0] = 0;
-		if (tag)
-			cp = tag;
-		else
-			cp = xgetlogin();
-		time(&now);
-		tp = ctime(&now) + 4;
-
-		snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
-			 pri, tp, cp, pid, msg);
-
-		if (write_all(fd, buf, strlen(buf) + 1) < 0)
-			warn(_("write failed"));
-	}
+	if (fd < 0)
+		return;
+	if (logflags & LOG_PID)
+		snprintf(pid, sizeof(pid), "[%d]", getpid());
+	else
+		pid[0] = 0;
+	if (tag)
+		cp = tag;
+	else
+		cp = xgetlogin();
+	time(&now);
+	tp = ctime(&now) + 4;
+	snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
+		 pri, tp, cp, pid, msg);
+	if (write_all(fd, buf, strlen(buf) + 1) < 0)
+		warn(_("write failed"));
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
-- 
2.0.2

