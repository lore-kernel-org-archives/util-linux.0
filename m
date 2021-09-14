Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD0C433FE
	for <util-linux@archiver.kernel.org>; Tue, 14 Sep 2021 22:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89D160F51
	for <util-linux@archiver.kernel.org>; Tue, 14 Sep 2021 22:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhINWJQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhINWJQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Sep 2021 18:09:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE694C061574
        for <util-linux@vger.kernel.org>; Tue, 14 Sep 2021 15:07:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 5so346064plo.5
        for <util-linux@vger.kernel.org>; Tue, 14 Sep 2021 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38s8PnPyKeRDlekeSYK3CEt0PDWbnPGxffjCKx0nOAc=;
        b=HyYIOiGX/TzJiDUCc/kGFf32rGSBJMiTRS8CHX0QB8Ztzq7xGlgSU4cUlLcZBiBpg1
         Wva5kRHBLFpq+I0GOJ51IqOE1bewr5ZzuTQEKj7CyMuL0jb7NA8VK0d7vHXBHV5m/pMv
         a6599IO7ucCvZDhOD/3xAV3G4vLe0iKu6vud5m8dvETQFwC3sJ9S0s87Q4y0oNo5evJL
         ZcH5lN3d1/zcIRkOawUgUsbfajLyTQFLfWZ6KPafrs/V32NLVYZc5HtJzPgUt52hRYJv
         2HpkJg2ypNpQVOsrjqI3qJb+kuVL3KCA7vmDXnEoU77j2ziJ2PczPReMFEMGgPbGiSBo
         4QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38s8PnPyKeRDlekeSYK3CEt0PDWbnPGxffjCKx0nOAc=;
        b=cyZxrkjYeQWI5KVc5oq+zFLOwpJXEGhJ78xynDmbMfw30zJFcT8J4mPBXtSjKRArqK
         JYEJ3bkMJrZLQauJqaZmHHJmZn3gVuEw64h4OIRQqYJrkwIFIp1OPJYsdmafwC5p0PQE
         jLfNtgC3pSCTpg4MZwEZ8oaOo/KlHYUEDJ3484IDFQRg+3PSCqAqf3/8KVjxpaJuv2BP
         x60gpzxtJD6i0a6GD1sa5h1qOePmm7uWz7/ggPbUvC+Gs+XdaWSIJknwb6jB8W9U6bwh
         egCgJi4NhayjOnB5F/kF/jYCp+CEvAvO2Ayki5FvKpbtu7JaAXxK5E+TCydJmGVSjL9P
         tEvw==
X-Gm-Message-State: AOAM5300N/J0+6JonSiMTbaKSh8C+gr5atZxK5PUQpe2WvsBBaXswEx1
        DEKNppITgFfxpWmgg6qcbghc8i2VaZRVO/z4
X-Google-Smtp-Source: ABdhPJwAAdnSDDALT/44QnPQIqhP0dwL9B/UKj1Nr44pLftdPK77EXLHZt7X9I2DUxvSpfw7rkMVKQ==
X-Received: by 2002:a17:902:8a90:b0:139:f0fd:5349 with SMTP id p16-20020a1709028a9000b00139f0fd5349mr16822739plo.53.1631657278097;
        Tue, 14 Sep 2021 15:07:58 -0700 (PDT)
Received: from Rajdev.localdomain ([49.156.64.163])
        by smtp.googlemail.com with ESMTPSA id z124sm12302821pgz.94.2021.09.14.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:07:57 -0700 (PDT)
From:   ritikrajdev <ritikrajdev761@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     ritikrajdev <ritikrajdev761@gmail.com>
Subject: [PATCH 1/1] more - Bug Resolve - new line separated command execution
Date:   Wed, 15 Sep 2021 03:34:13 +0530
Message-Id: <20210914220413.65881-2-ritikrajdev761@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914220413.65881-1-ritikrajdev761@gmail.com>
References: <20210914220413.65881-1-ritikrajdev761@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

---
 text-utils/more.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 6c538f724..72953fd8f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1285,7 +1285,7 @@ static void run_shell(struct more_control *ctl, char *filename)
 	putchar('!');
 	fflush(NULL);
 	if (ctl->previous_command.key == more_kc_run_shell && ctl->shell_line)
-		fputs(ctl->shell_line, stdout);
+		fputs(ctl->shell_line, stderr);
 	else {
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
 		if (strpbrk(cmdbuf, "%!\\"))
-- 
2.33.0

