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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB72C433DF
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508B52072C
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZHiPKpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgEWGni (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbgEWGni (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C25C061A0E
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b91so10970556edf.3
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ksmBWzGSBLI9S+ryY4LsL+6OvSiCsT4MrwndbLNcssI=;
        b=JZHiPKpmFIOmQvdkROLI2kQvu7VJzdwO+wGHjmRydzXnMM8x6sa3G08xr1KvOfUS13
         iJvE5dusydS3bdOTRRHP1VtXsYMVz+9yl5/v6A1N8G9spYq+LEXp3qfSNLBpIHga9aMe
         +nJ8R5TOFxt1/W45bb7rVRlKHPVcEFeUHHzDGCT4RBzOOez7MOg0iSuSHG68Puc0cY5Z
         x64tCNJqOY7tuhpjPJry7xf0qjew3ayTnqG9uK+gwN6vxocRq98G4idmLmBeg9GGhYKZ
         X19JNlWAIEJNAHz6yWMyt+1tiemNYJPo5R8117bsNKYaUR0+QzFchlvkxXkeke7I0RT/
         wHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ksmBWzGSBLI9S+ryY4LsL+6OvSiCsT4MrwndbLNcssI=;
        b=QuPhheZrcWkjDUmDek6w0Gji6LcTql1hmyqpC60OB+aMQ5RSybAqro1cM3M1ffTp9r
         TyxRG2pqX9KD+9g6DX5J1FW75O+HLxwihvld1Jl4TGS1DRvVyNHGYQb+zj2Z0oKDkJKB
         jkMcWC3B70YylEXIe00UOhlWDo+p9Esfx4JzChhx2Da/OHWN3ZPWPp9XZ05lhYecRvPI
         03trBkfz3a2Z7u5MUdznx2/357cfToDGzebYMg472d/CzNsKVOUNeAZGFVMShSkvFBTe
         cL7I3g8b4XDx9j5NfIksW4dj6DpQYDSrq7/VBgjt+Bt6ED9bbCqauxEaFDoxdL/YDcb0
         Bi+Q==
X-Gm-Message-State: AOAM533fJlBk6FLwD4nvyqczL9GKBTerk9bG4y/WAZnDwWMXHcxx9dLL
        i2AM/CjeoJMfbJwuB3q0zHDC7ZPOk5Y=
X-Google-Smtp-Source: ABdhPJw6Abooe6r5xME+sLD+M/dTXwsnoxqe4gA0dUs/k8N95tsHCkS+CsucAIaInyROqYZwlo3t7Q==
X-Received: by 2002:a50:f017:: with SMTP id r23mr5798777edl.290.1590216215447;
        Fri, 22 May 2020 23:43:35 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:34 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 6/9] Manual pages: nsenter.1: note that 'file' can be a bind mount
Date:   Sat, 23 May 2020 08:43:22 +0200
Message-Id: <20200523064325.78491-6-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 147137bd8..5674f8d61 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -88,7 +88,8 @@ argument.
 This should be one of the
 .I /proc/[pid]/ns/*
 files described in
-.BR namespaces (7).
+.BR namespaces (7),
+or the pathname of a bind mount that was created on one of those files.
 .TP
 \fB\-a\fR, \fB\-\-all\fR
 Enter all namespaces of the target process by the default
-- 
2.26.2

