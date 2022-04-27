Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E95C433EF
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiD0RJM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiD0RI6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 13:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332D026CE
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651079146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TddwEqJ27xrorZ7N2/jDsDPnP9EFMJ0eWw1KerxoQ3I=;
        b=RsnvMXlHppSCTtzq0VBYJPXBkc6PwVfeIBlYJkyIM7hy9wMwaGr4qB7yZdiM/Aq7vpSiZo
        ioeWwnyHKtWPsKKeKRFdLqyH/0QfUHWRkEKfOOElj8QJrkdz6gY02SmfkQPdKl/rZeJfmS
        nU3JuHwaJe/iLmbdbLWIPKMbo/a5wzs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-EsZiEEbSPjKSFSR5GgJ1qg-1; Wed, 27 Apr 2022 13:05:45 -0400
X-MC-Unique: EsZiEEbSPjKSFSR5GgJ1qg-1
Received: by mail-wm1-f72.google.com with SMTP id 125-20020a1c0283000000b003928cd3853aso2987752wmc.9
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TddwEqJ27xrorZ7N2/jDsDPnP9EFMJ0eWw1KerxoQ3I=;
        b=2QrLRtB9NJiXbKDr4QOC0cV/JrW2EJp88sS+NoFtRgT/dB+chnF1zG3piNOnAE68gW
         qUcvarTokyIIJD84bSYrV2R1jfyASVbLSR7n6aWZe1IIyMuxhsl5rVTblO+swRE6vVnx
         AUUGSbXUpvX60oo/qq9l2/s+QHRUkUmzxkSDxAGp8OMKhy0pNpVFuaEGNINRRrEM1dcC
         SLD6bq8qYjQU1Qxj8LGp9u8LA9NwkV5Fdzd8179VlTMUNE9ECHIq2ivfz1f37KKLGRkh
         I0p74Ez4YRaC/UbkK+x+DCWNLy39W0X+HbzORrRh4XG8fPQhgy7We07zyGq19Lbo14Wg
         7aiA==
X-Gm-Message-State: AOAM53167HfWOGlpLV1vJEIvwax1ledFHWy21AbvGOkl6Q0Ren/ypQzi
        8rnqxylvRytv8+LXe76jrAgqWWrbl78IuaZ3XcKRy1qDRABRu6Ih1hb7OTZfVaXACZWiAJXatWF
        LTNzY6apmBo7de4c1Dd49VlfJCTuYCVzNwzfoXU9RAgHZ8EChHynT6KKAvUwFJq7wyOeOIVqF
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr36981792wmi.91.1651079143584;
        Wed, 27 Apr 2022 10:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuPSJxLU330klIyl7f3WK7AgxLY8451Znc5wWkgXqZqkZEtn35AnXMaznGYvkpj4T9BN1FcQ==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr36981780wmi.91.1651079143367;
        Wed, 27 Apr 2022 10:05:43 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b0020af46b0ffbsm288582wrt.9.2022.04.27.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:05:42 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 2/4] libblkid: add FSLASTBLOCK implementation for xfs, ext and btrfs
Date:   Wed, 27 Apr 2022 19:05:12 +0200
Message-Id: <20220427170514.317720-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427170514.317720-1-aalbersh@redhat.com>
References: <20220427170514.317720-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Implementation of FSLASTBLOCK for most common filesystems. Most of
the fs store total number of reserved blocks in superblock.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libblkid/src/superblocks/btrfs.c | 5 +++++
 libblkid/src/superblocks/ext.c   | 5 +++++
 libblkid/src/superblocks/xfs.c   | 1 +
 3 files changed, 11 insertions(+)

diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index 78d767d26..0ead1f591 100644
--- a/libblkid/src/superblocks/btrfs.c
+++ b/libblkid/src/superblocks/btrfs.c
@@ -236,6 +236,11 @@ static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 	blkid_probe_set_uuid_as(pr, bfs->dev_item.uuid, "UUID_SUB");
 	blkid_probe_set_block_size(pr, le32_to_cpu(bfs->sectorsize));
 
+	uint32_t sectorsize_log = 31 -
+		__builtin_clz(le32_to_cpu(bfs->sectorsize));
+	blkid_probe_set_fslastblock(pr,
+			le64_to_cpu(bfs->total_bytes) >> sectorsize_log);
+
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index 3870522fa..105bdfcf3 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -190,6 +190,11 @@ static void ext_get_info(blkid_probe pr, int ver, struct ext2_super_block *es)
 
 	if (le32_to_cpu(es->s_log_block_size) < 32)
 		blkid_probe_set_block_size(pr, 1024U << le32_to_cpu(es->s_log_block_size));
+
+	uint64_t fslastblock = es->s_blocks_count |
+		((es->s_feature_incompat & EXT4_FEATURE_INCOMPAT_64BIT) ?
+		(uint64_t) es->s_blocks_count_hi << 32 : 0);
+	blkid_probe_set_fslastblock(pr, fslastblock);
 }
 
 
diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
index 444050f55..1f2e92cac 100644
--- a/libblkid/src/superblocks/xfs.c
+++ b/libblkid/src/superblocks/xfs.c
@@ -183,6 +183,7 @@ static int probe_xfs(blkid_probe pr, const struct blkid_idmag *mag)
 				sizeof(xs->sb_fname));
 	blkid_probe_set_uuid(pr, xs->sb_uuid);
 	blkid_probe_set_fssize(pr, xfs_fssize(xs));
+	blkid_probe_set_fslastblock(pr, be64_to_cpu(xs->sb_dblocks));
 	blkid_probe_set_block_size(pr, be16_to_cpu(xs->sb_sectsize));
 	return 0;
 }
-- 
2.27.0

