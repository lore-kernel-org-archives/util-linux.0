Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57386 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754005AbdFSLgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 07:36:17 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLB89-1dMdrS3e65-000HDx for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017
 13:36:15 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] agetty: cleanup usage issues
Date: Mon, 19 Jun 2017 13:36:14 +0200
Message-Id: <1497872174-9852-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fixed checkusage.sh warnings:
  agetty: --unknownopt, stderr too long: 45

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 term-utils/agetty.c | 102 ++++++++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 938fa2f..542cbce 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -308,7 +308,7 @@ static void termio_final(struct options *op,
 			 struct termios *tp, struct chardata *cp);
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
-static void usage(FILE * out) __attribute__((__noreturn__));
+static void usage(void) __attribute__((__noreturn__));
 static void log_err(const char *, ...) __attribute__((__noreturn__))
 			       __attribute__((__format__(printf, 1, 2)));
 static void log_warn (const char *, ...)
@@ -785,9 +785,9 @@ static void parse_args(int argc, char **argv, struct options *op)
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case HELP_OPTION:
-			usage(stdout);
+			usage();
 		default:
-			usage(stderr);
+			errtryhelp(EXIT_FAILURE);
 		}
 	}
 
@@ -795,7 +795,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 
 	if (argc < optind + 1) {
 		log_warn(_("not enough arguments"));
-		usage(stderr);
+		errtryhelp(EXIT_FAILURE);
 	}
 
 	/* Accept "tty", "baudrate tty", and "tty baudrate". */
@@ -804,7 +804,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		parse_speeds(op, argv[optind++]);
 		if (argc < optind + 1) {
 			warn(_("not enough arguments"));
-			usage(stderr);
+			errtryhelp(EXIT_FAILURE);
 		}
 		op->tty = argv[optind++];
 	} else {
@@ -2106,53 +2106,53 @@ static speed_t bcode(char *s)
 	return 0;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__ ((__noreturn__)) usage(void)
 {
-	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %1$s [options] <line> [<baud_rate>,...] [<termtype>]\n"
-		       " %1$s [options] <baud_rate>,... <line> [<termtype>]\n"), program_invocation_short_name);
-
-	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Open a terminal and set its mode.\n"), out);
-
-	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -8, --8bits                assume 8-bit tty\n"), out);
-	fputs(_(" -a, --autologin <user>     login the specified user automatically\n"), out);
-	fputs(_(" -c, --noreset              do not reset control mode\n"), out);
-	fputs(_(" -E, --remote               use -r <hostname> for login(1)\n"), out);
-	fputs(_(" -f, --issue-file <file>    display issue file\n"), out);
-	fputs(_(" -h, --flow-control         enable hardware flow control\n"), out);
-	fputs(_(" -H, --host <hostname>      specify login host\n"), out);
-	fputs(_(" -i, --noissue              do not display issue file\n"), out);
-	fputs(_(" -I, --init-string <string> set init string\n"), out);
-	fputs(_(" -J  --noclear              do not clear the screen before prompt\n"), out);
-	fputs(_(" -l, --login-program <file> specify login program\n"), out);
-	fputs(_(" -L, --local-line[=<mode>]  control the local line flag\n"), out);
-	fputs(_(" -m, --extract-baud         extract baud rate during connect\n"), out);
-	fputs(_(" -n, --skip-login           do not prompt for login\n"), out);
-	fputs(_(" -N  --nonewline            do not print a newline before issue\n"), out);
-	fputs(_(" -o, --login-options <opts> options that are passed to login\n"), out);
-	fputs(_(" -p, --login-pause          wait for any key before the login\n"), out);
-	fputs(_(" -r, --chroot <dir>         change root to the directory\n"), out);
-	fputs(_(" -R, --hangup               do virtually hangup on the tty\n"), out);
-	fputs(_(" -s, --keep-baud            try to keep baud rate after break\n"), out);
-	fputs(_(" -t, --timeout <number>     login process timeout\n"), out);
-	fputs(_(" -U, --detect-case          detect uppercase terminal\n"), out);
-	fputs(_(" -w, --wait-cr              wait carriage-return\n"), out);
-	fputs(_("     --nohints              do not print hints\n"), out);
-	fputs(_("     --nohostname           no hostname at all will be shown\n"), out);
-	fputs(_("     --long-hostname        show full qualified hostname\n"), out);
-	fputs(_("     --erase-chars <string> additional backspace chars\n"), out);
-	fputs(_("     --kill-chars <string>  additional kill chars\n"), out);
-	fputs(_("     --chdir <directory>    chdir before the login\n"), out);
-	fputs(_("     --delay <number>       sleep seconds before prompt\n"), out);
-	fputs(_("     --nice <number>        run login with this priority\n"), out);
-	fputs(_("     --reload               reload prompts on running agetty instances\n"), out);
-	fputs(_("     --help                 display this help and exit\n"), out);
-	fputs(_("     --version              output version information and exit\n"), out);
-	fprintf(out, USAGE_MAN_TAIL("agetty(8)"));
-
-	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+	puts(USAGE_HEADER);
+	printf(_(" %1$s [options] <line> [<baud_rate>,...] [<termtype>]\n"
+		     " %1$s [options] <baud_rate>,... <line> [<termtype>]\n"), program_invocation_short_name);
+
+	puts(USAGE_SEPARATOR);
+	puts(_("Open a terminal and set its mode.\n"));
+
+	puts(USAGE_OPTIONS);
+	puts(_(" -8, --8bits                assume 8-bit tty\n"));
+	puts(_(" -a, --autologin <user>     login the specified user automatically\n"));
+	puts(_(" -c, --noreset              do not reset control mode\n"));
+	puts(_(" -E, --remote               use -r <hostname> for login(1)\n"));
+	puts(_(" -f, --issue-file <file>    display issue file\n"));
+	puts(_(" -h, --flow-control         enable hardware flow control\n"));
+	puts(_(" -H, --host <hostname>      specify login host\n"));
+	puts(_(" -i, --noissue              do not display issue file\n"));
+	puts(_(" -I, --init-string <string> set init string\n"));
+	puts(_(" -J  --noclear              do not clear the screen before prompt\n"));
+	puts(_(" -l, --login-program <file> specify login program\n"));
+	puts(_(" -L, --local-line[=<mode>]  control the local line flag\n"));
+	puts(_(" -m, --extract-baud         extract baud rate during connect\n"));
+	puts(_(" -n, --skip-login           do not prompt for login\n"));
+	puts(_(" -N  --nonewline            do not print a newline before issue\n"));
+	puts(_(" -o, --login-options <opts> options that are passed to login\n"));
+	puts(_(" -p, --login-pause          wait for any key before the login\n"));
+	puts(_(" -r, --chroot <dir>         change root to the directory\n"));
+	puts(_(" -R, --hangup               do virtually hangup on the tty\n"));
+	puts(_(" -s, --keep-baud            try to keep baud rate after break\n"));
+	puts(_(" -t, --timeout <number>     login process timeout\n"));
+	puts(_(" -U, --detect-case          detect uppercase terminal\n"));
+	puts(_(" -w, --wait-cr              wait carriage-return\n"));
+	puts(_("     --nohints              do not print hints\n"));
+	puts(_("     --nohostname           no hostname at all will be shown\n"));
+	puts(_("     --long-hostname        show full qualified hostname\n"));
+	puts(_("     --erase-chars <string> additional backspace chars\n"));
+	puts(_("     --kill-chars <string>  additional kill chars\n"));
+	puts(_("     --chdir <directory>    chdir before the login\n"));
+	puts(_("     --delay <number>       sleep seconds before prompt\n"));
+	puts(_("     --nice <number>        run login with this priority\n"));
+	puts(_("     --reload               reload prompts on running agetty instances\n"));
+	puts(_("     --help                 display this help and exit\n"));
+	puts(_("     --version              output version information and exit\n"));
+	printf(USAGE_MAN_TAIL("agetty(8)"));
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
-- 
1.8.5.6

