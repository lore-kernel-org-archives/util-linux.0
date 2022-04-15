Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F5C433F5
	for <util-linux@archiver.kernel.org>; Fri, 15 Apr 2022 03:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348255AbiDODeO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 Apr 2022 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiDODeN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 14 Apr 2022 23:34:13 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16944198A
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2022 20:31:43 -0700 (PDT)
X-UUID: 30df76f9f8404bd691d48672bf795527-20220415
X-CPASD-INFO: 9ba12b1ef08647f7824aaa79b0e9697d@grKbUV-UX5WSUHqCg3qxcVhiYIGwo3F
        Zkl6VZVaOibB6Ul9sWVWEfWxUYGJgYVVzeW1ZZV5gXlF2fn91f1CFYmBcUJl6gI9rWZKPYQ==
X-CLOUD-ID: 9ba12b1ef08647f7824aaa79b0e9697d
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:197.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:41.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:14,DUF:37212,ACD:254,DCD:356,SL:0,EISP:0,AG:0,CFC:0.221,CFSR:0.054,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 30df76f9f8404bd691d48672bf795527-20220415
X-CPASD-BLOCK: 0
X-CPASD-STAGE: 1
X-UUID: 30df76f9f8404bd691d48672bf795527-20220415
X-User: lienze@kylinos.cn
Received: from fedora.. [(106.37.198.36)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1613696763; Fri, 15 Apr 2022 11:30:24 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Subject: [PATCH] build-sys: add blkpr to gitignore
Date:   Fri, 15 Apr 2022 11:31:25 +0800
Message-Id: <20220415033125.3409425-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since this commit 627428a95692 ("blkpr: add block persistent
reservations command"), we introduced blkpr, but the compiled generated
binary file is not added to the gitignore, so let's do it.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3274563ec..0effa8945 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,6 +73,7 @@ GSYMS
 /addpart
 /agetty
 /blkdiscard
+/blkpr
 /blkzone
 /blkid
 /blockdev
-- 
2.35.1

