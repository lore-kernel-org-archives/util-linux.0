Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:57435 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbcCHJVU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:20 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/9] fdisk, sfdisk: adjust the wording of the --wipe option
Date: Tue,  8 Mar 2016 10:07:45 +0100
Message-Id: <1457428072-2619-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use "when" as argument, to match the argument of --color,
that can have the same three values.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdisk.8  |   13 +++++++------
 disk-utils/sfdisk.8 |   13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 49401e5..89e3153 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -119,12 +119,13 @@ Specify the number of sectors per track of the disk.
 partition tables.) A reasonable value is 63.
 
 .TP
-\fB\-w\fR, \fB\-\-wipe\fR \fImode\fR
-Wipe filesystems, RAIDs and partition tables signatures from the device, in
-order to avoid possible collisions.  The \fImode\fR can be \fBauto\fR,
-\fBnever\fR or \fBalways\fR.  The default is \fBauto\fR, in this case signatures
-are wiped in the interactive mode only, in all cases detected signatures are
-reported by warning message before a new partition table is created. See also
+\fB\-w\fR, \fB\-\-wipe\fR \fIwhen\fR
+Wipe filesystem, RAID and partition-table signatures from the device, in order
+to avoid possible collisions.  The argument \fIwhen\fR can be \fBauto\fR,
+\fBnever\fR or \fBalways\fR.  When this option is not given, the default is
+\fBauto\fR, in which case signatures are wiped only when in interactive mode.
+In all cases detected signatures are reported by warning messages
+before a new partition table is created.  See also
 .BR wipefs (8)
 command.
 
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index b8cacee..52b1b34 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -210,12 +210,13 @@ Force editing of a nested disk label.  The primary disk label has to exist alrea
 This option allows to edit for example a hybrid/protective MBR on devices with GPT.
 
 .TP
-.BR -w , " \-\-wipe "\fImode
-Wipe filesystems, RAIDs and partition tables signatures from the device, in
-order to avoid possible collisions.  The \fImode\fR can be \fBauto\fR,
-\fBnever\fR or \fBalways\fR.  The default is \fBauto\fR, in this case signatures
-are wiped in the interactive mode only, in all cases detected signatures are
-reported by warning message before a new partition table is created. See also
+.BR -w , " \-\-wipe "\fIwhen
+Wipe filesystem, RAID and partition-table signatures from the device, in order
+to avoid possible collisions.  The argument \fIwhen\fR can be \fBauto\fR,
+\fBnever\fR or \fBalways\fR.  When this option is not given, the default is
+\fBauto\fR, in which case signatures are wiped only when in interactive mode.
+In all cases detected signatures are reported by warning messages
+before a new partition table is created.  See also
 .BR wipefs (8)
 command.
 
-- 
1.7.0.4

