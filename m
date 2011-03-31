Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:38806 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab1CaPAS (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 Mar 2011 11:00:18 -0400
Received: from homiemail-a10.g.dreamhost.com (caiajhbdcahe.dreamhost.com [208.97.132.74])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 970CB17A429
	for <util-linux-ng@vger.kernel.org>; Thu, 31 Mar 2011 08:00:17 -0700 (PDT)
Subject: [PATCH 1/3] mkfs.minix: add support for mkfs3
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 11:59:29 -0300
Message-ID: <1301583569.2159.15.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add superblock layout for minix3 filesystem support.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/minix.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/disk-utils/minix.h b/disk-utils/minix.h
index 638565e..8952792 100644
--- a/disk-utils/minix.h
+++ b/disk-utils/minix.h
@@ -44,6 +44,24 @@ struct minix_super_block {
         u32 s_zones;
 };
 
+/* V3 minix super-block data on disk */
+struct minix3_super_block {
+	u32 s_ninodes;
+	u16 s_pad0;
+	u16 s_imap_blocks;
+	u16 s_zmap_blocks;
+	u16 s_firstdatazone;
+	u16 s_log_zone_size;
+	u16 s_pad1;
+	u32 s_max_size;
+	u32 s_zones;
+	u16 s_magic;
+	u16 s_pad2;
+	u16 s_blocksize;
+	u8  s_disk_version;
+        u16 s_state;
+};
+
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
@@ -59,5 +77,6 @@ struct minix_super_block {
 #define MINIX_SUPER_MAGIC2   0x138F          /* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC   0x2468	     /* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2  0x2478	     /* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC   0x4d5a	     /* minix V3 fs (60 char names) */
 
 #endif /* KERNEL_INCLUDES_ARE_CLEAN */
-- 
1.7.1




