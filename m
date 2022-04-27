Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE1C4332F
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 17:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbiD0RJM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbiD0RJA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 13:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B43B1D0E0
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651079148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjsyeOBrqny3Kp7OYHJyw/qDd5V5UEAofuGkLZSA+aM=;
        b=bqUZQfznW0ntmk/SDVsxneM+5Lgyz/cHbN0v3de/SXRaUAHi3lEW5SspaVMtdnYnZ1+qR4
        sblNz/uJhnZ9jFJ3nUoPCtM1znEdGDP20RU3jx1/mRmLU1Xtx226nT/fY/kHLCUu3QouE0
        nSZkDmUWoA9DIAQzOmL7BPZooO7QxBQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-Mkgp-HI6NV-Fk7TrRpAy7g-1; Wed, 27 Apr 2022 13:05:47 -0400
X-MC-Unique: Mkgp-HI6NV-Fk7TrRpAy7g-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso792863wmq.3
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjsyeOBrqny3Kp7OYHJyw/qDd5V5UEAofuGkLZSA+aM=;
        b=SG1XRMHaEBTOmRy2ckLtbnCcoQRf+Q8Y71/OQUHjxJ/zHAtFrMwQXqu21y8WWE34Ct
         8FxY8utghUfG/DjLaV0HVzeVwj2fwaIzxZlreQE1MS5Y53kX+O360vFBHyprYPETzg4z
         ikWbRLizhn9KuVnNm6mYjYia0VVB6UAcFL5W0IMt3Wr5CSAVieKAjun8k2lxcGkry6SX
         cPvoUOl+FC3Rfh9JXeTF2X2ycs13zHg/ehFZ0RcyGEQ8BdvnM7KGv8yQGNHuFryZ6Y4G
         VHLSLDDdo+4Yh5CWm6G+hVHHj+b1pHqYl+KgHv2d8y89nKvq58vwgEA5xfNAbgAU7rPG
         rf9w==
X-Gm-Message-State: AOAM5300efisSW3YYyu973LSgRynaHmRfhLtPK6KXYFb5mKw4nwxmi5m
        VVvVK9mBRfRXuN/U0ytIQvDJ2+QHnSCfOdfWw2flYn/WHKNCkSd9oAIJbvJU3n71ulv65lqoWtw
        OfWk+7mCkncm6So33/uVJMcqRh2ipYRHABw/WHaPlpp0DPs0fUs9cF+FlwYZ6LCAFNPThK/St
X-Received: by 2002:a7b:c086:0:b0:393:f6fa:cfc7 with SMTP id r6-20020a7bc086000000b00393f6facfc7mr9319010wmh.62.1651079145872;
        Wed, 27 Apr 2022 10:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHuBtTYYj2v1ynwNLWwJJC2B2dLbsjpUJK8o+zajyuXKahwklOdEbscSuRGnVGWgtK0w3Yqg==
X-Received: by 2002:a7b:c086:0:b0:393:f6fa:cfc7 with SMTP id r6-20020a7bc086000000b00393f6facfc7mr9318990wmh.62.1651079145531;
        Wed, 27 Apr 2022 10:05:45 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b0020af46b0ffbsm288582wrt.9.2022.04.27.10.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:05:45 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 4/4] blkid: add tests for FSLASTBLOCK tag
Date:   Wed, 27 Apr 2022 19:05:14 +0200
Message-Id: <20220427170514.317720-5-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427170514.317720-1-aalbersh@redhat.com>
References: <20220427170514.317720-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 misc-utils/blkid.c                    | 2 +-
 tests/expected/blkid/low-probe-btrfs  | 1 +
 tests/expected/blkid/low-probe-ext2   | 1 +
 tests/expected/blkid/low-probe-ext3   | 1 +
 tests/expected/blkid/low-probe-jbd    | 1 +
 tests/expected/blkid/low-probe-xfs    | 1 +
 tests/expected/blkid/low-probe-xfs-v5 | 1 +
 7 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 2edcd2b41..5a3e43624 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -922,7 +922,7 @@ int main(int argc, char **argv)
 				BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
 				BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE |
 				BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION |
-				BLKID_SUBLKS_FSSIZE);
+				BLKID_SUBLKS_FSSIZE | BLKID_SUBLKS_FSLASTBLOCK);
 
 
 			if (fltr_usage &&
diff --git a/tests/expected/blkid/low-probe-btrfs b/tests/expected/blkid/low-probe-btrfs
index 509fac378..48649389a 100644
--- a/tests/expected/blkid/low-probe-btrfs
+++ b/tests/expected/blkid/low-probe-btrfs
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=4096
+ID_FS_FSLASTBLOCK=29440
 ID_FS_TYPE=btrfs
 ID_FS_USAGE=filesystem
 ID_FS_UUID=d4a78b72-55e4-4811-86a6-09af936d43f9
diff --git a/tests/expected/blkid/low-probe-ext2 b/tests/expected/blkid/low-probe-ext2
index 087da97a4..e236c6e8a 100644
--- a/tests/expected/blkid/low-probe-ext2
+++ b/tests/expected/blkid/low-probe-ext2
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=1024
+ID_FS_FSLASTBLOCK=100
 ID_FS_LABEL=test-ext2
 ID_FS_LABEL_ENC=test-ext2
 ID_FS_TYPE=ext2
diff --git a/tests/expected/blkid/low-probe-ext3 b/tests/expected/blkid/low-probe-ext3
index 8684884c1..164fefb7b 100644
--- a/tests/expected/blkid/low-probe-ext3
+++ b/tests/expected/blkid/low-probe-ext3
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=1024
+ID_FS_FSLASTBLOCK=2048
 ID_FS_LABEL=test-ext3
 ID_FS_LABEL_ENC=test-ext3
 ID_FS_SEC_TYPE=ext2
diff --git a/tests/expected/blkid/low-probe-jbd b/tests/expected/blkid/low-probe-jbd
index c9f9f6b79..f5462a2a3 100644
--- a/tests/expected/blkid/low-probe-jbd
+++ b/tests/expected/blkid/low-probe-jbd
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=1024
+ID_FS_FSLASTBLOCK=1024
 ID_FS_LOGUUID=0d7a07df-7b06-4829-bce7-3b9c3ece570c
 ID_FS_TYPE=jbd
 ID_FS_USAGE=other
diff --git a/tests/expected/blkid/low-probe-xfs b/tests/expected/blkid/low-probe-xfs
index a91e92bcc..be9c4194a 100644
--- a/tests/expected/blkid/low-probe-xfs
+++ b/tests/expected/blkid/low-probe-xfs
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=512
+ID_FS_FSLASTBLOCK=4096
 ID_FS_FSSIZE=11862016
 ID_FS_LABEL=test-xfs
 ID_FS_LABEL_ENC=test-xfs
diff --git a/tests/expected/blkid/low-probe-xfs-v5 b/tests/expected/blkid/low-probe-xfs-v5
index 129b41f26..fd2cba933 100644
--- a/tests/expected/blkid/low-probe-xfs-v5
+++ b/tests/expected/blkid/low-probe-xfs-v5
@@ -1,4 +1,5 @@
 ID_FS_BLOCK_SIZE=512
+ID_FS_FSLASTBLOCK=5120
 ID_FS_FSSIZE=17469440
 ID_FS_LABEL=test-xfs-v5
 ID_FS_LABEL_ENC=test-xfs-v5
-- 
2.27.0

