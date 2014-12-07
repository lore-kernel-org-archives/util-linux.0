Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48918 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbaLGKNU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:13:20 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so4842349wiv.4
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:13:19 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] line: use util-linux conventions
Date: Sun,  7 Dec 2014 10:13:04 +0000
Message-Id: <1417947184-24178-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947184-24178-1-git-send-email-kerolasa@iki.fi>
References: <1417947184-24178-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change add --help and --version print outs, checking at exit the
stdout write was successful, and as a minor thing the command is made to
use wide char functions to read and write inputs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/line.c | 64 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/text-utils/line.c b/text-utils/line.c
index 636122e..80daa34 100644
--- a/text-utils/line.c
+++ b/text-utils/line.c
@@ -15,31 +15,65 @@
  * See Documentation/deprecated.txt for more information.
  */
 
-#include	<stdio.h>
-#include	<unistd.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <unistd.h>
 
-static int	status;		/* exit status */
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+#include "widechar.h"
 
-static void
-doline(int fd)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	char c;
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("line(1)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	wint_t c;
+	int opt;
+	int status = EXIT_SUCCESS;
+
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((opt = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (opt) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
 
 	for (;;) {
-		if (read(fd, &c, 1) <= 0) {
-			status = 1;
+		c = getwchar();
+		if (c == WEOF) {
+			status = EXIT_FAILURE;
 			break;
 		}
 		if (c == '\n')
 			break;
-		putchar(c);
+		putwchar(c);
 	}
-	putchar('\n');
-}
+	putwchar(L'\n');
 
-int
-main(void)
-{
-	doline(0);
 	return status;
 }
-- 
2.1.3

