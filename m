Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62161 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:24 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3232421wgh.5
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/14] mkfs.cramfs: use defined failure name rather than magic value
Date: Sun, 13 Jul 2014 21:24:46 +0100
Message-Id: <1405283093-28182-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From manual page; 'On error, the value MAP_FAILED is returned, and errno
is set appropriately'.

Reference: http://man7.org/linux/man-pages/man2/mmap.2.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.cramfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 6f412d8..bae68ec 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -167,11 +167,9 @@ do_mmap(char *path, unsigned int size, unsigned int mode){
 	}
 
 	start = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (-1 == (int) (long) start) {
-		close(fd);
-		err(MKFS_EX_ERROR, "mmap");
-	}
 	close(fd);
+	if (start == MAP_FAILED)
+		err(MKFS_EX_ERROR, "mmap");
 	return start;
 err:
 	free(start);
-- 
2.0.1

