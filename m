Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36469 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcCMKb5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:31:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so9996346wml.3
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:31:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/10] getopt: fix memory leaks and integer overflows [ASAN & valgrind]
Date: Sun, 13 Mar 2016 10:31:41 +0000
Message-Id: <1457865109-2881-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getopt(1) is short living command, and one could argue ensuring all
allocations are freed at end of execution is waste of time.  There is a
point in that, but making test-suite runs to be less noisy with ASAN is also
nice as it encourages reading the errors when/if they happen.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index c4144f6..be2ed38 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -79,13 +79,23 @@
 /* The shells recognized. */
 typedef enum { BASH, TCSH } shell_t;
 
+/* This is a copy of getopt_long(3) structure, in which *name does not have
+ * const, so that is can be free'd at end of execution.  */
+struct getoption {
+	char *name;
+	int has_arg;
+	int *flag;
+	int val;
+};
+
 struct getopt_control {
 	shell_t shell;			/* the shell we generate output for */
 	char *optstr;			/* getopt(3) optstring */
-	struct option *long_options;	/* long options */
+	struct getoption *long_options;	/* long options */
 	int long_options_length;	/* length of options array */
 	int long_options_nr;		/* number of used elements in array */
 	unsigned int
+		free_name:1,		/* free up argv[0] after printout */
 		compatible:1,		/* compatibility mode for 'difficult' programs */
 		quiet_errors:1,		/* print errors */
 		quiet_output:1,		/* print output */
@@ -181,7 +191,7 @@ static void print_normalized(const struct getopt_control *ctl, const char *arg)
  * optstr must contain the short options, and longopts the long options.
  * Other settings are found in global variables.
  */
-static int generate_output(const struct getopt_control *ctl, char *argv[], int argc)
+static int generate_output(struct getopt_control *ctl, char *argv[], int argc)
 {
 	int exit_code = EXIT_SUCCESS;	/* Assume everything will be OK */
 	int opt;
@@ -195,8 +205,10 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 	optind = 0;
 
 	while ((opt =
-		(getopt_long_fp(argc, argv, ctl->optstr, ctl->long_options, &longindex)))
-	       != EOF)
+		(getopt_long_fp
+		 (argc, argv, ctl->optstr,
+		  (const struct option *)ctl->long_options, &longindex)))
+	       != EOF) {
 		if (opt == '?' || opt == ':')
 			exit_code = GETOPT_EXIT_CODE;
 		else if (!ctl->quiet_output) {
@@ -216,13 +228,19 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 					print_normalized(ctl, optarg ? optarg : "");
 			}
 		}
-
+	}
 	if (!ctl->quiet_output) {
 		printf(" --");
 		while (optind < argc)
 			print_normalized(ctl, argv[optind++]);
 		printf("\n");
 	}
+	for (longindex = 0; longindex < ctl->long_options_nr; longindex++)
+		free(ctl->long_options[longindex].name);
+	free(ctl->long_options);
+	free(ctl->optstr);
+	if (ctl->free_name)
+		free(argv[0]);
 	return exit_code;
 }
 
@@ -373,9 +391,6 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	add_longopt(&ctl, NULL, 0);	/* init */
-	getopt_long_fp = getopt_long;
-
 	if (getenv("GETOPT_COMPATIBLE"))
 		ctl.compatible = 1;
 
@@ -391,6 +406,9 @@ int main(int argc, char *argv[])
 			parse_error(_("missing optstring argument"));
 	}
 
+	add_longopt(&ctl, NULL, 0);	/* init */
+	getopt_long_fp = getopt_long;
+
 	if (argv[1][0] != '-' || ctl.compatible) {
 		ctl.quote = 0;
 		ctl.optstr = xmalloc(strlen(argv[1]) + 1);
@@ -417,6 +435,7 @@ int main(int argc, char *argv[])
 		case 'n':
 			free(name);
 			name = xstrdup(optarg);
+			ctl.free_name = 1;
 			break;
 		case 'q':
 			ctl.quiet_errors = 1;
@@ -428,6 +447,7 @@ int main(int argc, char *argv[])
 			ctl.shell = shell_type(optarg);
 			break;
 		case 'T':
+			free(ctl.long_options);
 			return TEST_EXIT_CODE;
 		case 'u':
 			ctl.quote = 0;
-- 
2.7.2

