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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DFC433E3
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EC52084C
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+wFnlbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbgE1O6n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403955AbgE1O6i (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB022C08C5CA
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so3488597wmh.2
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC9JyohFEvc97khLJGus7q+kYARY/h2mLjs6xhr8rX8=;
        b=m+wFnlbkRs+IUIST8l/QvBeA0MwshEXZui4EvuhCTN6p9ym3rQaeYLuEGuBfoI/NKN
         xcOM2AHlB+WMGUeshUmyJ+DmQROY2JP4Jx0m/HDGcGskKGCFrBSlc6h1qsq1XhWw7f6V
         y4FJ0peMAk5x53pekyMyYcGCWyK/1SMGR1/YYrNeV+cQ4ZtNSAVmUW3WMuUoNA0/IwCc
         tw3riYslDCgk1zXMhj7DzvEq6mni5G9QoXLWlVkseOIsGyCepuSW838rVJ8D8l8KL3Lo
         tZN474qjGRZyiaWXuDpczMUJ1gTBdOXSwMAw3DL3WEU1aQPaifAuHeC0FteQoRgDeU0/
         ZkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC9JyohFEvc97khLJGus7q+kYARY/h2mLjs6xhr8rX8=;
        b=esfmQzfuhDIEbAuwsvEAYWubORRphUFO29SC38G/3pBHYXVII6fohHUjld5GtrTfR9
         1AffQpnQkWLmE92cMJ+KHYggPF6FfHHjnlNZBs898hWwv3PFIM9TNjJELJZv0HQsxdop
         XWt0O0Sy2qvYT4jhzlkXHaHVR9ZAbyV9vi7Zt20VAlZlsUDvAr1ZJ23maVFjNAM4liRl
         /cGcC6IQbILuJY/UOKtYJef05b7Ge1nVT8Ez8xUD8r0ZkjXCzSYY5DtqnUXK/hgyAN0C
         WjzUZb6Kj94au+Jge4J6hU843YGfDRw/MT+OpZ7UAKPcwWLNlmcIleTLr0EEhoeWW1sX
         p10g==
X-Gm-Message-State: AOAM5316WH8S9igqBc6SKYYDoKh1hL+kV5zjcxbjAU9ukpWLx+ZfuU7z
        U6QDC1yDwJOYgFdfHOW+XXs=
X-Google-Smtp-Source: ABdhPJyT5yCRx81CTfUKOlPM1cjqg0Tr9YMWPmYWkI1wNZ/eTpBDcTpqcHALvW9snbMKSUpgevDCyw==
X-Received: by 2002:a1c:ba86:: with SMTP id k128mr3234317wmf.19.1590677916450;
        Thu, 28 May 2020 07:58:36 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:35 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 08/10] Manual pages: mount.8: Rewrite FILESYSTEM-SPECIFIC MOUNT OPTIONS intro
Date:   Thu, 28 May 2020 16:58:22 +0200
Message-Id: <20200528145823.978508-8-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add a table listing other manual pages that describe mount options
of some widely used filesystems. Additionally, rewrite the remaining
text to be a bit easier to read.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8 | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 7fa5733d4..94cb570a1 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1396,23 +1396,37 @@ only for root users or when mount executed without suid permissions.  The option
 is also supported as x-mount.mkdir, this notation is deprecated since v2.30.
 
 .SH FILESYSTEM-SPECIFIC MOUNT OPTIONS
-You should consult the respective man page for the filesystem first.
-If you want to know what options the ext4 filesystem supports, then check the
-.BR ext4 (5)
-man page.
-If that doesn't exist, you can also check the corresponding mount page like
-.BR mount.cifs (8).
-Note that you might have to install the respective userland tools.
-.sp
+This section lists options that are specific to particular filesystems.
+Where possible, you should first consult filesystem-specific manual pages
+for details.
+Some of those pages are listed in the following table.
+.TS
+lb lb
+l l.
+Filesystem(s)	Manual page
+btrfs	\fBbtrfs\fP(5)
+cifs	\fBmount.cifs\fP(8)
+ext2, ext3, ext4	\fBext4\fP(5)
+fuse	\fBfuse\fP(8)
+nfs	\fBnfs\fP(5)
+tmpfs	\fBtmpfs\fP(5)
+xfs	\fBxfs\fP(5)
+.TE
+.PP
+Note that some of the pages listed above might be available only
+after you install the respective userland tools.
+.PP
 The following options apply only to certain filesystems.
-We sort them by filesystem.  They all follow the
+We sort them by filesystem.
+All options follow the
 .B \-o
 flag.
-.sp
+.PP
 What options are supported depends a bit on the running kernel.
-More info may be found in the kernel source subdirectory
+Further information may be available in fileystem-specific
+files in the kernel source subdirectory
 .IR Documentation/filesystems .
-
+.\"
 .SS "Mount options for adfs"
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
-- 
2.26.2

