Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92CDC4708C
	for <util-linux@archiver.kernel.org>; Sat, 29 May 2021 01:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7620613F4
	for <util-linux@archiver.kernel.org>; Sat, 29 May 2021 01:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE2BqZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 28 May 2021 21:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhE2BqZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 May 2021 21:46:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A2C061574
        for <util-linux@vger.kernel.org>; Fri, 28 May 2021 18:44:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f22so3827844pgb.9
        for <util-linux@vger.kernel.org>; Fri, 28 May 2021 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WzuG/nxaFx5ugQAxMAjVYzlCQnkeGWtV7/k+iDwlbdw=;
        b=sBYb7SBLJNHzvtO87CRdlGpdsvuo9UvJckI/WgTjI7/2kyngneJ8lpslN5tDNCNPoe
         wajLhdmGIInV4mQh3j1CBex7UylzHxUD72rYnrGlg0wejM1d4tJUBUpEtDj3yroBmnYB
         bX0fvCnCMS8sDBZNBMz+F4u7NLIVIyOMWTs+TveQRU6f687Rj0P1f59xuoGi6uHloRIp
         pHmY9qIqzHgO5KhexGUX6t+r/Kp3XQAGaKR9LiyUNCM3BlTvaTF4AU8vQfWql5QwjNhA
         mXn9HzoV+UPNWA+Hro+8IOuH3cUJbreXoV8yWAhr89+WITs1NK58PZFMKiUqtjUJAjMF
         2FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WzuG/nxaFx5ugQAxMAjVYzlCQnkeGWtV7/k+iDwlbdw=;
        b=N7RjN1NuZKu3ywK4+3hmIh5sGznL0E5uyKUrjIGX8PzhS5LrHFy1ZA6jJMQLS4858C
         6RRV/Uq25rYnYrTLcGf9HGRNLFAck5J2lgyhV2GRIw84Ah0zmgcrtIL0dvuOiREO7qyB
         0G5d/Lh2AMX8BMCShkrVn36HOvRvXXZqfKPhLrvI0v+XqJcbp0N0LdHuvHhuhqxjqq3i
         kWZYyJuyQ6pJZf8klqMZzhEoDxphII6rNSCUPtSfgk3lxpaW2mjMoNa25vF57jX2VR5J
         apeYYzvDw2jDk9FN8UJZRHS4Ufh4eRqSMDvQ+cy5P8ZCksfuCgcyyp6OU5JrLsCdy1QH
         cGRA==
X-Gm-Message-State: AOAM530JdWqzi0eels27tx5jgr7lD56+HRuBsXDmowyS7bYisA9Ahd0g
        h8i/Hr3hh4gLgZ4vRW7kZlk5DzGahB4=
X-Google-Smtp-Source: ABdhPJwNaVc11TWrQ01tGFNBwjRGZ3ZoiK7rMZACvVOTHwn/jIHehsbfHfkpVSReJ0bYMmitHjLmtw==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id w185-20020a6230c20000b0290289116cec81mr6657584pfw.42.1622252688247;
        Fri, 28 May 2021 18:44:48 -0700 (PDT)
Received: from marlonpc-debian (pa49-183-171-130.pa.vic.optusnet.com.au. [49.183.171.130])
        by smtp.gmail.com with ESMTPSA id r25sm4437574pfh.18.2021.05.28.18.44.46
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 18:44:47 -0700 (PDT)
Date:   Sat, 29 May 2021 11:44:44 +1000
From:   Marlon Rac Cambasis <marlonrc08@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] agetty: Change size_t to const size_t to match other
 function.
Message-ID: <20210529014444.GA2525@marlonpc-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In xgetdomainname() it is 'const size_t sz', however in xgethostname()
it is 'size_t sz'. Add 'const' in xgethostname() to match the other
function.

Signed-off-by: Marlon Rac Cambasis <marlonrc08@gmail.com>
---
 term-utils/agetty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a48998c16..eb7959d34 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1476,7 +1476,7 @@ static void auto_baud(struct termios *tp)
 static char *xgethostname(void)
 {
 	char *name;
-	size_t sz = get_hostname_max() + 1;
+	const size_t sz = get_hostname_max() + 1;
 
 	name = malloc(sizeof(char) * sz);
 	if (!name)
-- 
2.20.1

