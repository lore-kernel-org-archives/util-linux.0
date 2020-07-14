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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E195C433F7
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62395221FD
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC+5atn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGNJ6A (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ57 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 05:57:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16C5C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:57:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a1so10942228edt.10
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3ukuiEs1oOfmsu19Q7ZUG5AQp+hRjVkEgUWQBFwhJg=;
        b=bC+5atn/a45XfYDmiSZmLuCGMhf4FmC19M6suxR7vJg97QAvRKjTK4zbbHd3DytITL
         a4/0LH+3NpMAEdmLgUuent/STfdUfhTZSACPCE+MKIQ5nKnP7gPZ3IBfxQe6vzKP5Q2h
         lMnh6KKK99/nianAhAorD9Vq1yTRs3XjElTm/qrq86ginh2aOGNrv6cBWSnQTiMdjNyO
         /8nH8wqtU0yUSLaTUFhjglhIK3m/kgup1a+S+Q/gX9XKy5Orfp2EdRNsCCGMKlw/6w2r
         9ZBj21G6+Tmvu4PNe7fC3gqqMWMcYNywJBN+G/vcHPjYVq3EJNpx8OPheea/RS4TS1um
         GcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3ukuiEs1oOfmsu19Q7ZUG5AQp+hRjVkEgUWQBFwhJg=;
        b=M1+DpQuMYDm31YemOXMeegaKCISkzawRUqBL/UwzeuOEnlOz7MggR3A25cAqD7ClRK
         3E6yId/b/c761yrnH1vIdx8YQYTdU3f1MsDsAMLLoXx8WDwvnGDRlT9wWiCQ1mmBJtCR
         g1fjgGFgteWLXpa2zGEepXDgdXqdmlQxAN7w3zs2P37EHzJQ3jM8cQ6j4LH2lDkd/Kz1
         5bvrX8Y5+xby5nHrJTcghNCCpL/fYcpN/xuH+ZVBDa5B3FdqvCwq2C+/s+1VBV5gDTx6
         HoMbRNbXQdkNEA0qsnvUFHczHtmE7FgAufyBPjl6qYEZd2iY3261nP1mED50g6SDcKgW
         nAhw==
X-Gm-Message-State: AOAM5319lcQl3CroSWzz4nCocodjK1o6AFg3VMsCMPCUPzTU2HBNgsdX
        T95UPMhv08a9O7NxxAAow/g=
X-Google-Smtp-Source: ABdhPJzKwDkjOtXDPNcbz8dPAZ41Nc6LLPOoUPVuGQMTn1nLVJYWXNne52jwk6mbM7OSibsbOovPKw==
X-Received: by 2002:a50:f418:: with SMTP id r24mr3595964edm.382.1594720677676;
        Tue, 14 Jul 2020 02:57:57 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c9sm14119803edv.8.2020.07.14.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:57:56 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/5] manual pages: adjtime_config.5: format pathname with .I
Date:   Tue, 14 Jul 2020 11:57:37 +0200
Message-Id: <20200714095741.45292-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/adjtime_config.5 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/adjtime_config.5 b/sys-utils/adjtime_config.5
index 0166461c4..f78b40f36 100644
--- a/sys-utils/adjtime_config.5
+++ b/sys-utils/adjtime_config.5
@@ -5,7 +5,7 @@ adjtime \- information about hardware clock setting and drift factor
 .I /etc/adjtime
 .SH DESCRIPTION
 The file
-.B /etc/adjtime
+.I /etc/adjtime
 contains descriptive information about the hardware mode clock setting and clock drift factor.
 The file is read and write by hwclock; and read by programs like rtcwake to get RTC time mode.
 .PP
-- 
2.26.2

