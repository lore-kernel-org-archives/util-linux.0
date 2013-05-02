Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38528 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761977Ab3EBSwU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:20 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so894162wgg.23
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/16] cal: add --highlight to usage()
Date: Thu,  2 May 2013 19:51:35 +0100
Message-Id: <1367520701-14962-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And clean up the usage() function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index cf50c57..d88fc2e 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -809,20 +809,19 @@ center(const char *str, size_t len, int separate)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
-	fprintf(out,
-	      _(" %s [options] [[[day] month] year]\n"),
-			program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -1, --one        show only current month (default)\n"
-	        " -3, --three      show previous, current and next month\n"
-		" -s, --sunday     Sunday as first day of week\n"
-		" -m, --monday     Monday as first day of week\n"
-		" -j, --julian     output Julian dates\n"
-		" -y, --year       show whole current year\n"
-		" -V, --version    display version information and exit\n"
-		" -h, --help       display this help text and exit\n\n"), out);
-
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [[[day] month] year]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -1, --one               show only current month (default)\n"), out);
+	fputs(_(" -3, --three             show previous, current and next month\n"), out);
+	fputs(_(" -s, --sunday            Sunday as first day of week\n"), out);
+	fputs(_(" -m, --monday            Monday as first day of week\n"), out);
+	fputs(_(" -j, --julian            output Julian dates\n"), out);
+	fputs(_(" -y, --year              show whole current year\n"), out);
+	fputs(_("     --highlight <when>  advice when to highlight; never, auto, always\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("cal(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.8.2.2

