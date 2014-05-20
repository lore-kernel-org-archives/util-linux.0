Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:59465 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbaETKXi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 06:23:38 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>, Miklos Szeredi <mszeredi@suse.cz>
Subject: [PATCH] libblkid: detect squashfs 3 vs 4
Date: Tue, 20 May 2014 10:23:33 +0000
Message-Id: <1400581413-17456-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Detect squashfs version <= 3 as squashfs3 and version >= 4 as squashfs.

squashfs kernel module version 4.0 (kernel 2.6.29) is not backward
compatible to open squashfs created with previous versions.

Also fixed version number parsing, see
$  mkdir test
$  mksquashfs test test.sqsh
$  blkid -p test.sqsh
- test.sqsh: VERSION="1024.0" TYPE="squashfs" USAGE="filesystem"
+ test.sqsh: VERSION="4.0" TYPE="squashfs" USAGE="filesystem"

This patch comes from openSUSE / SLE. Original author was probably
Miklos Szeredi.
Internal SUSE references: bnc#666893, sr226509

CC: Stanislav Brabec <sbrabec@suse.cz>
CC: Miklos Szeredi <mszeredi@suse.cz>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/superblocks/squashfs.c    | 63 ++++++++++++++++++++++++++--------
 libblkid/src/superblocks/superblocks.c |  1 +
 libblkid/src/superblocks/superblocks.h |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/libblkid/src/superblocks/squashfs.c b/libblkid/src/superblocks/squashfs.c
index 595c8e2..a35d60f 100644
--- a/libblkid/src/superblocks/squashfs.c
+++ b/libblkid/src/superblocks/squashfs.c
@@ -31,20 +31,46 @@ struct sqsh_super_block {
 static int probe_squashfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct sqsh_super_block *sq;
+	uint16_t major;
+	uint16_t minor;
 
 	sq = blkid_probe_get_sb(pr, mag, struct sqsh_super_block);
 	if (!sq)
 		return errno ? -errno : 1;
 
-	if (strcmp(mag->magic, "sqsh") == 0 ||
-	    strcmp(mag->magic, "qshs") == 0)
-		blkid_probe_sprintf_version(pr, "%u.%u",
-				sq->s_major,
-				sq->s_minor);
-	else
-		blkid_probe_sprintf_version(pr, "%u.%u",
-				swab16(sq->s_major),
-				swab16(sq->s_minor));
+	major = le16_to_cpu(sq->s_major);
+	minor = le16_to_cpu(sq->s_minor);
+	if (major < 4)
+		return -1;
+
+	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);
+
+	return 0;
+}
+
+static int probe_squashfs3(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct sqsh_super_block *sq;
+	uint16_t major;
+	uint16_t minor;
+
+	sq = blkid_probe_get_sb(pr, mag, struct sqsh_super_block);
+	if (!sq)
+		return -1;
+
+	if (strcmp(mag->magic, "sqsh") == 0) {
+		major = be16_to_cpu(sq->s_major);
+		minor = be16_to_cpu(sq->s_minor);
+	} else {
+		major = le16_to_cpu(sq->s_major);
+		minor = le16_to_cpu(sq->s_minor);
+	}
+
+	if (major > 3)
+		return -1;
+
+	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);
+
 	return 0;
 }
 
@@ -55,14 +81,21 @@ const struct blkid_idinfo squashfs_idinfo =
 	.probefunc	= probe_squashfs,
 	.magics		=
 	{
-		{ .magic = "sqsh", .len = 4 },
-		{ .magic = "hsqs", .len = 4 }, /* swap */
-
-		/* LZMA version */
-		{ .magic = "qshs", .len = 4 },
-		{ .magic = "shsq", .len = 4 }, /* swap */
+		{ .magic = "hsqs", .len = 4 },
 		{ NULL }
 	}
 };
 
+const struct blkid_idinfo squashfs3_idinfo =
+{
+	.name		= "squashfs3",
+	.usage		= BLKID_USAGE_FILESYSTEM,
+	.probefunc	= probe_squashfs3,
+	.magics		=
+	{
+		{ .magic = "sqsh", .len = 4 }, /* big endian */
+		{ .magic = "hsqs", .len = 4 }, /* little endian */
+		{ NULL }
+	}
+};
 
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 17da89a..91ca2ea 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -146,6 +146,7 @@ static const struct blkid_idinfo *idinfos[] =
 	&oracleasm_idinfo,
 	&vxfs_idinfo,
 	&squashfs_idinfo,
+	&squashfs3_idinfo,
 	&netware_idinfo,
 	&btrfs_idinfo,
 	&ubifs_idinfo,
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 2cae66a..3bbfb9c 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -57,6 +57,7 @@ extern const struct blkid_idinfo luks_idinfo;
 extern const struct blkid_idinfo highpoint37x_idinfo;
 extern const struct blkid_idinfo highpoint45x_idinfo;
 extern const struct blkid_idinfo squashfs_idinfo;
+extern const struct blkid_idinfo squashfs3_idinfo;
 extern const struct blkid_idinfo netware_idinfo;
 extern const struct blkid_idinfo sysv_idinfo;
 extern const struct blkid_idinfo xenix_idinfo;
-- 
1.8.4.5

