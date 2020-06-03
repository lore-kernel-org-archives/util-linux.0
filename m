Return-Path: <SRS0=KLef=7Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B15C433E3
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FBF2077D
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 07:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOqDn6aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgFCHlE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFCHlD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jun 2020 03:41:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D88C05BD1E
        for <util-linux@vger.kernel.org>; Wed,  3 Jun 2020 00:41:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so1102345ejb.4
        for <util-linux@vger.kernel.org>; Wed, 03 Jun 2020 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0nUpeSJbV4TsOqnnyas2UeoR4M35Zf01FYYlqH1k3Y=;
        b=sOqDn6aVAD4x387DPxwf3cg5ni9vJ7ZPtul8OKiw3LQ0wwgWoHyB247lbidsFoZe2V
         HHKuhPhAE4P8CE6L4JGxvjEpEn1ypliO4lIgwm40Ee7PUNGFcllKDa0spD0k6U04U/QN
         mxsoYdOnSc0CiDlyatT5Ew74lxGNHcKmzNGnxkytLV6zPQ81IMM24zWHYzYlYxjG075/
         XWK/AlIpGiR6Dpg1vHSIjBhqvkrBPihDkJMkI45k4mjGcn9xIq31XzFVwrAmTtRpmrRe
         gj+FNSVSp99XQVaiygpqDvMY949qNUuxZdcQGADggEp3vI1fYTeLSt1KzHG3CCJlGIJx
         LotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0nUpeSJbV4TsOqnnyas2UeoR4M35Zf01FYYlqH1k3Y=;
        b=Hs7/5BpXIiIkFZtwxOuwpCjnAMAvKtjKuKEV2VkEmPw8cpWZ4Hvm7jKAgUC4nQukrH
         glviiqzV9QuM0X4fmqYDzTEA3F8QQ9bIor3xKCFbnjdVsOn3IHvWNLpWMB3CDhjCRUla
         xxVqrajskVI5dtS2/7TXjT2iTaIjar2LjPt+8QI1wz5Fa19V5E3v0FllRRopTGwesilj
         6Rc3KZYiUYc/CUTsX9jD8JAMhbr9eVaKqOL153V6wcDzAulfh3V2RJ1G23mIiKRrkcR2
         kcrlJUtNtNLCVJI0kd8E2cXilKujpIHytESqa2tSCf4bSBS1aaV61KMy3WfoI3mTEXZ6
         ssmw==
X-Gm-Message-State: AOAM531b3zTqhK7xLFINXu7doDEclaQjzGkPOsXp6emdIH5jZLZx8kC2
        ff8++3FLC3SUnEzEJvI8jp0=
X-Google-Smtp-Source: ABdhPJzOVH0XfejJLvLdOkk3etpVD4e/5ARzqkQ0NiQ7hISVLHq/ARxyrY5xubxIlfKIUYX9jAy4XA==
X-Received: by 2002:a17:906:abca:: with SMTP id kq10mr13002737ejb.390.1591170062110;
        Wed, 03 Jun 2020 00:41:02 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id 38sm747983edq.6.2020.06.03.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 00:41:01 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/2] Manual pages: unshare.1: clarify that --pid=<file> requires --fork
Date:   Wed,  3 Jun 2020 09:40:57 +0200
Message-Id: <20200603074057.540157-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603074057.540157-1-mtk.manpages@gmail.com>
References: <20200603074057.540157-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Attempting to create a persistent PID namespace with --pid=<file>
will result in an error if --fork is not also specified. Let's
warn people about that, so they don't get puzzled.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 443aac658..7899db3ad 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -114,8 +114,13 @@ Unshare the network namespace.  If \fIfile\fP is specified, then a persistent
 namespace is created by a bind mount.
 .TP
 .BR \-p , " \-\-pid" [ =\fIfile ]
-Unshare the PID namespace.  If \fIfile\fP is specified then persistent
-namespace is created by a bind mount.  See also the \fB\-\-fork\fP and
+Unshare the PID namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
+(Creation of a persistent PID namespace will fail if the
+.B \-\-fork
+is not also specified.)
+.IP
+See also the \fB\-\-fork\fP and
 \fB\-\-mount-proc\fP options.
 .TP
 .BR \-u , " \-\-uts" [ =\fIfile ]
-- 
2.26.2

