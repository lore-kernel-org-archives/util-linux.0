Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC13C433F5
	for <util-linux@archiver.kernel.org>; Sat, 15 Jan 2022 16:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiAOQ3k (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 15 Jan 2022 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiAOQ3k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jan 2022 11:29:40 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D982BC061574
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:39 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h15so9694111qtx.0
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMLtPt3sF74Mw0F2dpAa3S1gWPERhEEOZ1M/tczB1NI=;
        b=DmyzDP8/I2bCBVbTVuqMDp+PVmbhMG0k88HtVWIq7Ei9hKTlfsP/2r5IAiSrRiJvny
         e382pX2BcvMuB+JR+VV/XMCix2Ub3juIt8MSeQbcsvwyN5IkjQEc/deoAwTc2AfIg+tJ
         OS0U1ldDrSiPujWiFXG/Nlhkjggtlv62K3c26HZ9msG8/6ExJTXAqt4GLvekIeF+2+7E
         BruSkCRsVTszB8Qe79/ynsvN/3ZeyiVy+ttHTfokJCgoHTDadJne/r/OkE0j8wg/8WSG
         C/MJiP/ioezR3OINrvd8e6w8qA9PJDSF8FFqxmz8kT94fusgNw+JzExY64nmNyOaZQFs
         sk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMLtPt3sF74Mw0F2dpAa3S1gWPERhEEOZ1M/tczB1NI=;
        b=cPsk1Cn+8tGUuPhz783Vp//eBRQHcIIvjVnq1R3rcKVupSGvFN6HZZorLCDHr8bsrr
         LpdxVI3dp1XZQ2BxO+S/oHN8XETNe4pyygLZLwke9NXjM3ZW+8S7lMbjjQb/QPGvdySH
         UveS5vwAQ2y+l9blGlLro1aLJOfqMD/EGLYsGXBrjGtB7Ew3dx22+utjTfa52qgOlaJH
         eFDxg20NVHt8VCNAk6aIJ7dnEL1G3vZnmIDzcHJVTid4/YAAIMJ+pkdHCdkJX5cmcz12
         WYei9mzskxqxIgvtagrBwbfv6WlJdzWanRRhpDk+SBe5RUwkh4bU+/3bDYmhN14tqzmh
         9MRQ==
X-Gm-Message-State: AOAM5305CSmgwJYe3CJJJ+kt/8csZHjHQNtTUEssCr6QfZdfbi8xAV45
        LXcONiWHmVmcl0i2lKRD/US+jsfkCig=
X-Google-Smtp-Source: ABdhPJxChmiK/NAHXke1LB04uOMSEmByquvEevmDvhdaN/ihuqb9Gm4kqyQmKehIAjJ/ZWtA4n4EBw==
X-Received: by 2002:a05:622a:186:: with SMTP id s6mr1755487qtw.376.1642264178803;
        Sat, 15 Jan 2022 08:29:38 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.gmail.com with ESMTPSA id w14sm6090347qta.6.2022.01.15.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 08:29:38 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Daniel Gerber <dg@atufi.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/2] unshare: some idmap fixes
Date:   Sat, 15 Jan 2022 11:29:24 -0500
Message-Id: <20220115162926.546843-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This series has some fixes to code and documentation around idmaps.


Sean Anderson (2):
  unshare: Fix parsing of id maps
  unshare: Fix doc comments

 sys-utils/unshare.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1

