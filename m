Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08AC433F5
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhKXS3m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhKXS3m (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:42 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCDC061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:32 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t34so3592787qtc.7
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg12aE0nc6JQPV5omf/DDBaxxes7OlML7ESljWL0Pfk=;
        b=QpLu0UqGfZCrLXB6iEU3D7p5l1tKLVRv5FXKPx/7oE2P2OLEdW3sSJ4jINVjt5xKTo
         xU9xRC2tYhqsmUUIbXqWTzOARzE+5gZ4ROKzoC8cDR1U8TD/AfaWoGAMryfv0PX7erIS
         ddokF3FWrobwdC0s6G8e2KO1IvhzM2Ve8a8LCvLT1Lc1Td+eKoOjsapThI8j5ZM8g+DY
         WyFaA7BHTegaUM+bW8KEz4hOFZkdMb9l6FLYN8ttfiZY3d0MzL38sVJn/4XJGnWynNCt
         y+Xz4vp6/h68XejxXk0B50dTNoLCunumL5H40JTajC0eNSsMEkO4SWL/WPDytN+AaSZ/
         5UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg12aE0nc6JQPV5omf/DDBaxxes7OlML7ESljWL0Pfk=;
        b=PxGrtW9gXspLV1FdDv7YEOwlxE+728xmtXRblT/Uip8KDDMsnh5p1A7OIyN3ydRJfQ
         qM0SavgKApRhrdvHc8aNitc/BCgOkW/fJFMaJlnK5g5ZOZ87APLM6pbIQRWAsRlLB182
         Tmjp1P5YMdvTFtjkOMnpQ7CPWSY7wHM0P6pcy6sNGC3Lc5jNMuykva/n8RhzDuJR59ff
         milmzTwhdmL6/oJGgfsLWtTyIHHOXMsHekd65WKDZBKn72syNIZ9y/z9ReosPbUPULZh
         M+NjVferUur1CNmMK/iAsopvkzw/nRt3hFcS5405tRD9dKa7igRp261kQot6JneuTyaM
         +THA==
X-Gm-Message-State: AOAM530bN8MnyfRAeJV/xfSQXgOai4SUhjinRl1sd0sfgSKoAa4C46le
        1a5CnxebtrcLLH9dM/4y64OkpK46jWk=
X-Google-Smtp-Source: ABdhPJzrQVi3On50eIqhsT44OFTaQClrQXvSuY7SpCCqkMhS6tsXpy5XtR5vQvIjZaYvQi4Ei2/6EA==
X-Received: by 2002:ac8:7f86:: with SMTP id z6mr10083251qtj.162.1637778391251;
        Wed, 24 Nov 2021 10:26:31 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:30 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 1/6] include/c: Add abs_diff macro
Date:   Wed, 24 Nov 2021 13:26:13 -0500
Message-Id: <20211124182618.1801447-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This macro calculates abs(a - b). It is especially useful for unsigned
numbers.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

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

