Return-Path: <SRS0=5wa5=5F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DBC4332B
	for <util-linux@archiver.kernel.org>; Fri, 20 Mar 2020 04:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A072072D
	for <util-linux@archiver.kernel.org>; Fri, 20 Mar 2020 04:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kiuYRIqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgCTEzp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:55:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56475 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTEzp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Mar 2020 00:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584680145; x=1616216145;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jL52R3J3J3wJKEMiiFSaUfJ5IxrBaXEZyk4JKd+eWKU=;
  b=kiuYRIqBlNPixb/utM1Cns3jneGAFl+u7jCqj9iPh77szm0DV5Gp0Cvz
   6DmxcjMa82yXyIzRI5EFQ18oTpowWGBaF4LNDc+R/ZwJY7SzUbQ1zLCPv
   Vr+KM+PqNgGk97R7JrOhnVcs21cw6kiHjy4Nbu2T2sNNKzmDueuQ4/oga
   zejRRg8SMiWvrHoe3GvpgY0fWd9Zip8tb/gPoklXjiz5j+M/+7Ar5K9sn
   IZg9yCDKsVWn2HtxaC0m2D9qExNjn5GL6HiSkahJYnnIfgga9RrBB6ETC
   mFCLGSj0XO5lLFyOj214etYRYqmWEOaJ0xj4Mh74tAHRwvz7+OPr+Wx3G
   Q==;
IronPort-SDR: Jy3UIHFuXco3RcDB8XiM+QdR25PUEOvtYovAFZYYJ6MyigxM+PcrAnoJeUQUVhWT0daGh/BMvQ
 tOscpVKmyc7v9LuYKaMj6RORch+a/buFdE4LR2/oGzu0tNoU31G91nhJ3mZoMiq0mK7zl+DZL6
 r5Yqr314RP5r2yINi6/jlmirSquXl7P4bC5TIHugH8ka4KCeWAq5PiErQWOd9x9GziG+2Jwb6K
 YUDS24ByEExVz+Ro+4R828nKeNPoKJKQFovRnnoG9uZrSEXBxDGF10G6WObkC2wsnb3/LeRTts
 BY8=
X-IronPort-AV: E=Sophos;i="5.72,283,1580745600"; 
   d="scan'208";a="134483993"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2020 12:55:45 +0800
IronPort-SDR: ENFY6iudY213TyRWg5HkjagHfdX+d0EfmvEDZJfmYsRlSUUYZiQQRU84gFaS7644d3AY9XFj5/
 4uXzKZhamk9gUZToiiftPqp3BPYVeXJiDItWI0gpwh4UBXbxxKZUtHzYbnfZD4bQgqIJax7my1
 0kLOpIyI5my7snadVL969Pk/ronElc1MCrhiLpKNzBMy6U7OmmX3V+rABg6Qnll3BzeZeIJ/Rv
 qq/0omz27M1g0oBnQc9rN6QuoGBbpWlgLqfvaIz3KAb4xlBH0FAeweBOGX9QEJYa2fO6Z9io2e
 wU6uV9E32d5mBBEfkiXGC/Qw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 21:47:32 -0700
IronPort-SDR: v8dMTIYHMA3NCYczDD9QDR4sEBtA6Dm8mR0FSrdGmGu6INJHuw66eug/xH/Mx8DxNXyCXP9cdS
 OOMIb3P7eh//pmz89ZWu9L5LXtoCJdoTs2UTnUap3+WeQ8l04Xr2W0oq+iWFMFafvq1VfgH7gm
 buP45jlj9+xJ5Qbju5vuEZz/U7YgPp9RhqpwE/H0ri5Gz+aISRlKCn28bHYXZIVmWg9O3FGaDh
 +CzJ5RLEx3gbb0goF4vzhq5bq6oU8/S6iZqS4evSwRRk34Ur5WwaOYydm2rCTUxSo6ONasNooC
 qXU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2020 21:55:44 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>
Subject: [PATCH] libblkid: Add support for zonefs
Date:   Fri, 20 Mar 2020 13:55:43 +0900
Message-Id: <20200320045543.2053382-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The zonefs filesystem was added to upstream linux kernel 5.6. This
patch add support for probing zonefs formatted zoned block devices so
that other file system formatting tool can detect its presence on a
device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 libblkid/src/Makemodule.am             |  1 +
 libblkid/src/superblocks/superblocks.c |  3 +-
 libblkid/src/superblocks/superblocks.h |  1 +
 libblkid/src/superblocks/zonefs.c      | 87 ++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 libblkid/src/superblocks/zonefs.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index c5d9426b1..394c2ed43 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -101,6 +101,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/vxfs.c \
 	libblkid/src/superblocks/xfs.c \
 	libblkid/src/superblocks/zfs.c \
+	libblkid/src/superblocks/zonefs.c \
 	\
 	libblkid/src/topology/topology.c \
 	libblkid/src/topology/topology.h
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index baf35e51b..67172d0a0 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -167,7 +167,8 @@ static const struct blkid_idinfo *idinfos[] =
 	&exfat_idinfo,
 	&f2fs_idinfo,
 	&mpool_idinfo,
-	&apfs_idinfo
+	&apfs_idinfo,
+	&zonefs_idinfo
 };
 
 /*
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 0cd0caccf..5ebe6bc43 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -84,6 +84,7 @@ extern const struct blkid_idinfo vdo_idinfo;
 extern const struct blkid_idinfo stratis_idinfo;
 extern const struct blkid_idinfo bitlocker_idinfo;
 extern const struct blkid_idinfo apfs_idinfo;
+extern const struct blkid_idinfo zonefs_idinfo;
 
 /*
  * superblock functions
diff --git a/libblkid/src/superblocks/zonefs.c b/libblkid/src/superblocks/zonefs.c
new file mode 100644
index 000000000..aa5d2e1bd
--- /dev/null
+++ b/libblkid/src/superblocks/zonefs.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License
+ */
+#include <stddef.h>
+#include <string.h>
+#include <uuid/uuid.h>
+
+#include "superblocks.h"
+
+#define ZONEFS_MAGIC		"SFOZ" /* 0x5a4f4653 'Z' 'O' 'F' 'S' */
+#define ZONEFS_MAGIC_SIZE	4
+#define ZONEFS_MAGIC_OFST	0
+#define ZONEFS_UUID_SIZE	16
+#define ZONEFS_LABEL_SIZE	32
+#define ZONEFS_SB_OFST		0
+
+#define ZONEFS_BLOCK_SIZE	4096U
+
+struct zonefs_super {
+
+	/* Magic number */
+	__le32		s_magic;
+
+	/* Checksum */
+	__le32		s_crc;
+
+	/* Volume label */
+	char		s_label[ZONEFS_LABEL_SIZE];
+
+	/* 128-bit uuid */
+	__u8		s_uuid[ZONEFS_UUID_SIZE];
+
+	/* Features */
+	__le64		s_features;
+
+	/* UID/GID to use for files */
+	__le32		s_uid;
+	__le32		s_gid;
+
+	/* File permissions */
+	__le32		s_perm;
+
+	/* Padding to 4096 bytes */
+	/* __u8		s_reserved[4020]; */
+
+} __attribute__ ((packed));
+
+static int probe_zonefs(blkid_probe pr,
+		const struct blkid_idmag *mag  __attribute__((__unused__)))
+{
+	struct zonefs_super *sb;
+
+	sb = (struct zonefs_super *)
+		blkid_probe_get_buffer(pr, ZONEFS_SB_OFST,
+				       sizeof(struct zonefs_super));
+	if (!sb)
+		return errno ? -errno : 1;
+
+	if (sb->s_label[0])
+		blkid_probe_set_label(pr, (unsigned char *) sb->s_label,
+				      sizeof(sb->s_label));
+
+	blkid_probe_set_uuid(pr, sb->s_uuid);
+	blkid_probe_set_block_size(pr, ZONEFS_BLOCK_SIZE);
+
+	return 0;
+}
+
+const struct blkid_idinfo zonefs_idinfo =
+{
+	.name           = "zonefs",
+	.usage          = BLKID_USAGE_FILESYSTEM,
+	.probefunc      = probe_zonefs,
+	.magics         =
+        {
+		{
+			.magic = (char *)ZONEFS_MAGIC,
+			.len = ZONEFS_MAGIC_SIZE,
+			.kboff = ZONEFS_SB_OFST,
+			.sboff = ZONEFS_MAGIC_OFST,
+		},
+		{ NULL }
+	}
+};
-- 
2.25.1

