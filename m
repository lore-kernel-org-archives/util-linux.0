Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:59552 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091AbaLNTpx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:45:53 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] textual: do not start option descriptions with a capital
Date: Sun, 14 Dec 2014 20:45:27 +0100
Message-Id: <1418586333-5342-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This normalizes the help text of getopt, clarifies one description,
and also adjust two comments.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/getopt.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 197bae7..85cac32 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -91,12 +91,12 @@ struct getopt_control {
 
 enum { REALLOC_INCREMENT = 8 };
 
-/* Allow changing which getopt is in use with function pointer */
+/* Allow changing which getopt is in use with function pointer. */
 int (*getopt_long_fp) (int argc, char *const *argv, const char *optstr,
 		       const struct option * longopts, int *longindex);
 
 /*
- * This function 'print_normalizeds' a single argument: it puts single quotes
+ * This function 'normalizes' a single argument: it puts single quotes
  * around it and escapes other special characters. If quote is false, it
  * just returns its argument.
  *
@@ -314,21 +314,21 @@ static void __attribute__ ((__noreturn__)) print_help(void)
 {
 	fputs(USAGE_HEADER, stderr);
 	fprintf(stderr, _(
-		" %1$s optstring parameters\n"
-		" %1$s [options] [--] optstring parameters\n"
-		" %1$s [options] -o|--options optstring [options] [--] parameters\n"),
+		" %1$s <optstring> <parameters>\n"
+		" %1$s [options] [--] <optstring> <parameters>\n"
+		" %1$s [options] -o|--options <optstring> [options] [--] <parameters>\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, stderr);
-	fputs(_(" -a, --alternative            Allow long options starting with single -\n"), stderr);
-	fputs(_(" -l, --longoptions <longopts> Long options to be recognized\n"), stderr);
-	fputs(_(" -n, --name <progname>        The name under which errors are reported\n"), stderr);
-	fputs(_(" -o, --options <optstring>    Short options to be recognized\n"), stderr);
-	fputs(_(" -q, --quiet                  Disable error reporting by getopt(3)\n"), stderr);
-	fputs(_(" -Q, --quiet-output           No normal output\n"), stderr);
-	fputs(_(" -s, --shell <shell>          Set shell quoting conventions\n"), stderr);
-	fputs(_(" -T, --test                   Test for getopt(1) version\n"), stderr);
-	fputs(_(" -u, --unquoted               Do not quote the output\n"), stderr);
+	fputs(_(" -a, --alternative             allow long options starting with single -\n"), stderr);
+	fputs(_(" -l, --longoptions <longopts>  the long options to be recognized\n"), stderr);
+	fputs(_(" -n, --name <progname>         the name under which errors are reported\n"), stderr);
+	fputs(_(" -o, --options <optstring>     the short options to be recognized\n"), stderr);
+	fputs(_(" -q, --quiet                   disable error reporting by getopt(3)\n"), stderr);
+	fputs(_(" -Q, --quiet-output            no normal output\n"), stderr);
+	fputs(_(" -s, --shell <shell>           set quoting conventions to those of <shell>\n"), stderr);
+	fputs(_(" -T, --test                    test for getopt(1) version\n"), stderr);
+	fputs(_(" -u, --unquoted                do not quote the output\n"), stderr);
 	fputs(USAGE_SEPARATOR, stderr);
 	fputs(USAGE_HELP, stderr);
 	fputs(USAGE_VERSION, stderr);
-- 
1.7.0.4

