Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36520 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab3ASAKJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:10:09 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so2459227wgd.28
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:10:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 22/22] tests: sort commands strings
Date: Sat, 19 Jan 2013 00:09:11 +0000
Message-Id: <1358554151-25985-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The list is starting to be long enough that making any order to it seems
like right thing to do.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh | 81 ++++++++++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/tests/commands.sh b/tests/commands.sh
index 3138fbf..787a4be 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -26,58 +26,47 @@ TS_HELPER_LOGINDEFS="$top_builddir/test_logindefs"
 # TODO: use partx
 TS_HELPER_PARTITIONS="$top_builddir/sample-partitions"
 
-# paths to commands
-TS_CMD_MOUNT=${TS_CMD_MOUNT:-"$top_builddir/mount"}
-TS_CMD_UMOUNT=${TS_CMD_UMOUNT:-"$top_builddir/umount"}
-
-TS_CMD_SWAPON=${TS_CMD_SWAPON:-"$top_builddir/swapon"}
-TS_CMD_SWAPOFF=${TS_CMD_SWAPOFF:-"$top_builddir/swapoff"}
-TS_CMD_LOSETUP=${TS_CMD_LOSETUP:-"$top_builddir/losetup"}
-
-TS_CMD_MKSWAP=${TS_CMD_MKSWAP:-"$top_builddir/mkswap"}
-TS_CMD_MKCRAMFS=${TS_CMD_MKCRAMFS:-"$top_builddir/mkfs.cramfs"}
-TS_CMD_MKMINIX=${TS_CMD_MKMINIX:-"$top_builddir/mkfs.minix"}
-TS_CMD_FSCKCRAMFS=${TS_CMD_FSCKCRAMFS:-"$top_builddir/test_fsck.cramfs"}
-TS_CMD_FSCKMINIX=${TS_CMD_FSCKMINIX:-"$top_builddir/fsck.minix"}
-
-TS_CMD_IPCS=${TS_CMD_IPCS:-"$top_builddir/ipcs"}
-
+# paths to commands (keep in a to z order)
+TS_CMD_BLKID=${TS_CMD_BLKID-"$top_builddir/blkid"}
+TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
 TS_CMD_COL=${TS_CMD_COL:-"$top_builddir/col"}
-TS_CMD_COLUMN=${TS_CMD_COLUMN:-"$top_builddir/column"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"$top_builddir/colrm"}
-TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
-
-TS_CMD_NAMEI=${TS_CMD_NAMEI-"$top_builddir/namei"}
-TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/look"}
-TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
-TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
+TS_CMD_COLUMN=${TS_CMD_COLUMN:-"$top_builddir/column"}
+TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
 TS_CMD_EJECT=${TS_CMD_EJECT-"$top_builddir/eject"}
-
-
-TS_CMD_HWCLOCK=${TS_CMD_HWCLOCK-"$top_builddir/hwclock"}
-TS_CMD_LSCPU=${TS_CMD_LSCPU-"$top_builddir/lscpu"}
-
-TS_CMD_BLKID=${TS_CMD_BLKID-"$top_builddir/blkid"}
-TS_CMD_PARTX=${TS_CMD_PARTX-"$top_builddir/partx"}
-TS_CMD_FINDMNT=${TS_CMD_FINDMNT-"$top_builddir/findmnt"}
-
+TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
-
-TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
-
-TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
+TS_CMD_FINDMNT=${TS_CMD_FINDMNT-"$top_builddir/findmnt"}
+TS_CMD_FSCKCRAMFS=${TS_CMD_FSCKCRAMFS:-"$top_builddir/test_fsck.cramfs"}
+TS_CMD_FSCKMINIX=${TS_CMD_FSCKMINIX:-"$top_builddir/fsck.minix"}
 TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
-TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
-TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
-TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
+TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
+TS_CMD_HWCLOCK=${TS_CMD_HWCLOCK-"$top_builddir/hwclock"}
 TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
-TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
+TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
+TS_CMD_IPCRM=${TS_CMD_IPCRM-"$top_builddir/ipcrm"}
+TS_CMD_IPCS=${TS_CMD_IPCS:-"$top_builddir/ipcs"}
+TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
-TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
-TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
+TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/look"}
+TS_CMD_LOSETUP=${TS_CMD_LOSETUP:-"$top_builddir/losetup"}
+TS_CMD_LSCPU=${TS_CMD_LSCPU-"$top_builddir/lscpu"}
+TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
+TS_CMD_MKCRAMFS=${TS_CMD_MKCRAMFS:-"$top_builddir/mkfs.cramfs"}
+TS_CMD_MKMINIX=${TS_CMD_MKMINIX:-"$top_builddir/mkfs.minix"}
+TS_CMD_MKSWAP=${TS_CMD_MKSWAP:-"$top_builddir/mkswap"}
+TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
+TS_CMD_MOUNT=${TS_CMD_MOUNT:-"$top_builddir/mount"}
+TS_CMD_NAMEI=${TS_CMD_NAMEI-"$top_builddir/namei"}
+TS_CMD_PARTX=${TS_CMD_PARTX-"$top_builddir/partx"}
+TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
+TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
-TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
-TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
+TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
+TS_CMD_SWAPOFF=${TS_CMD_SWAPOFF:-"$top_builddir/swapoff"}
+TS_CMD_SWAPON=${TS_CMD_SWAPON:-"$top_builddir/swapon"}
+TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
+TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
+TS_CMD_UMOUNT=${TS_CMD_UMOUNT:-"$top_builddir/umount"}
+TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
 TS_CMD_WHEREIS=${TS_CMD_WHEREIS-"$top_builddir/whereis"}
-TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
-TS_CMD_IPCRM=${TS_CMD_IPCRM-"$top_builddir/ipcrm"}
-- 
1.8.1.1

