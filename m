Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:51817 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3CPXkc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:32 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so1588718wib.15
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/7] whereis: align with howto-usage-function.txt
Date: Sat, 16 Mar 2013 23:40:15 +0000
Message-Id: <1363477219-29245-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index f579e29..e3cfb5f 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -154,24 +154,21 @@ static const char *srcdirs[] = {
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
-	fprintf(out,
-	      _(" %s [options] file\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -f <file>  define search scope\n"
-		" -b         search only for binaries\n"
-		" -B <dirs>  define binaries lookup path\n"
-		" -m         search only for manuals\n"
-		" -M <dirs>  define man lookup path\n"
-		" -s         search only for sources\n"
-		" -S <dirs>  define sources lookup path\n"
-		" -u         search for unusual entries\n"
-		" -l         output effective lookup paths\n"
-		" -V         output version information and exit\n"
-		" -h         display this help and exit\n\n"), out);
-
-	fputs(_("See how to use file and dirs arguments from whereis(1) manual.\n"), out);
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] file\n"), program_invocation_short_name);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -b         search only for binaries\n"), out);
+	fputs(_(" -B <dirs>  define binaries lookup path\n"), out);
+	fputs(_(" -m         search only for manuals\n"), out);
+	fputs(_(" -M <dirs>  define man lookup path\n"), out);
+	fputs(_(" -s         search only for sources\n"), out);
+	fputs(_(" -S <dirs>  define sources lookup path\n"), out);
+	fputs(_(" -f         terminate <dirs> argument list\n"), out);
+	fputs(_(" -u         search for unusual entries\n"), out);
+	fputs(_(" -l         output effective lookup paths\n"), out);
+	fprintf(out, USAGE_MAN_TAIL("whereis(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.8.2

