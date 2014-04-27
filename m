Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43702 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:08 -0400
Received: by mail-wi0-f181.google.com with SMTP id hm4so4740016wib.2
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/12] mkswap: remove legacy swap structure
Date: Sun, 27 Apr 2014 21:05:32 +0100
Message-Id: <1398629138-31718-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If software archeolgists want to know how the old, and unused, swap
header looked they can dig it from the revision history.

Reference: 4c85aa3a4c26f2a2c33bf16960b548d5bbd5b4bf
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c  |  3 +--
 include/swapheader.h | 11 +----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index cd96ad5..830b14c 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -186,8 +186,7 @@ write_uuid_and_label(unsigned char *uuid, char *volume_name)
 	struct swap_header_v1_2 *h;
 
 	/* Sanity check */
-	if (sizeof(struct swap_header_v1) !=
-	    sizeof(struct swap_header_v1_2)) {
+	if (sizeof(struct swap_header_v1_2) != SWAP_HEADER_SIZE) {
 		warnx(_("Bad swap header size, no label written."));
 		return;
 	}
diff --git a/include/swapheader.h b/include/swapheader.h
index 80fa36b..1fdd133 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -1,19 +1,10 @@
 #ifndef _SWAPHEADER_H
 #define _SWAPHEADER_H
 
-struct swap_header_v1 {
-        char         bootbits[1024];    /* Space for disklabel etc. */
-	unsigned int version;
-	unsigned int last_page;
-	unsigned int nr_badpages;
-	unsigned int padding[125];
-	unsigned int badpages[1];
-};
-
-
 #define SWAP_VERSION 1
 #define SWAP_UUID_LENGTH 16
 #define SWAP_LABEL_LENGTH 16
+#define SWAP_HEADER_SIZE 1540
 
 struct swap_header_v1_2 {
 	char	      bootbits[1024];    /* Space for disklabel etc. */
-- 
1.9.2

