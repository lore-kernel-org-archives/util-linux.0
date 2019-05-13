Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F1C04AA7
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49652085A
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWEMtW/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfEMSxa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 14:53:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43103 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSxa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 14:53:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id r3so16002584qtp.10
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlJBh+6xcRyjFrIbSy/mklU56YodQiuI7NRxhlACUpM=;
        b=EWEMtW/n/+c+wYt9AOoACYSP0iwe5BFmVwZrDluAxK6xqlMXQVyaIbEO8h7ua/UkXq
         5Ou4mWwQe1lZ4KUQJvTJ4UfVhQRguugQEjH0/+L9mCzoLbsDpF4AkTrygzST+5CBIM+n
         frA9exiECHszNhSYfRwzQ+j9/xtfjBdjYOvwRGOvDpEwAA/lhlsytZSOueGm3U7nbv55
         jE8u2174wFC9cdabhVBcFzRrm1GmOAzVw1phYy92PuuaLCU4MzhEg1e//muJZOPs6qJA
         vdp592v3IFkDsnwgDdStcabZnRL66cRMeB9E+Hx0uLCNA0iUs8MS73YG/jF3Jt+lbTA3
         lFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlJBh+6xcRyjFrIbSy/mklU56YodQiuI7NRxhlACUpM=;
        b=mUC8nBicV9QPSTrx27Ryz0HvYx0S6/5gucjUexLFtQzY0D49Dmpvciv9r4jABgh9PO
         6dwxyDqJgzB70L1hWr4WVLKxALHCaqtDkCFt9lyTSx7Lrm/1gd6zAJ51a/g0unU9HO2t
         gakClTUZyFi6l6YfGZIOPr0p04xKhw//OlstVid0naq9uCub9vSJEbSpeSnTGUQbPwbh
         vsou7/gpGQA1dILYEmzBZlJxV+hTYE0QzWBrvPdDWte+jrLhuQkUgdWqIh5Sp1QKpTvP
         tN6I4DCp1kZylxAJTMuPD21WEuGe1hj1yqoO17+YjbQuyLDiSd2lOX4Vv2lrWVdmyPQL
         FekA==
X-Gm-Message-State: APjAAAUx9iY3n/JsUDkRhlTewRsf9oBUctnSuelkWOglQO/13gC/mNsM
        sjYrrmQOhpyrWoWPjyDp+nszyZPg+jY=
X-Google-Smtp-Source: APXvYqzqYLlq09YfMyJyLPoQMfjBkPumCuFJsS4K9ht9HPU4JXHTRJlT6GXpPuVtchZ29k5E40Medg==
X-Received: by 2002:ac8:2617:: with SMTP id u23mr26167738qtu.141.1557773609120;
        Mon, 13 May 2019 11:53:29 -0700 (PDT)
Received: from austin2.ad.gaikai.biz ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id n66sm7577631qkf.49.2019.05.13.11.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:53:28 -0700 (PDT)
From:   Austin English <austinenglish@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Austin English <austinenglish@gmail.com>
Subject: [PATCH 6/6] text-utils/column.1: fix "maybe be" duplication
Date:   Mon, 13 May 2019 13:53:19 -0500
Message-Id: <20190513185319.28853-6-austinenglish@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513185319.28853-1-austinenglish@gmail.com>
References: <20190513185319.28853-1-austinenglish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Austin English <austinenglish@gmail.com>
---
 text-utils/column.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 84243b5bd..fd1aaabed 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -100,7 +100,7 @@ Print header line for each page.
 Specify columns where is possible to use multi-line cell for long text when
 necessary.
 .IP "\fB\-H, \-\-table-hide\fP \fIcolumns\fP"
-Don't print specified columns. The special placeholder '-' maybe be used to
+Don't print specified columns. The special placeholder '-' may be used to
 hide all unnamed columns (see --table-columns).
 .IP "\fB\-O, \-\-table-order\fP \fIcolumns\fP"
 Specify columns order on output.
-- 
2.21.0

