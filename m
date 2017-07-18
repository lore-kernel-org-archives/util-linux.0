Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36717 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdGRLJU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 18 Jul 2017 07:09:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so1773353wrb.3
        for <util-linux@vger.kernel.org>; Tue, 18 Jul 2017 04:09:20 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] blkid: Add dm-integrity superblock signature
Date: Tue, 18 Jul 2017 13:08:23 +0200
Message-Id: <20170718110823.6716-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since the kernel version 4.12 there is a new dm-integrity module
that provides an emulated per-sector metadata format for storing data integrity.

This patch adds dm-integrity magic signature to blkid to recognize such
a block device.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 libblkid/src/superblocks/lvm.c         | 38 ++++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |  1 +
 libblkid/src/superblocks/superblocks.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index b94d7b5d8..17731a8fd 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -174,6 +174,32 @@ static int probe_verity(blkid_probe pr, const struct blkid_idmag *mag)
 	return 0;
 }
 
+struct integrity_sb {
+	uint8_t  magic[8];
+	uint8_t  version;
+	int8_t   log2_interleave_sectors;
+	uint16_t integrity_tag_size;
+	uint32_t journal_sections;
+	uint64_t provided_data_sectors;
+	uint32_t flags;
+	uint8_t  log2_sectors_per_block;
+} __attribute__ ((packed));
+
+static int probe_integrity(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct integrity_sb *sb;
+
+	sb = blkid_probe_get_sb(pr, mag, struct integrity_sb);
+	if (sb == NULL)
+		return errno ? -errno : 1;
+
+	if (sb->version != 1)
+		return 1;
+
+	blkid_probe_sprintf_version(pr, "%u", sb->version);
+	return 0;
+}
+
 /* NOTE: the original libblkid uses "lvm2pv" as a name */
 const struct blkid_idinfo lvm2_idinfo =
 {
@@ -224,3 +250,15 @@ const struct blkid_idinfo verity_hash_idinfo =
 		{ NULL }
 	}
 };
+
+const struct blkid_idinfo integrity_idinfo =
+{
+	.name		= "DM_integrity",
+	.usage		= BLKID_USAGE_CRYPTO,
+	.probefunc	= probe_integrity,
+	.magics		=
+	{
+		{ .magic = "integrt\0", .len = 8 },
+		{ NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 341cd8a6f..c4ff4a271 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -109,6 +109,7 @@ static const struct blkid_idinfo *idinfos[] =
 	&lvm1_idinfo,
 	&snapcow_idinfo,
 	&verity_hash_idinfo,
+	&integrity_idinfo,
 	&luks_idinfo,
 	&vmfs_volume_idinfo,
 
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 79dba1a3c..7e0cec5a7 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -53,6 +53,7 @@ extern const struct blkid_idinfo lvm2_idinfo;
 extern const struct blkid_idinfo lvm1_idinfo;
 extern const struct blkid_idinfo snapcow_idinfo;
 extern const struct blkid_idinfo verity_hash_idinfo;
+extern const struct blkid_idinfo integrity_idinfo;
 extern const struct blkid_idinfo luks_idinfo;
 extern const struct blkid_idinfo highpoint37x_idinfo;
 extern const struct blkid_idinfo highpoint45x_idinfo;
-- 
2.13.2

