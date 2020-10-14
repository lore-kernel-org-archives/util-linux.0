Return-Path: <SRS0=yCBK=DV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE7C433E7
	for <util-linux@archiver.kernel.org>; Wed, 14 Oct 2020 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6442222C
	for <util-linux@archiver.kernel.org>; Wed, 14 Oct 2020 20:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoK2e04k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgJNUWw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Oct 2020 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNUWv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 14 Oct 2020 16:22:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC2C061755
        for <util-linux@vger.kernel.org>; Wed, 14 Oct 2020 13:22:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so554029wre.4
        for <util-linux@vger.kernel.org>; Wed, 14 Oct 2020 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=riy3BJtLXC7MJPV/6EYk0D9k8/vMgWOTTQWOGWFk9y0=;
        b=uoK2e04kFUvTqgW/WG74bm51UbDy0y1fFXXT7SU8VfXQEn6NuG1HbEcv/6IKtrJ22O
         W0+5jv3suET55QwD9TAw59rI3g9quKHZcj/xmQ7LXfQBRVYvZrgfubeyIfxN7oSVZ5At
         3Zo5lnN+yszgNrwaa+eO5tCfuJAl+193tnOzRwC8F04mTy3NA/deJsBOXuvZ6JzfZ9AC
         ISbEtSsdjrnc1/hx+5J9Mbm53wTLt8+QnClf0jO8xVfSx+76dcXHFgA4p6d/3u5u/APN
         M7VhH04/HeZJBWd2iRcWxjap7qWU1EIQ0hnL69PhwTdE0mCae4adKvFeJzfZmvyAkmSP
         bRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=riy3BJtLXC7MJPV/6EYk0D9k8/vMgWOTTQWOGWFk9y0=;
        b=nroaGvhefNLqCw9MW/NE4lU2R/so/x3xxIMq9tPunyuTZ77xvV+rpEadU5AElxeOTb
         0VJnHEJr4kz/yEADN3IeIknADKXolZIMTi12FeSety0vgvobDZ/CIFzLHeV4fuIxcuqd
         gz8Zfn0VwQAzfNWw7jLLKE7OS9WVZTQF6miqsGgh3Ul5o1DBrQZ02Ktd8dVOwRBm9Hof
         JxMu0zuSRpvb0s28Re1McW/SmwucK1uJTT/GUey+rRLLJgNyi0DmLJoPF3oD3fnC1NPx
         u8lj46xmrZeoOarnI2BaE31ywLu+D4L22i+N7GTz3EC4z80s02PcaeOGYqwY+4t/fAYI
         mjvw==
X-Gm-Message-State: AOAM533agUOT391x5LHbzFfuCp8aSPN43Y5h3sLWMud2ltNL4Nap5MVH
        bFhBLya5572xc+5lSmdfcQiFv8scRDc=
X-Google-Smtp-Source: ABdhPJxYI+Xb+kg9qYkqbFpOFDp8DukhL0kuRn0cbFgy010KJle4jeIdBMUyGFJfyDEtwlDgKPwhPQ==
X-Received: by 2002:a5d:680a:: with SMTP id w10mr508329wru.5.1602706969919;
        Wed, 14 Oct 2020 13:22:49 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id j17sm591589wrw.68.2020.10.14.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 13:22:48 -0700 (PDT)
Sender: Sami Kerola <kerolasa@gmail.com>
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] col: fix --help short option in usage() output
Date:   Wed, 14 Oct 2020 21:22:45 +0100
Message-Id: <20201014202245.24452-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The col(1) is using unusual -H as --help short option.  The -h is used for
--tabs (horizontal tab?) in this implementation.

Fixes: 62dee0176a0c8e687d9ff0cb87342a0f8b893aaa
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/col.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/text-utils/col.c b/text-utils/col.c
index e35e581cd..6963eb68f 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -181,7 +181,8 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -x, --spaces           convert tabs to spaces\n"
 		" -l, --lines NUM        buffer at least NUM lines\n"
 		));
-	printf(USAGE_HELP_OPTIONS(24));
+	printf( " -H, --help             %s\n", USAGE_OPTSTR_HELP);
+	printf( " -v, --version          %s\n", USAGE_OPTSTR_VERSION);
 
 	printf(USAGE_MAN_TAIL("col(1)"));
 	exit(EXIT_SUCCESS);
-- 
2.28.0

