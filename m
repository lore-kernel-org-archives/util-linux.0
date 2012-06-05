Return-Path: util-linux-owner@vger.kernel.org
Received: from minas.ics.muni.cz ([147.251.4.40]:53945 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab2FEO1D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 10:27:03 -0400
From: "Jan \"Yenya\" Kasprzak" <kas@fi.muni.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] flock: user-configurable exit code
Date: Tue,  5 Jun 2012 16:26:58 +0200
Message-Id: <1338906418-27379-1-git-send-email-kas@fi.muni.cz>
In-Reply-To: <20120605114616.GB14536@x2.net.home>
References: <20120605114616.GB14536@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Jan \"Yenya\" Kasprzak" <kas@fi.muni.cz>

When locking the file fails with -n or -w option, caller has no way
to distinguish between the exit code 1 of the -c command,
and the exit code 1 of flock(1) caused by the conflicting lock.

Add a new -E <exitcode> (--conflict-exit-code) option to set
the exit code for the case of locking failure to any value.
---
 sys-utils/flock.1 |   19 ++++++++++++++++---
 sys-utils/flock.c |   26 ++++++++++++++++----------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 5a6f27f..b50c619 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -71,13 +71,19 @@ cases, for example if the enclosed command group may have forked a background
 process which should not be holding the lock.
 .TP
 \fB\-n\fP, \fB\-\-nb\fP, \fB\-\-nonblock\fP
-Fail (with an exit code of 1) rather than wait if the lock cannot be
+Fail rather than wait if the lock cannot be
 immediately acquired.
+See the
+.I \-E
+option for the exit code used.
 .TP
 \fB\-w\fP, \fB\-\-wait\fP, \fB\-\-timeout\fP \fIseconds\fP
-Fail (with an exit code of 1) if the lock cannot be acquired within
+Fail if the lock cannot be acquired within
 .IR seconds .
 Decimal fractional values are allowed.
+See the
+.I \-E
+option for the exit code used.
 .TP
 \fB\-o\fP, \fB\-\-close\fP
 Close the file descriptor on which the lock is held before executing
@@ -86,6 +92,11 @@ This is useful if
 .B command
 spawns a child process which should not be holding the lock.
 .TP
+\fB\-E\fP, \fB\-\-conflict\-exit\-code\fP \fInumber\fP
+The exit code used when the \fB\-n\fP option is in use, and the
+conflicting lock exists, or the \fB\-w\fP option is in use,
+and the timeout is reached. The default value is 1.
+.TP
 \fB\-c\fP, \fB\-\-command\fP \fIcommand\fP
 Pass a single
 .IR command ,
@@ -134,7 +145,9 @@ return values for everything else but an options
 .I \-n
 or
 .I \-w
-failures which return 1.
+failures which return either the value given by the
+.I \-E
+option, or 1 by default.
 .SH AUTHOR
 .UR hpa@zytor.com
 H. Peter Anvin
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 1db28a2..5a3422a 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -58,6 +58,7 @@ static void __attribute__((__noreturn__)) usage(int ex)
 	fputs(_(  " -u  --unlock             remove a lock\n"), stderr);
 	fputs(_(  " -n  --nonblock           fail rather than wait\n"), stderr);
 	fputs(_(  " -w  --timeout <secs>     wait for a limited amount of time\n"), stderr);
+	fputs(_(  " -E  --conflict-exit-code <number>  exit code after conflict or timeout\n"), stderr);
 	fputs(_(  " -o  --close              close file descriptor before running command\n"), stderr);
 	fputs(_(  " -c  --command <command>  run a single command string through the shell\n"), stderr);
 	fprintf(stderr, USAGE_SEPARATOR);
@@ -141,6 +142,11 @@ int main(int argc, char *argv[])
 	int opt, ix;
 	int do_close = 0;
 	int status;
+	/*
+	 * The default exit code for lock conflict or timeout
+	 * is specified in man flock.1
+	 */
+	int conflict_exit_code = 1;
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
 	struct sigaction sa, old_sa;
@@ -153,6 +159,7 @@ int main(int argc, char *argv[])
 		{"nb", no_argument, NULL, 'n'},
 		{"timeout", required_argument, NULL, 'w'},
 		{"wait", required_argument, NULL, 'w'},
+		{"conflict-exit-code", required_argument, NULL, 'E'},
 		{"close", no_argument, NULL, 'o'},
 		{"help", no_argument, NULL, 'h'},
 		{"version", no_argument, NULL, 'V'},
@@ -171,7 +178,7 @@ int main(int argc, char *argv[])
 
 	optopt = 0;
 	while ((opt =
-		getopt_long(argc, argv, "+sexnouw:hV?", long_options,
+		getopt_long(argc, argv, "+sexnouw:E:hV?", long_options,
 			    &ix)) != EOF) {
 		switch (opt) {
 		case 's':
@@ -194,6 +201,10 @@ int main(int argc, char *argv[])
 			have_timeout = 1;
 			strtotimeval(optarg, &timeout.it_value);
 			break;
+		case 'E':
+			conflict_exit_code = strtos32_or_err(optarg,
+				_("invalid exit code"));
+			break;
 		case 'V':
 			printf("flock (%s)\n", PACKAGE_STRING);
 			exit(EX_OK);
@@ -252,18 +263,13 @@ int main(int argc, char *argv[])
 	while (flock(fd, type | block)) {
 		switch (errno) {
 		case EWOULDBLOCK:
-			/* -n option set and failed to lock. The numeric
-			 * exit value is specified in man flock.1
-			 */
-			exit(1);
+			/* -n option set and failed to lock. */
+			exit(conflict_exit_code);
 		case EINTR:
 			/* Signal received */
 			if (timeout_expired)
-				/* -w option set and failed to lock. The
-				 * numeric exit value is specified in man
-				 * flock.1
-				 */
-				exit(1);
+				/* -w option set and failed to lock. */
+				exit(conflict_exit_code);
 			/* otherwise try again */
 			continue;
 		case EIO:
-- 
1.7.10.2

