Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f177.google.com ([209.85.215.177]:44460 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3GGTy6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:54:58 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so2495401eak.22
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:54:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/34] sfdisk: make unhiding as complete as possible
Date: Sun,  7 Jul 2013 20:54:16 +0100
Message-Id: <1373226889-3451-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is unlikely anyone will ever need this, but I like idea commands being
complete.  The partition id's that can be unhide after this change are;

Hidden HPFS/NTFS
Hidden W95 FAT32
Hidden W95 FAT32 (LBA)
Hidden W95 FAT16 (LBA)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 6efef47..6b757a7 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -2992,7 +2992,8 @@ set_unhidden(struct disk_desc *z, char *pnam) {
 
     pno = asc_to_index(pnam, z);
     id = z->partitions[pno].p.sys_type;
-    if (id == 0x11 || id == 0x14 || id == 0x16 || id == 0x17)
+    if (id == 0x11 || id == 0x14 || id == 0x16 || id == 0x17 ||
+	id == 0x17 || id == 0x1b || id == 0x1c || id == 0x1e)
 	id -= 0x10;
     else
 	errx(EXIT_FAILURE, _("partition %s has id %x and is not hidden"), pnam, id);
-- 
1.8.3.2

