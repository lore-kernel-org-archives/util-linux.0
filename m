Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35206 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaHJL4Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:25 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so7304119wgh.8
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/5] logger: optimize string initializations
Date: Sun, 10 Aug 2014 12:56:09 +0100
Message-Id: <1407671771-29745-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Setting whole array to be completely full of nulls cannot be as quick as
making the only significant member of the array null only when needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 8ae00b2..85f9c35 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -299,7 +299,7 @@ static pid_t get_process_id(struct logger_ctl *ctl)
 
 static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 {
-	char *buf, pid[30] = { '\0' }, *cp, *tp, *hostname, *dot;
+	char *buf, pid[30], *cp, *tp, *hostname, *dot;
 	time_t now;
 	pid_t process;
 	int len;
@@ -308,6 +308,8 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 		return;
 	if ((process = get_process_id(ctl)))
 		snprintf(pid, sizeof(pid), "[%d]", process);
+	else
+		pid[0] = '\0';
 
 	cp = ctl->tag ? ctl->tag : xgetlogin();
 
@@ -334,7 +336,7 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 {
 	char *buf, *tag = NULL, *hostname = NULL;
-	char pid[32] = { '\0' }, time[64] = { '\0' }, timeq[80] = { '\0' };
+	char pid[32], time[64], timeq[80];
 	struct ntptimeval ntptv;
 	struct timeval tv;
 	struct tm *tm;
@@ -354,7 +356,8 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 			snprintf(time, sizeof(time), fmt, tv.tv_usec);
 		} else
 			err(EXIT_FAILURE, _("localtime() failed"));
-	}
+	} else
+		time[0] = '\0';
 
 	if (ctl->rfc5424_host) {
 		hostname = xgethostname();
@@ -372,6 +375,8 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 
 	if ((process = get_process_id(ctl)))
 		snprintf(pid, sizeof(pid), " %d", process);
+	else
+		pid[0] = '\0';
 
 	if (ctl->rfc5424_tq) {
 		if (ntp_gettime(&ntptv) == TIME_OK)
@@ -381,7 +386,8 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 		else
 			snprintf(timeq, sizeof(timeq),
 				 " [timeQuality tzKnown=\"1\" isSynced=\"0\"]");
-	}
+	} else
+		timeq[0] = '\0';
 
 	len = xasprintf(&buf, "<%d>1%s%s%s %s -%s%s %s", ctl->pri, time,
 		  hostname ? " " : "",
-- 
2.0.4

