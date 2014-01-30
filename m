Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbaA3Owp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jan 2014 09:52:45 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH] ionice: add the way to specify the target processes with pgid and uid
Date: Thu, 30 Jan 2014 23:52:38 +0900
Message-Id: <1391093558-20108-1-git-send-email-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

ioprio_get and ioprio_set system call accept not only process ID but
also process group ID(pgid) and user ID(uid) to specify the target
process(es).  However, ionice command accepts only process ID.  With
this patch a user can specify the target processes with pgid(-P
option) and uid(-u option).

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 schedutils/ionice.1 | 26 ++++++++++++++++++++
 schedutils/ionice.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 8b9d614..3b85635 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -17,6 +17,24 @@ ionice \- set or get process I/O scheduling class and priority
 .RB [ \-n
 .IR level ]
 .RB [ \-t ]
+.B \-P
+.IR PGID ...
+.br
+.B ionice
+.RB [ \-c
+.IR class ]
+.RB [ \-n
+.IR level ]
+.RB [ \-t ]
+.B \-u
+.IR UID ...
+.br
+.B ionice
+.RB [ \-c
+.IR class ]
+.RB [ \-n
+.IR level ]
+.RB [ \-t ]
 .IR "command " [ argument ...]
 .SH DESCRIPTION
 This program sets or gets the I/O scheduling class and priority for a program.
@@ -77,6 +95,10 @@ accepts an argument.  For realtime and best-effort, \fI0-7\fR are valid data
 Specify the process IDs of running processes for which to get or set the
 scheduling parameters.
 .TP
+.BR \-P , " \-\-pgid " \fIPGID\fR...
+Specify the process group IDs of running processes for which to get or set the
+scheduling parameters.
+.TP
 .BR \-t , " \-\-ignore"
 Ignore failure to set the requested priority.  If \fIcommand\fR was specified,
 run it even in case it was not possible to set the desired scheduling priority,
@@ -85,6 +107,10 @@ which can happen due to insufficient privileges or an old kernel version.
 .BR \-h , " \-\-help"
 Display help text and exit.
 .TP
+.BR \-u , " \-\-uid " \fIUID\fR...
+Specify the user IDs of running processes for which to get or set the
+scheduling parameters.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .SH EXAMPLES
diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index 03e41b7..a1b12ae 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -68,9 +68,9 @@ static int parse_ioclass(const char *str)
 	return -1;
 }
 
-static void ioprio_print(int pid)
+static void ioprio_print(int pid, int who)
 {
-	int ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);
+	int ioprio = ioprio_get(who, pid);
 
 	if (ioprio == -1)
 		err(EXIT_FAILURE, _("ioprio_get failed"));
@@ -89,9 +89,9 @@ static void ioprio_print(int pid)
 	}
 }
 
-static void ioprio_setpid(pid_t pid, int ioclass, int data)
+static void ioprio_setid(int which, int ioclass, int data, int who)
 {
-	int rc = ioprio_set(IOPRIO_WHO_PROCESS, pid,
+	int rc = ioprio_set(who, which,
 			    IOPRIO_PRIO_VALUE(ioclass, data));
 
 	if (rc == -1 && !tolerant)
@@ -106,6 +106,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		 "\n"
 		 "Usage:\n"
 		 "  %1$s [OPTION] -p PID [PID...]\n"
+		 "  %1$s [OPTION] -P PGID [PGID...]\n"
+		 "  %1$s [OPTION] -u UID [UID...]\n"
 		 "  %1$s [OPTION] COMMAND\n"
 		 "\n"
 		 "Options:\n"
@@ -114,7 +116,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		 "  -n, --classdata <num> scheduling class data\n"
 		 "                           0-7 for realtime and best-effort classes\n"
 		 "  -p, --pid=PID         view or modify already running process\n"
+		 "  -P, --pgid=PGID       view or modify already running process group\n"
 		 "  -t, --ignore          ignore failures\n"
+		 "  -u, --uid=UID         view or modify already running processes owned by a user\n"
 		 "  -V, --version         output version information and exit\n"
 		 "  -h, --help            display this help and exit\n\n"),
 		program_invocation_short_name);
@@ -125,7 +129,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main(int argc, char **argv)
 {
 	int data = 4, set = 0, ioclass = IOPRIO_CLASS_BE, c;
-	pid_t pid = 0;
+	int which = 0, who = 0;
+	const char *invalid_msg = NULL;
 
 	static const struct option longopts[] = {
 		{ "classdata", required_argument, NULL, 'n' },
@@ -133,6 +138,8 @@ int main(int argc, char **argv)
 		{ "help",      no_argument,       NULL, 'h' },
 		{ "ignore",    no_argument,       NULL, 't' },
 		{ "pid",       required_argument, NULL, 'p' },
+		{ "pgid",      required_argument, NULL, 'P' },
+		{ "uid",       required_argument, NULL, 'u' },
 		{ "version",   no_argument,       NULL, 'V' },
 		{ NULL, 0, NULL, 0 }
 	};
@@ -142,7 +149,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "+n:c:p:tVh", longopts, NULL)) != EOF)
+	while ((c = getopt_long(argc, argv, "+n:c:p:P:u:tVh", longopts, NULL)) != EOF)
 		switch (c) {
 		case 'n':
 			data = strtos32_or_err(optarg, _("invalid class data argument"));
@@ -162,7 +169,27 @@ int main(int argc, char **argv)
 			set |= 2;
 			break;
 		case 'p':
-			pid = strtos32_or_err(optarg, _("invalid PID argument"));
+			if (who)
+				errx(EXIT_FAILURE,
+				     _("can handle one of pid, pgid or uid at once"));
+			invalid_msg = _("invalid PID argument");
+			which = strtos32_or_err(optarg, invalid_msg);
+			who = IOPRIO_WHO_PROCESS;
+			break;
+		case 'P':
+			if (who)
+				errx(EXIT_FAILURE,
+				     _("can handle one of pid, pgid or uid at once"));
+			invalid_msg = _("invalid PGID argument");
+			which = strtos32_or_err(optarg, invalid_msg);
+			who = IOPRIO_WHO_PGRP;
+			break;
+		case 'u':
+			if (who)
+				errx(EXIT_FAILURE,
+				     _("can handle one of pid, pgid or uid at once"));
+			which = strtos32_or_err(optarg, invalid_msg);
+			who = IOPRIO_WHO_USER;
 			break;
 		case 't':
 			tolerant = 1;
@@ -197,37 +224,36 @@ int main(int argc, char **argv)
 			break;
 	}
 
-	if (!set && !pid && optind == argc)
+	if (!set && !which && optind == argc)
 		/*
 		 * ionice without options, print the current ioprio
 		 */
-		ioprio_print(0);
-
-	else if (!set && pid) {
+		ioprio_print(0, IOPRIO_WHO_PROCESS);
+	else if (!set && who) {
 		/*
-		 * ionice -p PID [PID ...]
+		 * ionice -p|-P|-u ID [ID ...]
 		 */
-		ioprio_print(pid);
+		ioprio_print(which, who);
 
 		for(; argv[optind]; ++optind) {
-			pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
-			ioprio_print(pid);
+			which = strtos32_or_err(argv[optind], invalid_msg);
+			ioprio_print(which, who);
 		}
-	} else if (set && pid) {
+	} else if (set && who) {
 		/*
-		 * ionice -c CLASS -p PID [PID ...]
+		 * ionice -c CLASS -p|-P|-u ID [ID ...]
 		 */
-		ioprio_setpid(pid, ioclass, data);
+		ioprio_setid(which, ioclass, data, who);
 
 		for(; argv[optind]; ++optind) {
-			pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
-			ioprio_setpid(pid, ioclass, data);
+			which = strtos32_or_err(argv[optind], invalid_msg);
+			ioprio_setid(which, ioclass, data, who);
 		}
 	} else if (argv[optind]) {
 		/*
 		 * ionice [-c CLASS] COMMAND
 		 */
-		ioprio_setpid(0, ioclass, data);
+		ioprio_setid(0, ioclass, data, IOPRIO_WHO_PROCESS);
 		execvp(argv[optind], &argv[optind]);
 		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 	} else
-- 
1.8.5.3

