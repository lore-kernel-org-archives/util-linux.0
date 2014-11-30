Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43009 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaK3N6M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:12 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so22207052wib.4
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/10] mkfs.cramfs: fix unsigned integer overflow [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:39 +0000
Message-Id: <1417355862-16935-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/mkfs.cramfs.c:622:20: runtime error: unsigned integer
overflow: 64 - 512 cannot be represented in type 'unsigned long'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.cramfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index bae68ec..d9a9153 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -619,7 +619,10 @@ do_compress(char *base, unsigned int offset, unsigned char const *name,
 	/* TODO: Arguably, original_size in these 2 lines should be
 	   st_blocks * 512.  But if you say that, then perhaps
 	   administrative data should also be included in both. */
-	change = new_size - original_size;
+	if (new_size <= original_size)
+		change = new_size - original_size;
+	else
+		change = new_size;
 	if (verbose)
 		printf(_("%6.2f%% (%+ld bytes)\t%s\n"),
 		       (change * 100) / (double) original_size, change, name);
-- 
2.1.3

