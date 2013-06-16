Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:59391 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:12 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so1698043wev.8
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/15] sfdisk: clean up usage() functions
Date: Sun, 16 Jun 2013 19:53:44 +0100
Message-Id: <1371408836-16663-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Includes removal of unhide usage function, which was never implemented.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index cbbdfd5..96b4de2 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -2356,11 +2356,11 @@ read_input(char *dev, int interactive, struct disk_desc *z) {
  */
 static void usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 		_(" %s [options] <device> [...]\n"),  program_invocation_short_name);
 
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -s, --show-size           list size of a partition\n"
 		" -c, --id                  change or print partition Id\n"
 		"     --change-id           change Id\n"
@@ -2407,27 +2407,29 @@ static void usage(FILE * out)
 	fputs(_("\nOverride the detected geometry using:\n"
 		" -C, --cylinders <number>  set the number of cylinders to use\n"
 		" -H, --heads <number>      set the number of heads to use\n"
-		" -S, --sectors <number>    set the number of sectors to use\n\n"), out);
+		" -S, --sectors <number>    set the number of sectors to use\n"), out);
 
+	fprintf(out, USAGE_MAN_TAIL("sfdisk(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
 static void
-activate_usage(char *progn) {
-    puts(_("Usage:"));
-    printf(_("%s device		 list active partitions on device\n"), progn);
-    printf(_("%s device n1 n2 ... activate partitions n1 ..., inactivate the rest\n"),
-	   progn);
-    printf(_("%s -An device	 activate partition n, inactivate the other ones\n"),
-	   program_invocation_short_name);
+activate_usage(void) {
+    char *p;
+    if (!strcmp(program_invocation_short_name, "activate"))
+	p = " ";
+    else
+	p = " --activate=";
+    fputs(USAGE_HEADER, stderr);
+    fputs(USAGE_SEPARATOR, stderr);
+    fprintf(stderr, _(" %s%sdevice            list active partitions on device\n"),
+	   program_invocation_short_name, p);
+    fprintf(stderr, _(" %s%sdevice n1 n2 ...  activate partitions n1 ..., inactivate the rest\n"),
+	   program_invocation_short_name, p);
+    fprintf(stderr, USAGE_MAN_TAIL("sfdisk(8)"));
     exit(EXIT_FAILURE);
 }
 
-static void
-unhide_usage(char *progn __attribute__ ((__unused__))) {
-    exit(1);
-}
-
 static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V";
 
 #define PRINT_ID 0400
@@ -2543,7 +2545,6 @@ main(int argc, char **argv) {
     int activate = 0;
     int do_id = 0;
     int unhide = 0;
-    int fdisk = 0;
     char *activatearg = 0;
     char *unhidearg = 0;
 
@@ -2564,8 +2565,6 @@ main(int argc, char **argv) {
     else if (!strcmp(progn, "unhide"))
 	unhide = 1;		/* equivalent to `sfdisk -U' */
 #endif
-    else
-	fdisk = 1;
 
     while ((c = getopt_long(argc, argv, short_opts, long_opts, NULL)) != -1) {
 	switch (c) {
@@ -2728,9 +2727,7 @@ main(int argc, char **argv) {
 
     if (optind == argc) {
 	if (activate)
-	    activate_usage(fdisk ? "sfdisk -A" : progn);
-	else if (unhide)
-	    unhide_usage(fdisk ? "sfdisk -U" : progn);
+	    activate_usage();
 	else
 	    usage(stderr);
     }
-- 
1.8.3.1

