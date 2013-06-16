Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:58329 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:15 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so1655248wib.16
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/15] sfdisk: use program_invocation_short_name to determine program name
Date: Sun, 16 Jun 2013 19:53:45 +0100
Message-Id: <1371408836-16663-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 96b4de2..2b4969b 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -2535,7 +2535,6 @@ unsigned long long total_size;
 
 int
 main(int argc, char **argv) {
-    char *progn;
     int c;
     char *dev;
     int opt_size = 0;
@@ -2555,14 +2554,10 @@ main(int argc, char **argv) {
 
     if (argc < 1)
 	errx(EXIT_FAILURE, _("no command?"));
-    if ((progn = strrchr(argv[0], '/')) == NULL)
-	progn = argv[0];
-    else
-	progn++;
-    if (!strcmp(progn, "activate"))
+    if (!strcmp(program_invocation_short_name, "activate"))
 	activate = 1;		/* equivalent to `sfdisk -A' */
 #if 0				/* not important enough to deserve a name */
-    else if (!strcmp(progn, "unhide"))
+    else if (!strcmp(program_invocation_short_name, "unhide"))
 	unhide = 1;		/* equivalent to `sfdisk -U' */
 #endif
 
-- 
1.8.3.1

