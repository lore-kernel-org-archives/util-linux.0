Return-Path: <SRS0=2g+Q=UD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A22C282CE
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD64216F4
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWGZd2sT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFDKRK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:17:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34375 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfFDKRJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jun 2019 06:17:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so1925552wmd.1
        for <util-linux@vger.kernel.org>; Tue, 04 Jun 2019 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvgzrTz8wrv9LBTGIGXlBEuvXleUHpW/8w2HSaPCRA0=;
        b=TWGZd2sTl7SeoCY0hRwgfIqG6pXIicDlgXSmqbO0Ig6uqLmfGGU4lvlN806LtB9ZYr
         HtOCAhp2UfYj290tR0cbIcN3r5tDFZuR/b3XD77znobEpkCK1m5zXMQpcngh0VtDjak3
         LYuwYsksnPv2L7TBLrMhEKjL5+WqoUPkUB3WkWw7Yyd1Ase2Acmh9zQdd/I8S1D/YT9c
         vvoPsm5h2l5JXdb8JZz/TPXROqLQRKQ8mGlG8Bfn9sALeKVzauGEE8V/F/V0lZYsx94w
         X9FSoh5cTCbppI858zUZRxEpZIJFECu3RvkImgLX85CyYKHu3yrJO3jarTsLTnb4bVqg
         iNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvgzrTz8wrv9LBTGIGXlBEuvXleUHpW/8w2HSaPCRA0=;
        b=RpQhcbG+M/af9yfWEQRTYEs5sF9/97wC8mJSJrV0SVtDcpfo3Jil/yy3Q/gQabS3HM
         YIP4rrMxcovmdrKiMcF+GvK7GjkfmxMJx/pSgBhaoi+AgDhbbMqZIpcrQaxy98vPudF4
         cnLB1GSIqddsNXG+G23wccX6C3MyCF/BJ731wk1hQxTKV4vtLlg51CpA4ImMZIoRblvl
         AhA3BN3M26ajQADuZImhbmHVa2iDR5l11ll1fiAcqPNfKM/JkRHW01L6gKg8/ruhXzPK
         ivFLzk445v8ev3R96bwFu4h9E+RXdTHmmQZTMINlQb/JMLTIWcgcDikGcVpcC8HSFnjS
         rBlg==
X-Gm-Message-State: APjAAAW8+aVmlJ8Qig0d2X/IbNj96qt6M9whKB/8jZRvq7rF8j5+R67S
        FGZZVL/ta5pvyXaQBaQbunvO+Vvv5C4=
X-Google-Smtp-Source: APXvYqyP6HMmacIojFPXsQ0DofeXBG1Yb0kJKo0WOa6EqtfqwRk6xv3Fh0BecykMa8OAFl0/bXkvPA==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr10872274wmj.65.1559643427403;
        Tue, 04 Jun 2019 03:17:07 -0700 (PDT)
Received: from merlot.mazyland.net (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id x129sm13594847wmg.44.2019.06.04.03.17.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:17:06 -0700 (PDT)
From:   Milan Broz <gmazyland@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] libblkid: fix detection of dm-integrity superblock version
Date:   Tue,  4 Jun 2019 12:16:57 +0200
Message-Id: <20190604101657.7268-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Kernel 5.2 can use superblock version 3 for dm-integrity.
Let's remove the explicit version check to be compatible
with future extensions.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 libblkid/src/superblocks/lvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index c7e456fa9..b078aba3f 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -193,7 +193,7 @@ static int probe_integrity(blkid_probe pr, const struct blkid_idmag *mag)
 	if (sb == NULL)
 		return errno ? -errno : 1;
 
-	if (sb->version !=1 && sb->version != 2)
+	if (!sb->version)
 		return 1;
 
 	blkid_probe_sprintf_version(pr, "%u", sb->version);
-- 
2.20.1

