Return-Path: <SRS0=4JBC=Q5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61486C43381
	for <util-linux@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380CA2075C
	for <util-linux@archiver.kernel.org>; Fri, 22 Feb 2019 16:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfBVQEX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:04:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVQEX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 22 Feb 2019 11:04:23 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxDJF-0001w2-AP
        for util-linux@vger.kernel.org; Fri, 22 Feb 2019 16:04:21 +0000
Received: by mail-wr1-f70.google.com with SMTP id h2so1201301wre.9
        for <util-linux@vger.kernel.org>; Fri, 22 Feb 2019 08:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMVVP99JjJZfUU0kN2OP0Fitv83W2XYp2tQxIiXfaM8=;
        b=cutl0LVHoV95J4sYFwBaK9zG+eGnt5tcdVQCt67CIhUvBsIyHIzhLxGO2rWpTMzqLf
         VuQO5x1yfdo/tOiZe6Dv/VJ4+98jxAnnYkvNtW3pbxjpSGRKHlMhJ6fa5Ze/9HP9DZ/+
         EFKP0D83pZ4bUuP3ZokF49JA9xT1YfahSQ3X2Lk1xT5zUYUNP9ZOUSK+aCzp6DFIGJ2d
         Etab86QVIEZYHMQssEmuOF45QPYj34S/sYEhWtY1Jmf4WN7jdnzvchd+0LnEKsKu8IVi
         PCueZ700YhgMmpfUlnlVFklVyW1gRGpbpGfy552sVA1aZDElrF0Hc+F3qpv2jbSW8Cq1
         59yg==
X-Gm-Message-State: AHQUAuaYbvSu2EKtXDL54v9Di+Tl8OM0H+VfkEdqg6NTuj/dnwpz//Yl
        GEvClgi4AxwleCnoqxrqK4nvDaGxLGwcxYpWaGUnscyQas+WnFDfU5UfFyR/BpRasNDRlG3Jlrq
        w2xKD0bwvG/bzgmMV+uIT9gp6YJTidB+Ei4PL//c=
X-Received: by 2002:a7b:c115:: with SMTP id w21mr3101568wmi.104.1550851460788;
        Fri, 22 Feb 2019 08:04:20 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYtGD4WRhr/DLYskyHCEcr5RkRYauri612LLiHroRwUjMBkDzxgqyUN24gZeryXK8iIg8Nwvg==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr3101550wmi.104.1550851460576;
        Fri, 22 Feb 2019 08:04:20 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id p6sm5808236wre.63.2019.02.22.08.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 08:04:19 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     util-linux@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] libfdisk: (dos) Use strtoul to parse the label-id
Date:   Fri, 22 Feb 2019 17:04:12 +0100
Message-Id: <20190222160412.26652-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Parsing of the label-id fails on 32-bit if the MSB is set. Fix that by
using strtoul instead of strtol.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 libfdisk/src/dos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 4f81970db9d8..86d15d21130b 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -669,7 +669,7 @@ static int dos_create_disklabel(struct fdisk_context *cxt)
 
 		if (s) {
 			errno = 0;
-			id = strtol(s, &end, 16);
+			id = strtoul(s, &end, 16);
 			if (!errno && end && s < end) {
 				has_id = 1;
 				DBG(LABEL, ul_debug("DOS: re-use ID from script (0x%08x)", id));
-- 
2.19.1

