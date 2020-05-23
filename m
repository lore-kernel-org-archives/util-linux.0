Return-Path: <SRS0=zF+j=7F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8DC433DF
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DF3206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXttw3v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgEWGnl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbgEWGnk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0FC061A0E
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so15431376ejd.8
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wh+LnhLbF/eOXcaz/YDRND2HkJeCGWnfa2yzBGsqDjc=;
        b=JXttw3v94q4ppDpQu1cRkaTRYVvwFj8+De5ZR4WU114D4APQ61dRv0LpKWlL5PZyyZ
         Ba9qdtLmnh9OnSbeOBMllNP0M01ypV9jD/qIMeoKs55SB8y4Ah8oup3dbbW3hBN2UUAA
         PibyidO0jiYOgMEEzhDdW4ZwtyAH4g7d4o/izvDzCgEtKoJ13hFOg63/HRzF9OUXU5sp
         HUaA/AsZzfuYjInM5OqFqPkrLsqmp3sjQ4v2r1L4JZ4FCQ/MqfqR4w7dJakUgddam57M
         Araqzm3uKyVhNbw2oRBsqAY8h0j+H0iIuOVwLSW14E0Ly9m3DbQAl2DwIijej7WqYWNc
         vvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wh+LnhLbF/eOXcaz/YDRND2HkJeCGWnfa2yzBGsqDjc=;
        b=fYwrSbM0fEoy8it6Fqk19gtDrVKBc+6fyurUXZH/Ede8Fhn/CbsbZej2wA6c/A6eup
         u9TYhPfQ9xVULTNJjf1XbAQAoBYyCKFA9cLTOAqUZ0E+mUvxkjz2qqabxw3mENCE55f+
         GE341tPUMSxqootwfEqorGE96evjRFS9OOYLInddQl1SX7P6ENP5Hw6R6cjYIqQMwc/q
         CWT12spFetJ/wbZdh1RvBC+yL/MX9ZtEpxZcBvkdtuwW/EbT/uVBu9ek4aeOHiJkh/hD
         wpLPNFYy+riAk0NUy0mkBPk19JGVoAMvIhcrJa5uVlkpAOROCdyA+U2RsrKHR1GEQnop
         fsKg==
X-Gm-Message-State: AOAM532d3KORw08NLBHBZEbmqBHU6RXq4AYZQ2AEDIlfpzFyybxBUMVu
        ExNYnRxLpMBlNiiKMcoLGJE=
X-Google-Smtp-Source: ABdhPJyKNJMMVmftYYJuCqjKFFK2zvNlK8SLpVkKrCJd8TCR4e+lA0jBhZvnne5MRwsBRuusTAGeAw==
X-Received: by 2002:a17:906:3607:: with SMTP id q7mr10713996ejb.81.1590216217793;
        Fri, 22 May 2020 23:43:37 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:37 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 9/9] Manual pages: unshare.1: fix examples, part 3
Date:   Sat, 23 May 2020 08:43:25 +0200
Message-Id: <20200523064325.78491-9-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The time namespaces example had no explanatory text!  Add some.
Also, use the "uptime -p" option for output that is more compact
(and perhaps more readable).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 38f7a62cf..679f93715 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -372,10 +372,17 @@ terminates, the processes in the PID namespace are not killed:
 .EE
 .in
 .PP
+The following example demonstrates the creation of a time namespace
+where the boottime clock is set to a point several years in the past:
+.PP
 .in +4n
 .EX
-.B # unshare \-\-fork \-\-time \-\-boottime 100000000 uptime
- 10:58:48 up 1158 days,  6:05,  1 user,  load average: 0.00, 0.00, 0.00
+.BR "# uptime \-p             " "# Show uptime in initial time namespace"
+up 21 hours, 30 minutes
+.B # unshare \-\-time \-\-fork \-\-boottime 300000000 uptime \-p
+up 9 years, 28 weeks, 1 day, 2 hours, 50 minutes
+.EE
+.in
 .SH AUTHORS
 .UR dottedmag@dottedmag.net
 Mikhail Gusarov
-- 
2.26.2

