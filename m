Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E40C433FE
	for <util-linux@archiver.kernel.org>; Wed, 25 May 2022 03:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiEYD00 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 May 2022 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiEYD00 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 May 2022 23:26:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2F15A01
        for <util-linux@vger.kernel.org>; Tue, 24 May 2022 20:26:24 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t13so6190746ilm.9
        for <util-linux@vger.kernel.org>; Tue, 24 May 2022 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=date:message-id:to:subject:from:mime-version
         :content-transfer-encoding;
        bh=4Hv3gZMoeQN3m9r2tBPNAex0xJy7+1oOOg1lffDt8rY=;
        b=Hs+coShakd0qpy7TkGbE5PIKA7LDQs/rYK/6MiosVLziD9r3V+Sv4nN9zkrEn4t9y9
         ZPrFp4UL2MELNR5W9zzh+UNXb43+cS1PZsqmCgSVxGwpRcO0+gFLaJK2QdGBYDO1gzZK
         ZhwpXdm0liX4KgsyCX3kCsP4nWf17gulUciG3/wh/OSKZznzelj+s3bBW1RPEPCh69Yn
         4pGkMZ5E9gc6DwgLFuvvqSFGca0zzojRDPPJq4u1MtmPcOjlFd3ecUf2KmEz8bGRxj3y
         4urOCR8p4kuWznVkeW+aIApFFdwestw7awSy1nZBemPOD4i9ZRCjeV3KJ8Rs1wYjfpjB
         8YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:to:subject:from:mime-version
         :content-transfer-encoding;
        bh=4Hv3gZMoeQN3m9r2tBPNAex0xJy7+1oOOg1lffDt8rY=;
        b=rgu8ExLI8D4NEYo9Aw8/vw3wkL2MXwbuCPXYgGOWHvbHa2PWk0kufMqWdXYC+LwYeN
         ABReUfdL9yJCpJkGTWGYDr+/eKRpm4RpivDXzvM6Y/jNq0b/nc6VFtRiLkHyt2P2ubEM
         RSerzRFYdAi2IFw3RMqJ1MDwo7GkDYxmc+9NfTn1gx3NgAWNRFZCnW9w0PZQT0cvKKlJ
         s1EmRdIEZUjrnzvVOAztVRIOv6QXCGCQOo9quDReYw4V0CZm0LZK6HL9O12ufLwEzWFK
         o+b1ycgbnu5Hzxm5xc0R4njWyBI45JAshg4zLnNOEa8sxwUKtxokbkXPv52t9dnuUQfX
         t1qg==
X-Gm-Message-State: AOAM530bpptTPOdYgKAk/Elsmaxn3KpU35t0qviJW/s2d9fpyiNdQPka
        I1gSjF3G0bHF5/Vx1+Qhl9MeY1SiuRZfEw==
X-Google-Smtp-Source: ABdhPJxuTEpk1H7AKKvp4aBy32rK+ojOhgzVWwP++fbMCC4BLyOiGVy5ll+s+Rz7heLZTqTBUgngaQ==
X-Received: by 2002:a92:cf01:0:b0:2cd:aeb6:b3f8 with SMTP id c1-20020a92cf01000000b002cdaeb6b3f8mr15411990ilo.265.1653449183973;
        Tue, 24 May 2022 20:26:23 -0700 (PDT)
Received: from localhost (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id o28-20020a02c6bc000000b0032ebda7c052sm2496758jan.128.2022.05.24.20.26.21
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 20:26:22 -0700 (PDT)
Date:   Wed, 25 May 2022 12:23:16 +0900 (JST)
Message-Id: <20220525.122316.1064747285110838277.hdk@igel.co.jp>
To:     util-linux@vger.kernel.org
Subject: [PATCH] loopdev: set block_size when using LOOP_CONFIGURE
From:   Hideki EIRAKU <hdk@igel.co.jp>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

LOOP_CONFIGURE ioctl was introduced by commit
d5fd456c88aba4fcf77d35fe38024a8d5c814686. Since the previous
implementation set partscan flag but did not set block_size with the
LOOP_CONFIGURE ioctl, an issue fixed by commit
422f0e9f206a145c59a71333dad20d38cbbfc0c4 was reappeared. Setting
block_size in the LOOP_CONFIGURE ioctl parameter fixes the issue.

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
---
 lib/loopdev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 437411bbe..631a120c4 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1385,6 +1385,8 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 	 * -- since Linux v5.8-rc1, commit 3448914e8cc550ba792d4ccc74471d1ca4293aae
 	 */
 	lc->config.fd = file_fd;
+	if (lc->blocksize > 0)
+		lc->config.block_size = lc->blocksize;
 
 	rc = repeat_on_eagain( ioctl(dev_fd, LOOP_CONFIGURE, &lc->config) );
 	if (rc != 0) {
@@ -1395,11 +1397,6 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 		}
 		fallback = 1;
 	} else {
-		if (lc->blocksize > 0
-			&& (rc = loopcxt_ioctl_blocksize(lc, lc->blocksize)) < 0) {
-			errsv = -rc;
-			goto err;
-		}
 		DBG(SETUP, ul_debugobj(lc, "LOOP_CONFIGURE: OK"));
 	}
 
-- 
2.30.2

