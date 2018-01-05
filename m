Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeAERPl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 Jan 2018 12:15:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F52583F46
        for <util-linux@vger.kernel.org>; Fri,  5 Jan 2018 17:15:41 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-116-224.phx2.redhat.com [10.3.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F8035DA2A
        for <util-linux@vger.kernel.org>; Fri,  5 Jan 2018 17:15:40 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH RFC 1/1] libblkid: Add support for stratis
Date: Fri,  5 Jan 2018 11:15:39 -0600
Message-Id: <20180105171539.5948-2-tasleson@redhat.com>
In-Reply-To: <20180105171539.5948-1-tasleson@redhat.com>
References: <20180105171539.5948-1-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Initial support for stratis, ref.
https://github.com/stratis-storage

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 libblkid/src/Makemodule.am             |   1 +
 libblkid/src/superblocks/stratis.c     | 104 +++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |   1 +
 libblkid/src/superblocks/superblocks.h |   1 +
 4 files changed, 107 insertions(+)
 create mode 100644 libblkid/src/superblocks/stratis.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 415c9f408..65d2e66ed 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -82,6 +82,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/romfs.c \
 	libblkid/src/superblocks/silicon_raid.c \
 	libblkid/src/superblocks/squashfs.c \
+	libblkid/src/superblocks/stratis.c \
 	libblkid/src/superblocks/superblocks.c \
 	libblkid/src/superblocks/superblocks.h \
 	libblkid/src/superblocks/swap.c \
diff --git a/libblkid/src/superblocks/stratis.c b/libblkid/src/superblocks/stratis.c
new file mode 100644
index 000000000..ae23b0fa1
--- /dev/null
+++ b/libblkid/src/superblocks/stratis.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2018 Tony Asleson <tasleson@redhat.com>
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+/*
+ * Specification for on disk format
+ * https://stratis-storage.github.io/StratisSoftwareDesign.pdf
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+
+#include "superblocks.h"
+#include "crc32c.h"
+
+struct stratis_sb {
+	uint32_t crc32;
+	uint8_t magic[16];
+	uint64_t sectors;
+	uint8_t reserved[4];
+	uint8_t pool_uuid[32];
+	uint8_t dev_uuid[32];
+	uint64_t mda_size;
+	uint64_t reserved_size;
+	uint64_t flags;
+	uint64_t initialization_time;
+} __attribute__ ((__packed__));
+
+#define BS 512
+#define FIRST_COPY_OFFSET BS
+#define SECOND_COPY_OFFSET (BS * 9)
+#define SB_AREA_SIZE (BS * 16)
+
+const char STRATIS_MAGIC[] = "!Stra0tis\x86\xff\x02^\x41rh";
+#define MAGIC_LEN (sizeof(STRATIS_MAGIC) - 1)
+
+#define _MAGIC_OFFSET (offsetof(const struct stratis_sb, magic))
+#define MAGIC_OFFSET_COPY_1 (FIRST_COPY_OFFSET + _MAGIC_OFFSET)
+#define MAGIC_OFFSET_COPY_2 (SECOND_COPY_OFFSET + _MAGIC_OFFSET)
+
+static int stratis_valid_sb(blkid_probe pr, uint8_t *p)
+{
+	const struct stratis_sb *stratis = (const struct stratis_sb *)p;
+	uint32_t crc = 0;
+
+	// generate CRC from byte position 4 for length 508 == 512 byte sector
+	crc = crc32c(~0L, p + sizeof(stratis->crc32),
+			BS - sizeof(stratis->crc32));
+	crc ^= ~0L;
+
+	return blkid_probe_verify_csum(pr, crc, le32_to_cpu(stratis->crc32));
+}
+
+static int probe_stratis(blkid_probe pr,
+		const struct blkid_idmag *mag __attribute__((__unused__)))
+{
+	const struct stratis_sb *stratis = NULL;
+	uint8_t *buf = blkid_probe_get_buffer(pr, 0, SB_AREA_SIZE);
+
+	if (!buf)
+		return errno ? -errno : 1;
+
+	if (stratis_valid_sb(pr, buf + FIRST_COPY_OFFSET)) {
+		stratis = (const struct stratis_sb *)(buf + FIRST_COPY_OFFSET);
+	} else {
+		if (!stratis_valid_sb(pr, buf + SECOND_COPY_OFFSET))
+			return 1;
+
+		stratis = (const struct stratis_sb *)
+				(buf + SECOND_COPY_OFFSET);
+	}
+
+	blkid_probe_strncpy_uuid(pr, (unsigned char *)stratis->dev_uuid,
+					sizeof(stratis->dev_uuid));
+	blkid_probe_set_value(pr, "POOL_UUID",
+				(unsigned char *)stratis->pool_uuid,
+				sizeof(stratis->pool_uuid));
+
+	blkid_probe_sprintf_value(pr, "SECTORS", "%" PRIu64, stratis->sectors);
+	blkid_probe_sprintf_value(pr, "INITIALIZATION_TIME", "%" PRIu64,
+					stratis->initialization_time);
+
+	return 0;
+}
+
+const struct blkid_idinfo stratis_idinfo = {
+	.name		= "stratis",
+	.usage		= BLKID_USAGE_RAID,
+	.probefunc	= probe_stratis,
+	.minsz		= SB_AREA_SIZE,
+	.magics		= {
+		{ .magic = STRATIS_MAGIC, .len = MAGIC_LEN,
+			.sboff = MAGIC_OFFSET_COPY_1},
+		{ .magic = STRATIS_MAGIC, .len = MAGIC_LEN,
+			.sboff = MAGIC_OFFSET_COPY_2},
+		{ NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 4387ab9e5..076541d1a 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -114,6 +114,7 @@ static const struct blkid_idinfo *idinfos[] =
 	&vmfs_volume_idinfo,
 	&ubi_idinfo,
 	&vdo_idinfo,
+	&stratis_idinfo,
 
 	/* Filesystems */
 	&vfat_idinfo,
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 38f6a8a65..2723fb1d5 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -80,6 +80,7 @@ extern const struct blkid_idinfo f2fs_idinfo;
 extern const struct blkid_idinfo bcache_idinfo;
 extern const struct blkid_idinfo mpool_idinfo;
 extern const struct blkid_idinfo vdo_idinfo;
+extern const struct blkid_idinfo stratis_idinfo;
 
 /*
  * superblock functions
-- 
2.13.6

