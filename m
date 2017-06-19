Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754001AbdFSLgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 07:36:17 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MMoU7-1dRZoG1oMB-008YQd for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017
 13:36:15 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] flock: cleanup usage issues
Date: Mon, 19 Jun 2017 13:36:12 +0200
Message-Id: <1497872174-9852-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Write --help always to stdout.
Always use errtryhelp(EX_USAGE) instead of errx(EX_USAGE, ...)

Noticed by

$ ./tools/checkusage.sh flock
flock: help no stdout
flock: help non-empty stderr

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/flock.c | 67 +++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 50194bd..5eab1db 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -46,34 +46,34 @@
 #include "monotonic.h"
 #include "timer.h"
 
-static void __attribute__((__noreturn__)) usage(int ex)
+static void __attribute__((__noreturn__)) usage(void)
 {
-	fprintf(stderr, USAGE_HEADER);
-	fprintf(stderr,
+	printf(USAGE_HEADER);
+	printf(
 		_(" %1$s [options] <file>|<directory> <command> [<argument>...]\n"
 		  " %1$s [options] <file>|<directory> -c <command>\n"
 		  " %1$s [options] <file descriptor number>\n"),
 		program_invocation_short_name);
 
-	fputs(USAGE_SEPARATOR, stderr);
-	fputs(_("Manage file locks from shell scripts.\n"), stderr);
-
-	fputs(USAGE_OPTIONS, stderr);
-	fputs(_(  " -s, --shared             get a shared lock\n"), stderr);
-	fputs(_(  " -x, --exclusive          get an exclusive lock (default)\n"), stderr);
-	fputs(_(  " -u, --unlock             remove a lock\n"), stderr);
-	fputs(_(  " -n, --nonblock           fail rather than wait\n"), stderr);
-	fputs(_(  " -w, --timeout <secs>     wait for a limited amount of time\n"), stderr);
-	fputs(_(  " -E, --conflict-exit-code <number>  exit code after conflict or timeout\n"), stderr);
-	fputs(_(  " -o, --close              close file descriptor before running command\n"), stderr);
-	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stderr);
-	fputs(_(  " -F, --no-fork            execute command without forking\n"), stderr);
-	fputs(_(  "     --verbose            increase verbosity\n"), stderr);
-	fprintf(stderr, USAGE_SEPARATOR);
-	fprintf(stderr, USAGE_HELP);
-	fprintf(stderr, USAGE_VERSION);
-	fprintf(stderr, USAGE_MAN_TAIL("flock(1)"));
-	exit(ex);
+	puts(USAGE_SEPARATOR);
+	puts(_("Manage file locks from shell scripts.\n"));
+
+	puts(USAGE_OPTIONS);
+	puts(_(  " -s, --shared             get a shared lock\n"));
+	puts(_(  " -x, --exclusive          get an exclusive lock (default)\n"));
+	puts(_(  " -u, --unlock             remove a lock\n"));
+	puts(_(  " -n, --nonblock           fail rather than wait\n"));
+	puts(_(  " -w, --timeout <secs>     wait for a limited amount of time\n"));
+	puts(_(  " -E, --conflict-exit-code <number>  exit code after conflict or timeout\n"));
+	puts(_(  " -o, --close              close file descriptor before running command\n"));
+	puts(_(  " -c, --command <command>  run a single command string through the shell\n"));
+	puts(_(  " -F, --no-fork            execute command without forking\n"));
+	puts(_(  "     --verbose            increase verbosity\n"));
+	printf(USAGE_SEPARATOR);
+	printf(USAGE_HELP);
+	printf(USAGE_VERSION);
+	printf(USAGE_MAN_TAIL("flock(1)"));
+	exit(EXIT_SUCCESS);
 }
 
 static sig_atomic_t timeout_expired = 0;
@@ -170,9 +170,6 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (argc < 2)
-		usage(EX_USAGE);
-
 	memset(&timeout, 0, sizeof timeout);
 
 	optopt = 0;
@@ -215,24 +212,25 @@ int main(int argc, char *argv[])
 			printf(UTIL_LINUX_VERSION);
 			exit(EX_OK);
 		case 'h':
-			usage(0);
+			usage();
 		default:
 			errtryhelp(EX_USAGE);
 		}
 	}
 
-	if (no_fork && do_close)
-		errx(EX_USAGE,
-			_("the --no-fork and --close options are incompatible"));
-
+	if (no_fork && do_close) {
+		warnx(_("the --no-fork and --close options are incompatible"));
+		errtryhelp(EX_USAGE);
+	}
 	if (argc > optind + 1) {
 		/* Run command */
 		if (!strcmp(argv[optind + 1], "-c") ||
 		    !strcmp(argv[optind + 1], "--command")) {
-			if (argc != optind + 3)
-				errx(EX_USAGE,
-				     _("%s requires exactly one command argument"),
+			if (argc != optind + 3) {
+				warnx(_("%s requires exactly one command argument"),
 				     argv[optind + 1]);
+				errtryhelp(EX_USAGE);
+			}
 			cmd_argv = sh_c_argv;
 			cmd_argv[0] = getenv("SHELL");
 			if (!cmd_argv[0] || !*cmd_argv[0])
@@ -252,7 +250,8 @@ int main(int argc, char *argv[])
 		fd = strtos32_or_err(argv[optind], _("bad file descriptor"));
 	} else {
 		/* Bad options */
-		errx(EX_USAGE, _("requires file descriptor, file or directory"));
+		warnx(_("requires file descriptor, file or directory"));
+		errtryhelp(EX_USAGE);
 	}
 
 	if (have_timeout) {
-- 
1.8.5.6

