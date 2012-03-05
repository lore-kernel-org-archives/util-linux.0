Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509Ab2CETjM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:12 -0500
Received: by eekc41 with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/17] sfdisk: use rpmatch to yes/no question
Date: Mon,  5 Mar 2012 20:38:40 +0100
Message-Id: <1330976334-10751-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 6267652..f549c64 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -53,6 +53,7 @@
 #include "gpt.h"
 #include "pathnames.h"
 #include "canonicalize.h"
+#include "rpmatch.h"
 
 /*
  * Table of contents:
@@ -3140,7 +3141,7 @@ do_reread(char *dev) {
 static void
 do_fdisk(char *dev) {
     int fd;
-    int c, answer;
+    char answer[32];
     struct stat statbuf;
     int interactive = isatty(0);
     struct disk_desc *z;
@@ -3197,22 +3198,20 @@ do_fdisk(char *dev) {
 	    else
 		warnx(_("I don't like this - probably you should answer No\n"));
 	}
- ask:
 	if (interactive) {
+ ask:
 	    if (no_write)
+		/* TRANSLATORS: sfdisk uses rpmatch which means the answers y and n
+		 * should be translated, but that is not the case with q answer. */
 		printf(_("Are you satisfied with this? [ynq] "));
 	    else
 		printf(_("Do you want to write this to disk? [ynq] "));
-	    answer = c = getchar();
-	    while (c != '\n' && c != EOF)
-		c = getchar();
-	    if (c == EOF)
-		printf(_("\nsfdisk: premature end of input\n"));
-	    if (c == EOF || answer == 'q' || answer == 'Q') {
+	    fgets(answer, sizeof(answer), stdin);
+	    if (answer[0] == 'q' || answer[0] == 'Q') {
 		errx(EXIT_FAILURE, _("Quitting - nothing changed"));
-	    } else if (answer == 'n' || answer == 'N') {
+	    } else if (rpmatch(answer) == 1) {
 		continue;
-	    } else if (answer == 'y' || answer == 'Y') {
+	    } else if (rpmatch(answer) == 0) {
 		break;
 	    } else {
 		printf(_("Please answer one of y,n,q\n"));
-- 
1.7.9.2

