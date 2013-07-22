Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:42161 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3GVL45 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jul 2013 07:56:57 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so1455606wes.32
        for <util-linux@vger.kernel.org>; Mon, 22 Jul 2013 04:56:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Subject: [PATCH] setsid: add an option to wait child return value
Date: Mon, 22 Jul 2013 12:56:47 +0100
Message-Id: <1374494207-3891-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>

This change proposed in util-linux maillist by Damien Wyart in behalf of
Daniel Kahn Gillmor.  Sami Kerola changed the patch to use option rather
than makign the default behavior of the command to change.

Reported-by: Damien Wyart <damien.wyart@gmail.com>
Reference: http://markmail.org/message/2z6qh5auk7wjie3l
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495881
CC: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setsid.1 |  5 +++++
 sys-utils/setsid.c | 27 ++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index eff7948..da8d648 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -15,6 +15,11 @@ runs a program in a new session.
 .TP
 \fB\-c\fP, \fB\-\-ctty\fP
 Set the controlling terminal to the current one.
+.TP
+\fB\-w\fP, \fB\-\-wait\fP
+Wait the execution of the program to end, and return the exit value of
+the child as return value of the
+.BR setsid .
 .SH "SEE ALSO"
 .BR setsid (2)
 .SH AUTHOR
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 756a520..782de82 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -9,6 +9,8 @@
  * 2001-01-18 John Fremlin <vii@penguinpowered.com>
  * - fork in case we are process group leader
  *
+ * 2008-08-20 Daniel Kahn Gillmor <dkg@fifthhorseman.net>
+ * - if forked, wait on child process and emit its return code.
  */
 
 #include <getopt.h>
@@ -16,6 +18,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 #include "c.h"
 #include "nls.h"
@@ -29,8 +33,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"),
-		out);
+	fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"), out);
+	fputs(_(" -w, --wait     wait program to exit, and use the same return\n"), out);
 
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -43,9 +47,12 @@ int main(int argc, char **argv)
 {
 	int ch;
 	int ctty = 0;
+	pid_t pid;
+	int status = 0;
 
 	static const struct option longopts[] = {
 		{"ctty", no_argument, NULL, 'c'},
+		{"wait", no_argument, NULL, 'w'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -56,7 +63,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "+Vhc", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "+Vhcw", longopts, NULL)) != -1)
 		switch (ch) {
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -64,6 +71,9 @@ int main(int argc, char **argv)
 		case 'c':
 			ctty=1;
 			break;
+		case 'w':
+			status = 1;
+			break;
 		case 'h':
 			usage(stdout);
 		default:
@@ -74,7 +84,8 @@ int main(int argc, char **argv)
 		usage(stderr);
 
 	if (getpgrp() == getpid()) {
-		switch (fork()) {
+		pid = fork();
+		switch (pid) {
 		case -1:
 			err(EXIT_FAILURE, _("fork"));
 		case 0:
@@ -82,7 +93,13 @@ int main(int argc, char **argv)
 			break;
 		default:
 			/* parent */
-			return 0;
+			if (!status)
+				return EXIT_SUCCESS;
+			if (wait(&status) != pid)
+				err(EXIT_FAILURE, "wait");
+			if (WIFEXITED(status))
+				return WEXITSTATUS(status);
+			err(status, _("child %d did not exit normally"), pid);
 		}
 	}
 	if (setsid() < 0)
-- 
1.8.3.3

