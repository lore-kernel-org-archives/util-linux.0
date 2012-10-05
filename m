Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53955 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab2JEBed (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 4 Oct 2012 21:34:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 69A3533C4F0
	for <util-linux-ng@vger.kernel.org>; Fri,  5 Oct 2012 01:34:32 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] fix bold style of man page references
Date: Thu,  4 Oct 2012 21:34:34 -0400
Message-Id: <1349400874-6163-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 disk-utils/fsck.8         | 2 +-
 fdisks/cfdisk.8           | 4 ++--
 misc-utils/blkid.8        | 2 +-
 misc-utils/ddate.1        | 4 ++--
 mount-deprecated/mount.8  | 4 ++--
 mount-deprecated/umount.8 | 2 +-
 sys-utils/eject.1         | 2 +-
 sys-utils/losetup.8       | 2 +-
 sys-utils/mount.8         | 6 +++---
 sys-utils/swapon.8        | 2 +-
 sys-utils/umount.8        | 2 +-
 sys-utils/unshare.1       | 5 +++--
 12 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 7779fe9..344a06f 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -97,7 +97,7 @@ Lock the whole-disk device by an exclusive
 .BR flock (2).
 This option can be used with one device only (this means that \fB-A\fR and
 \fB-l\fR are mutually exclusive).  This option is recommended when more
-.B fsck (8)
+.BR fsck (8)
 instances are executed in the same time.  The option is ignored when used for
 multiple devices or for non-rotating disks.  \fBfsck\fR does not lock underlying
 devices when executed to check stacked devices (e.g. MD or DM) -- this feature is
diff --git a/fdisks/cfdisk.8 b/fdisks/cfdisk.8
index 28ddad6..be88fdb 100644
--- a/fdisks/cfdisk.8
+++ b/fdisks/cfdisk.8
@@ -369,8 +369,8 @@ partition table from the disk.  The re-reading of the partition table does not
 work in some cases, for example for device-mapper devices.  In
 particular case you need to inform kernel about new
 partitions by
-.B partprobe(8),
-.B kpartx(8)
+.BR partprobe (8),
+.BR kpartx (8)
 or reboot the system.
 .TP
 .I Up Arrow
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 9c45a0e..dbf0643 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -121,7 +121,7 @@ symlinks directly; it is not reliable to use the symlinks without verification.
 The \fB-L\fR option works on systems with and without udev.
 
 Unfortunately, the original
-.B blkid(8)
+.BR blkid (8)
 from e2fsprogs use the \fB-L\fR option as a
 synonym for the \fB-o list\fR option.  For better portability, use \fB-l -o device
 -t LABEL=<label>\fR and \fB-o list\fR in your scripts rather than the \fB-L\fR option.
diff --git a/misc-utils/ddate.1 b/misc-utils/ddate.1
index 0b01e09..8dd22d0 100644
--- a/misc-utils/ddate.1
+++ b/misc-utils/ddate.1
@@ -21,7 +21,7 @@ day, month and year.
 If a format string is specified, the Discordian date will be printed in
 a format specified by the string. This mechanism works similarly to the
 format string mechanism of
-.B date(1),
+.BR date (1),
 only almost completely differently. The fields are:
 .IP %A
 Full name of the day of the week (i.e., Sweetmorn)
@@ -77,7 +77,7 @@ Today's St. Tib's Day, 3162.
 
 .SH BUGS
 
-.B ddate(1)
+.BR ddate (1)
 will produce undefined behavior if asked to produce the date for St. Tib's
 day and its format string does not contain the St. Tib's Day delimiters
 %{ and %}.
diff --git a/mount-deprecated/mount.8 b/mount-deprecated/mount.8
index 0217a3f..ae42ccc 100644
--- a/mount-deprecated/mount.8
+++ b/mount-deprecated/mount.8
@@ -1599,11 +1599,11 @@ If current process is in group of file's group ID, you can change timestamp.
 Other users can change timestamp.
 .PP
 The default is set from `dmask' option. (If the directory is writable,
-.B utime(2)
+.BR utime (2)
 is also allowed. I.e. ~dmask & 022)
 
 Normally
-.B utime(2)
+.BR utime (2)
 checks current process is owner of the file, or it has
 CAP_FOWNER capability.  But FAT filesystem doesn't have uid/gid on disk, so
 normal check is too inflexible. With this option you can relax it.
diff --git a/mount-deprecated/umount.8 b/mount-deprecated/umount.8
index 1c7d59a..4cbddc5 100644
--- a/mount-deprecated/umount.8
+++ b/mount-deprecated/umount.8
@@ -120,7 +120,7 @@ anymore.
 (Requires kernel 2.4.11 or later.)
 .IP "\fB\-\-no\-canonicalize\fP"
 Don't canonicalize paths. For more details about this option see the
-.B mount(8)
+.BR mount (8)
 man page.
 .IP "\fB\-\-fake\fP"
 Causes everything to be done except for the actual system call; this
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 1a23229..429f0dd 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -54,7 +54,7 @@ are carrying a laptop in a bag or case and don't want it to eject if the button
 is inadvertently pressed.
 .IP "\fB\-p, \-\-proc\fP"
 This option allow you to use /proc/mounts instead /etc/mtab. It also passes the
-\-n option to umount(1).
+\-n option to \fBumount\fR(1).
 .IP "\fB\-q, \-\-tape\fP"
 This option specifies that the drive should be ejected using a tape drive
 offline command.
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 6a006e1..921e10b 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -110,7 +110,7 @@ verbose mode
 
 .SH ENCRYPTION
 .B Cryptoloop is no longer supported in favor of dm-crypt. For more details see
-.B cryptsetup (8).
+.B cryptsetup(8).
 
 .SH RETURN VALUE
 .B losetup
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index f86eead..da17b96 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -462,7 +462,7 @@ operation. Detailed semantics is documented in Documentation/filesystems/shareds
 file in the kernel source tree.
 
 Note that Linux kernel does not allow to change more propagation flags by one
-.B mount (2)
+.BR mount (2)
 syscall and the flags cannot be mixed with another mount options. It means that
 more --make-* options cannot be used together or with another mount options.
 
@@ -1656,11 +1656,11 @@ If current process is in group of file's group ID, you can change timestamp.
 Other users can change timestamp.
 .PP
 The default is set from `dmask' option. (If the directory is writable,
-.B utime(2)
+.BR utime (2)
 is also allowed. I.e. ~dmask & 022)
 
 Normally
-.B utime(2)
+.BR utime (2)
 checks current process is owner of the file, or it has
 CAP_FOWNER capability.  But FAT filesystem doesn't have uid/gid on disk, so
 normal check is too inflexible. With this option you can relax it.
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index e471d07..0247ad8 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -134,7 +134,7 @@ may be also used to skip non-existing device.
 .B "\-f, \-\-fixpgsz"
 Reinitialize (exec /sbin/mkswap) the swap space if its page size does not
 match that of the the current running kernel.
-.B mkswap(2)
+.BR mkswap (2)
 initializes the whole device and does not check for bad blocks.
 .TP
 .B \-h, \-\-help
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index b949aeb..bdd10a5 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -68,7 +68,7 @@ filesystem is not unmounted.)
 .TP
 \fB\-c\fR, \fB\-\-no\-canonicalize\fR
 Do not canonicalize paths.  For more details about this option see the
-.B mount(8)
+.BR mount (8)
 man page.
 .TP
 \fB\-d\fR, \fB\-\-detach\-loop\fR
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index d7938c5..1325e34 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -31,7 +31,7 @@ process will have independent IPv4 and IPv6 stacks, IP routing tables, firewall
 rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees, sockets
 etc. (\fBCLONE_NEWNET\fP flag).
 .TP
-See the clone(2) for exact semantics of the flags.
+See the \fBclone\fR(2) for exact semantics of the flags.
 .SH OPTIONS
 .TP
 .BR \-h , " \-\-help"
@@ -52,7 +52,8 @@ Unshare the network namespace.
 The unshare command drops potential privileges before executing the
 target program. This allows to setuid unshare.
 .SH SEE ALSO
-unshare(2), clone(2)
+.BR unshare (2),
+.BR clone (2)
 .SH BUGS
 None known so far.
 .SH AUTHOR
-- 
1.7.12

