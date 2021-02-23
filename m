Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622CC433E0
	for <util-linux@archiver.kernel.org>; Tue, 23 Feb 2021 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA96464E4B
	for <util-linux@archiver.kernel.org>; Tue, 23 Feb 2021 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBWP1a (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232775AbhBWP12 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Feb 2021 10:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614093959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/VzEVVjEEPmsnt9REIwpa+Plj3h88lrrK5TAsboU5g=;
        b=AG5/PeHeJLIop2amj4HxSICFC/QbiQaPPrw34SA22AYsMaJbARPaQ6SNnPp6znrXdtwTSv
        FEOJh1WLQzDIQRHt1m88iYvygclzzOtuMD/Geyfw7WM0db8bURlLWc1qID0znD1hGyLaRK
        ZYm0DqsybmeLsAbki+KM/WiZnlCXD4o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-2O0yEzFKMjayuHvcHYqojA-1; Tue, 23 Feb 2021 10:25:57 -0500
X-MC-Unique: 2O0yEzFKMjayuHvcHYqojA-1
Received: by mail-ej1-f69.google.com with SMTP id mm18so2633301ejb.7
        for <util-linux@vger.kernel.org>; Tue, 23 Feb 2021 07:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/VzEVVjEEPmsnt9REIwpa+Plj3h88lrrK5TAsboU5g=;
        b=gK7ciTAldj47XNX2rxGcqgLaDzAsb+LEsMP+btTTEbNTY7cw0KI9ymWgeOuurdmmR5
         fWgcDHyHTP26m6DRu5XTPzU730sk5yyoidubeqh1W/XkcSx+QfPjwqdD0Qok6S9FHgyO
         qcqRhFn9IHEesURhfDyXbnLCjQbPxV0NSXF2HEGohYkoT6rtpzvmcFFV96lPJ8m8YPxr
         E2oAryjxY6BVvFeweCrwsCF+Xxqw+jt573KAv/EBhV1NGEQA3hVuEHsz70OODtNKYNL2
         v0rgPMeKtsI8ujdgg0ciunGoR6Oy+T+Dp3IhbrYBXyDuUjVOJ8ebhNruthr99S2sum0I
         t1Lg==
X-Gm-Message-State: AOAM533CKNc/B0XdrDvo2Ftr7opqleCfc+1RbqCtXkBK4xxiDlWeX+wt
        EAAVN54Z+PRkJp7w3bpxpkpDr8T+2heLp7SBUqm7REK2DqtowaGLcf45Zt/n+JnWw5ISqrcU+ny
        WIDGotYHeIxhGAtFcZHyWMG1cjVi69Fijg/Hkor9qmOq5yfNKoFSn+l9EQogF7faojFXUVmM=
X-Received: by 2002:a17:906:a0c:: with SMTP id w12mr26232700ejf.211.1614093956422;
        Tue, 23 Feb 2021 07:25:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGGiKs/FWi1jVhGGSuYpX5zQeFF5fEgYM9BbX49R7DDWiboKCnj+hCAm5OH3rKEAIMpGljEA==
X-Received: by 2002:a17:906:a0c:: with SMTP id w12mr26232672ejf.211.1614093956241;
        Tue, 23 Feb 2021 07:25:56 -0800 (PST)
Received: from localhost ([185.112.167.35])
        by smtp.gmail.com with ESMTPSA id dh23sm10014220edb.32.2021.02.23.07.25.55
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:25:55 -0800 (PST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <snemec@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] su: fix man page typos
Date:   Tue, 23 Feb 2021 16:25:54 +0100
Message-Id: <20210223152554.2649033-1-snemec@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Štěpán Němec <snemec@redhat.com>
---
 login-utils/su.1 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/su.1 b/login-utils/su.1
index 622be736a01a..0f20118bce6a 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -52,15 +52,15 @@ is mostly designed for unprivileged users, the recommended solution for
 privileged users (e.g., scripts executed by root) is to use
 non-set-user-ID command
 .BR runuser (1)
-that does not require authentication and provide separate PAM configuration. If
-the PAM session is not required at all then the recommend solution is to use
+that does not require authentication and provides separate PAM configuration. If
+the PAM session is not required at all then the recommended solution is to use
 command
 .BR setpriv (1).
 .PP
 Note that
 .B su
-in all cases use PAM
-.RB (pam_getenvlist (3))
+in all cases uses PAM
+.RB ( pam_getenvlist (3))
 to do the final environment modification.
 Command-line options
 such as \fB\-\-login\fR and \fB\-\-preserve\-environment\fR affect
-- 
2.29.2

