Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f46.google.com ([74.125.82.46]:32982 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbbLNVzA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:00 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so67533407wmn.0
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:54:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/8] include/c: add long options printing function
Date: Mon, 14 Dec 2015 21:54:46 +0000
Message-Id: <1450130093-12108-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When new options are added, or old removed, the bash completion files tend
to be forgot.  To avoid that in future add a new function to list long
options, so that the bash completion files can assess what options each
command has available with an util-linux standard option --print-long-opts.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/boilerplate.c |  9 ++++++++-
 include/c.h                 | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index 3ee7d7b..b1728ae 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -46,6 +46,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_("                           consecutive lines are intended by two spaces\n"), out);
 	fputs(_(" -f, --foobar            next option description resets indent\n"), out);
 	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_PRINT_LONG_OPTS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("fixme-command-name(1)"));
@@ -57,7 +58,8 @@ int main(int argc, char **argv)
 	int c;
 
 	enum {
-		OPT_XYZZY = CHAR_MAX + 1
+		OPT_PRINT_LONG_OPTS = CHAR_MAX + 1,
+		OPT_XYZZY
 	};
 	static const struct option longopts[] = {
 		{"no-argument", no_argument, NULL, 'n'},
@@ -67,6 +69,7 @@ int main(int argc, char **argv)
 		{"extremely-long-long-option", no_argument, NULL, 'e'},
 		{"long-explanation", no_argument, NULL, 'l'},
 		{"foobar", no_argument, NULL, 'f'},
+		{"print-long-opts", no_argument, NULL, OPT_PRINT_LONG_OPTS},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -87,6 +90,10 @@ int main(int argc, char **argv)
 		case 'l':
 		case 'f':
 			break;
+		/* standard util-linux options */
+		case OPT_PRINT_LONG_OPTS:
+			print_long_opts(longopts);
+			return EXIT_SUCCESS;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
diff --git a/include/c.h b/include/c.h
index 2a317eb..d18b461 100644
--- a/include/c.h
+++ b/include/c.h
@@ -14,6 +14,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <getopt.h>
 
 #include <assert.h>
 
@@ -295,6 +296,7 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_HEADER     _("\nUsage:\n")
 #define USAGE_OPTIONS    _("\nOptions:\n")
 #define USAGE_SEPARATOR    "\n"
+#define USAGE_PRINT_LONG_OPTS _("     --print-long-opts  print long options and exit\n")
 #define USAGE_HELP       _(" -h, --help     display this help and exit\n")
 #define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
 #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
@@ -302,6 +304,25 @@ static inline int xusleep(useconds_t usec)
 #define UTIL_LINUX_VERSION _("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING
 
 /*
+ * Print struct option long options to be used in bash completion files as
+ * dynamic listing.
+ */
+static inline void print_long_opts(const struct option *longopts)
+{
+	const struct option *p = longopts;
+
+	while (p->name) {
+		fputs("--", stdout);
+		fputs(p->name, stdout);
+		if (p->has_arg == optional_argument)
+			fputc('=', stdout);
+		fputc(' ', stdout);
+		p++;
+	}
+	fputc('\n', stdout);
+}
+
+/*
  * scanf modifiers for "strings allocation"
  */
 #ifdef HAVE_SCANF_MS_MODIFIER
-- 
2.6.4

