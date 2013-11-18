Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:44320 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3KRTmg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 14:42:36 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] fdisk: remove angle brackets from usage
Date: Mon, 18 Nov 2013 14:42:34 -0500
Message-Id: <1384803754-973-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove superfluous angle brackets and use square brackets
where appropriate to conform to the man page convention.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 fdisks/fdisk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 874f9d1..3572c64 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -50,22 +50,22 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 
 	fprintf(out,
-	      _(" %1$s [options] <disk>    change partition table\n"
-	        " %1$s [options] -l <disk> list partition table(s)\n"),
+	      _(" %1$s [options] [disk]    change partition table\n"
+	        " %1$s [options] -l [disk] list partition table(s)\n"),
 	       program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -b <size>         sector size (512, 1024, 2048 or 4096)\n"), out);
-	fputs(_(" -c[=<mode>]       compatible mode: 'dos' or 'nondos' (default)\n"), out);
+	fputs(_(" -b size           sector size (512, 1024, 2048 or 4096)\n"), out);
+	fputs(_(" -c[=mode]         compatible mode: 'dos' or 'nondos' (default)\n"), out);
 	fputs(_(" -h                print this help text\n"), out);
-	fputs(_(" -c[=<mode>]       compatible mode: 'dos' or 'nondos' (default)\n"), out);
-	fputs(_(" -L[=<when>]       colorize output (auto, always or never)\n"), out);
-	fputs(_(" -t <type>         force fdisk to recognize specified partition table type only\n"), out);
-	fputs(_(" -u[=<unit>]       display units: 'cylinders' or 'sectors' (default)\n"), out);
+	fputs(_(" -c[=mode]         compatible mode: 'dos' or 'nondos' (default)\n"), out);
+	fputs(_(" -L[=when]         colorize output (auto, always or never)\n"), out);
+	fputs(_(" -t type           force fdisk to recognize specified partition table type only\n"), out);
+	fputs(_(" -u[=unit]         display units: 'cylinders' or 'sectors' (default)\n"), out);
 	fputs(_(" -v                print program version\n"), out);
-	fputs(_(" -C <number>       specify the number of cylinders\n"), out);
-	fputs(_(" -H <number>       specify the number of heads\n"), out);
-	fputs(_(" -S <number>       specify the number of sectors per track\n"), out);
+	fputs(_(" -C number         specify the number of cylinders\n"), out);
+	fputs(_(" -H number         specify the number of heads\n"), out);
+	fputs(_(" -S number         specify the number of sectors per track\n"), out);
 
 	fprintf(out, USAGE_MAN_TAIL("fdisk(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-- 
1.8.3.2

