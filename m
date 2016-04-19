Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36558 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbcDSUf4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id l6so8273258wml.3
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/5] getopt: fix memory leaks and integer overflows [ASAN & valgrind]
Date: Tue, 19 Apr 2016 21:35:45 +0100
Message-Id: <1461098145-2988-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getopt(1) is short living command, and one could argue ensuring all
allocations are freed at end of execution is waste of time.  There is a
point in that, but making test-suite runs to be less noisy with ASAN is also
nice as it encourages reading the errors when/if they happen.

Reviewed-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 2cff2eb..dc2a976 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -86,6 +86,7 @@ struct getopt_control {
 	int long_options_length;	/* length of options array */
 	int long_options_nr;		/* number of used elements in array */
 	unsigned int
+		free_name:1,		/* free up argv[0] after printout */
 		compatible:1,		/* compatibility mode for 'difficult' programs */
 		quiet_errors:1,		/* print errors */
 		quiet_output:1,		/* print output */
@@ -181,7 +182,7 @@ static void print_normalized(const struct getopt_control *ctl, const char *arg)
  * optstr must contain the short options, and longopts the long options.
  * Other settings are found in global variables.
  */
-static int generate_output(const struct getopt_control *ctl, char *argv[], int argc)
+static int generate_output(struct getopt_control *ctl, char *argv[], int argc)
 {
 	int exit_code = EXIT_SUCCESS;	/* Assume everything will be OK */
 	int opt;
@@ -195,8 +196,10 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
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
@@ -216,13 +219,19 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
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
+		free((char *)ctl->long_options[longindex].name);
+	free(ctl->long_options);
+	free(ctl->optstr);
+	if (ctl->free_name)
+		free(argv[0]);
 	return exit_code;
 }
 
@@ -373,9 +382,6 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	add_longopt(&ctl, NULL, 0);	/* init */
-	getopt_long_fp = getopt_long;
-
 	if (getenv("GETOPT_COMPATIBLE"))
 		ctl.compatible = 1;
 
@@ -391,6 +397,9 @@ int main(int argc, char *argv[])
 			parse_error(_("missing optstring argument"));
 	}
 
+	add_longopt(&ctl, NULL, 0);	/* init */
+	getopt_long_fp = getopt_long;
+
 	if (argv[1][0] != '-' || ctl.compatible) {
 		ctl.quote = 0;
 		ctl.optstr = xmalloc(strlen(argv[1]) + 1);
@@ -417,6 +426,7 @@ int main(int argc, char *argv[])
 		case 'n':
 			free(name);
 			name = xstrdup(optarg);
+			ctl.free_name = 1;
 			break;
 		case 'q':
 			ctl.quiet_errors = 1;
@@ -428,6 +438,7 @@ int main(int argc, char *argv[])
 			ctl.shell = shell_type(optarg);
 			break;
 		case 'T':
+			free(ctl.long_options);
 			return TEST_EXIT_CODE;
 		case 'u':
 			ctl.quote = 0;
-- 
2.8.0

