Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52660 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbdFVChu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:50 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfjJY-1dBqtE27DY-00NCiO for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:48 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/13] fsck: add --help and --version
Date: Thu, 22 Jun 2017 04:37:41 +0200
Message-Id: <1498099066-24235-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Also cleanup usage() function, never write usage to stderr.

FIXME:
 - currently strtou32_or_err() exits with wrong exit code.
 - option -C does not use a safe strto*_err function

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.8 |  6 ++++++
 disk-utils/fsck.c | 27 ++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 3148e42..b3096be 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -309,6 +309,12 @@ Don't show the title on startup.
 .B \-V
 Produce verbose output, including all filesystem-specific commands
 that are executed.
+.TP
+\fB\-?\fR, \fB\-\-help\fR
+Display help text and exit.
+.TP
+\fB\-\-version\fR
+Display version information and exit.
 .SH FILESYSTEM SPECIFIC OPTIONS
 .B Options which are not understood by fsck are passed to the filesystem-specific checker! 
 .PP
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 5a418fc..6b8d551 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1369,8 +1369,9 @@ static int check_all(void)
 	return status;
 }
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(void)
 {
+	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] -- [fs-options] [<filesystem> ...]\n"),
 			 program_invocation_short_name);
@@ -1393,13 +1394,14 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -t <type>  specify filesystem types to be checked;\n"
 		"            <type> is allowed to be a comma-separated list\n"), out);
 	fputs(_(" -V         explain what is being done\n"), out);
-	fputs(_(" -?         display this help and exit\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
+	fputs(_(" -?, --help     display this help and exit\n"), out);
+	fputs(_("     --version  output version information and exit\n"), out);
+	fputs(USAGE_SEPARATOR, out);
 	fputs(_("See the specific fsck.* commands for available fs-options."), out);
 	fprintf(out, USAGE_MAN_TAIL("fsck(8)"));
-
-	exit(out == stderr ? FSCK_EX_USAGE : FSCK_EX_OK);
+	exit(FSCK_EX_OK);
 }
 
 static void signal_cancel(int sig __attribute__((__unused__)))
@@ -1433,6 +1435,15 @@ static void parse_argv(int argc, char *argv[])
 		arg = argv[i];
 		if (!arg)
 			continue;
+
+		/* the only two longopts to satisfy UL standards */
+		if (!opts_for_fsck && !strcmp(arg, "--help"))
+			usage();
+		if (!opts_for_fsck && !strcmp(arg, "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			exit(FSCK_EX_OK);
+		}
+
 		if ((arg[0] == '/' && !opts_for_fsck) || strchr(arg, '=')) {
 			if (num_devices >= MAX_DEVICES)
 				errx(FSCK_EX_ERROR, _("too many devices"));
@@ -1536,13 +1547,15 @@ static void parse_argv(int argc, char *argv[])
 			case 't':
 				tmp = NULL;
 				if (fstype)
-					usage(stderr);
+					errx(FSCK_EX_USAGE,
+						_("option '%s' may be specified only once"), "-t");
 				if (arg[j+1])
 					tmp = arg+j+1;
 				else if ((i+1) < argc)
 					tmp = argv[++i];
 				else
-					usage(stderr);
+					errx(FSCK_EX_USAGE,
+						_("option '%s' requires an argument"), "-t");
 				fstype = xstrdup(tmp);
 				compile_fs_type(fstype, &fs_type_compiled);
 				goto next_arg;
@@ -1550,7 +1563,7 @@ static void parse_argv(int argc, char *argv[])
 				opts_for_fsck++;
 				break;
 			case '?':
-				usage(stdout);
+				usage();
 				break;
 			default:
 				options[++opt] = arg[j];
-- 
1.8.5.6

