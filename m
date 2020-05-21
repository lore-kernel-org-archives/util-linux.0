Return-Path: <SRS0=+NO+=7D=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E66C433DF
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DC320738
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oglHsBQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEUHdV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 May 2020 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgEUHdU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2020 03:33:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1ADC061A0E
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:33:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l5so5950970edn.7
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AEtJuvQKUrBX+WP/O3v4gv7Dyph2Qo/TqBNW6DVlOQU=;
        b=oglHsBQSWK5nEdKPxnTGP/F7ZDTVGF22Vgjg6CnJVA9wWe0yjGcDsAA3mWUQgurbJJ
         +lzVKuXZ7EJA0mwRrPBjL6jaCJLCe563xX7jZ5mQMPGJgC3Oc2SU+dMr8kG9zFWK9gjN
         uCp7fcQV7opcgR8fi/SZnSKkYNRWKY8/f3hAEgsrlFVrvKBS5wb4pVQwD1AHhBx57PaX
         ypAAwbV4Aw/uSl9YH0xPq1OhzDLuyvaekU7vSav1G9C5vg/Jtv+UXQuGPGwmQ6MKAweH
         qovFVE5xX+nDn8sRWqZlE1/ZAe9w2gocN0a+Te2qluJhIV4Wlqf5Emp4eUdY492cb7yt
         zhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AEtJuvQKUrBX+WP/O3v4gv7Dyph2Qo/TqBNW6DVlOQU=;
        b=HXXJrFP6m49pdoquKttsOXL+zKLOMmck1o2wPw/chOReP09kpFtUbWmmsCsr7ZrgGr
         w5o7JrVyhqaMz/w9MV6ijfsVEwBmwemQXsBuXEHPaq9InZ6h9iu4hRnZdws9ptKaVIXu
         CxVmFosubncFT+g8Ae5TxLg+E+w/h4khR0DjXmZNDQGLVO5clAPJzT31JV/Tm16INpfa
         N2UZyf4pQNz/AFSttM6fLhyskcQaZJCzl6DBzAq8rBFHTC4RG81P5wnZuK0C8g5pneE6
         2DIvjTqPYoeUAjjtx3eplXYkzeOiVPSWMacqKkazaHODtvPh/hkCW5TtVQt5VOj3ve5M
         tgxQ==
X-Gm-Message-State: AOAM530fPo0GYaw8IUqTvbGWkKecdTa0gXnxgvcjrO3PfO+dsurPFue3
        GRlYKoOYk/8Da5clgs1yBrfkW+BF68I=
X-Google-Smtp-Source: ABdhPJwq8IYUy2GPR+1RbZ1e7nNd6Rlzv127CNLmnVl9POScGXSdo5/5G4s0+vzP15U2qAEALhzlog==
X-Received: by 2002:aa7:c5d3:: with SMTP id h19mr7179237eds.112.1590046399128;
        Thu, 21 May 2020 00:33:19 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id gl19sm3795597ejb.34.2020.05.21.00.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:33:18 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 4/4] Manual pages: rename RETURN VALUES to RETURN VALUE
Message-ID: <4788bbc4-5858-dd21-3f67-afff0e06786c@gmail.com>
Date:   Thu, 21 May 2020 09:33:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

One page, libuuid/man/uuid_time.3, uses this section name
that differs from the norm.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 libuuid/man/uuid_time.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libuuid/man/uuid_time.3 b/libuuid/man/uuid_time.3
index 77110c40b..132635d28 100644
--- a/libuuid/man/uuid_time.3
+++ b/libuuid/man/uuid_time.3
@@ -50,7 +50,7 @@ extract the creation time for UUIDs created with the
 and
 .BR uuid_generate_time_safe (3)
 functions.  It may or may not work with UUIDs created by other mechanisms.
-.SH RETURN VALUES
+.SH RETURN VALUE
 The time at which the UUID was created, in seconds since January 1, 1970 GMT
 (the epoch), is returned (see
 .BR time "(2))."
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
