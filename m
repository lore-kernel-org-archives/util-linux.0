Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF19C433EF
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 15:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiDYPMK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbiDYPMJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 11:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7BE6E4FF
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650899343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWPdSYGV1fi8RcWVJjAUlQnDL5/jzbUKPwtJo/QsAQU=;
        b=XCEiDv+j39n8w97ELuobvXc/9vW/ETxMSm8g0PVfBC/iUpt1n158wuiJNdKD1YfJt0Bl8e
        GZj41/77CXTbztJN7uq80RFJvv/QXakPAos+xqzJJIvquMNKZiExN6X49epAeGne2nvhef
        Se4joIWeeWK8cOWn/HkvVZZMwmuLMhs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-Qbzyui1SNxScv7TKHBLvkQ-1; Mon, 25 Apr 2022 11:09:00 -0400
X-MC-Unique: Qbzyui1SNxScv7TKHBLvkQ-1
Received: by mail-ej1-f72.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso7478714ejc.18
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWPdSYGV1fi8RcWVJjAUlQnDL5/jzbUKPwtJo/QsAQU=;
        b=XYrprpkcV2Z/sEpmTdjepVRYNAblq+GHBgiNAcLRteFd13i7qWF9YPujtvlfQcycdT
         U5cNnn3QtklVg2D3uTOxCe/MouPzXRaDuS19jLXYJvLXJ8znmW3k3aVVIjSHasy37pRR
         F+ifr6PFbKGKfx0eN3OVxK5CL8n5ANnkzuyOmFhOrC7ei69POTUSyBK74jQpRX5PeHMG
         osO0I0asF/IqxmPzYpzUQG/TW9KO0Xstwl5ItGJuGwtFuRFv/lq3QnuGo0N3wmjJcE00
         IPbDxETWvFy9IboBGC8eNQ3cQJGaz4R7HcZwNRBXiyEC9aRQcIQF11sxsKcCj+MmEXFc
         Pt6w==
X-Gm-Message-State: AOAM532Saj5zW537Qj9MhknLYoDEZleHNaigLF4HtlAZuxjdHKmYqVcf
        j/fR6m2F87bcaBQoB1ZCVeCHGrDahGhXfnxgoagNtXhqtZvn+7almsWCJ7P84ReSlsBZ3uBWh0D
        AYWmRwJPqny4rXXR0g1O53DTuBoq36v8FCmOvTqLyd1Hwe46nJFb1BhC8L1f87Nn6gbLy/8GJ
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr19399924edb.288.1650899339241;
        Mon, 25 Apr 2022 08:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcb+Wxz9Cpbus584/F2dWJXaVtjKqM9dYwWAMp24PRGQqcAcoAeSqCIZTo5oVDxJTwxAw0DQ==
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr19399901edb.288.1650899339043;
        Mon, 25 Apr 2022 08:08:59 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i19-20020a1709061cd300b006f38920dbeesm1776878ejh.134.2022.04.25.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:08:58 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 2/3] libblkid: implement FSSIZE calculation for XFS
Date:   Mon, 25 Apr 2022 17:08:38 +0200
Message-Id: <20220425150838.151020-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425150838.151020-1-aalbersh@redhat.com>
References: <20220425150838.151020-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The implementation is similar to one provided by statfs(2) + lsblk.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libblkid/src/superblocks/xfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
index d8c6fb6d4..444050f55 100644
--- a/libblkid/src/superblocks/xfs.c
+++ b/libblkid/src/superblocks/xfs.c
@@ -158,6 +158,15 @@ static int xfs_verify_sb(struct xfs_super_block *ondisk)
 	return 1;
 }
 
+static uint64_t xfs_fssize(struct xfs_super_block *xs)
+{
+	uint32_t lsize = xs->sb_logstart ? xs->sb_logblocks : 0;
+	uint64_t avail_blocks = be64_to_cpu(xs->sb_dblocks) - be32_to_cpu(lsize);
+	uint64_t fssize = avail_blocks*be32_to_cpu(xs->sb_blocksize);
+
+	return fssize;
+}
+
 static int probe_xfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct xfs_super_block *xs;
@@ -173,6 +182,7 @@ static int probe_xfs(blkid_probe pr, const struct blkid_idmag *mag)
 		blkid_probe_set_label(pr, (unsigned char *) xs->sb_fname,
 				sizeof(xs->sb_fname));
 	blkid_probe_set_uuid(pr, xs->sb_uuid);
+	blkid_probe_set_fssize(pr, xfs_fssize(xs));
 	blkid_probe_set_block_size(pr, be16_to_cpu(xs->sb_sectsize));
 	return 0;
 }
-- 
2.27.0

