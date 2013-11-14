Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:41948 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3KNTXP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Nov 2013 14:23:15 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] setsid: don't fork
Date: Thu, 14 Nov 2013 14:23:13 -0500
Message-Id: <1384456993-3721-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2.24 added a switch to setsid to wait for the child to exit
and return its exit status.  I believe this was the wrong way
to fix the underlying bug since the behavior of the program
still differs depending on whether it is run as the group leader
or not, and requires a switch to get the correct behavior.
Instead of this --wait switch, just make sure the parent
process is the one that execs the new program rather than
the child process.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/setsid.1 |  3 ---
 sys-utils/setsid.c | 23 +++++++++--------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index da8d648..ab1b20c 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -16,9 +16,6 @@ runs a program in a new session.
 \fB\-c\fP, \fB\-\-ctty\fP
 Set the controlling terminal to the current one.
 .TP
-\fB\-w\fP, \fB\-\-wait\fP
-Wait the execution of the program to end, and return the exit value of
-the child as return value of the
 .BR setsid .
 .SH "SEE ALSO"
 .BR setsid (2)
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 782de82..9810138 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -47,12 +47,10 @@ int main(int argc, char **argv)
 {
 	int ch;
 	int ctty = 0;
-	pid_t pid;
-	int status = 0;
+	pid_t pid = 0;
 
 	static const struct option longopts[] = {
 		{"ctty", no_argument, NULL, 'c'},
-		{"wait", no_argument, NULL, 'w'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -71,9 +69,6 @@ int main(int argc, char **argv)
 		case 'c':
 			ctty=1;
 			break;
-		case 'w':
-			status = 1;
-			break;
 		case 'h':
 			usage(stdout);
 		default:
@@ -90,22 +85,22 @@ int main(int argc, char **argv)
 			err(EXIT_FAILURE, _("fork"));
 		case 0:
 			/* child */
+			sleep(5);
 			break;
 		default:
 			/* parent */
-			if (!status)
-				return EXIT_SUCCESS;
-			if (wait(&status) != pid)
-				err(EXIT_FAILURE, "wait");
-			if (WIFEXITED(status))
-				return WEXITSTATUS(status);
-			err(status, _("child %d did not exit normally"), pid);
+			if (setpgid(pid, 0) == -1)
+				err(EXIT_FAILURE, _("setpgid failed"));
+			if (setpgid(0, pid) == -1)
+				err(EXIT_FAILURE, _("setpgid failed"));
+
 		}
 	}
 	if (setsid() < 0)
 		/* cannot happen */
 		err(EXIT_FAILURE, _("setsid failed"));
-
+	if (pid)
+		kill(pid, SIGTERM);
 	if (ctty) {
 		if (ioctl(STDIN_FILENO, TIOCSCTTY, 1))
 			err(EXIT_FAILURE, _("failed to set the controlling terminal"));
-- 
1.8.3.2

