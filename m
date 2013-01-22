Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48479 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:37 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so4717297wgb.1
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/14] rename: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:06 +0000
Message-Id: <1358897233-6676-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 21bd522..a36caec 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -95,17 +95,17 @@ static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] expression replacement file...\n"),
 		program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -v, --verbose    explain what is being done\n"
-		" -V, --version    output version information and exit\n"
-		" -s, --symlink    act on symlink target\n"
-		" -h, --help       display this help and exit\n\n"), out);
-
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -v, --verbose    explain what is being done\n"), out);
+	fputs(_(" -s, --symlink    act on symlink target\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("rename(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.8.1.1

