Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36543 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbcKJK7x (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so682450wma.3
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:52 -0800 (PST)
Subject: [PATCH 07/12] Fix formatting errors in page cross references
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5eca5018-ca00-67a3-1999-8beecba629a9@gmail.com>
Date: Thu, 10 Nov 2016 11:59:49 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These pages had errors such as

    .BR page (x) .

which should be

    .BR page (x).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/swaplabel.8 | 2 +-
 misc-utils/findmnt.8   | 2 +-
 sys-utils/blkdiscard.8 | 2 +-
 sys-utils/dmesg.1      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index 45c0492..8bac331 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -53,7 +53,7 @@ will truncate it and print a warning message.
 Specify a new \fIUUID\fR for the device.
 The \fI UUID\fR
 must be in the standard 8-4-4-4-12 character format, such as is output by
-.BR uuidgen (1) .
+.BR uuidgen (1).
 .PP
 .SH AUTHOR
 .B swaplabel
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 105f2c5..6e4ddb4 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -162,7 +162,7 @@ or \fB\-\-first\-only\fP options.
 The standard columns always use the new version of the information from the
 mountinfo file, except the umount action which is based on the original
 information cached by
-.BR findmnt (8) .
+.BR findmnt (8).
 The poll mode allows to use extra columns:
 .RS
 .TP
diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index da3d6cb..3b24f2f 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -13,7 +13,7 @@ blkdiscard \- discard sectors on a device
 .B blkdiscard
 is used to discard device sectors.  This is useful for solid-state
 drivers (SSDs) and thinly-provisioned storage.  Unlike
-.BR fstrim (8) ,
+.BR fstrim (8),
 this command is used directly on the block device.
 .PP
 By default,
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 6e0812f..d553418 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -120,7 +120,7 @@ Print the raw message buffer, i.e. do not strip the log-level prefixes.
 Note that the real raw format depends on the method how
 .BR dmesg (1)
 reads kernel messages.  The /dev/kmsg device uses a different format than
-.BR syslog (2) .
+.BR syslog (2).
 For backward compatibility,
 .BR dmesg (1)
 returns data always in the
-- 
2.5.5

