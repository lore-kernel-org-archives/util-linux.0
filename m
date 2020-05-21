Return-Path: <SRS0=+NO+=7D=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F9C433DF
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028F320738
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc0or96g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEUH2w (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 May 2020 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgEUH2w (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2020 03:28:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940EC061A0E
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id f13so5338275edr.13
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hZqvWtKD6nUjrWtcu+VwansL6Hj5JJDlhuZhH3XWmqE=;
        b=nc0or96g7SftegbEs5tXGMMPB31OFdIiEl19ZOVRbaOLolCIrTjCuIb9LLzHxl1ItH
         skyxudO4n7nCwqQHupIakPy0gkoOypoFSyGZ8U0BtvtISaZnOQocwF1NI61evCbc+baK
         058WUL90tb9oH0Ajf6eYRRKfF8GjLWjPF8e1wGw56Hpys1NICO90cbvapcfpQRPbAVNi
         2gijZX87emym2FhUJZ/yX0bqLSTxijiCNX9WmorVgR7X32XTwXFverleAa1g2TZTSgOM
         oZgMEJgQux/n32uOqiIw4wz916KHQgM1F0RBFiJTUBAnc4qlrGZ6hhoWT07a2rCX1Cvf
         nhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hZqvWtKD6nUjrWtcu+VwansL6Hj5JJDlhuZhH3XWmqE=;
        b=G3u3OnyDcfQyJKZgNhUEyiC3mG8E+YwecRZ+9ZE3/MaqaJ2evjUVvnwQkOoXC/6/vx
         U+2n2BejHMucbshYPQNJ9bEBBG6szSSlo+r+NzOhNVEM4I8NXrh6to0AmmRybcvIJKvS
         a6kcV9uQHN4Udk+0lzSixthTvWDj1Y1GjRWNlO0km25CZqZJ7yZ3N8Y38aD0h2dTci7/
         msbYTGz4MA3pbY3ePow80S7QGMXYdz8vBCEjwX5Sk2ED4gugD79qxbpaqG7oQ0nko7cN
         tB1o/6C39ZMYg9oRd+k+v438toTwu2zAvJMdT1lcyssvOBjVjJt6lbkpQlOLoFsbD/ek
         CRdw==
X-Gm-Message-State: AOAM533qwoboN0d7vGVunVXBtcylA1nStEC1lifnlkPfY5s+ZOZ5Snzn
        gklPVI0HR60duu4uIRXNkU8lUtFYc+0=
X-Google-Smtp-Source: ABdhPJysCpGmL/h3VhRWPSB8tRJtJNz5fblBwVNhmu+OzzReh4G8cDYWA06xqVS9ArEp3wZB4QIEVA==
X-Received: by 2002:aa7:c646:: with SMTP id z6mr5675340edr.13.1590046130083;
        Thu, 21 May 2020 00:28:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id s19sm3919683eja.91.2020.05.21.00.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:28:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 3/4] Manual pages: order ENVIRONMENT / FILES / CONFORMING TO
 consistently
Message-ID: <c56c02e1-2323-3969-d060-0be02d4e64d5@gmail.com>
Date:   Thu, 21 May 2020 09:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is value in ensuring that manual page sections use consistently
named sections, as far as possible, and also that sections have a
consistent order within manual pages. This is one of a series of patches
to place manual page sections in a consistent order.

In this patch, we ensure that the ENVIRONMENT, FILES, and CONFORMING TO
sections are always placed toward the end of the page, just above NOTES.

One page is not fixed by this patch: term-utils/agetty.8. This page
is a mess of unusual section names, and probably requires an individual
edit.

Testing that no gross editing mistake (causing accidental loss or addition
of text) was performed as follows:

    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > a
    [Apply patch]
    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > b
    $ diff a b
    $ echo $?
    0

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/fsck.8       |  4 ++--
 lib/terminal-colors.d.5 |  8 ++++----
 sys-utils/losetup.8     |  8 ++++----
 sys-utils/mount.8       | 22 +++++++++++-----------
 sys-utils/umount.8      | 14 +++++++-------
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 012c51f6e..97eb8d8c4 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -343,8 +343,6 @@ You're almost certainly doing something that you shouldn't be doing
 with
 .BR fsck .
 Options to different filesystem-specific fsck's are not standardized.
-.SH FILES
-.I /etc/fstab
 .SH ENVIRONMENT
 The
 .B fsck
@@ -388,6 +386,8 @@ enables libblkid debug output.
 .TP
 .B LIBMOUNT_DEBUG=all
 enables libmount debug output.
+.SH FILES
+.I /etc/fstab
 .SH AUTHORS
 .nf
 Theodore Ts'o <tytso@mit.edu>
diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index 4714bf505..b1be822f6 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -145,6 +145,10 @@ Lines where the first non-blank character is a # (hash) are ignored.
 Any other use of the hash character is not interpreted as introducing
 a comment.
 
+.SH ENVIRONMENT
+.IP TERMINAL_COLORS_DEBUG=all
+enables debug output.
+
 .SH FILES
 .I $XDG_CONFIG_HOME/terminal-colors.d
 .br
@@ -152,10 +156,6 @@ a comment.
 .br
 .I /etc/terminal-colors.d
 
-.SH ENVIRONMENT
-.IP TERMINAL_COLORS_DEBUG=all
-enables debug output.
-
 .SH EXAMPLE
 Disable colors for all compatible utilities:
 .RS
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 0db710449..7b51921a9 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -178,6 +178,10 @@ displays the status of a loop device, it returns 1 if the device
 is not configured and 2 if an error occurred which prevented
 determining the status of the device.
 
+.SH ENVIRONMENT
+.IP LOOPDEV_DEBUG=all
+enables debug output.
+
 .SH FILES
 .TP
 .I /dev/loop[0..N]
@@ -185,10 +189,6 @@ loop block devices
 .TP
 .I /dev/loop-control
 loop control device
-
-.SH ENVIRONMENT
-.IP LOOPDEV_DEBUG=all
-enables debug output.
 .SH EXAMPLE
 The following commands can be used as an example of using the loop device.
 .nf
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 9a43672c6..81bc225cb 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2574,6 +2574,17 @@ and
 to the mount.<suffix> helpers.  All other options are used in a
 comma-separated list as argument to the \fB\-o\fR option.
 
+.SH ENVIRONMENT
+.IP LIBMOUNT_FSTAB=<path>
+overrides the default location of the fstab file (ignored for suid)
+.IP LIBMOUNT_MTAB=<path>
+overrides the default location of the mtab file (ignored for suid)
+.IP LIBMOUNT_DEBUG=all
+enables libmount debug output
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output
+.IP LOOPDEV_DEBUG=all
+enables loop device setup debug output
 .SH FILES
 See also "\fBThe files /etc/fstab, /etc/mtab and /proc/mounts\fR" section above.
 .TP 18n
@@ -2594,17 +2605,6 @@ temporary file (unused on systems with mtab symlink)
 .TP
 .I /etc/filesystems
 a list of filesystem types to try
-.SH ENVIRONMENT
-.IP LIBMOUNT_FSTAB=<path>
-overrides the default location of the fstab file (ignored for suid)
-.IP LIBMOUNT_MTAB=<path>
-overrides the default location of the mtab file (ignored for suid)
-.IP LIBMOUNT_DEBUG=all
-enables libmount debug output
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output
-.IP LOOPDEV_DEBUG=all
-enables loop device setup debug output
 .SH HISTORY
 A
 .B mount
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 434877afc..43363b11c 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -253,6 +253,13 @@ to the \fB/sbin/umount.\fItype\fR helper independently of UID.
 .PP
 Note that \fI/etc/mtab\fR is currently deprecated and helper= and another
 userspace mount options are maintained by libmount.
+.SH ENVIRONMENT
+.IP LIBMOUNT_FSTAB=<path>
+overrides the default location of the fstab file (ignored for suid)
+.IP LIBMOUNT_MTAB=<path>
+overrides the default location of the mtab file (ignored for suid)
+.IP LIBMOUNT_DEBUG=all
+enables libmount debug output
 .SH FILES
 .TP
 .I /etc/mtab
@@ -264,13 +271,6 @@ table of known filesystems
 .TP
 .I /proc/self/mountinfo
 table of mounted filesystems generated by kernel.
-.SH ENVIRONMENT
-.IP LIBMOUNT_FSTAB=<path>
-overrides the default location of the fstab file (ignored for suid)
-.IP LIBMOUNT_MTAB=<path>
-overrides the default location of the mtab file (ignored for suid)
-.IP LIBMOUNT_DEBUG=all
-enables libmount debug output
 .SH HISTORY
 A
 .B umount
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
