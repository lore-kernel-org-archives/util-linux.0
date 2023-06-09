Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78255C7EE29
	for <util-linux@archiver.kernel.org>; Fri,  9 Jun 2023 01:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjFIBhd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjFIBhb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2023 21:37:31 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53D2D63
        for <util-linux@vger.kernel.org>; Thu,  8 Jun 2023 18:37:25 -0700 (PDT)
X-UUID: ab1f6cdccaff4d6cba9cd8cc53101b55-20230609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:55783be4-f58c-4ad7-a866-80ae6ac4df59,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:55783be4-f58c-4ad7-a866-80ae6ac4df59,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:3e060d3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230609093411IEK3NQHX,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: ab1f6cdccaff4d6cba9cd8cc53101b55-20230609
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(39.156.73.12)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 98976920; Fri, 09 Jun 2023 09:37:16 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Cc:     Enze Li <lienze@kylinos.cn>
Subject: [PATCH 1/2] build-sys: rearrange gitignore in alphabetical order
Date:   Fri,  9 Jun 2023 09:37:03 +0800
Message-Id: <20230609013704.2926603-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 .gitignore | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3e2164420..456811ac6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,6 +46,10 @@ config/test-driver
 configure
 cscope.out
 depcomp
+GPATH
+GRTAGS
+GTAGS
+GSYMS
 INSTALL
 install-sh
 libtool
@@ -64,16 +68,13 @@ tests/run.sh.log
 tests/run.sh.trs
 update.log
 ylwrap
-GPATH
-GRTAGS
-GTAGS
-GSYMS
 
 #
 # binaries
 #
 /addpart
 /agetty
+/build*/
 /blkdiscard
 /blkid
 /blkpr
@@ -197,4 +198,3 @@ GSYMS
 /wipefs
 /write
 /zramctl
-/build*/
-- 
2.34.1

