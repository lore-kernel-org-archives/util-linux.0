Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758921Ab2FALe2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 07:34:28 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51BYR25019117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 1 Jun 2012 07:34:28 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: dm-devel@redhat.com, Milan Broz <mbroz@redhat.com>
Subject: [PATCH] Add dm-verity hash device detection to blkid.
Date: Fri,  1 Jun 2012 13:34:08 +0200
Message-Id: <1338550448-13005-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

dm-verity can use separate device for hash verification,
in this case there is a superblock in the first sector.

See
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/device-mapper/verity.txt
for more info.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 libblkid/src/superblocks/lvm.c         |   41 ++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |    1 +
 libblkid/src/superblocks/superblocks.h |    1 +
 3 files changed, 43 insertions(+)

diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index 3a9807c..57d2b6e 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001 by Andreas Dilger
  * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
  * Copyright (C) 2008 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2012 Milan Broz <mbroz@redhat.com>
  *
  * This file may be redistributed under the terms of the
  * GNU Lesser General Public License.
@@ -142,6 +143,34 @@ static int probe_lvm1(blkid_probe pr, const struct blkid_idmag *mag)
 	return 0;
 }
 
+#define MAX_SALT_SIZE 384
+struct verity_sb {
+	uint8_t signature[8];
+	uint8_t version;
+	uint8_t data_block_bits;
+	uint8_t hash_block_bits;
+	uint8_t pad1[1];
+	uint16_t salt_size;
+	uint8_t pad2[2];
+	uint32_t data_blocks_hi;
+	uint32_t data_blocks_lo;
+	uint8_t algorithm[16];
+	uint8_t salt[MAX_SALT_SIZE];
+	uint8_t pad3[88];
+} __attribute__((packed));
+
+static int probe_verity(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct verity_sb *sb;
+
+	sb = blkid_probe_get_sb(pr, mag, struct verity_sb);
+	if (sb == NULL)
+		return -1;
+
+	blkid_probe_sprintf_version(pr, "%u", sb->version);
+	return 0;
+}
+
 /* NOTE: the original libblkid uses "lvm2pv" as a name */
 const struct blkid_idinfo lvm2_idinfo =
 {
@@ -180,3 +209,15 @@ const struct blkid_idinfo snapcow_idinfo =
 		{ NULL }
 	}
 };
+
+const struct blkid_idinfo verity_hash_idinfo =
+{
+	.name		= "DM_verity_hash",
+	.usage		= BLKID_USAGE_CRYPTO,
+	.probefunc	= probe_verity,
+	.magics		=
+	{
+		{ .magic = "verity\0\0", .len = 8 },
+		{ NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 91f4f88..879a40f 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -96,6 +96,7 @@ static const struct blkid_idinfo *idinfos[] =
 	&lvm2_idinfo,
 	&lvm1_idinfo,
 	&snapcow_idinfo,
+	&verity_hash_idinfo,
 	&luks_idinfo,
 	&vmfs_volume_idinfo,
 
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index c97e447..086a568 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -50,6 +50,7 @@ extern const struct blkid_idinfo hpfs_idinfo;
 extern const struct blkid_idinfo lvm2_idinfo;
 extern const struct blkid_idinfo lvm1_idinfo;
 extern const struct blkid_idinfo snapcow_idinfo;
+extern const struct blkid_idinfo verity_hash_idinfo;
 extern const struct blkid_idinfo luks_idinfo;
 extern const struct blkid_idinfo highpoint37x_idinfo;
 extern const struct blkid_idinfo highpoint45x_idinfo;
-- 
1.7.10

