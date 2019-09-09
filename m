Return-Path: <SRS0=RNVe=XE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1BC4740A
	for <util-linux@archiver.kernel.org>; Mon,  9 Sep 2019 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FFF218AF
	for <util-linux@archiver.kernel.org>; Mon,  9 Sep 2019 20:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLB8vr3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfIIU7O (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:59:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40742 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIIU7N (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 9 Sep 2019 16:59:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so18019654qtq.7
        for <util-linux@vger.kernel.org>; Mon, 09 Sep 2019 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=b31zn4Dv2+oCv9oq+PZeTMot6T1m1NywxxygrMYTs30=;
        b=mLB8vr3cIIg+bVaDeuCLpnlz6A7SVbdfT1D3iVP8nlur9odt5RO/ooNa1gS8JT0ocF
         oGU5adKPbREA363uy+VyJr6Mi5URqI0MEUHYIJZlE9w6MGC+c7wY8OvzmJug6fw3tZu4
         rVQWIt1yzQrcdSHMan1NbdcuZSbcqI+D2dvnS1UuZpaNuSuL2NX6k+TYZi24rs/iTTwD
         x+3Ejun9hnxqk4nqry8M4rTXaD2vytPRCrUpyn9umCYWH5kXFn3mmwdn2iXtwaYgGgV4
         NMWqrZuHU113XHktbdIB3XIFL2zzvnbAQ4VTw9Ed2M2hvme6Ha3fKNgqTFtjlqxJ32Y9
         L2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=b31zn4Dv2+oCv9oq+PZeTMot6T1m1NywxxygrMYTs30=;
        b=MxMjsSCrDNwCa9kszyTYOPZ+Hb1ZuGXOq8xgRarm3feRiNsF56L9VyVKfzlWOmgZ8j
         lVOOD525UkvZaoHZaWEVQWhro4Whu81ef+SQkVsOrrWA5J2EUpX8tHJFdjTAVlJ3R7GW
         cObVMgIWipstUdndgB3lx0t3/k+rbRrZvkgpzxeWqs8ePn87zhPgKWuXuNcZvWNJjGsp
         uqqHaEK4B5mF8aW4xUhsGVyvnckm1EKRN1P+2z8w+U+YdLXLvMp31QdkHqk9WJGb/lR2
         n3on834NO0+/qgNhIL6Z6DddzhGoBqBfG6tcOK+uyZCu0QnE6jI4wTvZep5qboWnxp3Y
         e7ww==
X-Gm-Message-State: APjAAAVa9b6Xz22+neTQySwDwiaaOoQM0izimxUJz0AmzB6Vl5VnaDR/
        ZegJdNnyTk6oK7keCJqzqRud0Kx0
X-Google-Smtp-Source: APXvYqwAaK1FaUodVyHrKD1tKJ0UfIUh3dqg6OTMinXHWd/kD+tuptR9JuCvo8rAnX+XdyTH48oRpg==
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr24092811qts.61.1568062752742;
        Mon, 09 Sep 2019 13:59:12 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id l48sm4686790qtb.50.2019.09.09.13.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Sep 2019 13:59:12 -0700 (PDT)
Date:   Mon, 9 Sep 2019 17:59:07 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: (gpt) add GUID for APFS containers
Message-ID: <20190909205907.alytemtibvk4kv37@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add the partition type GUID for the Apple File System to gpt_parttypes.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
---
 libfdisk/src/gpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 1658782a8..279f22978 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -217,6 +217,7 @@ static struct fdisk_parttype gpt_parttypes[] =
 
 	/* Apple OSX */
 	DEF_GUID("48465300-0000-11AA-AA11-00306543ECAC", N_("Apple HFS/HFS+")),
+	DEF_GUID("7C3457EF-0000-11AA-AA11-00306543ECAC", N_("Apple APFS")),
 	DEF_GUID("55465300-0000-11AA-AA11-00306543ECAC", N_("Apple UFS")),
 	DEF_GUID("52414944-0000-11AA-AA11-00306543ECAC", N_("Apple RAID")),
 	DEF_GUID("52414944-5F4F-11AA-AA11-00306543ECAC", N_("Apple RAID offline")),
-- 
2.11.0

