Return-Path: <SRS0=us4l=7K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F30C433E2
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3C92075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfHLcGQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbgE1O6n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403956AbgE1O6j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E89C08C5C8
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so4687784wmj.0
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7aopqsNC+cLiRu2Gz/ZV7fsYxDdEbdkKRCXMqRjXzs=;
        b=rfHLcGQOdx2QUKIB6E/c7t+7+fUcxnMZUAmIdRb3eIq1fyvU8R6fiRo+jfW2A11G/X
         f9M49qCyx47uop9s50emMrEycYM6gpQtm8KixJQcjxi7tS93ZqwDupE3kf6Q7ia2pen7
         b5H7c/Xa7TMgIu3yvfScHJdPU8QJxTfk7+GLgXxcXGaZHuLHoQEtJTqiwYAo+HWYw+9i
         A2L5saZIEror42i7Qg4LFxDL3twxeDW+B7uqOTAZRLt5MnC56tjcAqx4NO0q6DgS1oU5
         FmOy3ooVnt+HH0bNhZ9Wuw2cUlrEXzGn1ltXdoHin3moBZgBlPrP3uRkMo2WjTQoueE7
         Sp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7aopqsNC+cLiRu2Gz/ZV7fsYxDdEbdkKRCXMqRjXzs=;
        b=KpGQ9mEnTlxU+SGeW4iu4+/wZCVGdRSNGywuBi8B2JueFVuwKnybK+Ibur4lx5fl3V
         8mgU3uHwl6L6MaT/JIBwL3Ct8QRIYr2yDyebKFyZzxJ2NTy9sT8gf5VG9wcHK3xQ/gcu
         2U6ncBB0FpI0A80rwfh3LAJ3JqZVQpPVL5M6HUJ2UtSuQaJEiMm6sZL1QK7cGd9ZrJ6t
         Etd6v822qpJzQBn+ZRFOkwgsHogOGH49V1KBgNaT33wIKK3VPtv9Ev1NmrIKfFKVTsqN
         6uZ6/Qe7ql3JlFM3T54UzCEvkD9U/iq4En3RpyQ6M6X9iMNgMrKbYNQPWudvAEIbhdcg
         phZg==
X-Gm-Message-State: AOAM532mPqxT1LAegGH0hvvJvxDtSdud0csrsLLN7JZZZIhXvjICxIu8
        B40dcS1ongYt8KoQeQnPQkE=
X-Google-Smtp-Source: ABdhPJwHGcw1wRiX6K5c5S6hGUZHDVtRvEp9Qgl08EXlB8QV28EZkCM5uwyHSW1sHI6iK5R5ixJo5A==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr4021269wmh.105.1590677917780;
        Thu, 28 May 2020 07:58:37 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:36 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 09/10] Manual pages: umount.8: use "filesystem" consistently
Date:   Thu, 28 May 2020 16:58:23 +0200
Message-Id: <20200528145823.978508-9-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Currently, this page has a mix of "filesystem" and file system",
with the former being predominant.  Let's settle on one.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/umount.8 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index c56e51e18..f04746211 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -24,7 +24,7 @@
 .\"
 .TH UMOUNT 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
-umount \- unmount file systems
+umount \- unmount filesystems
 .SH SYNOPSIS
 .B umount \-a
 .RB [ \-dflnrv ]
@@ -43,13 +43,13 @@ umount \- unmount file systems
 .SH DESCRIPTION
 The
 .B umount
-command detaches the mentioned file system(s) from the file hierarchy.  A
-file system is specified by giving the directory where it has been
-mounted.  Giving the special device on which the file system lives may
+command detaches the mentioned filesystem(s) from the file hierarchy.  A
+filesystem is specified by giving the directory where it has been
+mounted.  Giving the special device on which the filesystem lives may
 also work, but is obsolete, mainly because it will fail in case this
 device was mounted on more than one directory.
 .PP
-Note that a file system cannot be unmounted when it is 'busy' - for
+Note that a filesystem cannot be unmounted when it is 'busy' - for
 example, when there are open files on it, or when some process has its
 working directory there, or when a swap file on it is in use.  The
 offending process could even be
-- 
2.26.2

