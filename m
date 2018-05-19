Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.hi.is ([130.208.165.104]:38838 "EHLO mx2.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeESAIz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 May 2018 20:08:55 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by mx2.hi.is (8.14.7/8.14.7) with ESMTP id w4J08plA013689
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 19 May 2018 00:08:53 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w4J08pi2032188
        for <util-linux@vger.kernel.org>; Sat, 19 May 2018 00:08:51 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w4J08oiO032187
        for util-linux@vger.kernel.org; Sat, 19 May 2018 00:08:50 GMT
Date: Sat, 19 May 2018 00:08:50 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man: choom.1: Use the correct macro for the font change of
 one argument
Message-ID: <20180519000850.GA32178@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Use the correct macro "I" for one argument, instead of the
two-fonts macro "IR".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/choom.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/choom.1 b/sys-utils/choom.1
index 9cac198d0..13e4fc247 100644
--- a/sys-utils/choom.1
+++ b/sys-utils/choom.1
@@ -4,7 +4,7 @@ choom \- display and adjust OOM-killer score.
 .SH SYNOPSIS
 .B choom
 .B \-p
-.IR pid
+.I pid
 .sp
 .B choom
 .B \-p
-- 
2.17.0


-- 
Bjarni I. Gislason
