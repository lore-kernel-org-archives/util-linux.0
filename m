Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752120AbdFVChu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:50 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgNGi-1eBU1A40O4-00ndaC for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:49 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/13] whereis: add --help and --version
Date: Thu, 22 Jun 2017 04:37:43 +0200
Message-Id: <1498099066-24235-11-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We can use errtryhelp() now and never print usage to stderr.
One may improve all these "bad usage" messages.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/whereis.1 |  6 ++++++
 misc-utils/whereis.c | 48 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 6461f26..0d2cbe7 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -125,6 +125,12 @@ or
 .BR \-S
 is specified, the option will output the hard-coded paths
 that the command was able to find on the system.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
 .SH EXAMPLE
 To find all files in
 .I /usr/\:bin
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index b5b35f5..897a7a2 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -183,8 +183,10 @@ static const char *whereis_type_to_name(int type)
 	}
 }
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(void)
 {
+	FILE *out = stdout;
+
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [-BMS <dir>... -f] <name>\n"), program_invocation_short_name);
 
@@ -201,9 +203,12 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -f         terminate <dirs> argument list\n"), out);
 	fputs(_(" -u         search for unusual entries\n"), out);
 	fputs(_(" -l         output effective lookup paths\n"), out);
-	fprintf(out, USAGE_MAN_TAIL("whereis(1)"));
 
-	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("whereis(1)"));
+	exit(EXIT_SUCCESS);
 }
 
 static void dirlist_add_dir(struct wh_dirlist **ls0, int type, const char *dir)
@@ -502,8 +507,18 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (argc == 1)
-		usage(stderr);
+	if (argc <= 1) {
+		warnx(_("not enough arguments"));
+		errtryhelp(EXIT_FAILURE);
+	} else {
+		/* first arg may be one of our standard longopts */
+		if (!strcmp(argv[1], "--help"))
+			usage();
+		if (!strcmp(argv[1], "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+		}
+	}
 
 	whereis_init_debug();
 
@@ -547,8 +562,10 @@ int main(int argc, char **argv)
 				opt_f_missing = 0;
 				break;
 			case 'B':
-				if (*(arg + 1))
-					usage(stderr);
+				if (*(arg + 1)) {
+					warnx(_("bad usage"));
+					errtryhelp(EXIT_FAILURE);
+				}
 				i++;
 				free_dirlist(&ls, BIN_DIR);
 				construct_dirlist_from_argv(
@@ -556,8 +573,10 @@ int main(int argc, char **argv)
 				opt_f_missing = 1;
 				break;
 			case 'M':
-				if (*(arg + 1))
-					usage(stderr);
+				if (*(arg + 1)) {
+					warnx(_("bad usage"));
+					errtryhelp(EXIT_FAILURE);
+				}
 				i++;
 				free_dirlist(&ls, MAN_DIR);
 				construct_dirlist_from_argv(
@@ -565,8 +584,10 @@ int main(int argc, char **argv)
 				opt_f_missing = 1;
 				break;
 			case 'S':
-				if (*(arg + 1))
-					usage(stderr);
+				if (*(arg + 1)) {
+					warnx(_("bad usage"));
+					errtryhelp(EXIT_FAILURE);
+				}
 				i++;
 				free_dirlist(&ls, SRC_DIR);
 				construct_dirlist_from_argv(
@@ -604,9 +625,10 @@ int main(int argc, char **argv)
 				printf(UTIL_LINUX_VERSION);
 				return EXIT_SUCCESS;
 			case 'h':
-				usage(stdout);
+				usage();
 			default:
-				usage(stderr);
+				warnx(_("bad usage"));
+				errtryhelp(EXIT_FAILURE);
 			}
 
 			if (arg_i < i)		/* moved to the next argv[] item */
-- 
1.8.5.6

