Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1EXU5I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 May 2011 16:57:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so2169065ewy.19
        for <util-linux@vger.kernel.org>; Tue, 24 May 2011 13:57:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/13] colrm: gotos, long options and argument checking
Date: Tue, 24 May 2011 22:56:40 +0200
Message-Id: <1306270604-6154-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Unnecessary goto jumps where replaced by a simple function, and
two loops. Long options support help and version, and the two
arguments this command has are now validated with strtoul_or_err.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/Makefile.am |    2 +
 text-utils/colrm.c     |  143 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 99 insertions(+), 46 deletions(-)

diff --git a/text-utils/Makefile.am b/text-utils/Makefile.am
index 8700889..0255033 100644
--- a/text-utils/Makefile.am
+++ b/text-utils/Makefile.am
@@ -6,6 +6,8 @@ usrbin_exec_PROGRAMS = col colcrt colrm column hexdump rev line tailf
 
 col_SOURCES = col.c $(top_srcdir)/lib/strutils.c
 
+colrm_SOURCES = colrm.c $(top_srcdir)/lib/strutils.c
+
 hexdump_SOURCES = hexdump.c conv.c display.c hexsyntax.c parse.c \
 		  hexdump.h $(top_srcdir)/lib/strutils.c
 
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index e8b1ea4..fa56f2d 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -40,67 +40,80 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <getopt.h>
 
 #include "nls.h"
 #include "widechar.h"
+#include "strutils.h"
+#include "c.h"
 
 /*
 COLRM removes unwanted columns from a file
 	Jeff Schriebman  UC Berkeley 11-74
 */
 
-int
-main(int argc, char **argv)
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	register int ct, first, last;
-	register wint_t c;
-	int i, w;
+	fprintf(out, _("\nUsage:\n"
+		       " %s [startcol [endcol]]\n"),
+		       program_invocation_short_name);
+
+	fprintf(out, _("\nOptions:\n"
+		       " -V, --version   output version information and exit\n"
+		       " -h, --help      display this help and exit\n\n"));
+
+	fprintf(out, _("%s reads from standard input and writes to standard output\n\n"),
+		       program_invocation_short_name);
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int process_input(unsigned long first, unsigned long last)
+{
+	unsigned long ct = 0;
+	wint_t c;
+	unsigned long i;
+	int w;
 	int padding;
 
-	setlocale(LC_ALL, "");
+	for (;;) {
+		c = getwc(stdin);
+		if (c == WEOF)
+			return 0;
+		if (c == '\t')
+			w = ((ct + 8) & ~7) - ct;
+		else if (c == '\b')
+			w = (ct ? ct - 1 : 0) - ct;
+		else {
+			w = wcwidth(c);
+			if (w < 0)
+				w = 0;
+		}
+		ct += w;
+		if (c == '\n') {
+			putwc(c, stdout);
+			ct = 0;
+			continue;
 
-	first = 0;
-	last = 0;
-	if (argc > 1)
-		first = atoi(*++argv);
-	if (argc > 2)
-		last = atoi(*++argv);
-
-start:
-	ct = 0;
-loop1:
-	c = getwc(stdin);
-	if (c == WEOF)
-		goto fin;
-	if (c == '\t')
-		w = ((ct + 8) & ~7) - ct;
-	else if (c == '\b')
-		w = (ct ? ct - 1 : 0) - ct;
-	else {
-		w = wcwidth(c);
-		if (w < 0)
-			w = 0;
-	}
-	ct += w;
-	if (c == '\n') {
-		putwc(c, stdout);
-		goto start;
-	}
-	if (!first || ct < first) {
-		putwc(c, stdout);
-		goto loop1;
+		}
+		if (!first || ct < first) {
+			putwc(c, stdout);
+			continue;
+		}
+		break;
 	}
-	for (i = ct-w+1; i < first; i++)
+
+	for (i = ct - w + 1; i < first; i++)
 		putwc(' ', stdout);
 
-/* Loop getting rid of characters */
+	/* Loop getting rid of characters */
 	while (!last || ct < last) {
 		c = getwc(stdin);
 		if (c == WEOF)
-			goto fin;
+			return 0;
 		if (c == '\n') {
 			putwc(c, stdout);
-			goto start;
+			return 1;
 		}
 		if (c == '\t')
 			ct = (ct + 8) & ~7;
@@ -116,25 +129,63 @@ loop1:
 
 	padding = 0;
 
-/* Output last of the line */
+	/* Output last of the line */
 	for (;;) {
 		c = getwc(stdin);
 		if (c == WEOF)
 			break;
 		if (c == '\n') {
 			putwc(c, stdout);
-			goto start;
+			return 1;
 		}
 		if (padding == 0 && last < ct) {
-			for (i = last; i <ct; i++)
+			for (i = last; i < ct; i++)
 				putwc(' ', stdout);
 			padding = 1;
 		}
 		putwc(c, stdout);
 	}
-fin:
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long first = 0, last = 0;
+	int opt;
+
+	static const struct option longopts[] = {
+		{"version", no_argument, 0, 'V'},
+		{"help", no_argument, 0, 'h'},
+		{NULL, 0, 0, 0}
+	};
+
+	setlocale(LC_ALL, "");
+
+	while ((opt =
+		getopt_long(argc, argv, "bfhl:pxVH", longopts,
+			    NULL)) != -1)
+		switch (opt) {
+		case 'V':
+			printf(_("%s from %s\n"),
+			       program_invocation_short_name,
+			       PACKAGE_STRING);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+
+	if (argc > 1)
+		first = strtoul_or_err(*++argv, _("first argument"));
+	if (argc > 2)
+		last = strtoul_or_err(*++argv, _("second argument"));
+
+	while (process_input(first, last))
+		;
+
 	fflush(stdout);
 	if (ferror(stdout) || fclose(stdout))
-		return 1;
-	return 0;
+		return EXIT_FAILURE;
+	return EXIT_SUCCESS;
 }
-- 
1.7.5.2

