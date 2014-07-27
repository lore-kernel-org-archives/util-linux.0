Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:53248 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S7Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:24 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] docs: remove all mention of helper= and uhelper= from umount man page
Date: Sun, 27 Jul 2014 20:58:57 +0200
Message-Id: <1406487540-10491-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
References: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/umount.8 |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 9d45157..54fe7ae 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -151,25 +151,24 @@ it finds the option \fBloop=...\fR in
 or when the \fB\-d\fR option was given.  Any still associated loop devices
 can be freed by using \fBlosetup -d\fR; see
 .BR losetup (8).
-.SH "EXTERNAL HELPERS"
+.SH EXTERNAL HELPERS
 The syntax of external unmount helpers is:
 .PP
-.BI /sbin/umount. suffix
+.RS
+.BI umount. suffix
 .RI { directory | device }
 .RB [ \-flnrv ]
 .RB [ \-t
 .IR type . subtype ]
+.RE
 .PP
-where \fIsuffix\fR is the filesystem type or a value from a "uhelper=" or
-"helper=" mtab option.  The \fB\-t\fR option can be used for filesystems
-with subtypes support (for example \fB/sbin/mount.fuse -t fuse.sshfs\fR).
+where \fIsuffix\fR is the filesystem type.
+The \fB\-t\fR option can be used for filesystems that
+have subtype support.  For example:
 .PP
-The \fBuhelper=\fR (unprivileged unmount helper) mount option can be used
-when non-root users need to be able to unmount a mountpoint which is not
-defined in \fI/etc/fstab\fR (e.g. devices mounted by udisk).
-.PP
-The \fBhelper=\fR mount option redirects all unmount requests to the
-\fB/sbin/umount.\fItype\fR helper independently of UID.
+.RS
+.B umount.fuse \-t fuse.sshfs
+.RE
 .SH FILES
 .TP
 .B /etc/mtab
-- 
1.7.0.4

