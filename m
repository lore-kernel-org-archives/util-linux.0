Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:40628 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab3AVX1y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:54 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so2142652wgb.2
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:53 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/14] column: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:13 +0000
Message-Id: <1358897233-6676-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 33bc28d..1f1a0a2 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -88,21 +88,20 @@ static void __attribute__((__noreturn__)) usage(int rc)
 {
 	FILE *out = rc == EXIT_FAILURE ? stderr : stdout;
 
-	fprintf(out, _("\nUsage: %s [options] [file ...]\n"),
-				program_invocation_short_name);
-	fprintf(out, _("\nOptions:\n"));
-
-	fprintf(out, _(
-	" -h, --help               displays this help text\n"
-	" -V, --version            output version information and exit\n"
-	" -c, --columns <width>    width of output in number of characters\n"
-	" -t, --table              create a table\n"
-	" -s, --separator <string> possible table delimiters\n"
-	" -o, --output-separator <string>\n"
-	"                          table output column separator, default is two spaces\n"
-	" -x, --fillrows           fill rows before columns\n"));
-
-	fprintf(out, _("\nFor more information see column(1).\n"));
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [file ...]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -c, --columns <width>    width of output in number of characters\n"), out);
+	fputs(_(" -t, --table              create a table\n"), out);
+	fputs(_(" -s, --separator <string> possible table delimiters\n"), out);
+	fputs(_(" -o, --output-separator <string>\n"), out);
+	fputs(_("                          table output column separator, default is two spaces\n"), out);
+	fputs(_(" -x, --fillrows           fill rows before columns\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("column(1)"));
+
 	exit(rc);
 }
 
-- 
1.8.1.1

