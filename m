Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B7CC7EE23
	for <util-linux@archiver.kernel.org>; Tue, 23 May 2023 08:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjEWIgw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 May 2023 04:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjEWIgV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 May 2023 04:36:21 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF11BEC
        for <util-linux@vger.kernel.org>; Tue, 23 May 2023 01:34:23 -0700 (PDT)
X-UUID: 9ee691d1cdc8497ebabb0fa31e0a7ef9-20230523
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0a6c1cd4-97fe-43e8-a4b9-de237e373128,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:0a6c1cd4-97fe-43e8-a4b9-de237e373128,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:4116c0c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230523163415X8AMR80V,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9ee691d1cdc8497ebabb0fa31e0a7ef9-20230523
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(210.12.40.82)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2135969408; Tue, 23 May 2023 16:34:15 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Cc:     Enze Li <lienze@kylinos.cn>
Subject: [PATCH] enosys: add support for LoongArch
Date:   Tue, 23 May 2023 16:33:56 +0800
Message-Id: <20230523083356.377658-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 misc-utils/enosys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
index 02978c20a..9facbcb53 100644
--- a/misc-utils/enosys.c
+++ b/misc-utils/enosys.c
@@ -70,6 +70,12 @@
 #    else
 # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_ARCV2
 #    endif
+#elif __loongarch__
+#    if _LOONGARCH_SZPTR == 32
+# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH32
+#    elif _LOONGARCH_SZPTR == 64
+# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH64
+#    endif
 #else
 #    error Unknown target architecture
 #endif

base-commit: fe0b1e793c9017edba72768e2e0b4c769c204604
-- 
2.34.1

