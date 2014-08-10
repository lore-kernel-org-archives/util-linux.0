Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:54414 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaHJL4W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:22 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so7497503wes.3
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/5] logger: remove openlog(3) options
Date: Sun, 10 Aug 2014 12:56:08 +0100
Message-Id: <1407671771-29745-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One variable less, and more importantly bit operations become unnecessary
in if statements.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index d1b93d0..8ae00b2 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -82,7 +82,6 @@ enum {
 
 struct logger_ctl {
 	int fd;
-	int logflags;
 	int pri;
 	char *tag;
 	char *unix_socket;
@@ -92,7 +91,9 @@ struct logger_ctl {
 	void (*syslogfp)(struct logger_ctl *ctl, char *msg);
 	unsigned int
 			prio_prefix:1,	/* read priority from intput */
+			pid:1,		/* print PID, or PPID if it is enabled as well*/
 			ppid:1,		/* include PPID instead of PID */
+			stderr_printout:1, /* output message to stderr */
 			rfc5424_time:1,	/* include time stamp */
 			rfc5424_tq:1,	/* include time quality markup */
 			rfc5424_host:1;	/* include hostname */
@@ -291,7 +292,7 @@ static pid_t get_process_id(struct logger_ctl *ctl)
 {
 	pid_t id = 0;
 
-	if (ctl->logflags & LOG_PID)
+	if (ctl->pid)
 		id = ctl->ppid ? getppid() : getpid();
 	return id;
 }
@@ -323,7 +324,7 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 
 	if (write_all(ctl->fd, buf, len) < 0)
 		warn(_("write failed"));
-	if (ctl->logflags & LOG_PERROR)
+	if (ctl->stderr_printout)
 		fprintf(stderr, "%s\n", buf);
 
 	free(hostname);
@@ -390,7 +391,7 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 	if (write_all(ctl->fd, buf, len) < 0)
 		warn(_("write failed"));
 
-	if (ctl->logflags & LOG_PERROR)
+	if (ctl->stderr_printout)
 		fprintf(stderr, "%s\n", buf);
 
 	free(hostname);
@@ -439,7 +440,7 @@ static void syslog_local(struct logger_ctl *ctl, char *msg)
 	len = xasprintf(&buf, "<%d>%s %s%s: %s", ctl->pri, time, tag, pid, msg);
 	if (write_all(ctl->fd, buf, len) < 0)
 		warn(_("write failed"));
-	if (ctl->logflags & LOG_PERROR)
+	if (ctl->stderr_printout)
 		fprintf(stderr, "%s\n", buf);
 	free(buf);
 }
@@ -557,7 +558,6 @@ int main(int argc, char **argv)
 {
 	struct logger_ctl ctl = {
 		.fd = -1,
-		.logflags = 0,
 		.ppid = 0,
 		.pri = LOG_NOTICE,
 		.prio_prefix = 0,
@@ -611,7 +611,7 @@ int main(int argc, char **argv)
 			stdout_reopened = 1;
 			break;
 		case 'i':		/* log process id also */
-			ctl.logflags |= LOG_PID;
+			ctl.pid = 1;
 			if (optarg) {
 				const char *p = optarg;
 
@@ -629,7 +629,7 @@ int main(int argc, char **argv)
 			ctl.pri = pencode(optarg);
 			break;
 		case 's':		/* log to standard error */
-			ctl.logflags |= LOG_PERROR;
+			ctl.stderr_printout = 1;
 			break;
 		case 't':		/* tag */
 			ctl.tag = optarg;
-- 
2.0.4

