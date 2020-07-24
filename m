Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22922C433F1
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0149C206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwwY1Uof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGXKG4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKGz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:06:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33643C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bm28so6656526edb.2
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/n+OLrOghOAuBT+BZbwWDLMxuS+Vw0EvmyCgJmA40go=;
        b=XwwY1Uofy9lctfyPc/8IIMzCoQOiLRtE8znHiDnc/Is1mG3Gc7wRpkvc4x+vZMkxI1
         Z1gRRsdeNCgSme5VG0OQaXPCjklegqrfs20rwTCA07tf7cHheyAi5jtXNv6ByHZGiUvm
         2OGfxkmmC8js761/3jgIdoL09DQ1Z0lcx3ZHs40595AV9HOcDDNYoL5NGssFKrKGZqRh
         teGYIg/d2jztrKkrnGUFFaugHKnmZO8v7kuuaMfzndiT3kVKgzidlRqkF9/uxGpPMtQE
         8p/QISU5gUMHuKLhuMyua2npq4nSbAjmV4c4uQs4bwtzv7Xum/brXy0lpoa6vwa9GcKZ
         kJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/n+OLrOghOAuBT+BZbwWDLMxuS+Vw0EvmyCgJmA40go=;
        b=GtKTVRemEn5ppYpigrrrIDApXJgfrYc1alurV4/4WRc67wi0uwrD1AtgqWP0uaDagt
         DzEh6qjIaH6li2sllwE0EwWMBE9rzvQQ+FhSO2MY6T4NASlDUrrcfTzHa4VmYuJSF41S
         n2CeVt6rLkVHc5X6rS3dNhICna75KbnP9NsWMs2ctD0zIj+/lZQlbPI9PvI/PJwkygg6
         JScijLkOoq+7qqxZsG3pClPUCqkFPYxzoplw8siMy4HNZH7pxKAn195FjUzMiuUNjeo8
         /6Ht1Q0jFOmHEGUyfgQtJC/7BgUKp4H6RVUPlyyx/OHCmqG6rxqWr8IOXSYOv0qYIhn8
         qGOw==
X-Gm-Message-State: AOAM532+nAXh0jqADfiSBVkmmyo4s0qHhBPr8/uVvZ5BjV/hsjg7if/V
        5G89ENUCdYMqjHUfw+9hiWc=
X-Google-Smtp-Source: ABdhPJz0hS1JupADFjG/udeOkVzsE0Qryl68CyBtJ4prAudyy3YJZrxqUB+BFSDtph2RAdsYxFQdNQ==
X-Received: by 2002:a50:dacf:: with SMTP id s15mr8587734edj.136.1595585213965;
        Fri, 24 Jul 2020 03:06:53 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id kt1sm356478ejb.78.2020.07.24.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:53 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 07/12] Manual pages: nologin.8: formatting fixes
Date:   Fri, 24 Jul 2020 12:06:13 +0200
Message-Id: <20200724100618.584918-7-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/nologin.8 | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index a95ff2ba1..1f06544b5 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -10,7 +10,10 @@ nologin \- politely refuse a login
 displays a message that an account is not available and exits non-zero.  It is
 intended as a replacement shell field to deny login access to an account.
 .PP
-If the file /etc/nologin.txt exists, nologin displays its contents to the
+If the file
+.IR /etc/nologin.txt exists ,
+.B nologin
+displays its contents to the
 user instead of the default message.
 .PP
 The exit status returned by
@@ -48,13 +51,19 @@ Display version information and exit.
 .B nologin
 is a per-account way to disable login (usually used for system accounts like http or ftp).
 .BR nologin (8)
-uses /etc/nologin.txt as an optional source for a non-default message, the login
+uses
+.I /etc/nologin.txt
+as an optional source for a non-default message, the login
 access is always refused independently of the file.
 .PP
 .BR pam_nologin (8)
 PAM module usually prevents all non-root users from logging into the system.
 .BR pam_nologin (8)
-functionality is controlled by /var/run/nologin or the /etc/nologin file.
+functionality is controlled by
+.I /var/run/nologin
+or the
+.I /etc/nologin
+file.
 .SH HISTORY
 The
 .B nologin
-- 
2.26.2

