Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:52936 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932291AbcCHJVh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:37 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 8/9] sfdisk: adjust more wordings and formatting in the man page
Date: Tue,  8 Mar 2016 10:07:51 +0100
Message-Id: <1457428072-2619-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.8 |   63 +++++++++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 52b1b34..277b843 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -64,14 +64,15 @@ Note that it's possible to address an unused partition with \fB\-N\fR.
 For example, an MBR always contains 4 partitions, but the number of used
 partitions may be smaller.  In this case \fBsfdisk\fR follows the default
 values from the partition table and does not use built-in defaults for the
-unused partition given with \fB\-N\fR.  See also \fB\---append\fR.
+unused partition given with \fB\-N\fR.  See also \fB\-\-append\fR.
 .TP
-.BR \-A , " \-\-activate \fIdevice\fR [" \fIpartition-number\fR...]
-Switch on the bootable flag.  If no \fIpartition-number\fR is specified,
-then all partitions with an enabled flag are listed.
+.BR \-A , " \-\-activate \fIdevice " [ \fIpartition-number ...]
+Switch on the bootable flag for the specified partitions.
+If no \fIpartition-number\fR is specified,
+then list the partitions with an enabled flag.
 .TP
-.BR " \-\-delete \fIdevice\fR [" \fIpartition-number\fR...]
-Delete all or specified partitions.
+.BR "\-\-delete \fIdevice " [ \fIpartition-number ...]
+Delete all or the specified partitions.
 .TP
 .BR \-d , " \-\-dump " \fIdevice\fR
 Dump the partitions of a device in a format that is usable as input to \fBsfdisk\fR.
@@ -91,30 +92,30 @@ together with \fB\-\-verify\fR.
 .BR \-F , " \-\-list-free " [ \fIdevice ...]
 List the free unpartitioned areas on all or the specified devices.
 .TP
-.BR \-\-part\-attrs " \fIdevice partno [" \fIattrs ]
-Change the GPT partition attribute bits.  If \fIattrs\fR is not specified,
-then print the current partition settings.  The \fIattrs\fR argument is a
+.BR "\-\-part\-attrs \fIdevice partition-number " [ \fIattributes ]
+Change the GPT partition attribute bits.  If \fIattributes\fR is not specified,
+then print the current partition settings.  The \fIattributes\fR argument is a
 comma- or space-delimited list of bits.  The currently supported attribute
 bits are: RequiredPartiton, NoBlockIOProtocol, LegacyBIOSBootable
 and GUID-specific bits in the range from 48 to 63.  For example, the string
 "RequiredPartiton,50,51" sets three bits.
 .TP
-.BR \-\-part\-label " \fIdevice partno [" \fIlabel ]
+.BR "\-\-part\-label \fIdevice partition-number " [ \fIlabel ]
 Change the GPT partition name (label).  If \fIlabel\fR is not specified,
 then print the current partition label.
 .TP
-.BR \-\-part\-type " \fIdevice partno [" \fItype ]
+.BR "\-\-part\-type \fIdevice partition-number " [ \fItype ]
 Change the partition type.  If \fItype\fR is not specified, then print the
 current partition type.  The \fItype\fR argument is hexadecimal for MBR,
 or a GUID for GPT.  For backward compatibility the options \fB\-c\fR and
-\fB\-\-id\fR have the same meaning.
+\fB\-\-id\fR have the same meaning as this one.
 .TP
-.BR \-\-part\-uuid " \fIdevice partno [" \fIuuid ]
+.BR "\-\-part\-uuid \fIdevice partition-number " [ \fIuuid ]
 Change the GPT partition UUID.  If \fIuuid\fR is not specified,
 then print the current partition UUID.
 .TP
 .BR \-r , " \-\-reorder " \fIdevice
-Fix partitions order by start offset.
+Renumber the partitions, ordering them by their start offset.
 .TP
 .BR \-s , " \-\-show\-size " [ \fIdevice ...]
 List the sizes of all or the specified devices.
@@ -155,26 +156,27 @@ Do everything except writing to the device.
 .B \-\-no\-reread
 Do not check through the re-read-partition-table ioctl whether the device is in use.
 .TP
-.BR \-O , " \-\-backup\-file " \fIpath\fR
+.BR \-O , " \-\-backup\-file " \fIpath
 Override the default backup file name.  Note that the device name and offset
 are always appended to the file name.
 .TP
 .BR \-\-move-data [ =\fIpath ]
-Move data after partition relocation, for example when move begin of the
-partition to another place on the disk. The size of the partition has to be the
-same, the new and old location may overlap. The option requires \fB\-N\fR to be
-processed on one specified partition only.
+Move data after partition relocation, for example when moving the beginning
+of a partition to another place on the disk.  The size of the partition has
+to remain the same, the new and old location may overlap.  This option requires
+option \fB\-N\fR in order to be processed on one specific partition only.
 
 The \fIpath\fR overrides the default log file name
-(the default is ~/sfdisk-<devname>.move). The log file contains information
-about all read/write oprations with the partition data.
+(the default is ~/sfdisk-<devname>.move).  The log file contains information
+about all read/write operations on the partition data.
 
-Note that this operation is ricky and not atomic. \fBDon't forget to backup your data!\fR
+Note that this operation is risky and not atomic. \fBDon't forget to backup your data!\fR
 
-The example below creates 100MiB free area before the first partition and moves
-data (e.g. filesystem), the next command creates a new partition from the free
-space (at offset 2048) and the last command reorder partitions to match disk
-order (original sdc1 will be sdc2).
+In the example below, the first command creates a 100MiB free area before
+the first partition and moves the data it contains (e.g. a filesystem),
+the next command creates a new partition from the free space (at offset 2048),
+and the last command reorders partitions to match disk order
+(the original sdc1 will become sdc2).
 .RS
 .sp
 .B "echo '+100M,' | sfdisk --move-data /dev/sdc -N 1"
@@ -277,7 +279,7 @@ given, the default for each field is its previous value.
 The default value of
 .I start
 is the first non-assigned sector aligned according to device I/O limits.
-The default start offset for the first partition is 1 MiB. The offset may
+The default start offset for the first partition is 1 MiB.  The offset may
 be followed by the multiplicative suffixes (KiB, MiB, GiB, TiB, PiB,
 EiB, ZiB and YiB) then the number is interpreted as offset in bytes.
 .sp
@@ -342,7 +344,7 @@ more readable.
 .RE
 The
 .I device
-field is optional.  \fBsfdisk\fRextracts the partition number from the
+field is optional.  \fBsfdisk\fR extracts the partition number from the
 device name.  It allows to specify the partitions in random order.
 This functionality is mostly used by \fB\-\-dump\fR.
 Don't use it if you are not sure.
@@ -419,7 +421,10 @@ For example:
 The GPT header can later be restored by:
 .RS
 .sp
-.B dd if=~/sfdisk-sda-0x00000200.bak of=/dev/sda seek=$((0x00000200)) bs=1 conv=notrunc
+.nf
+.B "dd  if=~/sfdisk-sda-0x00000200.bak  of=/dev/sda  \e"
+.B "  seek=$((0x00000200))  bs=1  conv=notrunc"
+.fi
 .sp
 .RE
 Note that \fBsfdisk\fR since version 2.26 no longer provides the \fB\-I\fR option to
-- 
1.7.0.4

