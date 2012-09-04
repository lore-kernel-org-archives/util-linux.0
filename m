Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:54703 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757086Ab2IDN6P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Sep 2012 09:58:15 -0400
Subject: [PATCH 2/2] libmount: document LIBMOUNT_DEBUG users
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Sep 2012 15:58:06 +0200
Message-ID: <1346767086.2668.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Update the manpages of programs that use this environment variable for
extra debugging information.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/fsck.8      |    3 +++
 misc-utils/lsblk.8     |    3 +++
 sys-utils/mountpoint.1 |    4 ++++
 sys-utils/swapon.8     |    4 ++++
 sys-utils/umount.8     |    7 +++++++
 5 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 1c89cfe..7779fe9 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -445,6 +445,9 @@ file.  It is also useful for developers who are testing
 .TP
 .B LIBBLKID_DEBUG=0xffff
 enables debug output.
+.TP
+.B LIBMOUNT_DEBUG=0xffff
+enables debug output.
 .SH SEE ALSO
 .BR fstab (5),
 .BR mkfs (8),
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 4ed024f..ced0a13 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -95,6 +95,9 @@ the time of kernel build.
 Milan Broz <mbroz@redhat.com>
 Karel Zak <kzak@redhat.com>
 .fi
+.SH ENVIRONMENT
+.IP LIBMOUNT_DEBUG=0xffff
+enables debug output.
 .SH SEE ALSO
 .BR findmnt (8),
 .BR blkid (8),
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index 3c7d084..5eb4156 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -29,12 +29,16 @@ Zero if the directory is a mountpoint, non-zero if not.
 .SH AUTHOR
 .PP
 Karel Zak <kzak@redhat.com>
+.SH ENVIRONMENT
+.IP LIBMOUNT_DEBUG=0xffff
+enables debug output.
 .SH NOTES
 .PP
 The util-linux
 .B mountpoint
 implementation was written from scratch for libmount. The original version
 for sysvinit suite was written by Miquel van Smoorenburg.
+
 .SH SEE ALSO
 .BR mount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index ed4df55..e471d07 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -217,6 +217,10 @@ log as "swapon: swapfile has holes." One possible workaround is to map the
 file to a loopback device. This will allow the file system to determine the
 mapping properly but may come with a performance impact.
 
+.SH ENVIRONMENT
+.IP LIBMOUNT_DEBUG=0xffff
+enables debug output.
+
 .SH SEE ALSO
 .BR swapon (2),
 .BR swapoff (2),
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index d073c55..f0fcd99 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -160,6 +160,13 @@ The helper= mount option redirects all umount requests to the
 .SH FILES
 .I /etc/mtab
 table of mounted file systems
+.SH ENVIRONMENT
+.IP LIBMOUNT_FSTAB=<path>
+overrides the default location of the fstab file
+.IP LIBMOUNT_MTAB=<path>
+overrides the default location of the mtab file
+.IP LIBMOUNT_DEBUG=0xffff
+enables debug output
 .SH "SEE ALSO"
 .BR umount (2),
 .BR mount (8),
-- 
1.7.4.1




