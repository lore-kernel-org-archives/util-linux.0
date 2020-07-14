Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A70C433E4
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96075221FD
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fksMKOXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGNJ6B (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ6A (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 05:58:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E093C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w6so20853394ejq.6
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nq1UQrv6d3Uxf0kjlhPu7GL7WRWZq3v7c2ss68/wPtM=;
        b=fksMKOXTN7IXfPWaoIGnVMkqOQq4yRJNFZ6AhypBfg7I6xZo27BkwN8seCyixn0xWI
         H3ianevbY+oqVR3OkZj9GOuERPHRSjbnAxFVIMa44oUWesnFmVUwstbvos22O2AFccYM
         /GG8MMXR5CAKn68BXht/dC3x1wMtDXbvMra1HKe7TZWGoGEEajI5KgrbHIe5Abb8HrKX
         seCW2reac12FfR8v7b7nC5zCucA+5ayXp6h8uI/1vvqhhA/7yPFW6L+bn0/AYN9fIvHe
         jniphZAlNVq8N+7tKQjjGkuQ6ZjCcB6WjH8Ng/UdR/02Pm68V9HJ/6yW31s1/1nkWScQ
         TY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nq1UQrv6d3Uxf0kjlhPu7GL7WRWZq3v7c2ss68/wPtM=;
        b=CuYyhct4D7zL8Hp9H4tN0lbBWytIIqzGSjbRwUPleRobcFdZmo3sf33IEC7lqcpx7Z
         aOZ7C6KuNsiJ0NLOrNuT9c15BhvbgCU/5v82cJwqB2+RVTfr7pnm4A23CYN+dUuNSqhW
         w1iJUF7uuj/nwRpBbK1BxZPrRsv9zmMJ1JspgphQK07x/22hYtYtHWzIgLuQwLPYJz4P
         N/P5Ze4B2KadDFJVyBb9Rps/jBOPBmZ63L6MjpkawvCUb/wvEyoD+9ryTik+Q0/9ZTHr
         XGY8yfrb3e1IFFabyHJRjMcw2ni9oWO00II3VXY5fmmGPPVHT77M1Xd3SvfVHRPvAAfj
         +zFQ==
X-Gm-Message-State: AOAM531asWb9k7Nppl4qw/ks06bUR0hYvvYml66nq0+II+pNGEUf78jU
        bMI4MBQtR/TSukcbmlrDKFjCA0vI
X-Google-Smtp-Source: ABdhPJyvcuIgIucmNYuG7MOyVdDpdYy9L1OuV/oXUBTfDoig4i+2S1H/yJPV4YcDw9IbtdCPkBHOPQ==
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr3667057ejm.206.1594720678935;
        Tue, 14 Jul 2020 02:57:58 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c9sm14119803edv.8.2020.07.14.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:57:58 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/5] Manual pages: login.1: SEE ALSO: add utmp(5), lastlog(8)
Date:   Tue, 14 Jul 2020 11:57:38 +0200
Message-Id: <20200714095741.45292-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714095741.45292-1-mtk.manpages@gmail.com>
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

utmp and lastlog are referred to in the manual page, and thus deserve a
cross references in SEE ALSO.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/login.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 57959d45f..3c72480c5 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -376,9 +376,11 @@ Karel Zak
 .BR mail (1),
 .BR passwd (1),
 .BR passwd (5),
+.BR utmp (5),
 .BR environ (7),
 .BR getty (8),
 .BR init (8),
+.BR lastlog (8)
 .BR shutdown (8)
 .SH AVAILABILITY
 The login command is part of the util-linux package and is
-- 
2.26.2

