Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f47.google.com ([209.85.215.47]:51209 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab3BKVXz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 16:23:55 -0500
Received: by mail-la0-f47.google.com with SMTP id fj20so6140837lab.6
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 13:23:54 -0800 (PST)
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: util-linux@vger.kernel.org
Cc: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: [PATCH 1/2] libblkid: Don't keep reading same sector of ISO
Date: Mon, 11 Feb 2013 23:22:11 +0200
Message-Id: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>

We were reading the same sector over and over again when parsing ISO9660.
This patches fixes it.
---
 libblkid/src/superblocks/iso9660.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/iso9660.c b/libblkid/src/superblocks/iso9660.c
index f7d2b76..33a8597 100644
--- a/libblkid/src/superblocks/iso9660.c
+++ b/libblkid/src/superblocks/iso9660.c
@@ -167,8 +167,10 @@ static int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
 
 		if (iso == NULL || iso->vd_type == ISO_VD_END)
 			break;
-		if (iso->vd_type != ISO_VD_SUPPLEMENTARY)
+		if (iso->vd_type != ISO_VD_SUPPLEMENTARY) {
+			off += ISO_SECTOR_SIZE;
 			continue;
+      }
 
 		if (memcmp(iso->escape_sequences, "%/@", 3) == 0 ||
 		    memcmp(iso->escape_sequences, "%/C", 3) == 0 ||
-- 
1.8.1.2

