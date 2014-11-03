Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:50713 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753926AbaKCVR1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Nov 2014 16:17:27 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] docs: fix some wording, grammar and formatting in man page of swapon
Date: Mon,  3 Nov 2014 22:17:16 +0100
Message-Id: <1415049437-2301-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fsck.8  |    2 +-
 sys-utils/swapon.8 |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 531bcf5..7d522ab 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -440,7 +440,7 @@ file.  It is also useful for developers who are testing
 enables libblkid debug output.
 .TP
 .B LIBMOUNT_DEBUG=all
-enables lilbmount debug output.
+enables libmount debug output.
 .SH SEE ALSO
 .na
 .BR fstab (5),
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 84047ae..23da280 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -192,40 +192,40 @@ Be verbose.
 .BR \-V , " \-\-version"
 Display version information and exit.
 .SH NOTES
-You should not use swapon on a file with holes. This can be seen in the system
-log as
+You should not use \fBswapon\fR on a file with holes.
+This can be seen in the system log as
 .RS
 .sp
 .B "swapon: swapfile has holes."
 .sp
 .RE
-The swap file implementation in the kernel expecting to be able to write to the
-file directly, without the assistance of the file system. This is problem on
+The swap file implementation in the kernel expects to be able to write to the
+file directly, without the assistance of the filesystem.  This is a problem on
 preallocated files (e.g.
-.BR fallocate (1)
-) on filesystems like \fBXFS\fR or \fBext4\fR, and on copy-on-write file
-systems like \fBbtrfs\fR.
+.BR fallocate (1))
+on filesystems like \fBXFS\fR or \fBext4\fR, and on copy-on-write
+filesystems like \fBbtrfs\fR.
 .PP
 It is recommended to use
-. BR dd (1)
+.BR dd (1)
 and
 .I /dev/zero
 to avoid holes on XFS and ext4.
 .PP
 .B swapon
 may not work correctly when using a swap file with some versions of
-\fBbtrfs\fR.  This is due to Since btrfs is a copy-on-write file system, the
+\fBbtrfs\fR.  This is due to btrfs being a copy-on-write filesystem: the
 file location may not be static and corruption can result.  Btrfs actively
-disallows the use of files on its file systems by refusing to map the file.
+disallows the use of swap files on its filesystems by refusing to map the file.
 .PP
-One possible workaround is to map the
-file to a loopback device.  This will allow the file system to determine the
+One possible workaround is to map the swap
+file to a loopback device.  This will allow the filesystem to determine the
 mapping properly but may come with a performance impact.
 .PP
 Swap over \fBNFS\fR may not work.
 .PP
 .B swapon
-automatically detects and rewrites swap space signature with old software
+automatically detects and rewrites a swap space signature with old software
 suspend data (e.g S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't
 do it, then we get data corruption the next time an attempt at unsuspending is
 made.
-- 
1.7.0.4

