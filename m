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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAEFC433E0
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BED2075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7IutoNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgE1O6n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403954AbgE1O6g (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B528C08C5C7
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so3487008wml.1
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/2z+c6ECktDEHj5IRnSB9a2yWdMUzU9I/SBJWOEsfY=;
        b=X7IutoNIwmIgUmDJnsM+DjaqNzXmgU+48b+CTp80P0ZGeBPi0Idt7heSL8sIXdNRsA
         rMUSud4jAHNwDLArY75YE7aIhx67m33vo1QE4m7E4WuqyXro76ous1KZN/1AFpBBL50H
         2QRHtfEMui9lJUxUSSFGT+xM/DWR/Xb/fiMosq3n9GD43diAWxbW8ArSMRbkxu0UDXRK
         yFzTy2civLSuROmotpoy1ElkvBPLboQ/x2AuCVtAcJafuCdC/15wA07JIC8MoQZSKWA7
         sdxb3ueTAPyl/sqESILK84qxEFamapblvJguRryRkhPeYCZARWgeUz5vZWinG+MxuTNO
         NBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/2z+c6ECktDEHj5IRnSB9a2yWdMUzU9I/SBJWOEsfY=;
        b=VD49+H8N6GSA8lp1ZuIunCucTbXEg54caRzCwO8rH3yZn6AFMmnVrsXTtIhSnKpcXE
         NrGvUsmn0YcrTGgpurv8DATuv6TJ6vpBEOXSiWCg/T7zjrDJGVX4VyW5LNQqwKIpChTF
         N2zQ94eb+i1QNSrN973/7cT+haetEc4coPOniXoZR6Phb36QTETdXJKQBijA83MJUIvb
         SsrBX2EnoJx58/KGgqLcWfxJHg05y7P2YW0YnTsvn9CrBmeTjIjNRUb6HWX6qC+BOoU/
         1+MVRzCtcuVXFKOhzRnHWodRFVmVG6KtvKErrfznfroURb+Af3LYdsjsibTaw1dw8Q+r
         MDEQ==
X-Gm-Message-State: AOAM530v8xdo4f7LQs2mzuAL7aXkOwmpn7wudXbSpIaVJPQsUGZlVGSg
        KBs77ZZ53YryfkaasmFatnv37NGfDFk=
X-Google-Smtp-Source: ABdhPJy7JkCxU2vKFYQnMi56fvLFeOyiaxeKUCp0FK+AyHqEoo7+Z3EP0D5JQLgT9aWnaK9+GvluYg==
X-Received: by 2002:a1c:b0c8:: with SMTP id z191mr3921937wme.165.1590677915203;
        Thu, 28 May 2020 07:58:35 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:34 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 07/10] Manual pages: mount.8: Typo fix (remove an accidental paragraph break)
Date:   Thu, 28 May 2020 16:58:21 +0200
Message-Id: <20200528145823.978508-7-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index b7a14de4e..7fa5733d4 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1048,7 +1048,6 @@ The
 option is useful when mounting filesystems that do not support
 extended attributes, such as a floppy or hard disk formatted with VFAT, or
 systems that are not normally running under SELinux, such as an ext3 or ext4 formatted
-
 disk from a non-SELinux workstation.  You can also use
 .B context=
 on filesystems you do not trust, such as a floppy.  It also helps in compatibility with
-- 
2.26.2

