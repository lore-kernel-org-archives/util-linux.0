Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.digidescorp.com ([50.73.98.161]:10989 "EHLO
	mail.digidescorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2G3MYd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 30 Jul 2012 08:24:33 -0400
Received: from iscandar.digidescorp.com by digidescorp.com (Cipher TLSv1:RC4-MD5:128) (MDaemon PRO v12.5.5)
	with ESMTP id md50002200029.msg
	for <util-linux@vger.kernel.org>; Mon, 30 Jul 2012 07:24:31 -0500
From: "Steven J. Magnani" <steve@digidescorp.com>
To: util-linux@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@gmail.com>, hirofumi@mail.parknet.co.jp,
        Karel Zak <kzak@redhat.com>,
        "Steven J. Magnani" <steve@digidescorp.com>
Subject: [PATCH] util-linux: Document new FAT options
Date: Mon, 30 Jul 2012 07:24:07 -0500
Message-Id: <1343651047-3061-1-git-send-email-steve@digidescorp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add man-page documentation for the new 'discard' and 'nfs' options
available for vfat/msdos filesystems.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
--- a/sys-utils/mount.8	2012-07-30 07:16:34.224450761 -0500
+++ b/sys-utils/mount.8	2012-07-30 07:14:07.693240720 -0500
@@ -1744,6 +1744,11 @@ flag.  A version string and a list of fi
 printed (these data are also printed if the parameters appear to be
 inconsistent).
 .TP
+.B discard
+If set, causes discard/TRIM commands to be issued to the block device
+when blocks are freed. This is useful for SSD devices and 
+sparse/thinly-provisoned LUNs.
+.TP
 .BR fat= {12 | 16 | 32 }
 Specify a 12, 16 or 32 bit fat.  This overrides
 the automatic FAT type detection routine.  Use with caution!
@@ -1753,6 +1758,11 @@ Character set to use for converting betw
 and 16 bit Unicode characters. The default is iso8859-1.
 Long filenames are stored on disk in Unicode format.
 .TP
+.B nfs
+If set, enables in-memory indexing of directory inodes to reduce the
+frequency of ESTALE errors in NFS client operations. Useful only when
+the filesystem is exported via NFS.
+.TP
 .BI tz=UTC
 This option disables the conversion of timestamps
 between local time (as used by Windows on FAT) and UTC

