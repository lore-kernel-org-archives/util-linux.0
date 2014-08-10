Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:63817 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaHJL41 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:27 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so2982735wib.14
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/5] logger: set function arguments read-only when possible
Date: Sun, 10 Aug 2014 12:56:10 +0100
Message-Id: <1407671771-29745-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 85f9c35..8ccc731 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -88,7 +88,7 @@ struct logger_ctl {
 	char *server;
 	char *port;
 	int socket_type;
-	void (*syslogfp)(struct logger_ctl *ctl, char *msg);
+	void (*syslogfp)(const struct logger_ctl *ctl, const char *msg);
 	unsigned int
 			prio_prefix:1,	/* read priority from intput */
 			pid:1,		/* print PID, or PPID if it is enabled as well*/
@@ -118,7 +118,7 @@ static char *get_prio_prefix(char *msg, int *prio)
 	return end + 1;
 }
 
-static int decode(char *name, CODE *codetab)
+static int decode(const char *name, CODE *codetab)
 {
 	register CODE *c;
 
@@ -278,7 +278,7 @@ static int journald_entry(FILE *fp)
 }
 #endif
 
-static char *xgetlogin()
+static char *xgetlogin(void)
 {
 	char *cp;
 	struct passwd *pw;
@@ -288,7 +288,7 @@ static char *xgetlogin()
 	return cp;
 }
 
-static pid_t get_process_id(struct logger_ctl *ctl)
+static pid_t get_process_id(const struct logger_ctl *ctl)
 {
 	pid_t id = 0;
 
@@ -297,7 +297,7 @@ static pid_t get_process_id(struct logger_ctl *ctl)
 	return id;
 }
 
-static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
+static void syslog_rfc3164(const struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, pid[30], *cp, *tp, *hostname, *dot;
 	time_t now;
@@ -333,7 +333,7 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 	free(buf);
 }
 
-static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
+static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, *tag = NULL, *hostname = NULL;
 	char pid[32], time[64], timeq[80];
@@ -423,7 +423,7 @@ static void parse_rfc5424_flags(struct logger_ctl *ctl, char *optarg)
 	}
 }
 
-static void syslog_local(struct logger_ctl *ctl, char *msg)
+static void syslog_local(const struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, *tag;
 	char time[32], pid[32];
@@ -469,7 +469,7 @@ static void logger_open(struct logger_ctl *ctl)
 	ctl->syslogfp = syslog_local;
 }
 
-static void logger_command_line(struct logger_ctl *ctl, char **argv)
+static void logger_command_line(const struct logger_ctl *ctl, char **argv)
 {
 	char buf[4096];
 	char *p = buf;
@@ -516,7 +516,7 @@ static void logger_stdin(struct logger_ctl *ctl)
 	}
 }
 
-static void logger_close(struct logger_ctl *ctl)
+static void logger_close(const struct logger_ctl *ctl)
 {
 	if (close(ctl->fd) != 0)
 		err(EXIT_FAILURE, _("close failed"));
-- 
2.0.4

