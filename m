Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:51238 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419AbbAKV2I (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:28:08 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] docs: sync the docstring of addpart, delpart and resizepart to the man page
Date: Sun, 11 Jan 2015 22:27:55 +0100
Message-Id: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also tweak the wording of those man pages a bit.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/addpart.8    |   19 ++++++++++---------
 disk-utils/delpart.8    |   18 ++++++------------
 disk-utils/resizepart.8 |   17 +++++++++--------
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/disk-utils/addpart.8 b/disk-utils/addpart.8
index dc7e203..867d53f 100644
--- a/disk-utils/addpart.8
+++ b/disk-utils/addpart.8
@@ -1,32 +1,33 @@
-.\" addpart.8 --
+.\" addpart.8 -- man page for addpart
 .\" Copyright 2007 Karel Zak <kzak@redhat.com>
 .\" Copyright 2007 Red Hat, Inc.
 .\" May be distributed under the GNU General Public License
-.TH ADDPART 8 "January 2007" "util-linux" "System Administration"
+.TH ADDPART 8 "January 2015" "util-linux" "System Administration"
 .SH NAME
-addpart \- a simple wrapper around the "add partition" ioctl
+addpart \- tell the kernel about the existence of a partition
 .SH SYNOPSIS
 .B addpart
 .I device partition start length
 .SH DESCRIPTION
 .B addpart
-is a program that informs the Linux kernel of a new partition.
+tells the Linux kernel about the existence of the specified partition.
+The command is a simple wrapper around the "add partition" ioctl.
 
-This command doesn't manipulate partitions on the hard drive.
+This command doesn't manipulate partitions on a hard drive.
 
 .SH PARAMETERS
 .TP
 .I device
-Specify the disk device.
+The disk device.
 .TP
 .I partition
-Specify the partition number.
+The partition number.
 .TP
 .I start
-Specify the beginning of the partition (in 512-byte sectors).
+The beginning of the partition (in 512-byte sectors).
 .TP
 .I length
-Specify the length of the partition (in 512-byte sectors).
+The length of the partition (in 512-byte sectors).
 
 .SH SEE ALSO
 .BR delpart (8),
diff --git a/disk-utils/delpart.8 b/disk-utils/delpart.8
index a818153..8c17678 100644
--- a/disk-utils/delpart.8
+++ b/disk-utils/delpart.8
@@ -1,27 +1,21 @@
-.\" delpart.8 --
+.\" delpart.8 -- man page for delpart
 .\" Copyright 2007 Karel Zak <kzak@redhat.com>
 .\" Copyright 2007 Red Hat, Inc.
 .\" May be distributed under the GNU General Public License
-.TH DELPART 8 "January 2007" "util-linux" "System Administration"
+.TH DELPART 8 "January 2015" "util-linux" "System Administration"
 .SH NAME
-delpart \- simple wrapper around the "del partition" ioctl
+delpart \- tell the kernel to forget about a partition
 .SH SYNOPSIS
 .B delpart
 .I device partition
 .SH DESCRIPTION
 .B delpart
-is a program that asks the Linux kernel to remove a partition.
+asks the Linux kernel to forget about the specified \fIpartition\fR
+(a number) on the specified \fIdevice\fR.
+The command is a simple wrapper around the "del partition" ioctl.
 
 This command doesn't manipulate partitions on a hard drive.
 
-.SH OPTIONS
-.TP
-.I device
-Specify the disk device.
-.TP
-.I partition
-Specify the partition number.
-
 .SH SEE ALSO
 .BR addpart (8),
 .BR fdisk (8),
diff --git a/disk-utils/resizepart.8 b/disk-utils/resizepart.8
index d4f35be..b6efe7e 100644
--- a/disk-utils/resizepart.8
+++ b/disk-utils/resizepart.8
@@ -1,29 +1,30 @@
-.\" resizepart.8 --
+.\" resizepart.8 -- man page for resizepart
 .\" Copyright 2012 Vivek Goyal <vgoyal@redhat.com>
 .\" Copyright 2012 Red Hat, Inc.
 .\" May be distributed under the GNU General Public License
-.TH RESIZEPART 8 "February 2012" "util-linux" "System Administration"
+.TH RESIZEPART 8 "January 2015" "util-linux" "System Administration"
 .SH NAME
-resizepart \- simple wrapper around the "resize partition" ioctl
+resizepart \- tell the kernel about the new size of a partition
 .SH SYNOPSIS
 .B resizepart
 .I device partition length
 .SH DESCRIPTION
 .B resizepart
-is a program that informs the Linux kernel of new partition size.
+tells the Linux kernel about the new size of the specified partition.
+The command is a simple wrapper around the "resize partition" ioctl.
 
-This command doesn't manipulate partitions on hard drive.
+This command doesn't manipulate partitions on a hard drive.
 
 .SH PARAMETERS
 .TP
 .I device
-Specify the disk device.
+The disk device.
 .TP
 .I partition
-Specify the partition number.
+The partition number.
 .TP
 .I length
-Specify the length of the partition (in 512-byte sectors).
+The new length of the partition (in 512-byte sectors).
 
 .SH SEE ALSO
 .BR addpart (8),
-- 
1.7.0.4

