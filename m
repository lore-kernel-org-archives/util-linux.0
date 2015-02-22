Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:34006 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbBVOl6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:41:58 -0500
Received: by wesq59 with SMTP id q59so13669938wes.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:41:57 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/16] flock: add --verbose option
Date: Sun, 22 Feb 2015 14:41:32 +0000
Message-Id: <1424616106-580-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Jenkins script jobs using flock are a great example of a situation in
which one may want an automation to be verbose, so that when unexpected
events happen there is more hints in logs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am |  4 ++--
 sys-utils/flock.1       |  4 ++++
 sys-utils/flock.c       | 33 ++++++++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 15d0a95..d3f77b4 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -1,8 +1,8 @@
 if BUILD_FLOCK
 usrbin_exec_PROGRAMS += flock
 dist_man_MANS += sys-utils/flock.1
-flock_SOURCES = sys-utils/flock.c
-flock_LDADD = $(LDADD) libcommon.la
+flock_SOURCES = sys-utils/flock.c lib/monotonic.c
+flock_LDADD = $(LDADD) libcommon.la $(CLOCKGETTIME_LIBS)
 endif
 
 if BUILD_IPCMK
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index cdc294b..f526b33 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -107,6 +107,10 @@ option for the exit code used. The zero number of
 .IR seconds
 is interpreted as \fB\-\-nonblock\fR.
 .TP
+.B \-\-verbose
+Tell why lock could not be got, and when it can be how long did it take
+to acquire the lock.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 3828155..cb8a82b 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -44,6 +44,7 @@
 #include "strutils.h"
 #include "closestream.h"
 #include "timer.h"
+#include "monotonic.h"
 
 static void __attribute__((__noreturn__)) usage(int ex)
 {
@@ -66,6 +67,7 @@ static void __attribute__((__noreturn__)) usage(int ex)
 	fputs(_(  " -E, --conflict-exit-code <number>  exit code after conflict or timeout\n"), stderr);
 	fputs(_(  " -o, --close              close file descriptor before running command\n"), stderr);
 	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stderr);
+	fputs(_(  "     --verbose            increase verbosity\n"), stderr);
 	fprintf(stderr, USAGE_SEPARATOR);
 	fprintf(stderr, USAGE_HELP);
 	fprintf(stderr, USAGE_VERSION);
@@ -120,6 +122,8 @@ int main(int argc, char *argv[])
 	int opt, ix;
 	int do_close = 0;
 	int status;
+	int verbose = 0;
+	struct timeval time_start, time_done;
 	/*
 	 * The default exit code for lock conflict or timeout
 	 * is specified in man flock.1
@@ -128,7 +132,9 @@ int main(int argc, char *argv[])
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
 	struct sigaction old_sa;
-
+	enum {
+		OPT_VERBOSE = CHAR_MAX + 1
+	};
 	static const struct option long_options[] = {
 		{"shared", no_argument, NULL, 's'},
 		{"exclusive", no_argument, NULL, 'x'},
@@ -139,8 +145,9 @@ int main(int argc, char *argv[])
 		{"wait", required_argument, NULL, 'w'},
 		{"conflict-exit-code", required_argument, NULL, 'E'},
 		{"close", no_argument, NULL, 'o'},
+		{"verbose", no_argument, NULL, OPT_VERBOSE},
 		{"help", no_argument, NULL, 'h'},
-		{"version", no_argument, NULL, 'V'},
+		{"version", required_argument, NULL, 'V'},
 		{NULL, 0, NULL, 0}
 	};
 
@@ -184,6 +191,9 @@ int main(int argc, char *argv[])
 			conflict_exit_code = strtos32_or_err(optarg,
 				_("invalid exit code"));
 			break;
+		case OPT_VERBOSE:
+			verbose = 1;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			exit(EX_OK);
@@ -239,16 +249,23 @@ int main(int argc, char *argv[])
 			setup_timer(&timeout, &old_timer, &old_sa, timeout_handler);
 	}
 
+	if (verbose)
+		gettime_monotonic(&time_start);
 	while (flock(fd, type | block)) {
 		switch (errno) {
 		case EWOULDBLOCK:
 			/* -n option set and failed to lock. */
+			if (verbose)
+				warnx(_("failed to get lock"));
 			exit(conflict_exit_code);
 		case EINTR:
 			/* Signal received */
-			if (timeout_expired)
+			if (timeout_expired) {
 				/* -w option set and failed to lock. */
+				if (verbose)
+					warnx(_("timeout while waiting to get lock"));
 				exit(conflict_exit_code);
+			}
 			/* otherwise try again */
 			continue;
 		case EIO:
@@ -282,13 +299,23 @@ int main(int argc, char *argv[])
 
 	if (have_timeout)
 		cancel_timer(&old_timer, &old_sa);
+	if (verbose) {
+		struct timeval delta;
 
+		gettime_monotonic(&time_done);
+		timersub(&time_done, &time_start, &delta);
+		printf(_("%s: getting lock took %ld.%06ld seconds\n"),
+		       program_invocation_short_name, delta.tv_sec,
+		       delta.tv_usec);
+	}
 	status = EX_OK;
 
 	if (cmd_argv) {
 		pid_t w, f;
 		/* Clear any inherited settings */
 		signal(SIGCHLD, SIG_DFL);
+		if (verbose)
+			printf(_("%s: executing %s\n"), program_invocation_short_name, cmd_argv[2]);
 		f = fork();
 
 		if (f < 0) {
-- 
2.3.0

