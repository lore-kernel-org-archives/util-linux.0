Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36807 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdHBMPU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Aug 2017 08:15:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id t128so3659055lff.3
        for <util-linux@vger.kernel.org>; Wed, 02 Aug 2017 05:15:20 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] libblkid: add support for UBI superblock
Date: Wed,  2 Aug 2017 14:14:18 +0200
Message-Id: <20170802121418.10628-1-zajec5@gmail.com>
In-Reply-To: <20170801140309.17646-1-zajec5@gmail.com>
References: <20170801140309.17646-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Rafał Miłecki <rafal@milecki.pl>

UBI is a volume management system that can be used on a raw flash
partition for providing multiple logical volumes. Detecting UBI
superblock may be useful for tools wanting to simplify or automate
attaching UBI.

Please note it's not directly related to the ubifs support which is just
a filesystem working on top of UBI volume.

In other words: UBI can be used on MTD partition (e.g. /dev/mtdblock0)
while ubifs can be used on UBI volume (e.g. /dev/ubi0_0).

This patch adds simple code reading UBI version and unique number and
setting it in the blkid_probe.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Update commit message (more UBI vs. ubifs details)
    Pass &hdr->image_seq to the blkid_probe_sprintf_uuid
    Add test
---
 libblkid/src/Makemodule.am             |   1 +
 libblkid/src/superblocks/superblocks.c |   1 +
 libblkid/src/superblocks/superblocks.h |   1 +
 libblkid/src/superblocks/ubi.c         |  51 +++++++++++++++++++++++++++++++++
 tests/expected/blkid/low-probe-ubi     |   5 ++++
 tests/ts/blkid/images-fs/ubi.img.xz    | Bin 0 -> 136 bytes
 6 files changed, 59 insertions(+)
 create mode 100644 libblkid/src/superblocks/ubi.c
 create mode 100644 tests/expected/blkid/low-probe-ubi
 create mode 100644 tests/ts/blkid/images-fs/ubi.img.xz

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
index 000000000..ee2644792
--- /dev/null
+++ b/libblkid/src/superblocks/ubi.c
@@ -0,0 +1,51 @@
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
+	blkid_probe_sprintf_uuid(pr, (unsigned char *)&hdr->image_seq, 4, "%u",
+				 be32_to_cpu(hdr->image_seq));
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
diff --git a/tests/expected/blkid/low-probe-ubi b/tests/expected/blkid/low-probe-ubi
new file mode 100644
index 000000000..318a35152
--- /dev/null
+++ b/tests/expected/blkid/low-probe-ubi
@@ -0,0 +1,5 @@
+ID_FS_TYPE=ubi
+ID_FS_USAGE=filesystem
+ID_FS_UUID=1329411831
+ID_FS_UUID_ENC=1329411831
+ID_FS_VERSION=1
diff --git a/tests/ts/blkid/images-fs/ubi.img.xz b/tests/ts/blkid/images-fs/ubi.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..ed3b3f4260f543608887d7cf09c9ff8fec8a7f1b
GIT binary patch
literal 136
zcmexsUKJ6=z`*kC+7>q^21Q0O1_p)_{ill`$p2?>jb+f9(CWul(ej4RWS(FA_j9dN
z(smqrqi{nbSMJ?3yNB5tZQ?r?Mrd4W6HgS&b;)>R@gwNIW<|r6?CWK@fgXCx7W1fm
n<p7$<z!2G>;%M<%&4qz6vB3ez?|s0pwed*$Zzhl=OJo!PP&YE!

literal 0
HcmV?d00001

-- 
2.11.0

