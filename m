Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:48066 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaG0Rw0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jul 2014 13:52:26 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so3320639wib.15
        for <util-linux@vger.kernel.org>; Sun, 27 Jul 2014 10:52:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/2] logger: add hostname to rfc3164 message
Date: Sun, 27 Jul 2014 18:52:15 +0100
Message-Id: <1406483535-17461-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406483535-17461-1-git-send-email-kerolasa@iki.fi>
References: <1406483535-17461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes the obsolete protocol a little bit more compliant with the
internet standard, but few should care now when we have rfc5424 support,
and rfc3164 feels broken.  For example it requires hostname to be not
fully qualified, which is hard to understand, and should make users to
prefer the new protocol.

Reported-by: Frank Thilo <thilo@unix-ag.org>
Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=705217
CC: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index ac583fd..9da404d 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -298,7 +298,7 @@ static pid_t get_process_id(struct logger_ctl *ctl)
 
 static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 {
-	char buf[1000], pid[30], *cp, *tp;
+	char buf[1000], pid[30], *cp, *tp, *hostname, *dot;
 	time_t now;
 	pid_t process;
 
@@ -312,10 +312,15 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 		cp = ctl->tag;
 	else
 		cp = xgetlogin();
+	hostname = xgethostname();
+	dot = strchr(hostname, '.');
+	if (dot)
+		*dot = '\0';
 	time(&now);
 	tp = ctime(&now) + 4;
-	snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
-		 ctl->pri, tp, cp, pid, msg);
+	snprintf(buf, sizeof(buf), "<%d>%.15s %s %.200s%s: %.400s",
+		 ctl->pri, tp, hostname, cp, pid, msg);
+	free(hostname);
 	if (write_all(ctl->fd, buf, strlen(buf) + 1) < 0)
 		warn(_("write failed"));
 	if (ctl->logflags & LOG_PERROR)
-- 
2.0.3

