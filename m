Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53384 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3FBRvx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:51:53 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so2027990wib.9
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:51:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/19] sfdisk: use program_invocation_short_name to determine program name
Date: Sun,  2 Jun 2013 18:51:12 +0100
Message-Id: <1370195485-27907-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index cac8252..912b95d 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -2549,7 +2549,6 @@ unsigned long long total_size;
 
 int
 main(int argc, char **argv) {
-    char *progn;
     int c;
     char *dev;
     int opt_size = 0;
@@ -2569,14 +2568,10 @@ main(int argc, char **argv) {
 
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
1.8.3

