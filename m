Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED74AC433EF
	for <util-linux@archiver.kernel.org>; Sun,  6 Feb 2022 06:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiBFGMR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 6 Feb 2022 01:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFGMQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Feb 2022 01:12:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D41C06173B
        for <util-linux@vger.kernel.org>; Sat,  5 Feb 2022 22:12:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cf2so6808462edb.9
        for <util-linux@vger.kernel.org>; Sat, 05 Feb 2022 22:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WW5eRsP5d6pWAP3dQKPwvFOagzJxPZkSt0Y3KMrBEg0=;
        b=O22rbidNTpGh98OjflDLxSfs36rVQUtJFiee3Xu30kDhrhziPdehBdB4tMMmkbZ2+D
         yHqQz74lkAlRXJ1fgDc6dmdypJPrXvvvJIql3oRBCO87kW1DsJM7JIwZGJfwQBs6uFrg
         rFRJIGbkqkKECmffIuJUDsIG0ozjXiYWXGIzPuP/9zpmWS/OKUIwmV7aEs7Yvvr/1Xvg
         Xuai+kf0QxFXFOJFCVWISgY0f67SQSKKZ2sRmag1KEk4AdjNS/gbm7zBUJQQstiuGcjB
         MmjLFxs5RXr9BsxqKpplbgziFTkOCNCkgedrbrk7nhNYgx0C1L5WCYG13iqADWxC91vi
         LKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WW5eRsP5d6pWAP3dQKPwvFOagzJxPZkSt0Y3KMrBEg0=;
        b=1vqRNXC95STy0smvXvoTnhxsxkFX30VTssxzHkhOSCO6ssW9QICfxEK+eHpJ+mhIei
         yaneEHlDqku1WR7SrtuNvCmP+BfZ8k5tqSzBDOxX2eF+yjnZKaqy4eZaLBZqGZXlvKdV
         ftfcPwPQ6Zyf0AwOI1thHrVwx7o0OrhmIXlcwo+/mOrC4iNwIafMMVWwXjaBgQRoRWPB
         fkGG9B98KrAmxKLsgqRJdFSyJ1HEpIsPIxhxDQ9bQliBg36AnebLzhWwO62KKEgtbzEI
         KCAvU546VFtFeF2PxzSzUh6NanIhVBN2sUER70d1yBmWhUGoEPMjnsgmDItRSckBDhga
         r0JQ==
X-Gm-Message-State: AOAM530TWePQXBHiJeIzaUGbw62j/p2MGn9T+18J3G3m0SvH7eicc140
        fS1dW00X8xD+btnd/Ki9x5x689T3q4Y=
X-Google-Smtp-Source: ABdhPJynk6lKVfhnEghW1zTyTL7/1eDD7aVVAmdflnhq4N0P4qfPhhsMzvvRv7nSNGHc5DUREkKFZw==
X-Received: by 2002:a05:6402:254c:: with SMTP id l12mr7446258edb.321.1644127933743;
        Sat, 05 Feb 2022 22:12:13 -0800 (PST)
Received: from localhost.localdomain (178.115.71.30.wireless.dyn.drei.com. [178.115.71.30])
        by smtp.gmail.com with ESMTPSA id bv2sm2264420ejb.154.2022.02.05.22.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 22:12:13 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 2/4] mount.8.adoc: use bold font for literal text in synopsis
Date:   Sun,  6 Feb 2022 07:11:56 +0100
Message-Id: <20220206061158.752262-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.35.1.301.gcdacdcff8b.dirty
In-Reply-To: <20220206061158.752262-1-aclopte@gmail.com>
References: <20220206061158.752262-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In a synopsis, *bold* text means "type exactly as shown" (see man(1)).
mount.8.adoc has *--make*-[*shared*|...] which is weird because
the middle dash is not in bold even though it's meant to be typed
literally. Make it bold like the surrounding text.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 sys-utils/mount.8.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 6f4465d0d..714b8133d 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -55,7 +55,7 @@ mount - mount a filesystem
 
 *mount* *--bind*|*--rbind*|*--move* _olddir newdir_
 
-*mount* *--make*-[*shared*|*slave*|*private*|*unbindable*|*rshared*|*rslave*|*rprivate*|*runbindable*] _mountpoint_
+*mount* *--make-*[*shared*|*slave*|*private*|*unbindable*|*rshared*|*rslave*|*rprivate*|*runbindable*] _mountpoint_
 
 == DESCRIPTION
 
-- 
2.35.1.301.gcdacdcff8b.dirty

