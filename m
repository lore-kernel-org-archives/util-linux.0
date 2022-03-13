Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FC1C433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Mar 2022 11:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiCMLrU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Mar 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCMLrU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2022 07:47:20 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCEBBE0C
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2022 04:46:12 -0700 (PDT)
X-KPN-MessageId: 2514e4a4-a2c3-11ec-a7c6-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 2514e4a4-a2c3-11ec-a7c6-005056992ed3;
        Sun, 13 Mar 2022 12:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=agwrL/nF6SoEfC/MBcXtmFScKeJCF4X7+9zMqYS3YVo=;
        b=wx80jFPP0nPHK9R/v9MDBBXPSKYNT6oG/y23FJNUpjvtIb5knIpPm3TTPLW3DTVVoZWkKuygpk+/z
         3CVU8APTaHsyHvHjrcjbQk/e394M+3bPi5Y7n+EbO5gIExZqYwoLSzQ4DJ/1up1vLzfZOzL5eDPLsU
         NaTlEarEGZ1CUgnY=
X-KPN-MID: 33|+VA9m82V/Qo9Atf+cDtl83AX8n0UnlDpPl5046s7mvT0I34js+LX7ctvkZWv7i6
 5m0uxIjcukOl9w8B0uv8LRtVJckFVwnrVdtQ3Uh39s0I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|k7ZhDIv/+QdgDx2esGiBiebdPp+Ge6BW06MrSMY13qSAkzG+5R5/fjMtrGPUBWI
 4hsc2bE8+EbOtsimlsYL/iQ==
X-Originating-IP: 82.168.50.91
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 2db7efcc-a2c3-11ec-807e-00505699b758;
        Sun, 13 Mar 2022 12:46:11 +0100 (CET)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     util-linux@vger.kernel.org
Cc:     Petr Pisar <petr.pisar@atlas.cz>
Subject: [PATCH] hardlink: add a missing word to an error message
Date:   Sun, 13 Mar 2022 12:45:56 +0100
Message-Id: <20220313114556.6218-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Reported-by: Petr Pisar <petr.pisar@atlas.cz>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index d4bb48386..b4dcb3c90 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1259,7 +1259,7 @@ static int parse_options(int argc, char *argv[])
 			opts.max_size = strtosize_or_err(optarg, _("failed to parse maximum size"));
 			break;
 		case 'r':
-			opts.cache_size = strtosize_or_err(optarg, _("failed to cache size"));
+			opts.cache_size = strtosize_or_err(optarg, _("failed to parse cache size"));
 			break;
 		case 'b':
 			opts.io_size = strtosize_or_err(optarg, _("failed to parse I/O size"));
-- 
2.34.1

