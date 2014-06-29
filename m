Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:60409 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2Pzc (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:55:32 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/7] docs: slightly improve the man page of umount
Date: Sun, 29 Jun 2014 17:49:43 +0200
Message-Id: <1404056983-10119-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove some stray words from option arguments.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/umount.8 |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index c9e2aca..4128d2f 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -32,7 +32,7 @@ umount \- unmount file systems
 .B umount \-a
 .RB [ \-dflnrv ]
 .RB [ \-t
-.IR vfstype ]
+.IR fstype ]
 .RB [ \-O
 .IR options ]
 .br
@@ -42,7 +42,7 @@ umount \- unmount file systems
 .SH DESCRIPTION
 The
 .B umount
-command detaches the file system(s) mentioned from the file hierarchy.  A
+command detaches the mentioned file system(s) from the file hierarchy.  A
 file system is specified by giving the directory where it has been
 mounted.  Giving the special device on which the file system lives may
 also work, but is obsolete, mainly because it will fail in case this
@@ -58,7 +58,7 @@ files.  A lazy unmount avoids this problem.
 .SH OPTIONS
 .TP
 \fB\-a\fR, \fB\-\-all\fR
-All of the file systems described in
+All of the filesystems described in
 .I /etc/mtab
 are unmounted.  (With
 .B umount
@@ -108,11 +108,11 @@ Lazy unmount.  Detach the filesystem from the filesystem hierarchy now,
 and cleanup all references to the filesystem as soon as it is not busy
 anymore.  (Requires kernel 2.4.11 or later.)
 .TP
-\fB\-O\fR, \fB\-\-test\-opts\fR \fIoptions,list\fR
-Indicate that the actions should only be taken on file systems with the
-specified options in
+\fB\-O\fR, \fB\-\-test\-opts\fR \fIoption\fR
+Indicate that the actions should only be taken on filesystems with the
+specified option in
 .IR /etc/fstab .
-More than one option type may be specified in a comma separated list.
+More than one option may be specified in a comma-separated list.
 Each option can be prefixed with
 .B no
 to specify options for which no action should be taken.
@@ -127,14 +127,14 @@ is unsupported.
 \fB\-r\fR, \fB\-\-read\-only\fR
 In case unmounting fails, try to remount read-only.
 .TP
-\fB\-t\fR, \fB\-\-types\fR \fIvfstype,ext2,ext3\fR
-Indicate that the actions should only be taken on file systems of the
+\fB\-t\fR, \fB\-\-types\fR \fItype\fR
+Indicate that the actions should only be taken on filesystems of the
 specified
 .IR type .
-More than one type may be specified in a comma separated list.  The list
-of file system types can be prefixed with
+More than one type may be specified in a comma-separated list.  The list
+of filesystem types can be prefixed with
 .B no
-to specify the file system types on which no action should be taken.
+to specify the types of filesystem on which no action should be taken.
 .TP
 \fB\-v\fR, \fB\-\-verbose\fR
 Verbose mode.
@@ -174,7 +174,7 @@ The helper= mount option redirects all umount requests to the
 /sbin/umount.<helper> independently on UID.
 .SH FILES
 .I /etc/mtab
-table of mounted file systems
+table of mounted filesystems
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
 overrides the default location of the fstab file
-- 
1.7.0.4

