Return-Path: <SRS0=zF+j=7F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC17C433E1
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362DF2072C
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/1ml1Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgEWGng (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbgEWGng (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7FC061A0E
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s21so15485613ejd.2
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8qo7pIVVsKSRQER4Y6h+x6rDJy9M779FF/daMop78U=;
        b=m/1ml1Rl84mw+WOyPEKt2dlS2KteruvsvEzuvkLeEjRiM+WFXJ+a0HwHUfdRsREyXI
         7mv5KzVSrVl2jp5hVRPW79rdLaP6nsnhQS0pA5GQBpuxnyYCty8OgwKCm3V6CTUd9uhd
         3KpFiUm7DBXBx56mYGLLpIHul6ambXMP8uypFxVMmrdegbpHkvAP4v6AQU7DGPemMqwI
         Z2gClhhDQ/hEaHnJaUbDubiwEcWaAAp4Ih3plOr3Vp2qljjfzHgVkr0MIHKUD/D4BPam
         BKhmoKEoP3XiBF0jZaIxfy8W1oVSKFvr7poX4QsI/9R97edRYzxzPgcYAEqneyRT6pYV
         1ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8qo7pIVVsKSRQER4Y6h+x6rDJy9M779FF/daMop78U=;
        b=PwSiavVKgUdz1erZYRQqwbNUJ6meYiqGjLqGx+2au1mJzFU701x3xmyOGabi2n07Hp
         tNrT8JHosOdSeDYDOHDXkH+e73LZ1F0vafQkSC7ccOjhF0fapBw9goGvUR5Jea2UBApG
         /SK0im+97Udwxz9CdYkc2uDTcPO12WDDtGxcEzcHJD3GVDop4QmEI+M7mCYglq9yr/u5
         d3nSfskHtVoGtMhFBTKlCPNm7xWbNHGSHiodQf6h0+FX9EZEpO188bACgCdf7ceheeZg
         xCQ42Ie91+pvhlCiszkS7D2sL7ilYfqMS28D2dsvHlRh7c47zpY8l72IonrXo4xQAI6O
         EcEg==
X-Gm-Message-State: AOAM533V1FwvwB2Q+HQoaBCnnJt7HxDAVxL1GoNgK7Y+0fwX/MXAIcit
        5prfqmQB5A1YzgY9MVbWZEA=
X-Google-Smtp-Source: ABdhPJyC+Y/8Woewjwj/fH9FtcCAF5JmIl8WCQUMm0WZ8Bn0MCr5haEfuS81SCEcFUJnX5/Ywsu3MQ==
X-Received: by 2002:a17:906:8402:: with SMTP id n2mr10768467ejx.26.1590216214553;
        Fri, 22 May 2020 23:43:34 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:34 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 5/9] Manual pages: nsenter.1: clarify the intro discussion
Date:   Sat, 23 May 2020 08:43:21 +0200
Message-Id: <20200523064325.78491-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The intro paragraph talks about entering the namespace of other
processes. That's not quite accurate, since nsenter can be used (via
a bind mount) to enter a namespace that has no member processes.  So
rework NAME and the intro paragraph in DESCRIPTION to remove mention
of "processes".

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index ea924f909..147137bd8 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -1,14 +1,19 @@
 .TH NSENTER 1 "June 2013" "util-linux" "User Commands"
 .SH NAME
-nsenter \- run program with namespaces of other processes
+nsenter \- run program in different namespaces
 .SH SYNOPSIS
 .B nsenter
 [options]
 .RI [ program
 .RI [ arguments ]]
 .SH DESCRIPTION
-Enters the namespaces of one or more other processes and then executes the specified
-\fIprogram\fP. If \fIprogram\fP is not given, then ``${SHELL}'' is run (default: /bin\:/sh).
+The
+.B nsenter
+command executes
+.I program
+in the namespace(s) that are specified in the command-line options
+(described below).
+If \fIprogram\fP is not given, then ``${SHELL}'' is run (default: /bin\:/sh).
 .PP
 Enterable namespaces are:
 .TP
-- 
2.26.2

