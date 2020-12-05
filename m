Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240DAC4361A
	for <util-linux@archiver.kernel.org>; Sat,  5 Dec 2020 07:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CF022D58
	for <util-linux@archiver.kernel.org>; Sat,  5 Dec 2020 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgLEHqL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 5 Dec 2020 02:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgLEHqK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 5 Dec 2020 02:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607154283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vCpcneTVpXPotDtJ4uB3+sBesXOArYmfRm3zlH/r+Ag=;
        b=DlqUnPlYQMJB7ehh2LfJpfnW1ZhNklUTTyuysJx5VbuRf5Ex2EqLZPbhGRvmYAYjE+Qin9
        SNS5XVPdypnrgA7p/p0i+GjfW6c4zH4vPaUx8nn6PcX2bDoH7408pgV766bjX5DYm4l9BV
        jaSZGxOzRxX7nPXDfRDzZpwx4cP4zys=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-hkoW2zfBPPC12ohIDrJ0Cw-1; Sat, 05 Dec 2020 02:44:38 -0500
X-MC-Unique: hkoW2zfBPPC12ohIDrJ0Cw-1
Received: by mail-pg1-f198.google.com with SMTP id m15so4958010pgs.7
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2020 23:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vCpcneTVpXPotDtJ4uB3+sBesXOArYmfRm3zlH/r+Ag=;
        b=FqZa2p0JNRYtYift2qZlGfnQICO/gNoGvbUiMV4fXQKv9npXDtNyLjtSjFafakaCTv
         mlZtaLTogN+lLe0S3EBnObPZ9XoGNzOMKOZ4vmpOa6DUUAj/20he2ztsH8vak2AU0tF0
         Ho/3+S85ZmMC0wlM3qIAlMDH+nsCRlUket75krq+Lrpobr52opGwzRVV4yx4vYtWgxSA
         V5as6q151BFpHTD1y07lhu2FveJNE5Qx8R0IKKrNHg8+U4aOrNCgvEIHuw92ul3Q7cHe
         21LfyckJpzIy66Flp2xzYYMMttPYfh5mOxRtwT7UbOIxA8Dwr9LBYMxXkNTCFyogXFFN
         9mHQ==
X-Gm-Message-State: AOAM530y1uOi38moXFJSEHdWpHHZ/AM9yF9QQvC+Dp63HG9w+6witdVE
        JAI8mKjSt9XVi6G5gVH3XFoBEn3oMGmAzy63ULReeHldQ5vm6oBimcZUbjXJvORFtvwhKANpn2N
        IZ0WgG469XGJhDp6kWQfITQ==
X-Received: by 2002:a17:90a:6d62:: with SMTP id z89mr7896922pjj.71.1607154277487;
        Fri, 04 Dec 2020 23:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz01uHn2Kx0go77D/u8ElMAZDxWNuITKhIf1D/VWyUenqJ4+CFBeGdR+ONxxUJOacUOyEESNA==
X-Received: by 2002:a17:90a:6d62:: with SMTP id z89mr7896910pjj.71.1607154277285;
        Fri, 04 Dec 2020 23:44:37 -0800 (PST)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a12sm4033257pjm.44.2020.12.04.23.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 23:44:36 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] libblkid: add erofs filesystem support
Date:   Sat,  5 Dec 2020 15:44:10 +0800
Message-Id: <20201205074410.2317033-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Enhanced Read-Only File System (EROFS) has been included in Linux
kernel, many Linux distributions, buildroot and Android AOSP for
a while. Plus, nowadays, it's known that EROFS has been commercially
used by several Android vendors for their system partitions.
util-linux in busybox can also detect it recently.

This patch adds support for detecting EROFS filesystem to libblkid.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 libblkid/src/Makemodule.am             |  1 +
 libblkid/src/superblocks/erofs.c       | 73 ++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |  3 +-
 libblkid/src/superblocks/superblocks.h |  1 +
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 libblkid/src/superblocks/erofs.c

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 1aa6dfcef..16a0a2826 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -101,6 +101,7 @@ libblkid_la_SOURCES = \
 	libblkid/src/superblocks/xfs.c \
 	libblkid/src/superblocks/zfs.c \
 	libblkid/src/superblocks/zonefs.c \
+	libblkid/src/superblocks/erofs.c \
 	\
 	libblkid/src/topology/topology.c \
 	libblkid/src/topology/topology.h
diff --git a/libblkid/src/superblocks/erofs.c b/libblkid/src/superblocks/erofs.c
new file mode 100644
index 000000000..0e7b4223d
--- /dev/null
+++ b/libblkid/src/superblocks/erofs.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2020 Gao Xiang
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License
+ */
+#include <stddef.h>
+#include <string.h>
+
+#include "superblocks.h"
+
+#define EROFS_SUPER_OFFSET      1024
+#define EROFS_SB_KBOFF		(EROFS_SUPER_OFFSET >> 10)
+
+#define EROFS_SUPER_MAGIC_V1	"\xe2\xe1\xf5\xe0"
+#define EROFS_MAGIC_OFF		0
+
+/* All in little-endian */
+struct erofs_super_block {
+	uint32_t	magic;
+	uint32_t	checksum;
+	uint32_t	feature_compat;
+	uint8_t		blkszbits;
+	uint8_t		reserved;
+
+	uint16_t	root_nid;
+	uint64_t	inos;
+
+	uint64_t	build_time;
+	uint32_t	build_time_nsec;
+	uint32_t	blocks;
+	uint32_t	meta_blkaddr;
+	uint32_t	xattr_blkaddr;
+	uint8_t		uuid[16];
+	uint8_t		volume_name[16];
+	uint32_t	feature_incompat;
+	uint8_t		reserved2[44];
+};
+
+static int probe_erofs(blkid_probe pr, const struct blkid_idmag *mag)
+{
+	struct erofs_super_block *sb;
+
+	sb = blkid_probe_get_sb(pr, mag, struct erofs_super_block);
+	if (!sb)
+		return errno ? -errno : BLKID_PROBE_NONE;
+
+	if (sb->volume_name[0])
+		blkid_probe_set_label(pr, (unsigned char *)sb->volume_name,
+				      sizeof(sb->volume_name));
+
+	blkid_probe_set_uuid(pr, sb->uuid);
+
+	if (sb->blkszbits < 32)
+		blkid_probe_set_block_size(pr, 1U << sb->blkszbits);
+	return BLKID_PROBE_OK;
+}
+
+const struct blkid_idinfo erofs_idinfo =
+{
+	.name           = "erofs",
+	.usage          = BLKID_USAGE_FILESYSTEM,
+	.probefunc      = probe_erofs,
+	.magics         =
+        {
+		{
+			.magic = EROFS_SUPER_MAGIC_V1,
+			.len = 4,
+			.kboff = EROFS_SB_KBOFF,
+			.sboff = EROFS_MAGIC_OFF,
+		}, { NULL }
+	}
+};
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 7b0f5eed0..f21365538 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -168,7 +168,8 @@ static const struct blkid_idinfo *idinfos[] =
 	&f2fs_idinfo,
 	&mpool_idinfo,
 	&apfs_idinfo,
-	&zonefs_idinfo
+	&zonefs_idinfo,
+	&erofs_idinfo
 };
 
 /*
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 5ebe6bc43..9c489c438 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -85,6 +85,7 @@ extern const struct blkid_idinfo stratis_idinfo;
 extern const struct blkid_idinfo bitlocker_idinfo;
 extern const struct blkid_idinfo apfs_idinfo;
 extern const struct blkid_idinfo zonefs_idinfo;
+extern const struct blkid_idinfo erofs_idinfo;
 
 /*
  * superblock functions
-- 
2.18.4

