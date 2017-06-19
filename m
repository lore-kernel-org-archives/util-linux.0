Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65224 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754003AbdFSLgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 07:36:17 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Ls8Qd-1dnUQq2dQN-013yQN for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017
 13:36:15 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] getopt: cleanup usage issues
Date: Mon, 19 Jun 2017 13:36:13 +0200
Message-Id: <1497872174-9852-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fixed checkusage.sh warnings:
  getopt: --help, returns error
  getopt: --help, no stdout
  getopt: --help, non-empty stderr

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/getopt.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index af4cf38..e7c549b 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -243,9 +243,7 @@ static void __attribute__ ((__noreturn__)) parse_error(const char *message)
 {
 	if (message)
 		warnx("%s", message);
-	fprintf(stderr, _("Try `%s --help' for more information.\n"),
-		program_invocation_short_name);
-	exit(PARAMETER_EXIT_CODE);
+	errtryhelp(PARAMETER_EXIT_CODE);
 }
 
 
@@ -325,33 +323,33 @@ static shell_t shell_type(const char *new_shell)
 	parse_error(_("unknown shell after -s or --shell argument"));
 }
 
-static void __attribute__ ((__noreturn__)) print_help(void)
+static void __attribute__ ((__noreturn__)) usage(void)
 {
-	fputs(USAGE_HEADER, stderr);
-	fprintf(stderr, _(
+	puts(USAGE_HEADER);
+	printf(_(
 		" %1$s <optstring> <parameters>\n"
 		" %1$s [options] [--] <optstring> <parameters>\n"
 		" %1$s [options] -o|--options <optstring> [options] [--] <parameters>\n"),
 		program_invocation_short_name);
 
-	fputs(USAGE_SEPARATOR, stderr);
-	fputs(_("Parse command options.\n"), stderr);
-
-	fputs(USAGE_OPTIONS, stderr);
-	fputs(_(" -a, --alternative             allow long options starting with single -\n"), stderr);
-	fputs(_(" -l, --longoptions <longopts>  the long options to be recognized\n"), stderr);
-	fputs(_(" -n, --name <progname>         the name under which errors are reported\n"), stderr);
-	fputs(_(" -o, --options <optstring>     the short options to be recognized\n"), stderr);
-	fputs(_(" -q, --quiet                   disable error reporting by getopt(3)\n"), stderr);
-	fputs(_(" -Q, --quiet-output            no normal output\n"), stderr);
-	fputs(_(" -s, --shell <shell>           set quoting conventions to those of <shell>\n"), stderr);
-	fputs(_(" -T, --test                    test for getopt(1) version\n"), stderr);
-	fputs(_(" -u, --unquoted                do not quote the output\n"), stderr);
-	fputs(USAGE_SEPARATOR, stderr);
-	fputs(USAGE_HELP, stderr);
-	fputs(USAGE_VERSION, stderr);
-	fprintf(stderr, USAGE_MAN_TAIL("getopt(1)"));
-	exit(PARAMETER_EXIT_CODE);
+	puts(USAGE_SEPARATOR);
+	puts(_("Parse command options.\n"));
+
+	puts(USAGE_OPTIONS);
+	puts(_(" -a, --alternative             allow long options starting with single -\n"));
+	puts(_(" -l, --longoptions <longopts>  the long options to be recognized\n"));
+	puts(_(" -n, --name <progname>         the name under which errors are reported\n"));
+	puts(_(" -o, --options <optstring>     the short options to be recognized\n"));
+	puts(_(" -q, --quiet                   disable error reporting by getopt(3)\n"));
+	puts(_(" -Q, --quiet-output            no normal output\n"));
+	puts(_(" -s, --shell <shell>           set quoting conventions to those of <shell>\n"));
+	puts(_(" -T, --test                    test for getopt(1) version\n"));
+	puts(_(" -u, --unquoted                do not quote the output\n"));
+	puts(USAGE_SEPARATOR);
+	puts(USAGE_HELP);
+	puts(USAGE_VERSION);
+	printf(USAGE_MAN_TAIL("getopt(1)"));
+	exit(EXIT_SUCCESS);
 }
 
 int main(int argc, char *argv[])
@@ -417,7 +415,7 @@ int main(int argc, char *argv[])
 			getopt_long_fp = getopt_long_only;
 			break;
 		case 'h':
-			print_help();
+			usage();
 		case 'o':
 			free(ctl.optstr);
 			ctl.optstr = xstrdup(optarg);
-- 
1.8.5.6

