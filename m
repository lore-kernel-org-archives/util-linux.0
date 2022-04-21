Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACCC433FE
	for <util-linux@archiver.kernel.org>; Thu, 21 Apr 2022 13:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiDUNNB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiDUNM6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2022 09:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F1238B0
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650546608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWPdSYGV1fi8RcWVJjAUlQnDL5/jzbUKPwtJo/QsAQU=;
        b=Kb98CkSct8bN4aJp6kPjEQ3uMB7u+f5SyhsfhgXYIvwm5G0IZr52Vvx92FpGl9xyO5Bgui
        LsQB9r8Aokl1Qi/CzVeIEWnPjycxFr7bvcI6j0KR8chFHNfZb5GXUpkUHq0MDrH2lL8/tg
        GhBDjToID0Ke+tHzrUTEx+Nq+DZX2uA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-abTbcdciODSEv95J6BSMiA-1; Thu, 21 Apr 2022 09:10:07 -0400
X-MC-Unique: abTbcdciODSEv95J6BSMiA-1
Received: by mail-wm1-f71.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so2408042wmb.2
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWPdSYGV1fi8RcWVJjAUlQnDL5/jzbUKPwtJo/QsAQU=;
        b=a1k8Lr2eM8eJdqQVDu3Ohq6v48EbANEWV86lIqt2bUN/gn9fU0f9Fp6eGzayhcrsWY
         GjL+0Lr3N2IuGQfJb2NuridikafyNh0ca0GvgHVEwG++mNwmhshz1Hf4/YsARfVjG9hy
         KW3TVB1g/M4KlXPJcpxJxBTn/SsCxY3n6r6sFVpFeNK3CsXWpMwB0RKJhzMLDKRRowpl
         QktEJmW5quSp++T23u8n8+or2ZJOOElfmmtVO8HmFRoQ31b+yC9OzutMJ64UCxQki7mV
         7bn04u6/pD9TgHlu4I7qo/2+pSL3v5ZZ1KiTGttzkmli0ih23JComcldwgb76KKYa7gW
         0XMg==
X-Gm-Message-State: AOAM532jnXFS2q0gjWn1eHfjXDx09Sf5uNF7bHwPsR0RZL2lgT4TZSGa
        7oFAADpTzBDcB69+gN5/Kd7V2sI74/ofhDrC4yHWWNoyzoMtFiY+xxNE5rXzPe1Tkfa0dhVZkxt
        Ijw4G02i782tULyNMdmKV4TDz9SJjl/DMQsd3UTVC0vf8nP6T3AOEq2FeiugvvhmNHvW09DiM
X-Received: by 2002:adf:f2cb:0:b0:20a:77c2:3958 with SMTP id d11-20020adff2cb000000b0020a77c23958mr18899775wrp.589.1650546605526;
        Thu, 21 Apr 2022 06:10:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrXOLjNEiZBRSqiTukloyoO7IbGwPvd6s292Phn+YVar/nv7Hyvk44aGW0+86TyrHKB04o+A==
X-Received: by 2002:adf:f2cb:0:b0:20a:77c2:3958 with SMTP id d11-20020adff2cb000000b0020a77c23958mr18899751wrp.589.1650546605190;
        Thu, 21 Apr 2022 06:10:05 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm2284875wrr.67.2022.04.21.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:10:04 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 2/2] libblkid: implement FSSIZE calculation for XFS
Date:   Thu, 21 Apr 2022 15:09:46 +0200
Message-Id: <20220421130946.318737-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220421130946.318737-1-aalbersh@redhat.com>
References: <20220421130946.318737-1-aalbersh@redhat.com>
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

