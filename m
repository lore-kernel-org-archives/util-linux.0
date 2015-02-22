Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:38533 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOmN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:13 -0500
Received: by wesw55 with SMTP id w55so13580088wes.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 16/16] logger: fix -i argument parsing regression
Date: Sun, 22 Feb 2015 14:41:46 +0000
Message-Id: <1424616106-580-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With earlier logger it's possible to combine the option -i with other
options, such as -s.  But currently:

$:~> logger -is
logger: failed to parse id: 's'

The changed behaviour breaks existing scripts like dhcpcd-run-hooks from
dhcpcd.

Broken-since: aab5b44405b9a6ada92e419e5a84cc0d1d4afee9
Reference: http://comments.gmane.org/gmane.linux.utilities.util-linux-ng/9683
Reported-by: Juergen Daubert <jue@jue.li>
Reviewed-by: Benno Schulenberg <benno@vertaalt.nl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 |  5 ++++-
 misc-utils/logger.c | 13 +++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index a855cdf..1bf8f2e 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -58,7 +58,10 @@ syslog port defined in /etc/services, which is often 514 .
 Log the contents of the specified \fIfile\fR.
 This option cannot be combined with a command-line message.
 .TP
-.BR \-i , " \-\-id" [ = \fIid ]
+.BR \-i
+Log the PID of the logger process with each line.
+.TP
+.BR "\-\-id" [ = \fIid ]
 Log the PID of the logger process with each line.  When the optional
 argument \fIid\fR is specified, then it is used instead of the logger
 command's PID.  The use of \fB\-\-id=$$\fR
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index db6fd44..9f9af7e 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -89,7 +89,8 @@ enum {
 	OPT_JOURNALD,
 	OPT_RFC3164,
 	OPT_RFC5424,
-	OPT_SOCKET_ERRORS
+	OPT_SOCKET_ERRORS,
+	OPT_ID
 };
 
 struct logger_ctl {
@@ -548,7 +549,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_("Enter messages into the system log.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -i, --id[=<id>]          log <id> (default is PID)\n"), out);
+	fputs(_(" -i                       log logger command PID\n"), out);
+	fputs(_("     --id[=<id>]          log <id> (default is PID)\n"), out);
 	fputs(_(" -f, --file <file>        log the contents of this file\n"), out);
 	fputs(_(" -p, --priority <prio>    mark given message with this priority\n"), out);
 	fputs(_("     --prio-prefix        look for a prefix on every line read from stdin\n"), out);
@@ -606,7 +608,7 @@ int main(int argc, char **argv)
 	FILE *jfd = NULL;
 #endif
 	static const struct option longopts[] = {
-		{ "id",		optional_argument,  0, 'i' },
+		{ "id",		optional_argument,  0, OPT_ID },
 		{ "stderr",	no_argument,	    0, 's' },
 		{ "file",	required_argument,  0, 'f' },
 		{ "priority",	required_argument,  0, 'p' },
@@ -633,7 +635,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "f:i::p:st:u:dTn:P:Vh",
+	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'f':		/* file to log */
@@ -642,6 +644,9 @@ int main(int argc, char **argv)
 			stdout_reopened = 1;
 			break;
 		case 'i':		/* log process id also */
+			ctl.pid = getpid();
+			break;
+		case OPT_ID:
 			if (optarg) {
 				const char *p = optarg;
 
-- 
2.3.0

