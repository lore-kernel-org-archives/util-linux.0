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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57958C433E1
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3395D2084C
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJyZpGBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbgE1O6m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403952AbgE1O6f (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CCC08C5C6
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so28262797wrt.5
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pgv81EuvQ37DEsO4usuKEx1BesGUYE+HgyWsL3cb64Y=;
        b=NJyZpGBdf6xgQlmmPpMLvGZczHj2d8o4+hP524JaR/n3zxjE+9IrHyN6TBiR5tEZu8
         BXLTa89cKxj5KjzY15arHxJM+v5DEntsZYKvqt4Wd9+8kHJhl5BOJY52c8GrI2UHYhy2
         l1f2O1Y0jNzYAyQ17lQLHdyclesNkRFPEz4ynQnEhXaSB3MyQsPG9mcXp5t47DGKoJ/O
         ZQKhyb1jO5lxhAimYVQbxiXZRCkIY/KiGZljHTEAJ/paUx8spYiNkk5+Ha7tWhIqI8Vs
         alhRFs8GH+tmNSMAD7mdRg0GnOStyXg5YVEt1KyDpHKXqQboZBocIjKEhPMmwloaUMWH
         2wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pgv81EuvQ37DEsO4usuKEx1BesGUYE+HgyWsL3cb64Y=;
        b=Y2sGW8wiI5uYRIxyUtnmV4OdoV8DeZS9jOA32fIYjV2H+tNiYm3tLiqwr1n4+oXfQx
         pC4ins7w5fZQfc6oruBTMWCI086fQ2w2eF2uqUBcCVl/Xowjp4h3d9RbNneCkf2zC1hm
         HQCkl1c1NhJ5mxPj651bctENn9sdzHzn3tmidWtVjxvS6y60cRSFTro+SrJwK0vcGjdx
         06YtA4ty1Dljq6SsJfvI+tylUrzXIs5fHl1ne5w6sotzVpKfCGGXBz/pz1YRzHZhMXw9
         SNnwICSVmOi2J2xkGIm7SORZb+xdfatfzvTPQ3MOrnqHwW8HyDhiPAzSqyTc6iGt6Rbn
         c5WQ==
X-Gm-Message-State: AOAM533RPaMhVty6xRR8AKsT+7tKOKSDN4SuHty2pvPf0XkToWzFqgNO
        dh3IL/FOhJ3BQhbQ0+n9lOX6Eup/n4g=
X-Google-Smtp-Source: ABdhPJwxcZHav85MvLLhqfTGBCu753irdq7vL1zMmXkPBcQPGPWWyJEyl2qIbC9GlaeYojct4oXE4w==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr3741867wrw.137.1590677914274;
        Thu, 28 May 2020 07:58:34 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:33 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 06/10] Manual pages: mount.8: SEE ALSO: add some obvious references
Date:   Thu, 28 May 2020 16:58:20 +0200
Message-Id: <20200528145823.978508-6-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

And correct sort order for "umount(8)" entry.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 7a1782284..b7a14de4e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2759,13 +2759,15 @@ Karel Zak <kzak@redhat.com>
 .fi
 .SH SEE ALSO
 .na
+.BR lsblk (1),
 .BR mount (2),
 .BR umount (2),
-.BR umount (8),
+.BR fileystems (5),
 .BR fstab (5),
 .BR nfs (5),
 .BR xfs (5),
 .BR mount_namespaces (7)
+.BR xattr (7)
 .BR e2label (8),
 .BR findmnt (8),
 .BR losetup (8),
@@ -2774,6 +2776,7 @@ Karel Zak <kzak@redhat.com>
 .BR nfsd (8),
 .BR swapon (8),
 .BR tune2fs (8),
+.BR umount (8),
 .BR xfs_admin (8)
 .ad
 .SH AVAILABILITY
-- 
2.26.2

