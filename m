Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38772 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbCOMzG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:06 -0400
Received: by wifj2 with SMTP id j2so21671922wif.1
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/8] logger: check xgethostname() return value
Date: Sun, 15 Mar 2015 12:54:48 +0000
Message-Id: <1426424094-25451-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index e3fc248..2e37d14 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -342,9 +342,10 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 		fprintf(stderr, "%s\n", buf);
 }
 
+#define NILVALUE "-"
 static void syslog_rfc3164_header(struct logger_ctl *const ctl)
 {
-	char pid[30], *hostname, *dot;
+	char pid[30], *hostname;
 
 	*pid = '\0';
 	if (ctl->fd < 0)
@@ -352,10 +353,12 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
 	if (ctl->pid)
 		snprintf(pid, sizeof(pid), "[%d]", ctl->pid);
 
-	hostname = xgethostname();
-	dot = strchr(hostname, '.');
-	if (dot)
-		*dot = '\0';
+	if ((hostname = xgethostname())) {
+		char *dot = strchr(hostname, '.');
+		if (dot)
+			*dot = '\0';
+	} else
+		hostname = xstrdup(NILVALUE);
 
 	xasprintf(&ctl->hdr, "<%d>%.15s %s %.200s%s: ",
 		 ctl->pri, rfc3164_current_time(), hostname, ctl->tag, pid);
@@ -383,7 +386,6 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
  * specified RFC5424. The rest of the field mappings should be
  * pretty clear from RFC5424. -- Rainer Gerhards, 2015-03-10
  */
-#define NILVALUE "-"
 static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 {
 	char *time;
@@ -416,7 +418,8 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 		time = xstrdup(NILVALUE);
 
 	if (ctl->rfc5424_host) {
-		hostname = xgethostname();
+		if (!(hostname = xgethostname()))
+			hostname = xstrdup(NILVALUE);
 		/* Arbitrary looking 'if (var < strlen()) checks originate from
 		 * RFC 5424 - 6 Syslog Message Format definition.  */
 		if (255 < strlen(hostname))
-- 
2.3.2

