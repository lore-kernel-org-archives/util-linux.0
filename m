Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45159 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:15 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so4772225wiv.4
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/12] swapon, swapheader, mkswap: move swap signature to header
Date: Sun, 27 Apr 2014 21:05:35 +0100
Message-Id: <1398629138-31718-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both swapon and mkswap need to know what is valid device signature, so
share the value.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c  | 4 ++--
 include/swapheader.h | 2 ++
 sys-utils/swapon.c   | 3 ---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 830b14c..16b8e89 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -177,7 +177,7 @@ write_signature(char *sig)
 {
 	char *sp = (char *) signature_page;
 
-	strncpy(sp + pagesize - 10, sig, 10);
+	strncpy(sp + pagesize - 10, sig, SWAP_SIGNATURE_SZ);
 }
 
 static void
@@ -611,7 +611,7 @@ main(int argc, char **argv) {
 	printf(_("Setting up swapspace version %d, size = %llu KiB\n"),
 		version, goodpages * pagesize / 1024);
 
-	write_signature("SWAPSPACE2");
+	write_signature(SWAP_SIGNATURE);
 	write_uuid_and_label(uuid, opt_label);
 
 	offset = 1024;
diff --git a/include/swapheader.h b/include/swapheader.h
index 1e1090c..9ca9673 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -5,6 +5,8 @@
 #define SWAP_UUID_LENGTH 16
 #define SWAP_LABEL_LENGTH 16
 #define SWAP_HEADER_SIZE 1540
+#define SWAP_SIGNATURE "SWAPSPACE2"
+#define SWAP_SIGNATURE_SZ (sizeof(SWAP_SIGNATURE) - 1)
 
 #include <stdint.h>
 
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index c2d4795..f321b05 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -76,9 +76,6 @@ enum {
 	SIG_SWSUSPEND
 };
 
-#define SWAP_SIGNATURE		"SWAPSPACE2"
-#define SWAP_SIGNATURE_SZ	(sizeof(SWAP_SIGNATURE) - 1)
-
 static int all;
 static int priority = -1;	/* non-prioritized swap by default */
 static int discard;		/* don't send swap discards by default */
-- 
1.9.2

