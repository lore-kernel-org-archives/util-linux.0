Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout.micron.com ([137.201.242.129]:43085 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdKPFCY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Nov 2017 00:02:24 -0500
From: <jgroves@micron.com>
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <John@Groves.net>,
        John Groves <jgroves@micron.com>
Subject: [PATCH v3 2/2] Add support for Micron mpool formatted drives
Date: Wed, 15 Nov 2017 23:01:39 -0600
Message-ID: <1510808499-7680-3-git-send-email-jgroves@micron.com>
In-Reply-To: <1510808499-7680-1-git-send-email-jgroves@micron.com>
References: <1510808499-7680-1-git-send-email-jgroves@micron.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: John Groves <jgroves@micron.com>

---
 libblkid/src/Makemodule.am             |  1 +
 libblkid/src/superblocks/mpool.c       | 66 ++++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |  3 +-
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 libblkid/src/superblocks/mpool.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 1fa00e9..ceece42 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -70,6 +70,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/luks.c \
 	libblkid/src/superblocks/lvm.c \
 	libblkid/src/superblocks/minix.c \
+	libblkid/src/superblocks/mpool.c \
 	libblkid/src/superblocks/netware.c \
 	libblkid/src/superblocks/nilfs.c \
 	libblkid/src/superblocks/ntfs.c \
diff --git a/libblkid/src/superblocks/mpool.c b/libblkid/src/superblocks/mpool.c
new file mode 100644
index 0000000..5f30fd4
--- /dev/null
+++ b/libblkid/src/superblocks/mpool.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2016 Micron Technology, Inc.
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+#include "crc32c.h"
+#include "superblocks.h"
+
+#include <uuid.h>
+
+#define MAX_MPOOL_NAME_LEN 32
+
+struct omf_sb_descriptor {
+	uint64_t        osb_magic;
+	uint8_t         osb_name[MAX_MPOOL_NAME_LEN];
+	uuid_t          osb_poolid; /* UUID of pool this drive belongs to */
+	uint16_t        osb_vers;
+	uint32_t        osb_gen;
+	uint32_t        osb_cksum1; /* crc32c of the preceding fields */
+} __attribute__((packed));
+
+static int probe_mpool(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct omf_sb_descriptor *osd;
+	uint32_t sb_crc;
+
+	osd = blkid_probe_get_sb(pr, mag, struct omf_sb_descriptor);
+	if (!osd)
+		return errno ? -errno : 1;
+
+	sb_crc = crc32c(~0L, (const void *)osd,
+			offsetof(struct omf_sb_descriptor, osb_cksum1));
+	sb_crc ^= ~0L;
+
+	if (!blkid_probe_verify_csum(pr, sb_crc, osd->osb_cksum1))
+		return 1;
+
+	blkid_probe_set_label(pr, osd->osb_name, sizeof(osd->osb_name));
+	blkid_probe_set_uuid(pr, osd->osb_poolid);
+
+	return 0;
+}
+
+/**
+ * Superblock (sb) -- magic = ASCII "mpoolDev"
+ */
+#define MPOOL_SB_MAGIC "\x6D\x70\x6f\x6f\x6c\x44\x65\x76"
+
+const struct blkid_idinfo mpool_idinfo =
+{
+	.name		= "mpool",
+	.usage		= BLKID_USAGE_FILESYSTEM,
+	.probefunc	= probe_mpool,
+	.magics		=
+	{
+		{ .magic = MPOOL_SB_MAGIC, .len = 8},
+		{ NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 341cd8a..3123d53 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -156,7 +156,8 @@ static const struct blkid_idinfo *idinfos[] =
 	&befs_idinfo,
 	&nilfs2_idinfo,
 	&exfat_idinfo,
-	&f2fs_idinfo
+	&f2fs_idinfo,
+	&mpool_idinfo
 };
 
 /*
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 79dba1a..5b5c6c2 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -75,6 +75,7 @@ extern const struct blkid_idinfo nilfs2_idinfo;
 extern const struct blkid_idinfo exfat_idinfo;
 extern const struct blkid_idinfo f2fs_idinfo;
 extern const struct blkid_idinfo bcache_idinfo;
+extern const struct blkid_idinfo mpool_idinfo;
 
 /*
  * superblock functions
-- 
2.9.3

