Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB49C433E5
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1F22065C
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ4C4+UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXKGl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgGXKGl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:06:41 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399FFC0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w9so9382581ejc.8
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZqvbXXTLEGzIwLE6Q7Pvmy0sL8qITV27V5UAUpWm9E=;
        b=TZ4C4+UMENlfChAHQRP/Zazi4cayrFHDg5LJEXQbkhwrg7R8aSbfNX2EJrgc/hiDCj
         5zv1tNGn0xFp/4hpc8Oim/kMXdIMv8zZ/Am+phxEaakBUz/WrSGCjz9Ow7LhLAofVo9t
         Ce8GDnZOYaFIknMBKml4bp6FOzNukrB8Ncqc1HX8jtze/e8rZ+UHa+i78WObwjf9aFVT
         riQjbfPnH5H4rTxczbw3VD0yl1rDU2rReej7VrHO+iXPzmCr1ZBVH1UuQtx9PgP0v98D
         qdukLzBWomB2kwqJXsvYMw5E4xixsevZVqZLo02of/OKEgsup6ZYwN90Lx544L2Y4I5K
         zAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZqvbXXTLEGzIwLE6Q7Pvmy0sL8qITV27V5UAUpWm9E=;
        b=p/yej/zq+zrcLAwDKDBKGpzgCw39UMzxLQOmbjFrFFicLe9pQShgyEIIpx3bm682Uc
         SMDnVGFzALy7DWinEI9yQc2uXClZpzVzcktSII1jjoSQtISaRkM2eSCc7lCmCs1ktYIj
         Wv2LHPDc2joytq4y1HgL7BzMgAxbYaKfStVoQv6sW4ogxmw71yiFYZdfktv0H15Wmuh+
         e7evy8ZVqWW3FbizMKBUjSOwgbUVVKWEfyJP1pSi8ajqzl8VV80hUFfivv3ETUPGBV3D
         6zcqseY91UJ05qh4i4qaAifaxmdYj9iweUwhZbLFHzyahwYlDlUizChvE8bsUaDB055D
         RkPA==
X-Gm-Message-State: AOAM533Yqsn3j6dXJANCEueRVsRvJYB0hCALIY3bep6l4MbyG8UQugj5
        jHXVR2YkQRGbJHBVQ5iphsPGpbyf
X-Google-Smtp-Source: ABdhPJweUV1iApFULSpMdDgt0w4vXYCz4ePOp6oMRs+dMFjEMFCynxvGmwbNGAqldwo+d5zORhOHdg==
X-Received: by 2002:a17:907:4420:: with SMTP id om24mr8220068ejb.10.1595585199946;
        Fri, 24 Jul 2020 03:06:39 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id i5sm339998ejc.114.2020.07.24.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:39 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 04/12] Manual pages: sfdisk.8: Minor wording and formatting fixes
Date:   Fri, 24 Jul 2020 12:06:10 +0200
Message-Id: <20200724100618.584918-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 disk-utils/sfdisk.8 | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 6c3f62edd..6c54a1699 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -26,7 +26,7 @@ sfdisk \- display or manipulate a disk partition table
 .SH DESCRIPTION
 .B sfdisk
 is a script-oriented tool for partitioning any block device.  It
-runs in interactive mode if executed on terminal (stdin refers to a terminal).
+runs in interactive mode if executed on a terminal (stdin refers to a terminal).
 
 Since version 2.26
 .B sfdisk
@@ -45,11 +45,15 @@ to alignment if the start offset is specified exactly in sectors and partition
 size relative or by multiplicative suffixes.
 
 The recommended way is not to specify start offsets at all and specify
-partition size in MiB, GiB (or so).  In this case sfdisk align all partitions
+partition size in MiB, GiB (or so).  In this case
+.B sfdisk
+aligns all partitions
 to block-device I/O limits (or when I/O limits are too small then to megabyte
 boundary to keep disk layout portable).  If this default behaviour is unwanted
 (usually for very small partitions) then specify offsets and sizes in
-sectors.  In this case sfdisk entirely follows specified numbers without any
+sectors.  In this case
+.B sfdisk
+entirely follows specified numbers without any
 optimization.
 .sp
 .B sfdisk
@@ -62,11 +66,15 @@ partitions.
 .B sfdisk
 uses BLKRRPART (reread partition table) ioctl to make sure that the device is
 not used by system or other tools (see also \-\-no-reread).  It's possible that
-this feature or another sfdisk activity races with \fBudevd\fR.  The recommended way
+this feature or another
+.B sfdisk
+activity races with \fBudevd\fR.  The recommended way
 how to avoid possible collisions is to use \fB\-\-lock\fR option.
 The exclusive lock will cause udevd to skip the event handling on the device.
 .PP
-The sfdisk prompt is only a hint for users and a displayed partition number does
+The
+.B sfdisk
+prompt is only a hint for users and a displayed partition number does
 not mean that the same partition table entry will be created (if -N not
 specified), especially for tables with gaps.
 
@@ -96,8 +104,10 @@ bootable flag on all unspecified partitions. The special placeholder '\-'
 may be used instead of the partition numbers to switch off the bootable flag
 on all partitions.
 
-The activation command is supported for MBR and PMBR only.  If GPT label is detected
-than sfdisk prints warning and automatically enter PMBR.
+The activation command is supported for MBR and PMBR only.
+If a GPT label is detected, then
+.B sfdisk
+prints warning and automatically enters PMBR.
 
 If no \fIpartition-number\fR is specified, then list the partitions with an
 enabled flag.
@@ -267,7 +277,9 @@ and the last command reorders partitions to match disk order
 
 .TP
 .B \-\-move\-use\-fsync
-Use fsync system call after each write when move data to a new location by
+Use the
+.BR fsync (2)
+system call after each write when moving data to a new location by
 \fB\-\-move\-data\fR.
 .TP
 .BR \-o , " \-\-output " \fIlist
@@ -305,7 +317,7 @@ to avoid possible collisions.  The argument \fIwhen\fR can be \fBauto\fR,
 except the old partition-table signatures which are always wiped before create
 a new partition-table if the argument \fIwhen\fR is not \fBnever\fR. In all
 cases detected signatures are reported by warning messages before a new
-partition table is created.  See also
+partition table is created.  See also the
 .BR wipefs (8)
 command.
 
@@ -418,7 +430,9 @@ The partition
 is given in hex for MBR (DOS) where 0x prefix is optional; a GUID string for
 GPT; a shortcut or an alias. It's recommended to use two letters for MBR hex codes to
 avoid collision between deprecated shortcut 'E' and '0E' MBR hex code. For backward
-compatibility sfdisk tries to interpret
+compatibility
+.B sfdisk
+tries to interpret
 .I type
 as a shortcut as a first possibility in partitioning scripts although on other places (e.g.
 \fB\-\-part-type command)\fR it tries shortcuts as the last possibility.
@@ -601,7 +615,9 @@ The welcome message.
 
 .SH ENVIRONMENT
 .IP SFDISK_DEBUG=all
-enables sfdisk debug output.
+enablescw
+.B sfdisk
+debug output.
 .IP LIBFDISK_DEBUG=all
 enables libfdisk debug output.
 .IP LIBBLKID_DEBUG=all
-- 
2.26.2

