Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33119 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHAODe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2017 10:03:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id 65so1597562lfa.0
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2017 07:03:33 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] libblkid: add support for UBI superblock
Date: Tue,  1 Aug 2017 16:03:09 +0200
Message-Id: <20170801140309.17646-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Rafał Miłecki <rafal@milecki.pl>

Detecting UBI superblock may be useful for tools wanting to simplify or
automate attaching UBI. Please note it's not directly related to the
ubifs support which is just a filesystem working on top of UBI volume.

This patch adds simple code reading UBI version and unique number and
setting it in the blkid_probe.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 libblkid/src/Makemodule.am             |  1 +
 libblkid/src/superblocks/superblocks.c |  1 +
 libblkid/src/superblocks/superblocks.h |  1 +
 libblkid/src/superblocks/ubi.c         | 50 ++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 libblkid/src/superblocks/ubi.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 2b70742bc..8dfe892ff 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -85,6 +85,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/superblocks.h \
 	libblkid/src/superblocks/swap.c \
 	libblkid/src/superblocks/sysv.c \
+	libblkid/src/superblocks/ubi.c \
 	libblkid/src/superblocks/ubifs.c \
 	libblkid/src/superblocks/udf.c \
 	libblkid/src/superblocks/ufs.c \
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 88578c8db..cb887f8f1 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -152,6 +152,7 @@ static const struct blkid_idinfo *idinfos[] =
 	&squashfs3_idinfo,
 	&netware_idinfo,
 	&btrfs_idinfo,
+	&ubi_idinfo,
 	&ubifs_idinfo,
 	&bfs_idinfo,
 	&vmfs_fs_idinfo,
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index ea875d768..695c3b783 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -64,6 +64,7 @@ extern const struct blkid_idinfo netware_idinfo;
 extern const struct blkid_idinfo sysv_idinfo;
 extern const struct blkid_idinfo xenix_idinfo;
 extern const struct blkid_idinfo btrfs_idinfo;
+extern const struct blkid_idinfo ubi_idinfo;
 extern const struct blkid_idinfo ubifs_idinfo;
 extern const struct blkid_idinfo zfs_idinfo;
 extern const struct blkid_idinfo bfs_idinfo;
diff --git a/libblkid/src/superblocks/ubi.c b/libblkid/src/superblocks/ubi.c
new file mode 100644
index 000000000..8b93b5dac
--- /dev/null
+++ b/libblkid/src/superblocks/ubi.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+
+#include "superblocks.h"
+
+struct ubi_ec_hdr {
+	uint32_t	magic;
+	uint8_t		version;
+	uint8_t		padding1[3];
+	uint64_t	ec;
+	uint32_t	vid_hdr_offset;
+	uint32_t	data_offset;
+	uint32_t	image_seq;
+	uint8_t		padding2[32];
+	uint32_t	hdr_crc;
+} __attribute__((packed));
+
+static int probe_ubi(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct ubi_ec_hdr *hdr;
+
+	hdr = blkid_probe_get_sb(pr, mag, struct ubi_ec_hdr);
+	if (!hdr)
+		return -1;
+
+	blkid_probe_sprintf_version(pr, "%u", hdr->version);
+	blkid_probe_sprintf_uuid(pr, NULL, 4, "%u", be32_to_cpu(hdr->image_seq));
+	return 0;
+}
+
+const struct blkid_idinfo ubi_idinfo =
+{
+	.name		= "ubi",
+	.usage		= BLKID_USAGE_FILESYSTEM,
+	.probefunc	= probe_ubi,
+	.magics		=
+	{
+		{ .magic = "UBI#", .len = 4 },
+		{ NULL }
+	}
+};
-- 
2.11.0

