Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/5] docs: update boilerplate.c usage()
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9ba07b4f-74a7-084a-e10c-e512d2198441@gmx.com>
Date: Sun, 2 Jul 2017 15:54:24 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/boilerplate.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index c97ad46..ae3fb5c 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -36,28 +36,27 @@
  */
 static void __attribute__((__noreturn__)) usage(void)
 {
-	FILE *out = stdout;
-	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
+	fputs(USAGE_HEADER, stdout);
+	printf(_(" %s [options] file...\n"), program_invocation_short_name);
 
-        fputs(USAGE_SEPARATOR, out);
-        fputs(_("Short program description.\n"), out);
+	fputs(USAGE_SEPARATOR, stdout);
+	puts(_("Short program description."));
 
-	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -n, --no-argument       option does not use argument\n"), out);
-	fputs(_("     --optional[=<arg>]  option argument is optional\n"), out);
-	fputs(_(" -r, --required <arg>    option requires an argument\n"), out);
-	fputs(_(" -z                      no long option\n"), out);
-	fputs(_("     --xyzzy             a long option only\n"), out);
-	fputs(_(" -e, --extremely-long-long-option\n"
-		"                         use next line for description when needed\n"), out);
-	fputs(_(" -l, --long-explanation  an example of very verbose, and chatty option\n"
-		"                           description on two, or multiple lines, where the\n"
-		"                           consecutive lines are intended by two spaces\n"), out);
-	fputs(_(" -f, --foobar            next option description resets indent\n"), out);
-	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_OPTIONS, stdout);
+	puts(_(" -n, --no-argument       option does not use argument"));
+	puts(_("     --optional[=<arg>]  option argument is optional"));
+	puts(_(" -r, --required <arg>    option requires an argument"));
+	puts(_(" -z                      no long option"));
+	puts(_("     --xyzzy             a long option only"));
+	puts(_(" -e, --extremely-long-long-option\n"
+	       "                         use next line for description when needed"));
+	puts(_(" -l, --long-explanation  an example of very verbose, and chatty option\n"
+	       "                           description on two, or multiple lines, where the\n"
+	       "                           consecutive lines are intended by two spaces"));
+	puts(_(" -f, --foobar            next option description resets indent"));
+	fputs(USAGE_SEPARATOR, stdout);
 	print_usage_help_options(25); /* char offset to align option descriptions */
-	fprintf(out, USAGE_MAN_TAIL("fixme-command-name(1)"));
+	printf(USAGE_MAN_TAIL("fixme-command-name(1)"));
 	exit(EXIT_SUCCESS);
 }
 
