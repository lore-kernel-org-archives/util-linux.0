Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E27C433EF
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B3361507
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhKQCNo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKQCNm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:42 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C9C061570
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:45 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f20so1201150qtb.4
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HWtsI5h2DEUWL+/lY1qwckXPr6zw+S8gYQnckmOSfg=;
        b=GQGyOBytSpXaz0TdzbgV7uDUMPRQZXFhkSn0J297/wmUHv9gUANZWP2WMDKQ2dfuoe
         iUHhwDzszUevrdz3NJeJa3+3Wiu+1JU/KT28zfL8IcbM7cl1eyX5AGC6yurtO2EUZSzP
         +fHNCTIA2eq5eYGW0oEdehRfUrg7yZpay+g4WNULU8x6n32zVz3MK11XxJN6b8GJyWQ1
         w3mOVoS4LmBR+yByerD5ujj5pQj74dkASja+hI67/oPdC7yYP4i5Qp9Bq4U4N7lDpmMS
         Y9AV720AuqTNS50f4N8bJUoHVU59YmqSZnS+0Qbzrd44CapPU98jYxEfJi9nCX+KNASB
         4P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HWtsI5h2DEUWL+/lY1qwckXPr6zw+S8gYQnckmOSfg=;
        b=5kpnmNUoxwPfjOuyTD3mPytz4t11MCgJjog+pqmsCw8txBE5R/yx38kPnKCHC6jhvW
         jkDBkXFfDRinfKJ4GA27h5kC63RuNWDCzXk9XqL8jKRGTrLXPeJ7eVyVeEifNjqQJLsd
         TYPJfhZD7I0TmGOKydEnh05UPrOTrPehH3BtObDPAebv0nMlR8Y+H4TEYpfP2dLB2qAz
         O1MZm2stDu7kIk6pnyyD2Rlxpuy0+GR4I9yRn1eUAeeyqQmNYrPfV7yv70ujaFhAdKAB
         Y5nR0PB+7p6g+2s4I7JSpQNLb42DWfNba6Xrwce5UalRrsuAic/Fy0z3DWxqG8+mM79h
         Ryfw==
X-Gm-Message-State: AOAM533hSsn/BjoQgqi/0x0wv2OMPJ3nKdlKcygMUIdMP/8+hBJz7zsP
        z6vEVb19YrEcleEUYZuSwv2xS2fSt+E=
X-Google-Smtp-Source: ABdhPJwMcp7cCbrCOIz4GcAyimeYRL3jkBMsASI3XAxuPZ77ubzVFw3JL+W2VKrQEHNSA1dT8uC77Q==
X-Received: by 2002:a05:622a:1102:: with SMTP id e2mr11421530qty.194.1637115044382;
        Tue, 16 Nov 2021 18:10:44 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:43 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/5] include/c: Add abs_diff macro
Date:   Tue, 16 Nov 2021 21:10:34 -0500
Message-Id: <20211117021038.823851-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117021038.823851-1-seanga2@gmail.com>
References: <20211117021038.823851-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This macro calculates abs(a - b). It is especially useful for unsigned
numbers.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 include/c.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/c.h b/include/c.h
index 354b59e29..ba799d8fd 100644
--- a/include/c.h
+++ b/include/c.h
@@ -159,6 +159,14 @@
 	_max1 > _max2 ? _max1 : _max2; })
 #endif
 
+#ifndef abs_diff
+# define abs_diff(x, y) __extension__ ({        \
+	__typeof__(x) _a = (x);			\
+	__typeof__(y) _b = (y);			\
+	(void) (&_a == &_b);			\
+	_a > _b ? _a - _b : _b - _a; })
+#endif
+
 #ifndef cmp_numbers
 # define cmp_numbers(x, y) __extension__ ({	\
 	__typeof__(x) _a = (x);			\
-- 
2.33.0

