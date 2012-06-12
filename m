Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2FLLSX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 07:18:23 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5CBINr1001294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 12 Jun 2012 07:18:23 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: dm-devel@redhat.com, Milan Broz <mbroz@redhat.com>
Subject: [PATCH] libblkid: update dm-verity scan
Date: Tue, 12 Jun 2012 13:18:02 +0200
Message-Id: <1339499882-1432-1-git-send-email-mbroz@redhat.com>
In-Reply-To: <1338550448-13005-1-git-send-email-mbroz@redhat.com>
References: <1338550448-13005-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

New superblock now contains UUID. Old version is not going to be used.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 libblkid/src/superblocks/lvm.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index 57d2b6e..0afc773 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -143,31 +143,36 @@ static int probe_lvm1(blkid_probe pr, const struct blkid_idmag *mag)
 	return 0;
 }
 
-#define MAX_SALT_SIZE 384
 struct verity_sb {
-	uint8_t signature[8];
-	uint8_t version;
-	uint8_t data_block_bits;
-	uint8_t hash_block_bits;
-	uint8_t pad1[1];
-	uint16_t salt_size;
-	uint8_t pad2[2];
-	uint32_t data_blocks_hi;
-	uint32_t data_blocks_lo;
-	uint8_t algorithm[16];
-	uint8_t salt[MAX_SALT_SIZE];
-	uint8_t pad3[88];
+	uint8_t  signature[8];	/* "verity\0\0" */
+	uint32_t version;	/* superblock version */
+	uint32_t hash_type;	/* 0 - Chrome OS, 1 - normal */
+	uint8_t  uuid[16];	/* UUID of hash device */
+	uint8_t  algorithm[32];/* hash algorithm name */
+	uint32_t data_block_size; /* data block in bytes */
+	uint32_t hash_block_size; /* hash block in bytes */
+	uint64_t data_blocks;	/* number of data blocks */
+	uint16_t salt_size;	/* salt size */
+	uint8_t  _pad1[6];
+	uint8_t  salt[256];	/* salt */
+	uint8_t  _pad2[168];
 } __attribute__((packed));
 
 static int probe_verity(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct verity_sb *sb;
+	unsigned int version;
 
 	sb = blkid_probe_get_sb(pr, mag, struct verity_sb);
 	if (sb == NULL)
 		return -1;
 
-	blkid_probe_sprintf_version(pr, "%u", sb->version);
+	version = le32_to_cpu(sb->version);
+	if (version != 1)
+		return 1;
+
+	blkid_probe_set_uuid(pr, sb->uuid);
+	blkid_probe_sprintf_version(pr, "%u", version);
 	return 0;
 }
 
-- 
1.7.10

