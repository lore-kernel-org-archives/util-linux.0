Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35598 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2IYWi7 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 25 Sep 2012 18:38:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id BEA5F33D792
	for <util-linux-ng@vger.kernel.org>; Tue, 25 Sep 2012 22:38:58 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] mount(8): fix a few typos
Date: Tue, 25 Sep 2012 18:39:00 -0400
Message-Id: <1348612740-7637-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Nothing of note here.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Documentation/releases/v2.21-ReleaseNotes |  2 +-
 mount-deprecated/mount.8                  | 20 ++++++++++----------
 sys-utils/mount.8                         | 24 ++++++++++++------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/releases/v2.21-ReleaseNotes b/Documentation/releases/v2.21-ReleaseNotes
index ea0b559..ed68ee3 100644
--- a/Documentation/releases/v2.21-ReleaseNotes
+++ b/Documentation/releases/v2.21-ReleaseNotes
@@ -933,7 +933,7 @@ tests:
    - make minix tests more robust  [Karel Zak]
    - remove obsolete checktty test  [Karel Zak]
    - remove unexpected set -x  [Karel Zak]
-   - remove unssuported losetup -s  [Karel Zak]
+   - remove unsupported losetup -s  [Karel Zak]
    - update fdisk and blkid MD tests  [Francesco Cosoleto]
    - update fdisk tests  [Francesco Cosoleto]
    - update tests with fdisk output  [Karel Zak]
diff --git a/mount-deprecated/mount.8 b/mount-deprecated/mount.8
index 5adce0e..0217a3f 100644
--- a/mount-deprecated/mount.8
+++ b/mount-deprecated/mount.8
@@ -533,7 +533,7 @@ Don't canonicalize paths. The mount command canonicalizes all paths
 .IR /etc/mtab
 file. This option can be used together with the
 .B \-f
-flag for already canonicalized absolut paths.
+flag for already canonicalized absolute paths.
 .IP "\fB\-s\fP"
 Tolerate sloppy mount options rather than failing. This will ignore
 mount options not supported by a filesystem type. Not all filesystems
@@ -1267,7 +1267,7 @@ to the options given in
 No checking is done at mount time. This is the default. This is fast.
 It is wise to invoke
 .BR e2fsck (8)
-every now and then, e.g. at boot time. The non-default behavior is unssuported
+every now and then, e.g. at boot time. The non-default behavior is unsupported
 (check=normal and check=strict options have been removed). Note that these mount options
 don't have to be supported if ext4 kernel driver is used for ext2 and ext3 filesystems.
 .TP
@@ -1334,7 +1334,7 @@ Support "user." extended attributes (or not).
 
 .SH "Mount options for ext3"
 The ext3 filesystem is a version of the ext2 filesystem which has been
-enhanced with journalling.  It supports the same options as ext2 as
+enhanced with journaling.  It supports the same options as ext2 as
 well as the following additions:
 .\" .TP
 .\" .BR abort
@@ -1365,7 +1365,7 @@ filesystem containing inconsistencies that can
 lead to any number of problems.
 .TP
 .BR data= { journal | ordered | writeback }
-Specifies the journalling mode for file data.  Metadata is always journaled.
+Specifies the journaling mode for file data.  Metadata is always journaled.
 To use modes other than
 .B ordered
 on the root filesystem, pass the mode to the kernel as boot parameter, e.g.
@@ -1487,7 +1487,7 @@ may improve the throughput of multi-threaded, synchronous workloads on very
 fast disks, at the cost of increasing latency.
 .TP
 .BI journal_ioprio= prio
-The I/O priority (from 0 to 7, where 0 is the highest priorty) which should be
+The I/O priority (from 0 to 7, where 0 is the highest priority) which should be
 used for I/O operations submitted by kjournald2 during a commit operation.
 This defaults to 3, which is a slightly higher priority than the default I/O
 priority.
@@ -1606,7 +1606,7 @@ Normally
 .B utime(2)
 checks current process is owner of the file, or it has
 CAP_FOWNER capability.  But FAT filesystem doesn't have uid/gid on disk, so
-normal check is too unflexible. With this option you can relax it.
+normal check is too inflexible. With this option you can relax it.
 .RE
 .TP
 .BI check= value
@@ -1913,7 +1913,7 @@ keyword with no value will grow the volume to the full size of the partition.
 .B nointegrity
 Do not write to the journal.  The primary use of this option is to allow
 for higher performance when restoring a volume from backup media. The
-integrity of the volume is not guaranteed if the system abnormally abends.
+integrity of the volume is not guaranteed if the system abnormally ends.
 .TP
 .B integrity
 Default.  Commit metadata changes to the journal.  Use this option to remount
@@ -2060,10 +2060,10 @@ Disable the border allocator algorithm invented by Yury Yu. Rupasov.
 This may provide performance improvements in some situations.
 .TP
 .BR nolog
-Disable journalling. This will provide slight performance improvements in
+Disable journaling. This will provide slight performance improvements in
 some situations at the cost of losing reiserfs's fast recovery from crashes.
-Even with this option turned on, reiserfs still performs all journalling
-operations, save for actual writes into its journalling area.  Implementation
+Even with this option turned on, reiserfs still performs all journaling
+operations, save for actual writes into its journaling area.  Implementation
 of
 .IR nolog
 is a work in progress.
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index cbd7c13..f86eead 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -190,7 +190,7 @@ The file
 may contain lines describing what devices are usually
 mounted where, using which options. The default location of the
 .BR fstab (5)
-file could be overrided by --fstab <path> command line option (see below for
+file could be overridden by --fstab <path> command line option (see below for
 more details).
 .LP
 The command
@@ -558,7 +558,7 @@ Don't canonicalize paths. The mount command canonicalizes all paths
 .IR /etc/mtab
 file. This option can be used together with the
 .B \-f
-flag for already canonicalized absolut paths.
+flag for already canonicalized absolute paths.
 .IP "\fB\-s\fP"
 Tolerate sloppy mount options rather than failing. This will ignore
 mount options not supported by a filesystem type. Not all filesystems
@@ -1313,7 +1313,7 @@ to the options given in
 No checking is done at mount time. This is the default. This is fast.
 It is wise to invoke
 .BR e2fsck (8)
-every now and then, e.g. at boot time. The non-default behavior is unssuported
+every now and then, e.g. at boot time. The non-default behavior is unsupported
 (check=normal and check=strict options have been removed). Note that these mount options
 don't have to be supported if ext4 kernel driver is used for ext2 and ext3 filesystems.
 .TP
@@ -1382,7 +1382,7 @@ Support "user." extended attributes (or not).
 
 .SH "Mount options for ext3"
 The ext3 filesystem is a version of the ext2 filesystem which has been
-enhanced with journalling.  It supports the same options as ext2 as
+enhanced with journaling.  It supports the same options as ext2 as
 well as the following additions:
 .\" .TP
 .\" .BR abort
@@ -1413,7 +1413,7 @@ filesystem containing inconsistencies that can
 lead to any number of problems.
 .TP
 .BR data= { journal | ordered | writeback }
-Specifies the journalling mode for file data.  Metadata is always journaled.
+Specifies the journaling mode for file data.  Metadata is always journaled.
 To use modes other than
 .B ordered
 on the root filesystem, pass the mode to the kernel as boot parameter, e.g.
@@ -1544,7 +1544,7 @@ may improve the throughput of multi-threaded, synchronous workloads on very
 fast disks, at the cost of increasing latency.
 .TP
 .BI journal_ioprio= prio
-The I/O priority (from 0 to 7, where 0 is the highest priorty) which should be
+The I/O priority (from 0 to 7, where 0 is the highest priority) which should be
 used for I/O operations submitted by kjournald2 during a commit operation.
 This defaults to 3, which is a slightly higher priority than the default I/O
 priority.
@@ -1663,7 +1663,7 @@ Normally
 .B utime(2)
 checks current process is owner of the file, or it has
 CAP_FOWNER capability.  But FAT filesystem doesn't have uid/gid on disk, so
-normal check is too unflexible. With this option you can relax it.
+normal check is too inflexible. With this option you can relax it.
 .RE
 .TP
 .BI check= value
@@ -1742,7 +1742,7 @@ inconsistent).
 .B discard
 If set, causes discard/TRIM commands to be issued to the block device
 when blocks are freed. This is useful for SSD devices and
-sparse/thinly-provisoned LUNs.
+sparse/thinly-provisioned LUNs.
 .TP
 .BR fat= {12 | 16 | 32 }
 Specify a 12, 16 or 32 bit fat.  This overrides
@@ -1980,7 +1980,7 @@ keyword with no value will grow the volume to the full size of the partition.
 .B nointegrity
 Do not write to the journal.  The primary use of this option is to allow
 for higher performance when restoring a volume from backup media. The
-integrity of the volume is not guaranteed if the system abnormally abends.
+integrity of the volume is not guaranteed if the system abnormally ends.
 .TP
 .B integrity
 Default.  Commit metadata changes to the journal.  Use this option to remount
@@ -2127,10 +2127,10 @@ Disable the border allocator algorithm invented by Yury Yu. Rupasov.
 This may provide performance improvements in some situations.
 .TP
 .BR nolog
-Disable journalling. This will provide slight performance improvements in
+Disable journaling. This will provide slight performance improvements in
 some situations at the cost of losing reiserfs's fast recovery from crashes.
-Even with this option turned on, reiserfs still performs all journalling
-operations, save for actual writes into its journalling area.  Implementation
+Even with this option turned on, reiserfs still performs all journaling
+operations, save for actual writes into its journaling area.  Implementation
 of
 .IR nolog
 is a work in progress.
-- 
1.7.12

