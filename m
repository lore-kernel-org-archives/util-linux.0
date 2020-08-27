Return-Path: <SRS0=LL90=CF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F4C433E3
	for <util-linux@archiver.kernel.org>; Thu, 27 Aug 2020 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC3022B40
	for <util-linux@archiver.kernel.org>; Thu, 27 Aug 2020 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFYtDb9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgH0PNC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgH0PMy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2020 11:12:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68907C061264
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2020 08:12:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b2so5242909edw.5
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2020 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wesletgCYH1cfROVy8wYyqI784H0kwPuIG9G2gHsb0w=;
        b=hFYtDb9iRlDBBuLINQdvuFs4sauugeL4MfRDC4ehpbing3X1dwNNwOKC7R8TnSASSK
         yJ4JA6dSC0zjmI+AU2sjNNElS0DS7pPFPFA0UlkJcFvwkKcE+iWXUxsUclSsOhiv1aiQ
         rQz7e8UrlMpDV+RJUucrMnlA6okKEi95yYcWj+qxZjRooi4O0XzcOkYMDvRLgun3hlnS
         pxv1yp8qw2c/CAUbaQorWrbIGmzfJDoMcH0KBno9uEOMWpwtkZiLWL+gVq0VQoXQlMay
         8vWKKnSzDCWqEpV1qWTjab7SKRaNvF6DkRnfLkKP4cGxgY033tlcKn+4ctOmrLh+L0Ka
         QwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wesletgCYH1cfROVy8wYyqI784H0kwPuIG9G2gHsb0w=;
        b=PTSWXFMmR52RJsHP7WliUXaFxWY2w0/9xD8Y3kTXHOOhuqFEAlojWeqrdWtp3d6WOc
         BZs8kUjMGZHCVUb8K3t0bpJlvXewGGviHhio90q5vTwmfl3C3cN6GLPSHXTQ0FW4AVxm
         yQ1hIhEVAkF5xV3zrLdipnMusHcxysmbkvmrF/+kPiME2aY5Q7DOqD+zXpGwCHg8reQG
         Nun8Bl03dDxAmwfMd0imC7B1uLGacdALSInipwdoBkg88bXr/QNb93TX9c23phg/DnNv
         s4CVcIpRZVLyFSDpwR3UIJKQZjR6SQLs8TqGBCp/6lLUHiDGPlss3J4IpHZoMsQH9iK7
         vJbA==
X-Gm-Message-State: AOAM532f+BKaAaxM5v+jG0LGZDnhg4XCTj5miwJoKXaG/9M9funcv8iM
        Wi3FpbczmeeWCfmYdriqytg=
X-Google-Smtp-Source: ABdhPJyw6ypmU/QtG+zJT/90uyJ4yVI7u0c0XAt8yEsCg30tFNHK4HSwp24eG6Zr7L40BD7E4+0OHg==
X-Received: by 2002:a50:c089:: with SMTP id k9mr19753941edf.110.1598541171046;
        Thu, 27 Aug 2020 08:12:51 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:4c01:2cf1:7133:9da2:66a9])
        by smtp.gmail.com with ESMTPSA id do6sm2398440ejc.35.2020.08.27.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:12:50 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH] Manual pages: blockdev.8, sfdisk.8: typo fixes
Date:   Thu, 27 Aug 2020 17:12:45 +0200
Message-Id: <20200827151245.97613-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Fix a couple of typos that I introduced.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 disk-utils/blockdev.8 | 2 +-
 disk-utils/sfdisk.8   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index 44ed9e1e9..48d69ec51 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -48,7 +48,7 @@ Get alignment offset.
 .IP "\fB\-\-getbsz\fP"
 Print the blocksize in bytes.
 This size does not describe device topology.  It's
-the size used internally by ithe kernel and it may be modified (for example) by
+the size used internally by the kernel and it may be modified (for example) by
 filesystem driver on mount.
 .IP "\fB\-\-getdiscardzeroes\fP"
 Get discard zeroes support status.
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 6415b0f1b..bd5a2b11d 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -600,7 +600,7 @@ The welcome message.
 
 .SH ENVIRONMENT
 .IP SFDISK_DEBUG=all
-enablescw
+enables
 .B sfdisk
 debug output.
 .IP LIBFDISK_DEBUG=all
-- 
2.26.2

