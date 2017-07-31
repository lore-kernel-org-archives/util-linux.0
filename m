Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37443 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdGaTzZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id 12so24395003wrb.4
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/9] agetty: remove dead DO_DEVFS_FIDDLING code segment
Date: Mon, 31 Jul 2017 20:55:06 +0100
Message-Id: <20170731195508.11661-8-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no ./configure option to enable this, and it is unlikely any
distribution hot patching to enable fiddling when building package.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index cc0cc3f62..a95da6f3d 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -829,45 +829,6 @@ static void parse_args(int argc, char **argv, struct options *op)
 	if (argc > optind && argv[optind])
 		op->term = argv[optind];
 
-#ifdef DO_DEVFS_FIDDLING
-	/*
-	 * Some devfs junk, following Goswin Brederlow:
-	 *   turn ttyS<n> into tts/<n>
-	 *   turn tty<n> into vc/<n>
-	 * http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=72241
-	 */
-	if (op->tty && strlen(op->tty) < 90) {
-		char dev_name[100];
-		struct stat st;
-
-		if (strncmp(op->tty, "ttyS", 4) == 0) {
-			strcpy(dev_name, "/dev/");
-			strcat(dev_name, op->tty);
-			if (stat(dev_name, &st) < 0) {
-				strcpy(dev_name, "/dev/tts/");
-				strcat(dev_name, op->tty + 4);
-				if (stat(dev_name, &st) == 0) {
-					op->tty = strdup(dev_name + 5);
-					if (!op->tty)
-						log_err(_("failed to allocate memory: %m"));
-				}
-			}
-		} else if (strncmp(op->tty, "tty", 3) == 0) {
-			strcpy(dev_name, "/dev/");
-			strncat(dev_name, op->tty, 90);
-			if (stat(dev_name, &st) < 0) {
-				strcpy(dev_name, "/dev/vc/");
-				strcat(dev_name, op->tty + 3);
-				if (stat(dev_name, &st) == 0) {
-					op->tty = strdup(dev_name + 5);
-					if (!op->tty)
-						log_err(_("failed to allocate memory: %m"));
-				}
-			}
-		}
-	}
-#endif				/* DO_DEVFS_FIDDLING */
-
 	debug("exiting parseargs\n");
 }
 
-- 
2.13.3

