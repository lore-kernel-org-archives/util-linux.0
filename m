Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8EC7619A
	for <util-linux@archiver.kernel.org>; Mon, 27 Mar 2023 08:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjC0Ik2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Mar 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjC0IkJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Mar 2023 04:40:09 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FF4204
        for <util-linux@vger.kernel.org>; Mon, 27 Mar 2023 01:35:47 -0700 (PDT)
X-UUID: d23293df81f7435a80dc86f5ef89f22c-20230327
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:bde6cea4-3a89-4d8e-82ca-a80222115314,IP:10,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:20
X-CID-INFO: VERSION:1.1.20,REQID:bde6cea4-3a89-4d8e-82ca-a80222115314,IP:10,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:25b5999,CLOUDID:55e47ab4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230327162540BWYRTU99,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: d23293df81f7435a80dc86f5ef89f22c-20230327
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 790119986; Mon, 27 Mar 2023 16:25:39 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Cc:     lienze@kylinos.cn, enze.li@gmx.com
Subject: [PATCH] setarch: add loongarch support
Date:   Mon, 27 Mar 2023 16:25:20 +0800
Message-Id: <20230327082520.292468-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 sys-utils/setarch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 8c6eecf52..78b51830c 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -236,6 +236,10 @@ static struct arch_domain *init_arch_domains(void)
 		{PER_LINUX,	"alphaev6",	"alpha"},
 		{PER_LINUX,	"alphaev67",	"alpha"},
 #endif
+#if defined(__loongarch__)
+		{PER_LINUX,	"loongarch",	"loongarch64"},
+		{PER_LINUX,	"loongarch64",	"loongarch64"},
+#endif
 #if defined(__e2k__)
 		{PER_LINUX,	"e2k",      "e2k"},
 		{PER_LINUX,	"e2kv4",	"e2k"},
-- 
2.25.1

