Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E7C433DF
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A908D2073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYf/Nq5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbgEYM73 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388785AbgEYM72 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:59:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82392C05BD43
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e10so14953605edq.0
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IabBvfY5v2WIwINeYqta0bcSY/uyUjv9H/CMpeWQcx4=;
        b=ZYf/Nq5WSn/sTsaj83P4cWZxyoKx2TFdYVClKEYInVafTMvO5F5ZZ9dqJrI8hkNm2Z
         ppGn53IycLzXTdzie7doZ1Pk2ubTN3aFE+/VDtF19YzBwCkX6GTknIPPULV+CFr1ZPj6
         H4XQj/sJ1vevxrPXoAgmCADgJRvoacF8hMm5ex2JX1epg0T/qT6MB2woLmDU4tGh4f93
         GD8kOApkmWRAUjzaXgBfm8AJAcy3FykVjMcsuP28OFBPGLKifPD0FRLNUdZmya4LIX+D
         /3kiO/yAGOtEsH9lMMmwPjcVlaniYxtTbPOC5zMfjsvSQZOSqlsOIVnDwuIRETEE1KAU
         hzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IabBvfY5v2WIwINeYqta0bcSY/uyUjv9H/CMpeWQcx4=;
        b=VWNikyKQCF7aa2WxLm69pPtRCR7m0UU7SbZuCqn65VPRjC/n0/FFkqEpirm9+/gYKL
         ryvPfi9t4RjOHiyQ1mdpJkYWNWrVlGUsk6dKDiIb6I8kZsixjJajwrqVD83LjX2v2bSF
         6/TSoaIkGvoboP38NqdY1kGtg5zrettzt9r4sLyv3E6Q3P0/iRf0K7c+XxQW99cp4YKh
         rp73yBHFh+jAwrNV7FK+njlP+hr+wACXzgAfZYARQUyRyfWMegFveHb0VU2hhMIrdEvJ
         XiHB4wy1IdAQPzbiLwYCsuwgyOCCXoiu52SUs1w6X/bngz10UspNbCSR4D3dNOAoaFP/
         Fa3A==
X-Gm-Message-State: AOAM533A1s6RDIYtY9D8OJS9uahqyRnwwVql87daUxGWA0asxS31bAvD
        o1vQWkVs9j9TjOKRRWawVq4Bq3qgLOg=
X-Google-Smtp-Source: ABdhPJyIjpkwjKkkEG91UJxyM3xEow0du9H1IWDB2hlGWzNAmL9U7pUdOnrVVxLz3aquapH5YMSjIw==
X-Received: by 2002:aa7:d691:: with SMTP id d17mr15377367edr.273.1590411566237;
        Mon, 25 May 2020 05:59:26 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b14sm15709719edx.93.2020.05.25.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:59:25 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 4/5] Man pages: ipcmk.1, ipcs.1, lsipc.1: explicitly mention "System V"
Date:   Mon, 25 May 2020 14:59:11 +0200
Message-Id: <20200525125912.43748-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525125912.43748-1-mtk.manpages@gmail.com>
References: <20200525125912.43748-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Explicitly mention "System V" in the description, so that readers do not
get confused with the POSIX IPC mechanisms.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/ipcmk.1 | 3 ++-
 sys-utils/ipcs.1  | 2 +-
 sys-utils/lsipc.1 | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index 6de6d819d..c40222014 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -8,7 +8,8 @@ ipcmk \- make various IPC resources
 [options]
 .SH DESCRIPTION
 .B ipcmk
-allows you to create shared memory segments, message queues,
+allows you to create System V inter-process communication (IPC) objects:
+shared memory segments, message queues,
 and semaphore arrays.
 .SH OPTIONS
 .TP
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index e0662302d..d259a7df6 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -8,7 +8,7 @@ ipcs \- show information on IPC facilities
 [options]
 .SH DESCRIPTION
 .B ipcs
-shows information on inter-process communication facilities.
+shows information on System V inter-process communication facilities.
 By default it shows information about all three resources:
 shared memory segments, message queues, and semaphore arrays.
 .SH OPTIONS
diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index e5ae55bbd..b58b4cdf4 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -8,7 +8,7 @@ lsipc \- show information on IPC facilities currently employed in the system
 [options]
 .SH DESCRIPTION
 .B lsipc
-shows information on the inter-process communication facilities
+shows information on the System V inter-process communication facilities
 for which the calling process has read access.
 .SH OPTIONS
 .TP
-- 
2.26.2

