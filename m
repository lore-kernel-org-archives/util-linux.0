Return-Path: <SRS0=8RqP=EP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D4C5517A
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 02:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160CC206B6
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 02:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0CvwqMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKIC6S (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 8 Nov 2020 21:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIC6S (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2020 21:58:18 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD4C0613CF
        for <util-linux@vger.kernel.org>; Sun,  8 Nov 2020 18:58:18 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id x13so2051521qvk.8
        for <util-linux@vger.kernel.org>; Sun, 08 Nov 2020 18:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNRZ5newgbnibLCf7GWC9OYJ0UMYndwCIVALEsKud7M=;
        b=C0CvwqMa5f3IFbyLC3HdRQxmK/eO7mjrx3XjHYugMq5z3BxrIgKqgNX9GxjXbja45B
         HrG2juJO4250gqN4rKyi00Ch8Ckcd60ur4/0xqNRT5VlzoMU4sDcfAH6wILk1KhfTOQj
         pJYmx3LeKqaICpU9tdbhdK8JdkQvTqDN8iT9ZaLvw0V85FHZumhtQ9hIsT6jYwMwyKEa
         xIeE+UkhmbsW9IMeUN0liYpkG8bTGqU5NC8o9SU4tOdncsrPu5WE14cuRwnvKtXLYohD
         EZdT/EM1jE5ShOd+3iyqD/i0IvtGnEuQ8bTCEF4Hkifnp2jLchox1dWMvHxFwFnAzrWd
         FXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNRZ5newgbnibLCf7GWC9OYJ0UMYndwCIVALEsKud7M=;
        b=TvQdjSgo68/Jh/4CZx3h0/EzonlXx0ftM6ipYXsOle3VF8OWX+qSH52zfEN9F4eYrH
         niFIs4mJ1wfrK/wpOqv1+JZyafnZBdEW9wiHtW4YDJqiGGvj/nAAsdxc8sLB0s7qjDoZ
         UMpon3VK60QEcHOpMLogYfrzjhvd/LbsIBQ1zldivu27XjGb5ALVCtHhUBOeN7kSvcmk
         TeZTJ2zYPgkAAt0TF5EMdjazTfPtYmewZi6VIFidm4TBKMY1H2NDb66KqWqeTEa/kU5S
         rki3419y+2T4YoEC/O6KHagInCAeKMfGY3pZZxlCS5EEGM/FmAEg8XDKxy9P3SLai1gt
         OoVg==
X-Gm-Message-State: AOAM532FYf287cdxOdnRCrHZWm2ALEHjiYJ5ku67FajexQy21jbe++NS
        C5gnbcNX704nfTHIXLdh4FZhyFUVRg==
X-Google-Smtp-Source: ABdhPJzytAnEdBq3HUnkFcyfJnbX9GBFthYaCdnN8Jvt3HQ2fJYTtkLC9IFYmOvomeEAMngtLHatvA==
X-Received: by 2002:ad4:5685:: with SMTP id bc5mr12723203qvb.48.1604890697548;
        Sun, 08 Nov 2020 18:58:17 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id b20sm5663387qkc.33.2020.11.08.18.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 18:58:17 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org, jbastian@redhat.com
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 2/2] lscpu-arm: Remove hard corded model name of Cortex family and X-Gene
Date:   Sun,  8 Nov 2020 21:58:06 -0500
Message-Id: <20201109025806.26567-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109025806.26567-1-msys.mizuma@gmail.com>
References: <20201109025806.26567-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Remove hard corded model name of Cortex family and X-Gene so that
lscpu can show the model name using Processor Version of SMBIOS Type4.
---
 sys-utils/lscpu-arm.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 3f258a710..6ece27349 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -53,37 +53,6 @@ static const struct id_part arm_part[] = {
     { 0xb36, "ARM1136" },
     { 0xb56, "ARM1156" },
     { 0xb76, "ARM1176" },
-    { 0xc05, "Cortex-A5" },
-    { 0xc07, "Cortex-A7" },
-    { 0xc08, "Cortex-A8" },
-    { 0xc09, "Cortex-A9" },
-    { 0xc0d, "Cortex-A17" },	/* Originally A12 */
-    { 0xc0f, "Cortex-A15" },
-    { 0xc0e, "Cortex-A17" },
-    { 0xc14, "Cortex-R4" },
-    { 0xc15, "Cortex-R5" },
-    { 0xc17, "Cortex-R7" },
-    { 0xc18, "Cortex-R8" },
-    { 0xc20, "Cortex-M0" },
-    { 0xc21, "Cortex-M1" },
-    { 0xc23, "Cortex-M3" },
-    { 0xc24, "Cortex-M4" },
-    { 0xc27, "Cortex-M7" },
-    { 0xc60, "Cortex-M0+" },
-    { 0xd01, "Cortex-A32" },
-    { 0xd03, "Cortex-A53" },
-    { 0xd04, "Cortex-A35" },
-    { 0xd05, "Cortex-A55" },
-    { 0xd07, "Cortex-A57" },
-    { 0xd08, "Cortex-A72" },
-    { 0xd09, "Cortex-A73" },
-    { 0xd0a, "Cortex-A75" },
-    { 0xd0b, "Cortex-A76" },
-    { 0xd0c, "Neoverse-N1" },
-    { 0xd13, "Cortex-R52" },
-    { 0xd20, "Cortex-M23" },
-    { 0xd21, "Cortex-M33" },
-    { 0xd4a, "Neoverse-E1" },
     { -1, "unknown" },
 };
 
@@ -110,7 +79,6 @@ static const struct id_part cavium_part[] = {
 };
 
 static const struct id_part apm_part[] = {
-    { 0x000, "X-Gene" },
     { -1, "unknown" },
 };
 
-- 
2.27.0

