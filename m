Return-Path: util-linux-owner@vger.kernel.org
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:41688 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdF3Oau (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 30 Jun 2017 10:30:50 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 5159C60AC9
        for <util-linux@vger.kernel.org>; Fri, 30 Jun 2017 14:30:49 +0000 (UTC)
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 528608F
        for <util-linux@vger.kernel.org>; Fri, 30 Jun 2017 14:30:48 +0000 (UTC)
To: <util-linux@vger.kernel.org>
From: Mark Tinguely <mark.tinguely@hpe.com>
Subject: [PATCH] libblkid: add HPE extended-XFS to known filesystems
Message-ID: <012d19cf-cf77-fe9a-29c5-98ca42c3d377@hpe.com>
Date: Fri, 30 Jun 2017 09:30:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Mark Tinguely <mark.tinguely@hpe.com>

The HPE (formerly SGI) enhanced XFS has changed its magic
version number to allow the use of EXFS and community XFS
filesystems at the same time.

This patch adds HPE EXFS support to libblkid.

Signed-off-by: Mark Tinguely <mark.tinguely@hpe.com>
---
  libblkid/src/Makemodule.am             |   1 +
  libblkid/src/superblocks/exfs.c        | 282 +++++++++++++++++++++++++++++++++
  libblkid/src/superblocks/superblocks.c |   2 +
  libblkid/src/superblocks/superblocks.h |   2 +
  4 files changed, 287 insertions(+)
  create mode 100644 libblkid/src/superblocks/exfs.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index ed80222ec..f151b3960 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -54,6 +54,7 @@ libblkid_la_SOURCES = \
  	libblkid/src/superblocks/drbdproxy_datalog.c \
  	libblkid/src/superblocks/drbdmanage.c \
  	libblkid/src/superblocks/exfat.c \
+	libblkid/src/superblocks/exfs.c \
  	libblkid/src/superblocks/ext.c \
  	libblkid/src/superblocks/f2fs.c \
  	libblkid/src/superblocks/gfs.c \
diff --git a/libblkid/src/superblocks/exfs.c b/libblkid/src/superblocks/exfs.c
new file mode 100644
index 000000000..2a7a6f3cc
--- /dev/null
+++ b/libblkid/src/superblocks/exfs.c
@@ -0,0 +1,282 @@
+/*
+ * Copyright (C) 1999 by Andries Brouwer
+ * Copyright (C) 1999, 2000, 2003 by Theodore Ts'o
+ * Copyright (C) 2001 by Andreas Dilger
+ * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
+ * Copyright (C) 2008 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2013 Eric Sandeen <sandeen@redhat.com>
+ * Copyright (C) 2017 Hewlett Packard Enterprise Development LP
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <ctype.h>
+#include <stdint.h>
+
+#include "superblocks.h"
+
+struct exfs_super_block {
+	uint32_t	sb_magicnum;	/* magic number == EXFS_SB_MAGIC */
+	uint32_t	sb_blocksize;	/* logical block size, bytes */
+	uint64_t	sb_dblocks;	/* number of data blocks */
+	uint64_t	sb_rblocks;	/* number of realtime blocks */
+	uint64_t	sb_rextents;	/* number of realtime extents */
+	unsigned char	sb_uuid[16];	/* file system unique id */
+	uint64_t	sb_logstart;	/* starting block of log if internal */
+	uint64_t	sb_rootino;	/* root inode number */
+	uint64_t	sb_rbmino;	/* bitmap inode for realtime extents */
+	uint64_t	sb_rsumino;	/* summary inode for rt bitmap */
+	uint32_t	sb_rextsize;	/* realtime extent size, blocks */
+	uint32_t	sb_agblocks;	/* size of an allocation group */
+	uint32_t	sb_agcount;	/* number of allocation groups */
+	uint32_t	sb_rbmblocks;	/* number of rt bitmap blocks */
+	uint32_t	sb_logblocks;	/* number of log blocks */
+
+	uint16_t	sb_versionnum;	/* header version == EXFS_SB_VERSION */
+	uint16_t	sb_sectsize;	/* volume sector size, bytes */
+	uint16_t	sb_inodesize;	/* inode size, bytes */
+	uint16_t	sb_inopblock;	/* inodes per block */
+	char		sb_fname[12];	/* file system name */
+	uint8_t		sb_blocklog;	/* log2 of sb_blocksize */
+	uint8_t		sb_sectlog;	/* log2 of sb_sectsize */
+	uint8_t		sb_inodelog;	/* log2 of sb_inodesize */
+	uint8_t		sb_inopblog;	/* log2 of sb_inopblock */
+	uint8_t		sb_agblklog;	/* log2 of sb_agblocks (rounded up) */
+	uint8_t		sb_rextslog;	/* log2 of sb_rextents */
+	uint8_t		sb_inprogress;	/* mkfs is in progress, don't mount */
+	uint8_t		sb_imax_pct;	/* max % of fs for inode space */
+					/* statistics */
+	uint64_t	sb_icount;	/* allocated inodes */
+	uint64_t	sb_ifree;	/* free inodes */
+	uint64_t	sb_fdblocks;	/* free data blocks */
+	uint64_t	sb_frextents;	/* free realtime extents */
+
+	/* this is not all... but enough for libblkid */
+
+} __attribute__((packed));
+
+#define EXFS_MIN_BLOCKSIZE_LOG	9	/* i.e. 512 bytes */
+#define EXFS_MAX_BLOCKSIZE_LOG	16	/* i.e. 65536 bytes */
+#define EXFS_MIN_BLOCKSIZE	(1 << EXFS_MIN_BLOCKSIZE_LOG)
+#define EXFS_MAX_BLOCKSIZE	(1 << EXFS_MAX_BLOCKSIZE_LOG)
+#define EXFS_MIN_SECTORSIZE_LOG	9	/* i.e. 512 bytes */
+#define EXFS_MAX_SECTORSIZE_LOG	15	/* i.e. 32768 bytes */
+#define EXFS_MIN_SECTORSIZE	(1 << EXFS_MIN_SECTORSIZE_LOG)
+#define EXFS_MAX_SECTORSIZE	(1 << EXFS_MAX_SECTORSIZE_LOG)
+
+#define	EXFS_DINODE_MIN_LOG	8
+#define	EXFS_DINODE_MAX_LOG	11
+#define	EXFS_DINODE_MIN_SIZE	(1 << EXFS_DINODE_MIN_LOG)
+#define	EXFS_DINODE_MAX_SIZE	(1 << EXFS_DINODE_MAX_LOG)
+
+#define	EXFS_MAX_RTEXTSIZE	(1024 * 1024 * 1024)	/* 1GB */
+#define	EXFS_DFL_RTEXTSIZE	(64 * 1024)		/* 64kB */
+#define	EXFS_MIN_RTEXTSIZE	(4 * 1024)		/* 4kB */
+
+#define EXFS_MIN_AG_BLOCKS	64
+#define EXFS_MAX_DBLOCKS(s) ((uint64_t)(s)->sb_agcount * (s)->sb_agblocks)
+#define EXFS_MIN_DBLOCKS(s) ((uint64_t)((s)->sb_agcount - 1) *	\
+			 (s)->sb_agblocks + EXFS_MIN_AG_BLOCKS)
+
+
+static void sb_from_disk(struct exfs_super_block *from,
+			 struct exfs_super_block *to)
+{
+
+	to->sb_magicnum = be32_to_cpu(from->sb_magicnum);
+	to->sb_blocksize = be32_to_cpu(from->sb_blocksize);
+	to->sb_dblocks = be64_to_cpu(from->sb_dblocks);
+	to->sb_rblocks = be64_to_cpu(from->sb_rblocks);
+	to->sb_rextents = be64_to_cpu(from->sb_rextents);
+	to->sb_logstart = be64_to_cpu(from->sb_logstart);
+	to->sb_rootino = be64_to_cpu(from->sb_rootino);
+	to->sb_rbmino = be64_to_cpu(from->sb_rbmino);
+	to->sb_rsumino = be64_to_cpu(from->sb_rsumino);
+	to->sb_rextsize = be32_to_cpu(from->sb_rextsize);
+	to->sb_agblocks = be32_to_cpu(from->sb_agblocks);
+	to->sb_agcount = be32_to_cpu(from->sb_agcount);
+	to->sb_rbmblocks = be32_to_cpu(from->sb_rbmblocks);
+	to->sb_logblocks = be32_to_cpu(from->sb_logblocks);
+	to->sb_versionnum = be16_to_cpu(from->sb_versionnum);
+	to->sb_sectsize = be16_to_cpu(from->sb_sectsize);
+	to->sb_inodesize = be16_to_cpu(from->sb_inodesize);
+	to->sb_inopblock = be16_to_cpu(from->sb_inopblock);
+	to->sb_blocklog = from->sb_blocklog;
+	to->sb_sectlog = from->sb_sectlog;
+	to->sb_inodelog = from->sb_inodelog;
+	to->sb_inopblog = from->sb_inopblog;
+	to->sb_agblklog = from->sb_agblklog;
+	to->sb_rextslog = from->sb_rextslog;
+	to->sb_inprogress = from->sb_inprogress;
+	to->sb_imax_pct = from->sb_imax_pct;
+	to->sb_icount = be64_to_cpu(from->sb_icount);
+	to->sb_ifree = be64_to_cpu(from->sb_ifree);
+	to->sb_fdblocks = be64_to_cpu(from->sb_fdblocks);
+	to->sb_frextents = be64_to_cpu(from->sb_frextents);
+}
+
+static int exfs_verify_sb(struct exfs_super_block *ondisk)
+{
+	struct exfs_super_block sb, *sbp = &sb;
+
+	/* beXX_to_cpu(), but don't convert UUID and fsname! */
+	sb_from_disk(ondisk, sbp);
+
+	/* sanity checks, we don't want to rely on magic string only */
+	if (sbp->sb_agcount <= 0					||
+	    sbp->sb_sectsize < EXFS_MIN_SECTORSIZE			||
+	    sbp->sb_sectsize > EXFS_MAX_SECTORSIZE			||
+	    sbp->sb_sectlog < EXFS_MIN_SECTORSIZE_LOG			||
+	    sbp->sb_sectlog > EXFS_MAX_SECTORSIZE_LOG			||
+	    sbp->sb_sectsize != (1 << sbp->sb_sectlog)			||
+	    sbp->sb_blocksize < EXFS_MIN_BLOCKSIZE			||
+	    sbp->sb_blocksize > EXFS_MAX_BLOCKSIZE			||
+	    sbp->sb_blocklog < EXFS_MIN_BLOCKSIZE_LOG			||
+	    sbp->sb_blocklog > EXFS_MAX_BLOCKSIZE_LOG			||
+	    sbp->sb_blocksize != (1ULL << sbp->sb_blocklog)		||
+	    sbp->sb_inodesize < EXFS_DINODE_MIN_SIZE			||
+	    sbp->sb_inodesize > EXFS_DINODE_MAX_SIZE			||
+	    sbp->sb_inodelog < EXFS_DINODE_MIN_LOG			||
+	    sbp->sb_inodelog > EXFS_DINODE_MAX_LOG			||
+	    sbp->sb_inodesize != (1 << sbp->sb_inodelog)		||
+	    (sbp->sb_blocklog - sbp->sb_inodelog != sbp->sb_inopblog)	||
+	    (sbp->sb_rextsize * sbp->sb_blocksize > EXFS_MAX_RTEXTSIZE)	||
+	    (sbp->sb_rextsize * sbp->sb_blocksize < EXFS_MIN_RTEXTSIZE)	||
+	    (sbp->sb_imax_pct > 100 /* zero sb_imax_pct is valid */)	||
+	    sbp->sb_dblocks == 0					||
+	    sbp->sb_dblocks > EXFS_MAX_DBLOCKS(sbp)			||
+	    sbp->sb_dblocks < EXFS_MIN_DBLOCKS(sbp))
+		return 0;
+	return 1;
+}
+
+static int probe_exfs(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct exfs_super_block *xs;
+
+	xs = blkid_probe_get_sb(pr, mag, struct exfs_super_block);
+	if (!xs)
+		return errno ? -errno : 1;
+
+	if (!exfs_verify_sb(xs))
+		return 1;
+
+	if (*xs->sb_fname != '\0')
+		blkid_probe_set_label(pr, (unsigned char *) xs->sb_fname,
+				sizeof(xs->sb_fname));
+	blkid_probe_set_uuid(pr, xs->sb_uuid);
+	return 0;
+}
+
+const struct blkid_idinfo exfs_idinfo =
+{
+	.name		= "exfs",
+	.usage		= BLKID_USAGE_FILESYSTEM,
+	.probefunc	= probe_exfs,
+	.magics		=
+	{
+		{ .magic = "EXFS", .len = 4 },
+		{ NULL }
+	}
+};
+
+struct exlog_rec_header {
+	uint32_t	h_magicno;
+	uint32_t	h_dummy1[1];
+	uint32_t	h_version;
+	uint32_t	h_len;
+	uint32_t	h_dummy2[71];
+	uint32_t	h_fmt;
+	unsigned char	h_uuid[16];
+} __attribute__((packed));
+
+#define EXLOG_HEADER_MAGIC_NUM 0xFEEDbabe
+
+/*
+ * For very small filesystems, the minimum log size
+ * can be smaller, but that seems vanishingly unlikely
+ * when used with an external log (which is used for
+ * performance reasons; tiny conflicts with that goal).
+ */
+#define EXFS_MIN_LOG_BYTES	(10 * 1024 * 1024)
+
+#define EXLOG_FMT_LINUX_LE	1
+#define EXLOG_FMT_LINUX_BE	2
+#define EXLOG_FMT_IRIX_BE	3
+
+#define EXLOG_VERSION_1		1
+#define EXLOG_VERSION_2		2	/* Large IClogs, Log sunit */
+#define EXLOG_VERSION_OKBITS	(EXLOG_VERSION_1 | EXLOG_VERSION_2)
+
+static int exlog_valid_rec_header(struct exlog_rec_header *rhead)
+{
+	uint32_t hlen;
+
+	if (rhead->h_magicno != cpu_to_be32(EXLOG_HEADER_MAGIC_NUM))
+		return 0;
+
+	if (!rhead->h_version ||
+	    (be32_to_cpu(rhead->h_version) & (~EXLOG_VERSION_OKBITS)))
+		return 0;
+
+	/* LR body must have data or it wouldn't have been written */
+	hlen = be32_to_cpu(rhead->h_len);
+	if (hlen <= 0 || hlen > INT_MAX)
+		return 0;
+
+	if (rhead->h_fmt != cpu_to_be32(EXLOG_FMT_LINUX_LE) &&
+	    rhead->h_fmt != cpu_to_be32(EXLOG_FMT_LINUX_BE) &&
+	    rhead->h_fmt != cpu_to_be32(EXLOG_FMT_IRIX_BE))
+		return 0;
+
+	return 1;
+}
+
+/* exlog record header will be in some sector in the first 256k */
+static int probe_exfs_log(blkid_probe pr,
+		const struct blkid_idmag *mag __attribute__((__unused__)))
+{
+	int i;
+	struct exlog_rec_header *rhead;
+	unsigned char *buf;
+
+	buf = blkid_probe_get_buffer(pr, 0, 256*1024);
+	if (!buf)
+		return errno ? -errno : 1;
+
+	if (memcmp(buf, "EXFS", 4) == 0)
+		return 1;			/* this is regular EXFS, ignore */
+
+	/* check the first 512 512-byte sectors */
+	for (i = 0; i < 512; i++) {
+		rhead = (struct exlog_rec_header *)&buf[i*512];
+
+		if (exlog_valid_rec_header(rhead)) {
+			blkid_probe_set_uuid_as(pr, rhead->h_uuid, "LOGUUID");
+
+			if (blkid_probe_set_magic(pr, i * 512,
+						sizeof(rhead->h_magicno),
+						(unsigned char *) &rhead->h_magicno))
+				return 1;
+
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+const struct blkid_idinfo exfs_log_idinfo =
+{
+	.name		= "exfs_external_log",
+	.usage		= BLKID_USAGE_OTHER,
+	.probefunc	= probe_exfs_log,
+	.magics		= BLKID_NONE_MAGIC,
+	.minsz		= EXFS_MIN_LOG_BYTES,
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 341cd8a6f..de00d76be 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -118,6 +118,8 @@ static const struct blkid_idinfo *idinfos[] =
  	&swap_idinfo,
  	&xfs_idinfo,
  	&xfs_log_idinfo,
+	&exfs_idinfo,
+	&exfs_log_idinfo,
  	&ext4dev_idinfo,
  	&ext4_idinfo,
  	&ext3_idinfo,
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 79dba1a3c..ce2ff190c 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -30,6 +30,8 @@ extern const struct blkid_idinfo jbd_idinfo;
  extern const struct blkid_idinfo jfs_idinfo;
  extern const struct blkid_idinfo xfs_idinfo;
  extern const struct blkid_idinfo xfs_log_idinfo;
+extern const struct blkid_idinfo exfs_idinfo;
+extern const struct blkid_idinfo exfs_log_idinfo;
  extern const struct blkid_idinfo gfs_idinfo;
  extern const struct blkid_idinfo gfs2_idinfo;
  extern const struct blkid_idinfo romfs_idinfo;
-- 
2.12.0

