Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:62868 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757032AbaGVWBy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:54 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so289434wes.18
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/10] logger: add process --id=parent optional argument
Date: Tue, 22 Jul 2014 23:00:58 +0100
Message-Id: <1406066459-4816-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When scripts send several messages they will be easier to group together
when parent process id is printed rather than id of the each logger
process.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 | 11 +++++++++--
 misc-utils/logger.c | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 214e870..f8446b4 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -56,8 +56,15 @@ port defined in /etc/services, which is often
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .TP
-\fB\-i\fR, \fB\-\-id\fR
-Log the process ID of the logger process with each line.
+\fB\-i\fR, \fB\-\-id\fR [\fIparent\fR]
+Log the process ID of the logger process with each line.  When optional
+argument
+.I parent
+is specified parent process id is used.  Grouping of messages is expected
+to be easier when
+.I parent
+is in use in scripts that send several logger messages and run in
+parallel user sessions.
 .TP
 .TP
 \fB\-n\fR, \fB\-\-server\fR \fIserver\fR
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 3974f11..5c75d71 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -85,7 +85,8 @@ struct logger_ctl {
 	int logflags;
 	int pri;
 	char *tag;
-	unsigned int	rfc5424_time:1,
+	unsigned int	parent:1,
+			rfc5424_time:1,
 			rfc5424_tq:1,
 			rfc5424_host:1;
 };
@@ -281,15 +282,29 @@ static char *xgetlogin()
 	return cp;
 }
 
+static pid_t get_process_id(struct logger_ctl *ctl)
+{
+	pid_t id = 0;
+
+	if (ctl->logflags & LOG_PID) {
+		if (ctl->parent)
+			id = getppid();
+		else
+			id = getpid();
+	}
+	return id;
+}
+
 static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 {
 	char buf[1000], pid[30], *cp, *tp;
 	time_t now;
+	pid_t process;
 
 	if (ctl->fd < 0)
 		return;
-	if (ctl->logflags & LOG_PID)
-		snprintf(pid, sizeof(pid), "[%d]", getpid());
+	if ((process = get_process_id(ctl)))
+		snprintf(pid, sizeof(pid), "[%d]", process);
 	else
 		pid[0] = 0;
 	if (ctl->tag)
@@ -311,6 +326,7 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 	char fmt[64], time[64], timeq[80], *hostname;
 	struct timeval tv;
 	struct tm *tm;
+	pid_t process;
 
 	if (ctl->fd < 0)
 		return;
@@ -339,8 +355,8 @@ static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
 		tag = xgetlogin();
 	if (48 < strlen(tag))
 		errx(EXIT_FAILURE, _("tag '%s' is too long"), tag);
-	if (ctl->logflags & LOG_PID)
-		snprintf(pid, sizeof(pid), " %d", getpid());
+	if ((process = get_process_id(ctl)))
+		snprintf(pid, sizeof(pid), " %d", process);
 	else
 		pid[0] = 0;
 	if (ctl->rfc5424_tq) {
@@ -391,7 +407,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(" %s [options] [<message>]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -i, --id              log the process ID too\n"), out);
+	fputs(_(" -i, --id[=parent]     log the [parent] process ID too\n"), out);
 	fputs(_(" -f, --file <file>     log the contents of this file\n"), out);
 	fputs(_(" -p, --priority <prio> mark given message with this priority\n"), out);
 	fputs(_("     --prio-prefix     look for a prefix on every line read from stdin\n"), out);
@@ -428,6 +444,7 @@ int main(int argc, char **argv)
 	struct logger_ctl ctl = {
 		.fd = -1,
 		.logflags = 0,
+		.parent = 0,
 		.pri = LOG_NOTICE,
 		.tag = NULL,
 		.rfc5424_time = 1,
@@ -444,7 +461,7 @@ int main(int argc, char **argv)
 	FILE *jfd = NULL;
 #endif
 	static const struct option longopts[] = {
-		{ "id",		no_argument,	    0, 'i' },
+		{ "id",		optional_argument,  0, 'i' },
 		{ "stderr",	no_argument,	    0, 's' },
 		{ "file",	required_argument,  0, 'f' },
 		{ "priority",	required_argument,  0, 'p' },
@@ -471,7 +488,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
+	while ((ch = getopt_long(argc, argv, "f:i::p:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'f':		/* file to log */
@@ -481,6 +498,12 @@ int main(int argc, char **argv)
 			break;
 		case 'i':		/* log process id also */
 			ctl.logflags |= LOG_PID;
+			if (optarg) {
+				if (!strcmp(optarg, "parent"))
+					ctl.parent = 1;
+				else
+					warnx(_("ignoring unknown option argument: %s"));
+			}
 			break;
 		case 'p':		/* priority */
 			ctl.pri = pencode(optarg);
-- 
2.0.2

