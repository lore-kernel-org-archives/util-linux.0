Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0932C433EF
	for <util-linux@archiver.kernel.org>; Wed, 13 Apr 2022 07:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiDMH4F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiDMH4E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2022 03:56:04 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2A41FB2
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2022 00:53:42 -0700 (PDT)
X-UUID: b5b52ba051284ded9f72ef4004744a0f-20220413
X-CPASD-INFO: e712d8a21e264582bc5630b69c893f53@rodrUpFqj2JdhXSCg3iDbIKTYVaCcpx
        WaZFoZVO7h396Ul9sWVWEfWxUYGJgYVVzeW1ZZF5gXlF2fn91f1CFYmBcUJl6gI9rhWdfYg==
X-CLOUD-ID: e712d8a21e264582bc5630b69c893f53
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:197.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:47.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:12,DUF:37045,ACD:252,DCD:354,SL:0,EISP:0,AG:0,CFC:0.241,CFSR:0.048,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: b5b52ba051284ded9f72ef4004744a0f-20220413
X-CPASD-BLOCK: 0
X-CPASD-STAGE: 1
X-UUID: b5b52ba051284ded9f72ef4004744a0f-20220413
X-User: lienze@kylinos.cn
Received: from fedora.. [(106.37.198.36)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1828485290; Wed, 13 Apr 2022 15:52:29 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Subject: [PATCH] build-sys: add gnu global outputs to gitignore
Date:   Wed, 13 Apr 2022 15:53:50 +0800
Message-Id: <20220413075350.2190928-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Some people like to use gnu global to browse code, so we add the global
output files to gitignore, which is safe because no function-related
code is changed.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 840f64615..3274563ec 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,10 @@ tests/run.sh.log
 tests/run.sh.trs
 update.log
 ylwrap
+GPATH
+GRTAGS
+GTAGS
+GSYMS
 
 #
 # binaries
-- 
2.35.1

