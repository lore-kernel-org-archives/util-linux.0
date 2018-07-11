Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37121 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKKih (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 11 Jul 2018 06:38:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so2019763wmh.2
        for <util-linux@vger.kernel.org>; Wed, 11 Jul 2018 03:34:56 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] blkid: Check for a secondary LUKS2 header.
Date: Wed, 11 Jul 2018 12:34:39 +0200
Message-Id: <20180711103439.10443-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds search for a secondary LUKS2 header,
if the primary one is corrupted.

This patch is primarily needed for wipefs that should wipe
both signatures (otherwise LUKS2 header recovery can use
secondary header and revert wipefs action).

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 libblkid/src/superblocks/luks.c | 60 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/libblkid/src/superblocks/luks.c b/libblkid/src/superblocks/luks.c
index bc3d7f558..67d7cfcc5 100644
--- a/libblkid/src/superblocks/luks.c
+++ b/libblkid/src/superblocks/luks.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2018 Milan Broz <gmazyland@gmail.com>
  *
  * Inspired by libvolume_id by
  *     Kay Sievers <kay.sievers@vrfy.org>
@@ -29,6 +30,15 @@
 #define LUKS2_CHECKSUM_ALG_L		32
 #define LUKS2_CHECKSUM_L		64
 
+#define LUKS_MAGIC	"LUKS\xba\xbe"
+#define LUKS_MAGIC_2	"SKUL\xba\xbe"
+
+/* Offsets for secondary header (for scan if primary header is corrupted). */
+#define LUKS2_HDR2_OFFSETS { 0x04000, 0x008000, 0x010000, 0x020000, \
+                             0x40000, 0x080000, 0x100000, 0x200000, 0x400000 }
+
+static const uint64_t secondary_offsets[] = LUKS2_HDR2_OFFSETS;
+
 struct luks_phdr {
 	uint8_t		magic[LUKS_MAGIC_L];
 	uint16_t	version;
@@ -59,18 +69,16 @@ struct luks2_phdr {
 	/* Padding to 4k, then JSON area */
 } __attribute__ ((packed));
 
-static int probe_luks(blkid_probe pr, const struct blkid_idmag *mag)
+static int luks_attributes(blkid_probe pr, struct luks2_phdr *header, uint64_t offset)
 {
-	struct luks_phdr *header_v1;
-	struct luks2_phdr *header;
 	int version;
+	struct luks_phdr *header_v1;
 
-	header = blkid_probe_get_sb(pr, mag, struct luks2_phdr);
-	if (header == NULL)
-		return errno ? -errno : 1;
+	if (blkid_probe_set_magic(pr, offset, LUKS_MAGIC_L, (unsigned char *) &header->magic))
+		return BLKID_PROBE_NONE;
 
 	version = be16_to_cpu(header->version);
-	blkid_probe_sprintf_version(pr, "%u", be16_to_cpu(header->version));
+	blkid_probe_sprintf_version(pr, "%u", version);
 
 	if (version == 1) {
 		header_v1 = (struct luks_phdr *)header;
@@ -84,7 +92,37 @@ static int probe_luks(blkid_probe pr, const struct blkid_idmag *mag)
 		blkid_probe_set_id_label(pr, "SUBSYSTEM",
 			(unsigned char *) header->subsystem, LUKS2_LABEL_L);
 	}
-	return 0;
+
+	return BLKID_PROBE_OK;
+}
+
+static int probe_luks(blkid_probe pr, const struct blkid_idmag *mag __attribute__((__unused__)))
+{
+	struct luks2_phdr *header;
+	size_t i;
+
+	header = (struct luks2_phdr *) blkid_probe_get_buffer(pr, 0, sizeof(struct luks2_phdr));
+	if (!header)
+		return errno ? -errno : BLKID_PROBE_NONE;
+
+	if (!memcmp(header->magic, LUKS_MAGIC, LUKS_MAGIC_L)) {
+		/* LUKS primary header was found. */
+		return luks_attributes(pr, header, 0);
+	} else {
+		/* No primary header, scan for known offsets of LUKS2 secondary header. */
+		for (i = 0; i < ARRAY_SIZE(secondary_offsets); i++) {
+			header = (struct luks2_phdr *) blkid_probe_get_buffer(pr,
+				  secondary_offsets[i], sizeof(struct luks2_phdr));
+
+			if (!header)
+				return errno ? -errno : BLKID_PROBE_NONE;
+
+			if (!memcmp(header->magic, LUKS_MAGIC_2, LUKS_MAGIC_L))
+				return luks_attributes(pr, header, secondary_offsets[i]);
+		}
+	}
+
+	return BLKID_PROBE_NONE;
 }
 
 const struct blkid_idinfo luks_idinfo =
@@ -92,9 +130,5 @@ const struct blkid_idinfo luks_idinfo =
 	.name		= "crypto_LUKS",
 	.usage		= BLKID_USAGE_CRYPTO,
 	.probefunc	= probe_luks,
-	.magics		=
-	{
-		{ .magic = "LUKS\xba\xbe", .len = 6 },
-		{ NULL }
-	}
+	.magics		= BLKID_NONE_MAGIC
 };
-- 
2.18.0

