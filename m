Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B40ECAAD1
	for <util-linux@archiver.kernel.org>; Wed, 31 Aug 2022 08:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiHaIra (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHaIr3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 31 Aug 2022 04:47:29 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40BC6B71
        for <util-linux@vger.kernel.org>; Wed, 31 Aug 2022 01:47:24 -0700 (PDT)
X-UUID: db009082301844a0bc38aa723c1a3d7b-20220831
X-CPASD-INFO: d9b4123aee0b485d84e0b7779843052f@rYmcVF5kYZGRhXKug3uAnlhllWCSY1e
        Ge3JUY15lXoaVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3s3ucVGFgYw==
X-CLOUD-ID: d9b4123aee0b485d84e0b7779843052f
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:144.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4992.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:0,DUF:3667,ACD:66,DCD:66,SL:0,EISP:0,AG:0,CFC:0.281,CFSR:0.107,UAT:0,RA
        F:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,E
        AF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: db009082301844a0bc38aa723c1a3d7b-20220831
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: db009082301844a0bc38aa723c1a3d7b-20220831
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 174406868; Wed, 31 Aug 2022 16:47:39 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Cc:     lienze@kylinos.cn
Subject: [PATCH] asciidoc: fix typo in hwclock.8
Date:   Wed, 31 Aug 2022 16:47:43 +0800
Message-Id: <20220831084743.10620-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The typo here is inferred from the context of the "--delay" option in
the document.

    in same cases -> in some cases
        ^                ^
Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 sys-utils/hwclock.8.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index 0d32b0a64..3e181edd2 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -120,7 +120,7 @@ The argument must be in local time, even if you keep your Hardware Clock in UTC.
 **--delay=**__seconds__::
 This option can be used to overwrite the internally used delay when setting the clock time. The default is 0.5 (500ms) for rtc_cmos, for another RTC types the delay is 0. If RTC type is impossible to determine (from sysfs) then it defaults also to 0.5 to be backwardly compatible.
 +
-The 500ms default is based on commonly used MC146818A-compatible (x86) hardware clock. This Hardware Clock can only be set to any integer time plus one half second. The integer time is required because there is no interface to set or get a fractional second. The additional half second delay is because the Hardware Clock updates to the following second precisely 500 ms after setting the new time. Unfortunately, this behavior is hardware specific and in same cases another delay is required.
+The 500ms default is based on commonly used MC146818A-compatible (x86) hardware clock. This Hardware Clock can only be set to any integer time plus one half second. The integer time is required because there is no interface to set or get a fractional second. The additional half second delay is because the Hardware Clock updates to the following second precisely 500 ms after setting the new time. Unfortunately, this behavior is hardware specific and in some cases another delay is required.
 
 *-D*, *--debug*::
 Use *--verbose*. The *--debug* option has been deprecated and may be repurposed or removed in a future release.
-- 
2.37.2

