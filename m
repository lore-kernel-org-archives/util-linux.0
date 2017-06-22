Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdFVChv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:51 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZOan-1d4x0K0cZx-00LItl for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:49 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/13] more: add --help and --version
Date: Thu, 22 Jun 2017 04:37:44 +0200
Message-Id: <1498099066-24235-12-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 text-utils/more.1 |  6 ++++++
 text-utils/more.c | 29 ++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/text-utils/more.1 b/text-utils/more.1
index 428fdec..c4420e0 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -98,6 +98,12 @@ Start displaying each file at line
 The
 .I string
 to be searched in each file before starting to display it.
+.TP
+\fB\-\-help\fR
+Display help text and exit.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
 .SH COMMANDS
 Interactive commands for
 .B more
diff --git a/text-utils/more.c b/text-utils/more.c
index 7c197b2..3578656 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -225,8 +225,9 @@ static void putstring(char *s)
 	tputs(s, fileno(stdout), putchar);	/* putp(s); */
 }
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(void)
 {
+	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <file>...\n"), program_invocation_short_name);
 
@@ -244,9 +245,12 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -<number>   the number of lines per screenful\n"), out);
 	fputs(_(" +<number>   display file beginning from line number\n"), out);
 	fputs(_(" +/<string>  display file beginning from search string match\n"), out);
-	fputs(_(" -V          display version information and exit\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("     --help     display this help and exit\n"), out);
+	fputs(_(" -V, --version  output version information and exit\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("more(1)"));
-	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+	exit(EXIT_SUCCESS);
 }
 
 int main(int argc, char **argv)
@@ -267,6 +271,16 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	if (argc > 1) {
+		/* first arg may be one of our standard longopts */
+		if (!strcmp(argv[1], "--help"))
+			usage();
+		if (!strcmp(argv[1], "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+		}
+	}
+
 	nfiles = argc;
 	fnames = argv;
 	setlocale(LC_ALL, "");
@@ -319,9 +333,10 @@ int main(int argc, char **argv)
 	left = dlines;
 	if (nfiles > 1)
 		prnames++;
-	if (!no_intty && nfiles == 0)
-		usage(stderr);
-	else
+	if (!no_intty && nfiles == 0) {
+		warnx(_("bad usage"));
+		errtryhelp(EXIT_FAILURE);
+	} else
 		f = stdin;
 	if (!no_tty) {
 		signal(SIGQUIT, onquit);
@@ -488,7 +503,7 @@ void argscan(char *s)
 			break;
 		default:
 			warnx(_("unknown option -%s"), s);
-			usage(stderr);
+			errtryhelp(EXIT_FAILURE);
 			break;
 		}
 		s++;
-- 
1.8.5.6

