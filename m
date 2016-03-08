Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:52936 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932244AbcCHJVi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:38 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/9] fstrim: a few tiny tweaks of the man page
Date: Tue,  8 Mar 2016 10:07:47 +0100
Message-Id: <1457428072-2619-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/fstrim.8 |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index fd8507d..b30c8c2 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -34,7 +34,7 @@ Running
 frequently, or even using
 .BR "mount -o discard" ,
 might negatively affect the lifetime of poor-quality SSD devices.  For most
-desktop and server systems the sufficient trimming frequency is once a week.
+desktop and server systems a sufficient trimming frequency is once a week.
 Note that not all
 devices support a queued trim, so each trim command incurs a performance penalty
 on whatever else might be trying to use the disk at the time.
@@ -64,11 +64,11 @@ will stop at the filesystem size boundary.  The default value extends to
 the end of the filesystem.
 .IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
 Minimum contiguous free range to discard, in bytes. (This value is internally
-rounded up to a multiple of the filesystem block size).  Free ranges smaller
+rounded up to a multiple of the filesystem block size.)  Free ranges smaller
 than this will be ignored.  By increasing this value, the fstrim operation
 will complete more quickly for filesystems with badly fragmented freespace,
-although not all blocks will be discarded.  Default value is zero, discard
-every free block.
+although not all blocks will be discarded.  The default value is zero,
+discarding every free block.
 .IP "\fB\-v, \-\-verbose\fP"
 Verbose execution.  With this option
 .B fstrim
@@ -114,7 +114,7 @@ Lukas Czerner <lczerner@redhat.com>
 Karel Zak <kzak@redhat.com>
 .fi
 .SH SEE ALSO
-.BR mount (8)
+.BR mount (8),
 .BR blkdiscard (8)
 .SH AVAILABILITY
 The fstrim command is part of the util-linux package and is available from
-- 
1.7.0.4

