Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:47800 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX10 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:26 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so2074267wey.0
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/14] partx: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:02 +0000
Message-Id: <1358897233-6676-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/partx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 45bf773..9fa9587 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -704,19 +704,19 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --add            add specified partitions or all of them\n"
-		" -d, --delete         delete specified partitions or all of them\n"
-		" -l, --list           list partitions (DEPRECATED)\n"
-		" -s, --show           list partitions\n\n"
-		" -u, --update         update specified partitions or all of them\n"
-		" -b, --bytes          print SIZE in bytes rather than in human readable format\n"
-		" -g, --noheadings     don't print headings for --show\n"
-		" -n, --nr <n:m>       specify the range of partitions (e.g. --nr 2:4)\n"
-		" -o, --output <type>  define which output columns to use\n"
-		" -P, --pairs          use key=\"value\" output format\n"
-		" -r, --raw            use raw output format\n"
-		" -t, --type <type>    specify the partition type (dos, bsd, solaris, etc.)\n"
-		" -v, --verbose        verbose mode\n"), out);
+	fputs(_(" -a, --add            add specified partitions or all of them\n"), out);
+	fputs(_(" -d, --delete         delete specified partitions or all of them\n"), out);
+	fputs(_(" -l, --list           list partitions (DEPRECATED)\n"), out);
+	fputs(_(" -s, --show           list partitions\n\n"), out);
+	fputs(_(" -u, --update         update specified partitions or all of them\n"), out);
+	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
+	fputs(_(" -g, --noheadings     don't print headings for --show\n"), out);
+	fputs(_(" -n, --nr <n:m>       specify the range of partitions (e.g. --nr 2:4)\n"), out);
+	fputs(_(" -o, --output <type>  define which output columns to use\n"), out);
+	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
+	fputs(_(" -r, --raw            use raw output format\n"), out);
+	fputs(_(" -t, --type <type>    specify the partition type (dos, bsd, solaris, etc.)\n"), out);
+	fputs(_(" -v, --verbose        verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.8.1.1

