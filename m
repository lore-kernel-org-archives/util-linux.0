Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE6C0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1971F2081D
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 11:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd0tpEjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1971F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeKGVSz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:18:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42245 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeKGVSz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2018 16:18:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so17065947wru.9
        for <util-linux@vger.kernel.org>; Wed, 07 Nov 2018 03:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaecLAY389XGjxEmYeJsK/vYBv0lQtDMLGRjATyw6JQ=;
        b=Bd0tpEjz0SvhFpdUBn34M+A+Fn6saJ4Mbp0izH3FxuboulYgFSnnxlZBwgODwmgZau
         1JnDeo16ZynxKduE26mqSq4lFsObnUeB2d0l5iHE6/OqAsrm6e7lZuopT4/CVwKoJyY8
         BD0XFi/SyILLnpZpO8qs3d0/ABASThEAJ2SCDAUycafE92G585KCVGzyjdBfAtebFaIf
         bjbQWRxvBnqretYBfBJ9eqnhB+wwCsxmS04bihP6RMHtXST00Gh6WV3PwVjAmn0lN7bt
         Cj2kYyh9n8RbkPVYfNFFUa5GqtVwSXt9vmPBFT25KEsAG7M8mOhWqr5huIs9iJmheZAG
         QpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaecLAY389XGjxEmYeJsK/vYBv0lQtDMLGRjATyw6JQ=;
        b=X9JfOTGnAfaCZq/INwls42nz7wsZHGdbLxjwtY/fkADUTy2p6VFZSFZbF9SJkeHU1t
         Fy0T+oGac8pSqtUeamC+GGrtQOywt6fZ2zrVd8zfEQEvEhclz6Zk+5+pcOzeLAjl+sjS
         h8hxO/mVOT22MNFyWn0KMkvESNSdwqVON7w9k3JxzTjdG5EK/vAL0bMApfDRWcKjnwiD
         lSmVWgZ1Rie5+/KYnV9jUhkrdRZ2+EE/02ooQ3k5pD+YnikC7Jf8Wvfju5u2ezXiR6e2
         r3/AEWmJgGI/fEopEYv8A9DRZSM3sXXf58L4Yti6C2IZUEFlGPaog348fpYCS3ey7gzG
         a61Q==
X-Gm-Message-State: AGRZ1gJLsIpKu/arrl3zv2FRG8zsr0LbMZ4HviiQP4ODZyJn6ydlq6CO
        3/lLoEddCyG0+gIYuhI+VsCzZHgt
X-Google-Smtp-Source: AJdET5ewYJo5QavcNYolkJn0Z4LbnKaurM1ViKK8rSyduvwWYD8NGak32USp8gm5TEwYJvVFnm8iuA==
X-Received: by 2002:adf:df82:: with SMTP id z2-v6mr1514559wrl.118.1541591331974;
        Wed, 07 Nov 2018 03:48:51 -0800 (PST)
Received: from merlot.mazyland.net (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id g5-v6sm261405wrw.97.2018.11.07.03.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 03:48:51 -0800 (PST)
From:   Milan Broz <gmazyland@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] blkid: fix detection of dm-integrity superblock
Date:   Wed,  7 Nov 2018 12:48:37 +0100
Message-Id: <20181107114837.12075-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Some new features in Linux kernel 4.19 for dm-integrity use metadata
format version 2, patch adds it to detection.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 libblkid/src/superblocks/lvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index 17731a8fd..c7e456fa9 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -193,7 +193,7 @@ static int probe_integrity(blkid_probe pr, const struct blkid_idmag *mag)
 	if (sb == NULL)
 		return errno ? -errno : 1;
 
-	if (sb->version != 1)
+	if (sb->version !=1 && sb->version != 2)
 		return 1;
 
 	blkid_probe_sprintf_version(pr, "%u", sb->version);
-- 
2.19.1

