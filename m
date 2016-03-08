Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:54436 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932601AbcCHJWF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:22:05 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 9/9] mount: adjust some wordings and formatting in the man page
Date: Tue,  8 Mar 2016 10:07:52 +0100
Message-Id: <1457428072-2619-9-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |   49 ++++++++++++++++++++-----------------------------
 1 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 1903253..8464b5c 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -27,7 +27,7 @@
 .\" with this program; if not, write to the Free Software Foundation, Inc.,
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
-.TH MOUNT 8 "July 2014" "util-linux" "System Administration"
+.TH MOUNT 8 "August 2015" "util-linux" "System Administration"
 .SH NAME
 mount \- mount a filesystem
 .SH SYNOPSIS
@@ -91,11 +91,9 @@ refers to the root of the filesystem on
 
 If only the directory or the device is given, for example:
 .RS
-
-.br
+.sp
 .BI "mount /dir"
-.br
-
+.sp
 .RE
 then \fBmount\fR looks for a mountpoint (and if not found then for a device) in the
 .IR /etc/fstab
@@ -105,14 +103,11 @@ or
 .B \-\-source
 options to avoid ambivalent interpretation of the given argument.  For example:
 .RS
-
-.br
+.sp
 .BI "mount \-\-target /mountpoint"
-.br
-
+.sp
 .RE
 
-
 .B The listing.
 .RS
 The listing mode is maintained for backward compatibility only.
@@ -124,13 +119,11 @@ mountpoint name are replaced with '?'.
 
 The following command lists all mounted filesystems (of type
 .IR type ):
-
 .RS
-.br
+.sp
 .BR "mount " [ \-l "] [" "\-t \fItype\/\fP" ]
-.br
+.sp
 .RE
-
 The option \fB\-l\fR adds labels to this listing.  See below.
 .RE
 
@@ -284,15 +277,13 @@ Thus, given a line
 .sp
 .RE
 any user can mount the iso9660 filesystem found on an inserted CDROM
-using the command
+using the command:
 .RS
 .sp
 .B "mount /dev/cdrom"
-.sp
 .RE
 or
 .RS
-.sp
 .B "mount /cd"
 .sp
 .RE
@@ -364,22 +355,21 @@ a second place by using:
 Note that the filesystem mount options will remain the same as those
 on the original mount point.
 
-.BR mount(8)
-since v2.27 allow to change the options by passing the
-.B \-o
-option along with
-.BR \-\-bind
-for example:
+.BR mount (8)
+since v2.27 allows to change the mount options by passing the
+relevant options along with
+.BR \-\-bind .
+For example:
 
 .RS
 .br
 .B mount \-\-bind,ro foo foo
 .RE
 
-This feature is not supported by Linux kernel and it is implemented in userspace
-by additional remount mount(2) syscall. This solution is not atomic.
+This feature is not supported by the Linux kernel; it is implemented in userspace
+by an additional \fBmount\fR(2) remounting syscall.  This solution is not atomic.
 
-The alternative (classic) way to create a read-only bind mount is to use remount
+The alternative (classic) way to create a read-only bind mount is to use the remount
 operation, for example:
 
 .RS
@@ -391,14 +381,15 @@ operation, for example:
 .I olddir newdir
 .RE
 
-Note that read-only bind will create a read-only mountpoint (VFS entry), but the
-original filesystem superblock will still be writable, meaning that the
+Note that a read-only bind will create a read-only mountpoint (VFS entry),
+but the original filesystem superblock will still be writable, meaning that the
 .I olddir
 will be writable, but the
 .I newdir
 will be read-only.
 
-It's impossible to change mount options recursively (for example b \fB -o rbind,ro\fR).
+It's impossible to change mount options recursively
+(for example with \fB-o rbind,ro\fR).
 .RE
 
 .B The move operation.
-- 
1.7.0.4

