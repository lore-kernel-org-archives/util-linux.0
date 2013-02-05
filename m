Return-Path: alex@nowcomputing.com
From: Alejandro Martinez Ruiz <alex@nowcomputing.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: [PATCH 1/2] libblkid: add Flash-Friendly File System (f2fs) support
Date: Tue,  5 Feb 2013 18:00:06 +0100
Message-Id: <1360083607-29885-2-git-send-email-alex@nowcomputing.com>
In-Reply-To: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
References: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

This adds support for detecting Flash-Friendly File System (f2fs) to libblkid.
Based on work by Sven-Göran Bergh at http://www.mail-archive.com/busybox@busybox.net/msg17874.html

Signed-off-by: Alejandro Martinez Ruiz <alex@nowcomputing.com>
---
 libblkid/src/Makemodule.am             |  1 +
 libblkid/src/superblocks/f2fs.c        | 98 ++++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |  3 +-
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 libblkid/src/superblocks/f2fs.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index de60458..90efa3d 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -54,6 +54,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/drbdproxy_datalog.c \
 	libblkid/src/superblocks/exfat.c \
 	libblkid/src/superblocks/ext.c \
+	libblkid/src/superblocks/f2fs.c \
 	libblkid/src/superblocks/gfs.c \
 	libblkid/src/superblocks/hfs.c \
 	libblkid/src/superblocks/highpoint_raid.c \
diff --git a/libblkid/src/superblocks/f2fs.c b/libblkid/src/superblocks/f2fs.c
new file mode 100644
index 0000000..ad03441
--- /dev/null
+++ b/libblkid/src/superblocks/f2fs.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2013 Alejandro Martinez Ruiz <alex@nowcomputing.com>
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License
+ */
+
+#include <stddef.h>
+#include <string.h>
+
+#include "superblocks.h"
+
+#define F2FS_MAGIC		"\x10\x20\xF5\xF2"
+#define F2FS_MAGIC_OFF		0
+#define F2FS_UUID_SIZE		16
+#define F2FS_LABEL_SIZE		512
+#define F2FS_SB1_OFF		0x400
+#define F2FS_SB1_KBOFF		(F2FS_SB1_OFF >> 10)
+#define F2FS_SB2_OFF		0x1400
+#define F2FS_SB2_KBOFF		(F2FS_SB2_OFF >> 10)
+
+struct f2fs_super_block {					/* According to version 1.1 */
+/* 0x00 */	uint32_t	magic;				/* Magic Number */
+/* 0x04 */	uint16_t	major_ver;			/* Major Version */
+/* 0x06 */	uint16_t	minor_ver;			/* Minor Version */
+/* 0x08 */	uint32_t	log_sectorsize;			/* log2 sector size in bytes */
+/* 0x0C */	uint32_t	log_sectors_per_block;		/* log2 # of sectors per block */
+/* 0x10 */	uint32_t	log_blocksize;			/* log2 block size in bytes */
+/* 0x14 */	uint32_t	log_blocks_per_seg;		/* log2 # of blocks per segment */
+/* 0x18 */	uint32_t	segs_per_sec;			/* # of segments per section */
+/* 0x1C */	uint32_t	secs_per_zone;			/* # of sections per zone */
+/* 0x20 */	uint32_t	checksum_offset;		/* checksum offset inside super block */
+/* 0x24 */	uint64_t	block_count;			/* total # of user blocks */
+/* 0x2C */	uint32_t	section_count;			/* total # of sections */
+/* 0x30 */	uint32_t	segment_count;			/* total # of segments */
+/* 0x34 */	uint32_t	segment_count_ckpt;		/* # of segments for checkpoint */
+/* 0x38 */	uint32_t	segment_count_sit;		/* # of segments for SIT */
+/* 0x3C */	uint32_t	segment_count_nat;		/* # of segments for NAT */
+/* 0x40 */	uint32_t	segment_count_ssa;		/* # of segments for SSA */
+/* 0x44 */	uint32_t	segment_count_main;		/* # of segments for main area */
+/* 0x48 */	uint32_t	segment0_blkaddr;		/* start block address of segment 0 */
+/* 0x4C */	uint32_t	cp_blkaddr;			/* start block address of checkpoint */
+/* 0x50 */	uint32_t	sit_blkaddr;			/* start block address of SIT */
+/* 0x54 */	uint32_t	nat_blkaddr;			/* start block address of NAT */
+/* 0x58 */	uint32_t	ssa_blkaddr;			/* start block address of SSA */
+/* 0x5C */	uint32_t	main_blkaddr;			/* start block address of main area */
+/* 0x60 */	uint32_t	root_ino;			/* root inode number */
+/* 0x64 */	uint32_t	node_ino;			/* node inode number */
+/* 0x68 */	uint32_t	meta_ino;			/* meta inode number */
+/* 0x6C */	uint8_t		uuid[F2FS_UUID_SIZE];		/* 128-bit uuid for volume */
+/* 0x7C */	uint16_t	volume_name[F2FS_LABEL_SIZE];	/* volume name */
+#if 0
+/* 0x47C */	uint32_t	extension_count;		/* # of extensions below */
+/* 0x480 */	uint8_t		extension_list[64][8];		/* extension array */
+#endif
+} __attribute__((packed));
+
+static int probe_f2fs(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct f2fs_super_block *sb;
+	uint16_t major, minor;
+
+	sb = blkid_probe_get_sb(pr, mag, struct f2fs_super_block);
+	if (!sb)
+		return -1;
+
+	major = le16_to_cpu(sb->major_ver);
+	minor = le16_to_cpu(sb->minor_ver);
+
+	/* For version 1.0 we cannot know the correct sb structure */
+	if (major == 1 && minor == 0)
+		return 0;
+
+	if (*((unsigned char *) sb->volume_name))
+		blkid_probe_set_utf8label(pr, (unsigned char *) sb->volume_name,
+						sizeof(sb->volume_name),
+						BLKID_ENC_UTF16LE);
+
+	blkid_probe_set_uuid(pr, sb->uuid);
+	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);
+}
+
+const struct blkid_idinfo f2fs_idinfo =
+{
+	.name           = "f2fs",
+	.usage          = BLKID_USAGE_FILESYSTEM,
+	.probefunc      = probe_f2fs,
+	.magics         =
+        {
+		{
+			.magic = F2FS_MAGIC,
+			.len = 4,
+			.kboff = F2FS_SB1_KBOFF,
+			.sboff = F2FS_MAGIC_OFF
+		},
+		{ NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 2929a5f..62aa662 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -140,7 +140,8 @@ static const struct blkid_idinfo *idinfos[] =
 	&vmfs_fs_idinfo,
 	&befs_idinfo,
 	&nilfs2_idinfo,
-	&exfat_idinfo
+	&exfat_idinfo,
+	&f2fs_idinfo
 };
 
 /*
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 08f1438..887732a 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -69,6 +69,7 @@ extern const struct blkid_idinfo drbdproxy_datalog_idinfo;
 extern const struct blkid_idinfo befs_idinfo;
 extern const struct blkid_idinfo nilfs2_idinfo;
 extern const struct blkid_idinfo exfat_idinfo;
+extern const struct blkid_idinfo f2fs_idinfo;
 
 /*
  * superblock functions
-- 
1.8.1.2.422.g08c0e7f
