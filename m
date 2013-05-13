Return-Path: util-linux-owner@vger.kernel.org
Received: from lizzard.sbs.de ([194.138.37.39]:17159 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab3EMWTN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 May 2013 18:19:13 -0400
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.13.6/8.13.6) with ESMTP id r4DLx7vO026888
	for <util-linux@vger.kernel.org>; Mon, 13 May 2013 23:59:07 +0200
From: Dennis H Jensen <dennis.h.jensen@siemens.com>
To: util-linux@vger.kernel.org
Cc: Dennis H Jensen <dennis.h.jensen@siemens.com>
Subject: [PATCH RFC] logger: add support for --loglevel-prefix when logging stdin
Date: Mon, 13 May 2013 23:57:18 +0200
Message-Id: <1368482238-6023-1-git-send-email-dennis.h.jensen@siemens.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a new option to logger that will make it look for a
loglevel prefix <[0-7]> at the beginning of every line.

If a loglevel is found logger will log the message using the found
loglevel combined with the facility specified by --priority. When no
loglevel is found the default level provided by the --priority option
will be used.

Signed-off-by: Dennis H Jensen <dennis.h.jensen@siemens.com>
---
 misc-utils/logger.1 |  9 +++++++++
 misc-utils/logger.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 09ecdc4..af6f4f5 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -109,6 +109,15 @@ Write to the specified
 .I socket
 instead of to the builtin syslog routines.
 .TP
+\fB\-\-loglevel\-prefix\fR
+Look for a log level prefix on every line read from standard input.
+The log level prefix must have the format \fI<0...7>\fR; logger will
+use the facility specified by the \fB\-p\fR option and the specified level
+as the default when no log level prefix is found. For example \fB\-p\fR
+\fIuser.debug\fR will log messages in the user facility and default to
+the debug level.
+This option doesn't affect a command-line message.
+.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index c83c0b8..36371be 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -64,6 +64,10 @@ enum {
 	ALL_TYPES = TYPE_UDP | TYPE_TCP
 };
 
+enum {
+	ARG_LOGLEVEL_PREFIX = 0x100
+};
+
 static int decode(char *name, CODE *codetab)
 {
 	register CODE *c;
@@ -240,7 +244,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
  */
 int
 main(int argc, char **argv) {
-	int ch, logflags, pri;
+	int ch, logflags, pri, loglevel_prefix;
 	char *tag, buf[1024];
 	char *usock = NULL;
 	char *server = NULL;
@@ -260,6 +264,7 @@ main(int argc, char **argv) {
 		{ "port",	required_argument,  0, 'P' },
 		{ "version",	no_argument,	    0, 'V' },
 		{ "help",	no_argument,	    0, 'h' },
+		{ "loglevel-prefix", no_argument,   0, ARG_LOGLEVEL_PREFIX },
 		{ NULL,		0, 0, 0 }
 	};
 
@@ -271,9 +276,10 @@ main(int argc, char **argv) {
 	tag = NULL;
 	pri = LOG_NOTICE;
 	logflags = 0;
+	loglevel_prefix = 0;
 	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
-		switch((char)ch) {
+		switch (ch) {
 		case 'f':		/* file to log */
 			if (freopen(optarg, "r", stdin) == NULL)
 				err(EXIT_FAILURE, _("file %s"),
@@ -311,6 +317,9 @@ main(int argc, char **argv) {
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
+		case ARG_LOGLEVEL_PREFIX:
+			loglevel_prefix = 1;
+			break;
 		case '?':
 		default:
 			usage(stderr);
@@ -360,6 +369,9 @@ main(int argc, char **argv) {
 			mysyslog(LogSock, logflags, pri, tag, buf);
 		}
 	} else {
+		char *msg = buf;
+		int default_priority = pri;
+		int facility = default_priority & LOG_FACMASK;
 		while (fgets(buf, sizeof(buf), stdin) != NULL) {
 		    /* glibc is buggy and adds an additional newline,
 		       so we have to remove it here until glibc is fixed */
@@ -368,10 +380,23 @@ main(int argc, char **argv) {
 		    if (len > 0 && buf[len - 1] == '\n')
 			    buf[len - 1] = '\0';
 
+			msg = buf;
+			if (loglevel_prefix) {
+				int level = default_priority & LOG_PRIMASK;
+				if (msg[0] == '<' && msg[1] && msg[2] == '>') {
+					switch (msg[1]) {
+					case '0' ... '7':
+						level = msg[1] - '0';
+						msg += 3;
+					}
+				}
+				pri = facility | level;
+			}
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
1.8.1.4

