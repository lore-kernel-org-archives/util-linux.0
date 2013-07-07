Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f176.google.com ([209.85.215.176]:52167 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:51 -0400
Received: by mail-ea0-f176.google.com with SMTP id z15so2462636ead.21
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/34] mkfs.cramfs: argument to free() is a constant address [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:33 +0100
Message-Id: <1373226889-3451-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.cramfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index fdc2cae..ebc8112 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -168,7 +168,6 @@ do_mmap(char *path, unsigned int size, unsigned int mode){
 
 	start = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (-1 == (int) (long) start) {
-		free(start);
 		close(fd);
 		err(MKFS_EX_ERROR, "mmap");
 	}
-- 
1.8.3.2

