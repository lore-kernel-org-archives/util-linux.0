Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35650 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163337AbdDWU6s (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so252732wrg.2
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/10] logger: make month names, login name, and tag read-only objects
Date: Sun, 23 Apr 2017 21:58:19 +0100
Message-Id: <20170423205821.7444-9-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index b9fcc8552..653adae94 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -115,7 +115,7 @@ struct logger_ctl {
 	int pri;
 	pid_t pid;			/* zero when unwanted */
 	char *hdr;			/* the syslog header (based on protocol) */
-	char *tag;
+	char const *tag;
 	char *msgid;
 	char *unix_socket;		/* -u <path> or default to _PATH_DEVLOG */
 	char *server;
@@ -369,9 +369,9 @@ static int journald_entry(struct logger_ctl *ctl, FILE *fp)
 }
 #endif
 
-static char *xgetlogin(void)
+static char const *xgetlogin(void)
 {
-	char *cp;
+	char const *cp;
 	struct passwd *pw;
 
 	if (!(cp = getlogin()) || !*cp)
@@ -385,12 +385,12 @@ static char *xgetlogin(void)
  * of a leading 0). The function uses a static buffer which is
  * overwritten on the next call (just like ctime() does).
  */
-static const char *rfc3164_current_time(void)
+static char const *rfc3164_current_time(void)
 {
 	static char time[32];
 	struct timeval tv;
 	struct tm *tm;
-	static char *monthnames[] = {
+	static char const * const monthnames[] = {
 		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
 		"Sep", "Oct", "Nov", "Dec"
 	};
@@ -727,7 +727,7 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 {
 	char *time;
 	char *hostname;
-	char *const app_name = ctl->tag;
+	char const *app_name = ctl->tag;
 	char *procid;
 	char *const msgid = xstrdup(ctl->msgid ? ctl->msgid : NILVALUE);
 	char *structured = NULL;
-- 
2.12.2

