Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46510 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdJWO1H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Oct 2017 10:27:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id l1so17604270wrc.3
        for <util-linux@vger.kernel.org>; Mon, 23 Oct 2017 07:27:07 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] blkid: Add support for LUKS2 and new LABEL attributes.
Date: Mon, 23 Oct 2017 16:26:51 +0200
Message-Id: <20171023142651.15930-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds support for detection of a LUKS2 superblock.

LUKS2 is new version of Linux Unified Key Setup for encrypted
block devices.

LUKS2 contains a binary header and then JSON area for metadata.
Blkid should only parse the binary part, including newly available
optional LABEL and SUBSYSTEM fields.

LABEL is similar to filesystem label. The SUBSYSTEM field is
in principle, just a second label and can be used for specific udev rules
(for example if you have some 3rd party system that activates
volumes automatically, you can mark devices using this attribute).
Both labels are optional.

The magic string and UUID location are intentionally on the same offset
as LUKS v1, so even unpatched blkid now recognizes LUKS2.

Anyway, the code should not parse other versions of the header, so we now
explicitly check for header version and support only version 1 and 2.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 libblkid/src/superblocks/luks.c | 42 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/libblkid/src/superblocks/luks.c b/libblkid/src/superblocks/luks.c
index 00696f28c..bc3d7f558 100644
--- a/libblkid/src/superblocks/luks.c
+++ b/libblkid/src/superblocks/luks.c
@@ -24,6 +24,10 @@
 #define LUKS_SALTSIZE			32
 #define LUKS_MAGIC_L			6
 #define UUID_STRING_L			40
+#define LUKS2_LABEL_L			48
+#define LUKS2_SALT_L			64
+#define LUKS2_CHECKSUM_ALG_L		32
+#define LUKS2_CHECKSUM_L		64
 
 struct luks_phdr {
 	uint8_t		magic[LUKS_MAGIC_L];
@@ -39,17 +43,47 @@ struct luks_phdr {
 	uint8_t		uuid[UUID_STRING_L];
 } __attribute__((packed));
 
+struct luks2_phdr {
+	char		magic[LUKS_MAGIC_L];
+	uint16_t	version;
+	uint64_t	hdr_size;	/* in bytes, including JSON area */
+	uint64_t	seqid;		/* increased on every update */
+	char		label[LUKS2_LABEL_L];
+	char		checksum_alg[LUKS2_CHECKSUM_ALG_L];
+	uint8_t		salt[LUKS2_SALT_L]; /* unique for every header/offset */
+	char		uuid[UUID_STRING_L];
+	char		subsystem[LUKS2_LABEL_L]; /* owner subsystem label */
+	uint64_t	hdr_offset;	/* offset from device start in bytes */
+	char		_padding[184];
+	uint8_t		csum[LUKS2_CHECKSUM_L];
+	/* Padding to 4k, then JSON area */
+} __attribute__ ((packed));
+
 static int probe_luks(blkid_probe pr, const struct blkid_idmag *mag)
 {
-	struct luks_phdr *header;
+	struct luks_phdr *header_v1;
+	struct luks2_phdr *header;
+	int version;
 
-	header = blkid_probe_get_sb(pr, mag, struct luks_phdr);
+	header = blkid_probe_get_sb(pr, mag, struct luks2_phdr);
 	if (header == NULL)
 		return errno ? -errno : 1;
 
-	blkid_probe_strncpy_uuid(pr, (unsigned char *) header->uuid,
-			sizeof(header->uuid));
+	version = be16_to_cpu(header->version);
 	blkid_probe_sprintf_version(pr, "%u", be16_to_cpu(header->version));
+
+	if (version == 1) {
+		header_v1 = (struct luks_phdr *)header;
+		blkid_probe_strncpy_uuid(pr,
+			(unsigned char *) header_v1->uuid, UUID_STRING_L);
+	} else if (version == 2) {
+		blkid_probe_strncpy_uuid(pr,
+			(unsigned char *) header->uuid, UUID_STRING_L);
+		blkid_probe_set_label(pr,
+			(unsigned char *) header->label, LUKS2_LABEL_L);
+		blkid_probe_set_id_label(pr, "SUBSYSTEM",
+			(unsigned char *) header->subsystem, LUKS2_LABEL_L);
+	}
 	return 0;
 }
 
-- 
2.15.0.rc1

