Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55562 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2LPKor (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:47 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061857wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/14] docs: fsck(8), mkfs(8): update manual references
Date: Sun, 16 Dec 2012 10:44:02 +0000
Message-Id: <1355654642-22106-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.8 | 16 +++++-----------
 disk-utils/mkfs.8 | 10 ++++------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 344a06f..21e79da 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -451,17 +451,11 @@ enables debug output.
 .SH SEE ALSO
 .BR fstab (5),
 .BR mkfs (8),
-.BR fsck.ext2 (8)
-or
-.BR fsck.ext3 (8)
-or
 .BR e2fsck (8),
-.BR cramfsck (8),
-.BR fsck.minix (8),
-.BR fsck.msdos (8),
+.BR e2fsck.conf (5),
+.BR jfs_fsck (8),
+.BR jfs_fscklog (8),
 .BR fsck.jfs (8),
-.BR fsck.nfs (8),
-.BR fsck.vfat (8),
+.BR fsck.minix (8),
 .BR fsck.xfs (8),
-.BR fsck.xiafs (8),
-.BR reiserfsck (8).
+.BR reiserfsck (8)
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index af9304b..c8e3d22 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -94,17 +94,15 @@ for the ext2 filesystem.
 .BR fs (5),
 .BR badblocks (8),
 .BR fsck (8),
-.BR mkdosfs (8),
-.BR mke2fs (8),
 .BR mkfs.bfs (8),
 .BR mkfs.ext2 (8),
 .BR mkfs.ext3 (8),
 .BR mkfs.ext4 (8),
+.BR mkfs.ext4dev (8),
+.BR mkfs.jfs (8),
+.BR jfs_mkfs (8),
 .BR mkfs.minix (8),
-.BR mkfs.msdos (8),
-.BR mkfs.vfat (8),
-.BR mkfs.xfs (8),
-.BR mkfs.xiafs (8)
+.BR mkfs.xfs (8)
 .SH AVAILABILITY
 The mkfs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.8.0.2

