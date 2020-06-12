Return-Path: <SRS0=sYuO=7Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B182C433E2
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481AF207D8
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3T0P/WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLLTk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgFLLTk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Jun 2020 07:19:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD9C03E96F
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so7941513wmh.5
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4W7TlAWQnwvxH55BmpBoWQgaaYRUKQMr4iu8MpaPE4=;
        b=B3T0P/WT6saV+iBvJMqo0XbR2zT4jaWxRz4g1yArzZJonzD2qcExqksuH4CY00RPZq
         9VNJT/f2TzJnTb5vqgYKMlj6VlZsUarL98/ourDsTEOZjPBCFVqM3CnaUloOeN1z8kV2
         j6twav4QZZa1FHb3/WqlytoViJp5cGLlJh1RfBOQkjUUJJeqaHySnsa4FeB6dVGhfmxP
         aceRg1p5QHOApU/bGNX8O8EznZckOcvgAgAhEkQr+5eJrR7GlO0AXiT69Qf5VO/ZrK0e
         ocpo0zOKJ6SBP2A5M0bbD9WkH7m6KNfFvYHwXPAtpuCE/mIxYa0RPKX9+TrTO/NO6OqG
         Zh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4W7TlAWQnwvxH55BmpBoWQgaaYRUKQMr4iu8MpaPE4=;
        b=JlH4GA+bZ7iRo9fuhFEV8u1tCZ6x/lgzUIYOhFoA4geX/Dtz0a3yS4vjeGokOIZZi1
         MCbC+YDx7VzN9/P4nH1tn7odnA4dGuAa47288oHzJ1ji8V9DdY1AwYnkGF55VjfmS380
         UBpF7CFyPJpffSA/v2wMrTvLIxnwBqzaf8fLBOjkTzczO0y2bxjH3ZQI7djnM9vU2j42
         rBmdwKPqDLeh6rRI5gQDmw7eBJbpDod13jXtVNR/1ZL59gGtJfEipxQG76M9htpZi8Fz
         dilgUTCC/M8fbeJseogigm4LSCZVr0WlLad4UcrgnOHM1auh3EuMoVISQZtszrW8E6B5
         aBwQ==
X-Gm-Message-State: AOAM533hfTbJSzBbngxKxRJP1JeJjvvBi9y5JOo9br5J+6akFhnoIQge
        YgNQv+f3EkL8tWYEJM/hieo=
X-Google-Smtp-Source: ABdhPJxbWhRvpwyUT5GqvOp8Y7egQ19cepfpRDomYFLwzOUJhMQWkdLGsvOpFVs/r6n3IjNTz3pFYA==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr13382838wmj.144.1591960778394;
        Fri, 12 Jun 2020 04:19:38 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id o6sm9511433wrp.3.2020.06.12.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:19:37 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/3] Manual pages: setpriv.1: warn users of restrictions on capability changes
Date:   Fri, 12 Jun 2020 13:19:33 +0200
Message-Id: <20200612111933.3043314-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612111933.3043314-1-mtk.manpages@gmail.com>
References: <20200612111933.3043314-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The kernel imposes various restrictions on the changes that can be
made to the inheritable, ambient, and bounding sets. Warn the user
about that.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/setpriv.1 | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 3794a917e..42d1a2fb9 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -65,6 +65,22 @@ the current ambient set for
 and the current bounding set for
 .BR \-\-bounding\-set .
 .IP
+Note the following restrictions (detailed in
+.BR capabilities (7))
+regarding modifications to these capability sets:
+.RS
+.IP * 2
+A capability can be added to the inheritable set only if it is
+currently present in the bounding set.
+.IP *
+A capability can be added to the ambient set only if it is currently
+present in both the permitted and inheritable sets.
+.IP *
+Notwithstanding the syntax offered by
+.BR setpriv ,
+the kernel does not permit capabilities to be added to the bounding set.
+.RE
+.IP
 If you drop a capability from the bounding set without also dropping it from the
 inheritable set, you are likely to become confused.  Do not do that.
 .TP
-- 
2.26.2

