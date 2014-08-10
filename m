Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38734 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaHJL4T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:19 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so7480260wgg.16
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/5] logger: allow use of --id=ppid when logging locally
Date: Sun, 10 Aug 2014 12:56:07 +0100
Message-Id: <1407671771-29745-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no obvious way to make syslog(3) to print both pid or ppid, so
duplicate the libc syslog() to logger.  Making the ppid printing work
using unix socket has side effect of local becoming capable to use both
rfc format output, which is hopefully seen as good thing.  The
syslog_local() is format wise one-to-one copy with glibc syslog(3)
format.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 7b10df8..d1b93d0 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -418,7 +418,30 @@ static void parse_rfc5424_flags(struct logger_ctl *ctl, char *optarg)
 
 static void syslog_local(struct logger_ctl *ctl, char *msg)
 {
-	syslog(ctl->pri, "%s", msg);
+	char *buf, *tag;
+	char time[32], pid[32];
+	struct timeval tv;
+	struct tm *tm;
+	pid_t process;
+	int len;
+
+	gettimeofday(&tv, NULL);
+	tm = localtime(&tv.tv_sec);
+	strftime(time, sizeof(time), "%h %e %T", tm);
+
+	tag = ctl->tag ? ctl->tag : program_invocation_short_name;
+
+	if ((process = get_process_id(ctl)))
+		snprintf(pid, sizeof(pid), "[%d]", process);
+	else
+		pid[0] = '\0';
+
+	len = xasprintf(&buf, "<%d>%s %s%s: %s", ctl->pri, time, tag, pid, msg);
+	if (write_all(ctl->fd, buf, len) < 0)
+		warn(_("write failed"));
+	if (ctl->logflags & LOG_PERROR)
+		fprintf(stderr, "%s\n", buf);
+	free(buf);
 }
 
 static void logger_open(struct logger_ctl *ctl)
@@ -435,12 +458,7 @@ static void logger_open(struct logger_ctl *ctl)
 			ctl->syslogfp = syslog_rfc5424;
 		return;
 	}
-
-	if (ctl->syslogfp == syslog_rfc5424 || ctl->syslogfp == syslog_rfc3164)
-		errx(EXIT_FAILURE, _("--server or --socket are required to "
-				     "log by --rfc5424 or --rfc3164."));
-
-	openlog(ctl->tag ? ctl->tag : xgetlogin(), ctl->logflags, 0);
+	ctl->fd = unix_socket("/dev/log", ctl->socket_type);
 	ctl->syslogfp = syslog_local;
 }
 
@@ -493,10 +511,8 @@ static void logger_stdin(struct logger_ctl *ctl)
 
 static void logger_close(struct logger_ctl *ctl)
 {
-	if (!ctl->unix_socket && !ctl->server)
-		closelog();
-	else
-		close(ctl->fd);
+	if (close(ctl->fd) != 0)
+		err(EXIT_FAILURE, _("close failed"));
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
-- 
2.0.4

