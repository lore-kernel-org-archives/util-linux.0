Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62CC433DF
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86112081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwrB6zE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgESMwi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgESMwh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:52:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFEFC08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so3447577wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Yyy5WE3AwI9trTGyyLsB1+YSIesXwlVFv/AYyMiiLMI=;
        b=JwrB6zE44s4uLuljto+1V5SB5zb3sYC5Vg81bSWNzbygCZ0IRhb8j+RfhWT4SklAMZ
         wGA0+C1NsnlQso/2+4X73CXlzb8yZpunJHN0K66RCMdd6U6ML02Geq2gnJlHwV9bGmIO
         U/WAAILe+VeK6uFqJ4wSF6IhI0bKdfWk9ah6hMT6oO3uJE2HikB8LqmN9qzDEs6ISwyw
         FN2IuPmiUSQPfoTuWBjLYZ/z2HOS4ROnYCkYhU61gg+wHD+yCRLC8gvlbnxoqS7WN/U4
         4JpA8yRsRCo/hlyY6Rs1jh52oxV4bXF34sBtWeYIHRyUIBQ/ItRVoELx0otTA5b0iouG
         au4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Yyy5WE3AwI9trTGyyLsB1+YSIesXwlVFv/AYyMiiLMI=;
        b=etGmO2SlMUDwSlWLfYvjU1x+C22j7ZNpWwkkKZWk/WTu9oy1UzAcv7x1I8QSQU6VVk
         +ztcyeEzRIc4zYDKwnbxC7k6uZBTHWo2p7dyD/EE6Bqn6kNHumKgiBZNXNHjLuRTtqKR
         nfURTY0ff5jz4z2Cs5Jdvia4NLek+5P5j84+aorb3pWMh8qhLh0dd1/k2Vk4nzCUZOlk
         xOXRFb4XjgqfyVtdKMryo0JIYIeRaCsjoeV6azqDhBNphdjNFSVhIRSD6dhGNKpbEETb
         bJbuqrrghp5USN+CPeKQyjXzMCPJCqRzHcCl3/kqDdAkajRVCrFkh8QsM3fmzFSUx6P1
         SEMQ==
X-Gm-Message-State: AOAM530TK8fFYOfyxtttij/irDCH2jLHLT5EWRqw/8q20+YPMB0W8jqB
        0mQ/MNA3TxwoYpXbAGt20oV3/1X+7DQ=
X-Google-Smtp-Source: ABdhPJzEf1IxVil1GqkYmpZc1/yJPb8AoP1qPbpP52zH95NgwycIVKmz3bpdY8VHLS0m/0OUcm7+Bg==
X-Received: by 2002:a1c:444:: with SMTP id 65mr5598688wme.21.1589892756102;
        Tue, 19 May 2020 05:52:36 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id z10sm3803169wmi.2.2020.05.19.05.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:52:35 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 4/7] Manual pages: Standardize on OPTIONS as section title
Message-ID: <3a0d1c7a-aa3f-dd47-ceb8-4ec75e187a70@gmail.com>
Date:   Tue, 19 May 2020 14:52:34 +0200
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

There is quite some value (in terms of readability and user
expectations) if consistent names are used for the sections
within manual pages. This patch is one of a series to bring
about this consistency.

Currently we have OPTIONS (many) or OPTION (1 page, setpriv(1),
which actually supports multiple options!).

Let's standardize on OPTIONS (which is also what is
suggested in man-pages(7)).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/setpriv.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index ae68d3a55..5fb4dec20 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -26,7 +26,7 @@ from
 from
 .BR runit ,
 or similar tools shipped by other service managers.
-.SH OPTION
+.SH OPTIONS
 .TP
 .B \-\-clear\-groups
 Clear supplementary groups.
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
