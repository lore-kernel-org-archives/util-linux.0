Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:47919 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab2LPKoU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:20 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061756wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:19 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/14] isosize: fix usage() -h option print out
Date: Sun, 16 Dec 2012 10:43:53 +0000
Message-Id: <1355654642-22106-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixes usage() bug from commit 4eba43a7 which claimed sort option for
--help being -H.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index e5defae..625dd42 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -153,15 +153,17 @@ static void isosize(char *filenamep, int xflag, long divisor)
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fprintf(out, _("\nUsage:\n"
-		       " %s [options] iso9660_image_file\n"),
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+		_(" %s [options] iso9660_image_file\n"),
 		program_invocation_short_name);
-
-	fprintf(out, _("\nOptions:\n"
-		       " -d, --divisor=NUM      divide bytes NUM\n"
-		       " -x, --sectors          show sector count and size\n"
-		       " -V, --version          output version information and exit\n"
-		       " -H, --help             display this help and exit\n\n"));
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -d, --divisor=NUM      divide bytes NUM\n"), out);
+	fputs(_(" -x, --sectors          show sector count and size\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("isosize(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -195,8 +197,7 @@ int main(int argc, char **argv)
 			xflag = 1;
 			break;
 		case 'V':
-			printf(_("%s (%s)\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
-- 
1.8.0.2

