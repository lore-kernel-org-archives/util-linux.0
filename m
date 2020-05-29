Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF467C433E0
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE85320723
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrJu9pms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgE2MUy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2MUx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 May 2020 08:20:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4927AC03E969
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 05:20:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e1so3340840wrt.5
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=guQRSTNDVaJdiRUqsaz1xFN61oxxRg4GHOFn+pIAaco=;
        b=BrJu9pms6XrVeLcLbwfBaeZYu9GzT8+ui8qB4REr8Wisfhgxp7iSGXzKMXHCTyq8b4
         T2qdIL/HzeyfRixFzsgZS90n2o5OP1lVJcMPCtjBcMqsP5SAUcyxD/WAPYNnEcMgV+DK
         fo0vq9vwRZh/HrT06W9oKAsDLApXkBd5QuBjhdSb8t/7KOpSMqQrcWfAmxyJrD5EQ68R
         78MIXBp9LFSXWEyQWuW5gjxT7UfK9bUL9ty+hjfMiKMRWKuXMKKVUF7hSaKZYKuZb5MS
         23i/LsaDMq/keFw5jgZ79ME7Ad8/K5Z7vKXk3RVtDZNNEVHJoTZ9QtTE+tjuOFFIwyDM
         vyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=guQRSTNDVaJdiRUqsaz1xFN61oxxRg4GHOFn+pIAaco=;
        b=YdpAcL2XwfZVPcEAzt4y5/k5DkpYW1C7Lraa9mrAh4ToUkhPXR8jn3V9tBd7YMg4/q
         0nirgV3qL6vXGbEGUrVc+NPnDHiZnq5OlLtOikzPAxPPX1WpgXd/qGo/PyrYMPId8ufv
         wnDb3hFBMrWIHRyEY+tPaSOHkiCVGm3uCeG+sstdEpcQv2BPV8OKEaR9JCmWKfeaRBbK
         DYD7R2jgNl2uvAXpRE4v7p63UvdQknGHbRs1qAfm6Li6ADbk9gSlcGIAC3D/1FwSxN6E
         fUjFMcnhVf1wP2DUqUt8n9RTi9Y7gvqy+KCUQV+yfrotA8XxzxYCF1DEmXPecxkG2qMS
         dRhw==
X-Gm-Message-State: AOAM5327VR3v0Bam6Mkh51zToyjplJZjFUZawweNMvh1GRffDSKoXkCd
        H9rRwM3DwDWoIp0n+9+toDQ=
X-Google-Smtp-Source: ABdhPJxIHYUPPPqhGHrhA3N9mALTCs3g3o9Z26RwAv/wawLLSbRPeMK/VvNV2YiPDBl1q6doCwJp4A==
X-Received: by 2002:a5d:4042:: with SMTP id w2mr8921769wrp.423.1590754851742;
        Fri, 29 May 2020 05:20:51 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id u7sm9911386wrm.23.2020.05.29.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:20:50 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/2] Manual pages: wording fix: "another" ==> "other"
Date:   Fri, 29 May 2020 14:20:47 +0200
Message-Id: <20200529122048.1052198-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In several pages, there is a consistent wording problem: "another"
where "other" should be used. This wording problem can be
surprisingly confusing for native speakers, especially those
unaware that in some other languages, "another" and "other" can be
expressed with the same word.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 disk-utils/fdisk.8        | 2 +-
 disk-utils/sfdisk.8       | 4 ++--
 login-utils/runuser.1     | 2 +-
 login-utils/su.1          | 2 +-
 misc-utils/blkid.8        | 2 +-
 sys-utils/lsmem.1         | 3 ++-
 sys-utils/mount.8         | 9 +++++----
 sys-utils/umount.8        | 6 +++---
 term-utils/scriptreplay.1 | 2 +-
 text-utils/column.1       | 2 +-
 10 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index e84782c46..519bd6a50 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -207,7 +207,7 @@ partition table before you write it to the device.
 And vice-versa it is possible to write the current in-memory disk layout
 to the script file by command 'O'.
 .PP
-The script files are compatible between cfdisk, sfdisk, fdisk and another
+The script files are compatible between cfdisk, sfdisk, fdisk and other
 libfdisk applications. For more details see
 .BR sfdisk (8).
 
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 819efee90..2f8afe88c 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -61,7 +61,7 @@ partitions.
 
 .B sfdisk
 uses BLKRRPART (reread partition table) ioctl to make sure that the device is
-not used by system or another tools (see also \-\-no-reread).  It's possible that
+not used by system or other tools (see also \-\-no-reread).  It's possible that
 this feature or another sfdisk activity races with \fBudevd\fR.  The recommended way
 how to avoid possible collisions is to use \fB\-\-lock\fR option.
 The exclusive lock will cause udevd to skip the event handling on the device. 
@@ -421,7 +421,7 @@ GPT; a shortcut or an alias. It's recommended to use two letters for MBR hex cod
 avoid collision between deprecated shortcut 'E' and '0E' MBR hex code. For backward
 compatibility sfdisk tries to interpret
 .I type
-as a shortcut as a first possibility in partitioning scripts although on another places (e.g.
+as a shortcut as a first possibility in partitioning scripts although on other places (e.g.
 \fB\-\-part-type command)\fR it tries shortcuts as the last possibility.
 
 Since v2.36 libfdisk supports partition type aliases as extension to shortcuts. The alias is a
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 251a6d153..7bcbbde12 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -109,7 +109,7 @@ in order to make the shell a login shell
 .BR \-P , " \-\-pty"
 Create pseudo-terminal for the session. The independent terminal provides
 better security as user does not share terminal with the original
-session.  This allow to avoid TIOCSTI ioctl terminal injection and another
+session.  This allow to avoid TIOCSTI ioctl terminal injection and other
 security attacks against terminal file descriptors. The all session is also
 possible to move to background (e.g., "runuser \-\-pty \-u username \-\- command &").
 If the pseudo-terminal is enabled then runuser command works
diff --git a/login-utils/su.1 b/login-utils/su.1
index 9e3154ea4..1589eb4a3 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -122,7 +122,7 @@ This option is ignored if the option \fB\-\-login\fR is specified.
 .BR \-P , " \-\-pty"
 Create pseudo-terminal for the session. The independent terminal provides
 better security as user does not share terminal with the original
-session.  This allow to avoid TIOCSTI ioctl terminal injection and another
+session.  This allow to avoid TIOCSTI ioctl terminal injection and other
 security attacks against terminal file descriptors. The all session is also
 possible to move to background (e.g., "su \-\-pty \- username \-c
 application &"). If the pseudo-terminal is enabled then su command works
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 53becc42f..57a3b754f 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -145,7 +145,7 @@ will print all of the devices that match the search parameter.
 This option forces
 .B blkid
 to use udev when used for LABEL or UUID tokens in \fB\-\-match\-token\fR. The
-goal is to provide output consistent with another utils (like mount, etc.)
+goal is to provide output consistent with other utils (like mount, etc.)
 on systems where the same tag is used for multiple devices.
 .TP
 \fB\-L\fR, \fB\-\-label\fR \fIlabel\fR
diff --git a/sys-utils/lsmem.1 b/sys-utils/lsmem.1
index 9d0b07398..2fe78b4c6 100644
--- a/sys-utils/lsmem.1
+++ b/sys-utils/lsmem.1
@@ -70,7 +70,8 @@ Produce output in raw format.  All potentially unsafe characters are hex-escaped
 .TP
 .BR \-S , " \-\-split " \fIlist\fP
 Specify which columns (attributes) use to split memory blocks to ranges.  The
-supported columns are STATE, REMOVABLE, NODE and ZONES, or "none". The another columns are
+supported columns are STATE, REMOVABLE, NODE and ZONES, or "none".
+The other columns are
 silently ignored. For more details see DESCRIPTION above.
 .TP
 .BR \-s , " \-\-sysroot " \fIdirectory\fP
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 94cb570a1..ca1544c9e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -64,7 +64,7 @@ command serves to attach the filesystem found on some device
 to the big file tree.  Conversely, the
 .BR umount (8)
 command will detach it again.  The filesystem is used to control how data is
-stored on the device or provided in a virtual way by network or another services.
+stored on the device or provided in a virtual way by network or other services.
 
 The standard form of the
 .B mount
@@ -439,7 +439,8 @@ will be writable, but the
 will be read-only.
 
 It's also possible to change nosuid, nodev, noexec, noatime, nodiratime and
-relatime VFS entry flags by "remount,bind" operation.  The another (for example
+relatime VFS entry flags by "remount,bind" operation.
+The other (for example
 filesystem specific flags) are silently ignored.  It's impossible to change mount
 options recursively (for example with \fB\-o rbind,ro\fR).
 
@@ -696,7 +697,7 @@ and calls
 .BR mount (2)
 system call, otherwise it runs in the original mount namespace.
 It means that the target namespace does not have
-to contain any libraries or another requirements necessary to execute
+to contain any libraries or other requirements necessary to execute
 .BR mount (2)
 command.
 .sp
@@ -1372,7 +1373,7 @@ system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
 .TP
 .B x-*
 The same as \fBX-*\fR options, but stored permanently in the user space. It
-means the options are also available for umount or another operations.  Note
+means the options are also available for umount or other operations.  Note
 that maintain mount options in user space is tricky, because it's necessary use
 libmount based tools and there is no guarantee that the options will be always
 available (for example after a move mount operation or in unshared namespace).
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index f04746211..ff26d413e 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -55,7 +55,7 @@ working directory there, or when a swap file on it is in use.  The
 offending process could even be
 .B umount
 itself - it opens libc, and libc in its turn may open for example locale
-files.  A lazy unmount avoids this problem, but it may introduce another
+files.  A lazy unmount avoids this problem, but it may introduce other
 issues. See \fB\-\-lazy\fR description below.
 .SH OPTIONS
 .TP
@@ -149,7 +149,7 @@ and calls
 .BR umount (2)
 system call, otherwise it runs in the original namespace.
 It means that the target mount namespace does not have
-to contain any libraries or another requirements necessary to execute
+to contain any libraries or other requirements necessary to execute
 .BR umount (2)
 command.
 .sp
@@ -267,7 +267,7 @@ A \fBhelper=\fItype\fR marker in the mtab file will redirect
 all unmount requests
 to the \fB/sbin/umount.\fItype\fR helper independently of UID.
 .PP
-Note that \fI/etc/mtab\fR is currently deprecated and helper= and another
+Note that \fI/etc/mtab\fR is currently deprecated and helper= and other
 userspace mount options are maintained by libmount.
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index a93b8a790..7f1487561 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -69,7 +69,7 @@ Specifies how to use CR (0x0D, carriage return) character from log files.
 The default mode is
 .IR auto ,
 in this case CR is replaced with line break for stdin log, because otherwise
-scriptreplay will overwrite the same line.  The another modes are
+scriptreplay will overwrite the same line.  The other modes are
 .I never
 and
 .IR always .
diff --git a/text-utils/column.1 b/text-utils/column.1
index 5e4e29e68..634c1be84 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -111,7 +111,7 @@ Insert empty line to the table for each empty line on input. The default
 is ignore empty lines at all.
 .IP "\fB\-r, \-\-tree\fP \fIcolumn\fP"
 Specify column to use tree-like output. Note that the circular dependencies and
-another anomalies in child and parent relation are silently ignored.
+other anomalies in child and parent relation are silently ignored.
 .IP "\fB\-i, \-\-tree\-id\fP \fIcolumn\fP"
 Specify column with line ID to create child-parent relation.
 .IP "\fB\-p, \-\-tree\-parent\fP \fIcolumn\fP"
-- 
2.26.2

