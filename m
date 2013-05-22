Return-Path: util-linux-owner@vger.kernel.org
Received: from lizzard.sbs.de ([194.138.37.39]:25776 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab3EVLN5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 May 2013 07:13:57 -0400
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.13.6/8.13.6) with ESMTP id r4MBDsq1030592
	for <util-linux@vger.kernel.org>; Wed, 22 May 2013 13:13:55 +0200
From: Dennis H Jensen <dennis.h.jensen@siemens.com>
To: util-linux@vger.kernel.org
Cc: Dennis H Jensen <dennis.h.jensen@siemens.com>
Subject: [PATCH v2] logger: add support for --prio-prefix when logging stdin
Date: Wed, 22 May 2013 13:12:08 +0200
Message-Id: <1369221128-4816-1-git-send-email-dennis.h.jensen@siemens.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a new option to logger that will make it look for a
priority prefix <n> at the beginning of every line. The priority is
a single decimal number formed as explained in syslog(3).

If a prefix is found logger will log the message using the found
facility and level in that prefix, if the prefix doesn't contain a
facility the default facility specified by the -p option will be used.
If no prefix is found, logger will use the priority specified by -p.

Signed-off-by: Dennis H Jensen <dennis.h.jensen@siemens.com>
---
 misc-utils/logger.1 |   13 +++++++++++++
 misc-utils/logger.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 09ecdc4..f4cadc6 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -109,6 +109,19 @@ Write to the specified
 .I socket
 instead of to the builtin syslog routines.
 .TP
+\fB\-\-prio\-prefix\fR
+Look for a syslog prefix on every line read from standard input, a
+number contained within angle brackets that contain both the facility
+and level. The decimal prefix is constructed by multiplying the
+facility by 8 and then adding the level, thus \fIlocal0.info\fR,
+facility=16 and level=6, becomes \fI<134>\fR.
+
+If the prefix contains no facility, the facility defaults to what is
+specified by \fB\-p\fR option, similarly if no prefix is provided the
+line is logged using the \fB\-p\fR \fIpriority\fR.
+
+This option doesn't affect a command-line message.
+.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index c83c0b8..0166bd7 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -64,6 +64,30 @@ enum {
 	ALL_TYPES = TYPE_UDP | TYPE_TCP
 };
 
+enum {
+	OPT_PRIO_PREFIX = CHAR_MAX + 1
+};
+
+
+static char* get_prio_prefix(char *msg, int *prio)
+{
+	int p;
+	char *end = NULL;
+	int facility = *prio & LOG_FACMASK;
+
+	errno = 0;
+	p = strtoul(msg + 1, &end, 10);
+
+	if (errno || !end || end == msg + 1 || end[0] != '>')
+		return msg;
+
+	if (p & LOG_FACMASK)
+		facility = p & LOG_FACMASK;
+
+	*prio = facility | (p & LOG_PRIMASK);
+	return end + 1;
+}
+
 static int decode(char *name, CODE *codetab)
 {
 	register CODE *c;
@@ -240,7 +264,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
  */
 int
 main(int argc, char **argv) {
-	int ch, logflags, pri;
+	int ch, logflags, pri, prio_prefix;
 	char *tag, buf[1024];
 	char *usock = NULL;
 	char *server = NULL;
@@ -260,6 +284,7 @@ main(int argc, char **argv) {
 		{ "port",	required_argument,  0, 'P' },
 		{ "version",	no_argument,	    0, 'V' },
 		{ "help",	no_argument,	    0, 'h' },
+		{ "prio-prefix", no_argument, 0, OPT_PRIO_PREFIX },
 		{ NULL,		0, 0, 0 }
 	};
 
@@ -271,9 +296,10 @@ main(int argc, char **argv) {
 	tag = NULL;
 	pri = LOG_NOTICE;
 	logflags = 0;
+	prio_prefix = 0;
 	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
-		switch((char)ch) {
+		switch (ch) {
 		case 'f':		/* file to log */
 			if (freopen(optarg, "r", stdin) == NULL)
 				err(EXIT_FAILURE, _("file %s"),
@@ -311,6 +337,9 @@ main(int argc, char **argv) {
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
+		case OPT_PRIO_PREFIX:
+			prio_prefix = 1;
+			break;
 		case '?':
 		default:
 			usage(stderr);
@@ -360,6 +389,8 @@ main(int argc, char **argv) {
 			mysyslog(LogSock, logflags, pri, tag, buf);
 		}
 	} else {
+		char *msg;
+		int default_priority = pri;
 		while (fgets(buf, sizeof(buf), stdin) != NULL) {
 		    /* glibc is buggy and adds an additional newline,
 		       so we have to remove it here until glibc is fixed */
@@ -368,10 +399,15 @@ main(int argc, char **argv) {
 		    if (len > 0 && buf[len - 1] == '\n')
 			    buf[len - 1] = '\0';
 
+			msg = buf;
+			pri = default_priority;
+			if (prio_prefix && msg[0] == '<')
+				msg = get_prio_prefix(msg, &pri);
+
 		    if (!usock && !server)
-			syslog(pri, "%s", buf);
+			syslog(pri, "%s", msg);
 		    else
-			mysyslog(LogSock, logflags, pri, tag, buf);
+			mysyslog(LogSock, logflags, pri, tag, msg);
 		}
 	}
 	if (!usock && !server)
-- 
1.7.9.5

