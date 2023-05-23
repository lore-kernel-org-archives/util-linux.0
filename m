Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BAC7EE23
	for <util-linux@archiver.kernel.org>; Tue, 23 May 2023 07:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjEWHnf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 May 2023 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjEWHne (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 May 2023 03:43:34 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575C11A
        for <util-linux@vger.kernel.org>; Tue, 23 May 2023 00:43:32 -0700 (PDT)
X-UUID: da7f9d1f3e944e01950364ec25292f8b-20230523
X-CID-CACHE: Type:Local,Time:202305231540+08,HitQuantity:1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c4103b53-4e0e-4766-9113-a9eb95569a18,IP:15,
        URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-30
X-CID-INFO: VERSION:1.1.22,REQID:c4103b53-4e0e-4766-9113-a9eb95569a18,IP:15,UR
        L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-30
X-CID-META: VersionHash:120426c,CLOUDID:832cbec1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:19|44|24|17|102,TC:nil,Content:0,EDM
        :2,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: da7f9d1f3e944e01950364ec25292f8b-20230523
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(210.12.40.82)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1816130441; Tue, 23 May 2023 15:43:22 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Subject: [PATCH] build-sys: add enosys and syscalls.h to gitignore
Date:   Tue, 23 May 2023 15:43:10 +0800
Message-Id: <20230523074310.371267-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

After compiling enosys, the syscalls.h file and the executable enosys are
generated, let's add these two files to the .gitignore file.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 3e2164420..9f4b38407 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,7 @@ GPATH
 GRTAGS
 GTAGS
 GSYMS
+syscalls.h
 
 #
 # binaries
@@ -95,6 +96,7 @@ GSYMS
 /delpart
 /dmesg
 /eject
+/enosys
 /fadvise
 /fallocate
 /fdformat

base-commit: fe0b1e793c9017edba72768e2e0b4c769c204604
-- 
2.34.1

