Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B175BC04AAA
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2712085A
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS//v8ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfEMSxZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 14:53:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46327 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSxZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 14:53:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so7090462qtz.13
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTQWBJ9nZCN3OVB+ZW3LgUH0z5T30W5Es2IqNKDKnZw=;
        b=JS//v8olvMJxr/05cvn7QIqsZmq16UKTiuhjwzhXNzyG8HZyDcUXPnUbHTFKtNKKas
         K1RsHXD4mW3DoSlGe8+CmzkYVykzER3+n9/iwUA+0w88fJ7UXz4Xi1sOjAftVthR7Zxb
         UdQ1y28v491NsWorDYHDlUpx+JlSCUeB+f0iLRUhaXDWGfES1H3MdmY23J4VcCDhh1Np
         MiVehl5pGrpQMTqdaOrytrob3KIUCM2kmGuvICGfXrEHBgkcIgbE/pfsQhzN+Cd/AAhz
         xFTCzgJ8PZVgkFMHX1sDp4X+FniKCiD7IHClzf1CWJnUoqSRdz5a2/Bkb2sAS+IXB8Nb
         sR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTQWBJ9nZCN3OVB+ZW3LgUH0z5T30W5Es2IqNKDKnZw=;
        b=JYxuhaRCo64TCGH6gF/N9JK3wytiHmZrBH4wECtuDiWjqXA3YLgXyRSAMqFjzL2Tsh
         hBR6cQqh4mp/9sTm+5bhwJJDAvXMy4h/LhEJ47b4381ZA9fZCcFws6/bMQDeM5RCMsOz
         cEPNUX+OBf6qqwcsMj8gopxqbdsIYgslma099yhzYguI9a8xQpDw5lRrlNX1XBNz/Wmm
         kzUgY/f49RKi7miWOrxJDi0R/C2kIcDxkpU429kru/Amid0PxhjZ0kZM9mRxV0e8kIch
         ZL3WaPWO9/Sd3Nya/74KZznL5grqhdwpuupRRoOxIQz4L0pbonsCv8164uXcij7ZmQu9
         L9xw==
X-Gm-Message-State: APjAAAWhzSnB6XbJFXUL7bLIhxDiWn0y8jEnN/lyuBa3NwcESer3qRbx
        2E3pLZ79DWyr0ZmuTmBOxG/ViTtQbjc=
X-Google-Smtp-Source: APXvYqzC/aFCMhpQErtKHN5/fTM2AvewgdxJTfMTmGz1iFRxVBe75WNlTwppqb53CEFuivNPek4XXg==
X-Received: by 2002:a0c:b4a2:: with SMTP id c34mr23440895qve.209.1557773603753;
        Mon, 13 May 2019 11:53:23 -0700 (PDT)
Received: from austin2.ad.gaikai.biz ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id n66sm7577631qkf.49.2019.05.13.11.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:53:23 -0700 (PDT)
From:   Austin English <austinenglish@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Austin English <austinenglish@gmail.com>
Subject: [PATCH 2/6] libmount/src/utils.c: fix "maybe be" duplication
Date:   Mon, 13 May 2019 13:53:15 -0500
Message-Id: <20190513185319.28853-2-austinenglish@gmail.com>
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
 libmount/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 7f6cc1405..73166cb91 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -913,7 +913,7 @@ int mnt_open_uniq_filename(const char *filename, char **name)
  * should be canonicalized. The returned pointer should be freed by the caller.
  *
  * WARNING: the function compares st_dev of the @path elements. This traditional
- * way maybe be insufficient on filesystems like Linux "overlay". See also
+ * way may be insufficient on filesystems like Linux "overlay". See also
  * mnt_table_find_target().
  *
  * Returns: allocated string with the target of the mounted device or NULL on error
-- 
2.21.0

