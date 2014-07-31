Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:53173 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008AbaGaUnf (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Jul 2014 16:43:35 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: restore the mention of uhelper= and helper= in man page of umount
Date: Thu, 31 Jul 2014 22:43:29 +0200
Message-Id: <1406839409-2846-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/umount.8 |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 54fe7ae..8a640f4 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -162,20 +162,30 @@ The syntax of external unmount helpers is:
 .IR type . subtype ]
 .RE
 .PP
-where \fIsuffix\fR is the filesystem type.
+where \fIsuffix\fR is the filesystem type (or the value from a
+\fBuhelper=\fR or \fBhelper=\fR marker in the mtab file).
 The \fB\-t\fR option can be used for filesystems that
 have subtype support.  For example:
 .PP
 .RS
 .B umount.fuse \-t fuse.sshfs
 .RE
+.PP
+A \fBuhelper=\fIsomething\fR marker (unprivileged helper) can appear in
+the \fI/etc/mtab\fR file when ordinary users need to be able to unmount
+a mountpoint that is not defined in \fI/etc/fstab\fR
+(for example for a device that was mounted by \fBudisks\fR(1)).
+.PP
+A \fBhelper=\fItype\fR marker in the mtab file will redirect
+all unmount requests
+to the \fB/sbin/umount.\fItype\fR helper independently of UID.
 .SH FILES
 .TP
 .B /etc/mtab
 table of mounted filesystems
 .TP
 .B /etc/fstab
-checked when option \fB\-O\fR is given
+table of known filesystems
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
 overrides the default location of the fstab file
-- 
1.7.0.4

