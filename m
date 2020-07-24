Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B49C433F4
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA490206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcuJdXds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGXKHK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKHK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:07:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89FC0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so9380738eje.7
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wezfqKGz1j+k8qPYA3MPYpPB/r9++XYnAnYgN9tMIis=;
        b=OcuJdXdseOW2h05UEVY94/G48HGYTXiIeNpyoMwfhFLMyVSOumlYtxPtv9Y0KXmjIS
         Gnok7eGJFknM4KGBbnCzgedHTzMObG5ZIHF1sSnRx1e49fDX7XWyi70he7C67tuicENK
         BU2Zeom7Y5azvaanqV09gQc5pf0I63m7TLQPDPwdxUGq71DIxJ/X26AgNuaO0kq9hzCB
         ZMLkMEWmG4lZDbaXTVunJdaAAxU3FAKRrYpmID2lYR6+rvLxmC2pkoIPfcFqyHs4HeBL
         f8KoTt7r8sKQ4Yjn32okspC9F2SWs2BsDzjeEoW73CbyWBosooGtcqAEUESksuh97O1A
         n5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wezfqKGz1j+k8qPYA3MPYpPB/r9++XYnAnYgN9tMIis=;
        b=Km6SHCv45MFJtCOVwJUR0y2eKidls77BE41rh/bSxujgu/b2ig/+HThIbB6WmExJpU
         5NRZHq3/LpQ+Fqkvk2QAk7C4gcmzvGM/c0aSrumjIbDlChKCSqMmZztZUeuibvYbShGP
         JE2nLY43e4lanB7E6Tc8UmSJeyU7j4X5KEu4LK35cJzw2dvXzIuJQqdTNJPwVf1jd23O
         86BdwC/aYZ+3OyP9nXi04ayoymDwKC9x4/s61dOTVRm7UN8AqWZv6d5W39tVISWzr9wa
         dm2wLij4Bcn0Y8NL+p7XO7c7H2y0OIlOuGTwDzFcoIZG0YK+SMyhWzZSjxj5T2IkF2JF
         zUZg==
X-Gm-Message-State: AOAM531WKTI1aRQVoMPS3EKjt0Yl/Hz0f07nupzhSRs6MXV7KARdXJxb
        eOXUt3Sdo0GoZvZBvPgQ9sc=
X-Google-Smtp-Source: ABdhPJxD9dl3ODcba4pjNpIqyEyNdL20RTDPRnCg12Jf7M9ZtrsDygU9yHWm7Kh2CZt2r5Kkj4ehFA==
X-Received: by 2002:a17:906:fb81:: with SMTP id lr1mr8200423ejb.104.1595585228603;
        Fri, 24 Jul 2020 03:07:08 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id h8sm421823edq.15.2020.07.24.03.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:07:08 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 10/12] Manual pages: wdctl.8: typo fix
Date:   Fri, 24 Jul 2020 12:06:16 +0200
Message-Id: <20200724100618.584918-10-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

---
 sys-utils/wdctl.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/wdctl.8 b/sys-utils/wdctl.8
index efd8b5917..c2c1ef163 100644
--- a/sys-utils/wdctl.8
+++ b/sys-utils/wdctl.8
@@ -14,7 +14,7 @@ Show hardware watchdog status.  The default device is
 If more than one device is specified then the output is separated by
 one blank line.
 .PP
-If the device is already used or user has no permissions to read from the device than
+If the device is already used or user has no permissions to read from the device, then
 .B wdctl
 reads data from sysfs.  In this case information about supported features (flags) might be missing.
 .PP
-- 
2.26.2

