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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE182C433E0
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAE82075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3L4XmPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbgE1O6p (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403770AbgE1O6d (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA91C08C5C8
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so14186495wru.6
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lgn1r1Xmo9fvqMAXoO/h9hVSx0qFlwn0LLJzwtHEBsA=;
        b=H3L4XmPODz6V44ww+3A7iOwJP+yFhD9sfupp1df4Yo8AB9UMQrZY/59AiTdO5jLHGn
         FYLAGBGzhG0Xxt+JV3307k4pzHmRHnSVUK/1fvrQaoDDRiDQ5g8VzehbV/L2tNNsVscx
         hKy5qdkJQGO3TZXMH0ZJasKqzG9iummXYwv46jP6LmRauqBIbaXc3lyFBE7CkhE4HTkI
         Qgi14NYFBIlUxwHDioH8dnKzznzdy2ZsAfrRGaB4MuT4oIKch0/TaAiKfMwvrd+JhLA/
         aLkvh/OpOADq/MDdiB8RXhLeuthZq1tP+JZnpQLUtobSfMpwdFYeUV8vllDeliEVEgp5
         c5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lgn1r1Xmo9fvqMAXoO/h9hVSx0qFlwn0LLJzwtHEBsA=;
        b=bGsBQBqyGjcV3kZBqEbJq4nvp8hdkLULnIhJwnKs3fVtVhWAIjORKQ+OIOwh45ZIlH
         l4/3G6D0Nt1RARTOIpzCR4NE5wJjl7axjNDETf4+2Hqw4jwchfLKfV69keU/XoBGOsmM
         TXnZwccoOWyXHM8vPLKa7EQKRvV1TXYQgEJ60SNXljNOG2Q//56/Fy/0OOIwbjXHlc35
         fxoYpWEKBqHS7oCNQco+CAzWSbop8FxjwY38bJoNUzkfzbejeILnYUzy0dpQeTVMqvjw
         xDB3DdquLmTeeMYcgQ48pLCAVr2DWulm+Mk8lLbj/xM2aQZQzB/lIKA+rTTyl8IbqfnX
         zBbw==
X-Gm-Message-State: AOAM531TaghcDfA7DISJNa3Io+3sbJh2q9E2/vY6ljbGxYJISCab7Uzj
        ouSP0pFmArR7tg9UvXVvkVE=
X-Google-Smtp-Source: ABdhPJw4lc2Ja5KmoSwthUJjaHSdVscVaelCS30AP+6zqK90wHY8rUv9kdlN7MEEGeuEPAhxo066XQ==
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr3821504wrv.245.1590677911975;
        Thu, 28 May 2020 07:58:31 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:31 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 04/10] Manual pages: mount.8, umount.8: Clarify that "namespace" means "mount namespace"
Date:   Thu, 28 May 2020 16:58:18 +0200
Message-Id: <20200528145823.978508-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There are various references to "namespaces" when it would be
clearer to say "mount namespaces". Also, add references to the
mount_namespaces(7) manual page.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8  | 11 +++++++----
 sys-utils/umount.8 | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 81bc225cb..fff060ad1 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -664,19 +664,21 @@ This is necessary for example when
 is on a read-only filesystem.
 .TP
 .BR \-N , " \-\-namespace " \fIns
-Perform mount in namespace specified by \fIns\fR.
+Perform mount in the mount namespace specified by \fIns\fR.
 \fIns\fR is either PID of process running in that namespace
 or special file representing that namespace.
 .sp
 .BR mount (8)
-switches to the namespace when it reads /etc/fstab, writes /etc/mtab (or writes to /run/mount) and calls
+switches to the mount namespace when it reads /etc/fstab,
+writes /etc/mtab (or writes to /run/mount) and calls
 .BR mount (2)
-system call, otherwise it runs in the original namespace. It means that the target namespace does not have
+system call, otherwise it runs in the original mount namespace.
+It means that the target namespace does not have
 to contain any libraries or another requirements necessary to execute
 .BR mount (2)
 command.
 .sp
-See \fBnamespaces\fR(7) for more information.
+See \fBmount_namespaces\fR(7) for more information.
 .TP
 .BR \-O , " \-\-test\-opts " \fIopts
 Limit the set of filesystems to which the
@@ -2680,6 +2682,7 @@ Karel Zak <kzak@redhat.com>
 .BR fstab (5),
 .BR nfs (5),
 .BR xfs (5),
+.BR mount_namespaces (7)
 .BR e2label (8),
 .BR findmnt (8),
 .BR losetup (8),
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 43363b11c..edcb6cc1f 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -68,7 +68,8 @@ filesystems. This list of the filesystems may be replaced by \fB\-\-types\fR
 umount option.
 .TP
 .BR \-A , " \-\-all\-targets"
-Unmount all mountpoints in the current namespace for the specified filesystem.
+Unmount all mountpoints in the current mount namespace
+for the specified filesystem.
 The filesystem can be specified by one of the mountpoints or the device name (or
 UUID, etc.).  When this option is used together with \fB\-\-recursive\fR, then
 all nested mounts within the filesystem are recursively unmounted.
@@ -129,19 +130,20 @@ server or a network partition. Remounts of the share will not be possible.
 
 .TP
 .BR \-N , " \-\-namespace " \fIns
-Perform umount in namespace specified by \fIns\fR.
+Perform umount in the mount namespace specified by \fIns\fR.
 \fIns\fR is either PID of process running in that namespace
 or special file representing that namespace.
 .sp
 .BR umount (8)
 switches to the namespace when it reads /etc/fstab, writes /etc/mtab (or writes to /run/mount) and calls
 .BR umount (2)
-system call, otherwise it runs in the original namespace. It means that the target namespace does not have
+system call, otherwise it runs in the original namespace.
+It means that the target mount namespace does not have
 to contain any libraries or another requirements necessary to execute
 .BR umount (2)
 command.
 .sp
-See \fBnamespaces\fR(7) for more information.
+See \fBmount_namespaces\fR(7) for more information.
 .TP
 .BR \-n , " \-\-no\-mtab"
 Unmount without writing in
@@ -278,6 +280,7 @@ command appeared in Version 6 AT&T UNIX.
 .SH SEE ALSO
 .BR umount (2),
 .BR losetup (8),
+.BR mount_namespaces (7)
 .BR mount (8)
 .SH AVAILABILITY
 The umount command is part of the util-linux package and is available from
-- 
2.26.2

