Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34118 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755045AbcKJK7b (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so2348050wme.1
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:30 -0800 (PST)
Subject: [PATCH 02/12] Place SEE ALSO entries in order
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <359c3d9f-ebf3-5b5a-1b6f-d0dfe939d05d@gmail.com>
Date: Thu, 10 Nov 2016 11:59:27 +0100
MIME-Version: 1.0
In-Reply-To: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch does only the following:

* Order SEE ALSO entries first by section name, then alphabetically
  within section
* Adds one or two missing commas in SEE ALSO lists
* Removes one or two periods that were (inconsistently) used
  at the end of SEE ALSO lists.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/cfdisk.8         |  4 ++--
 disk-utils/fdformat.8       |  4 ++--
 disk-utils/fdisk.8          |  4 ++--
 disk-utils/fsck.8           |  6 +++---
 disk-utils/fsck.minix.8     |  2 +-
 disk-utils/mkfs.cramfs.8    |  4 ++--
 disk-utils/mkfs.minix.8     |  2 +-
 disk-utils/swaplabel.8      |  4 ++--
 libuuid/man/uuid_generate.3 |  6 +++---
 login-utils/last.1          |  4 ++--
 login-utils/login.1         |  4 ++--
 login-utils/runuser.1       |  8 ++++----
 login-utils/su.1            |  6 +++---
 login-utils/vipw.8          |  2 +-
 misc-utils/blkid.8          |  2 +-
 misc-utils/findmnt.8        |  4 ++--
 misc-utils/getopt.1         |  4 ++--
 misc-utils/kill.1           |  2 +-
 misc-utils/logger.1         |  2 +-
 misc-utils/lsblk.8          |  4 ++--
 misc-utils/mcookie.1        |  2 +-
 schedutils/chrt.1           |  2 +-
 schedutils/taskset.1        |  4 ++--
 sys-utils/dmesg.1           |  2 +-
 sys-utils/eject.1           |  2 +-
 sys-utils/fallocate.1       |  4 ++--
 sys-utils/fstab.5           |  6 +++---
 sys-utils/fstrim.8          |  4 ++--
 sys-utils/ipcrm.1           |  2 +-
 sys-utils/ipcs.1            |  2 +-
 sys-utils/lsipc.1           |  2 +-
 sys-utils/lsns.8            |  2 +-
 sys-utils/mount.8           | 14 +++++++-------
 sys-utils/nsenter.1         |  4 ++--
 sys-utils/pivot_root.8      |  2 +-
 sys-utils/prlimit.1         |  4 ++--
 sys-utils/setpriv.1         |  2 +-
 sys-utils/swapon.8          |  6 +++---
 sys-utils/switch_root.8     |  4 ++--
 sys-utils/umount.8          |  4 ++--
 sys-utils/unshare.1         |  2 +-
 term-utils/mesg.1           |  2 +-
 term-utils/script.1         |  2 +-
 term-utils/setterm.1        |  6 +++---
 text-utils/colcrt.1         |  4 ++--
 text-utils/more.1           |  4 ++--
 text-utils/tailf.1          |  4 ++--
 47 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 6204bdc..d6ad327 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -189,10 +189,10 @@ use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 
 .SH "SEE ALSO"
 .BR fdisk (8),
-.BR sfdisk (8),
 .BR parted (8),
 .BR partprobe (8),
-.BR partx (8)
+.BR partx (8),
+.BR sfdisk (8)
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
 .PP
diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index b7b3a35..02c2fb6 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -64,9 +64,9 @@ Display version information and exit.
 Display help text and exit.
 .SH "SEE ALSO"
 .BR fd (4),
-.BR setfdprm (8),
+.BR emkfs (8),
 .BR mkfs (8),
-.BR emkfs (8)
+.BR setfdprm (8)
 .SH AUTHOR
 Werner Almesberger (almesber@nessie.cs.id.ethz.ch)
 .SH AVAILABILITY
diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 70e88e3..cdb3168 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -359,9 +359,9 @@ use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 
 .SH "SEE ALSO"
 .BR cfdisk (8),
-.BR sfdisk (8),
 .BR mkfs (8),
-.BR partx (8)
+.BR partx (8),
+.BR sfdisk (8)
 
 .SH AVAILABILITY
 The fdisk command is part of the util-linux package and is available from
diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index ca83ce9..df007f1 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -392,13 +392,13 @@ or
 or
 .BR e2fsck (8),
 .BR cramfsck (8),
-.BR fsck.minix (8),
-.BR fsck.msdos (8),
 .BR fsck.jfs (8),
 .BR fsck.nfs (8),
+.BR fsck.minix (8),
+.BR fsck.msdos (8),
 .BR fsck.vfat (8),
 .BR fsck.xfs (8),
-.BR reiserfsck (8).
+.BR reiserfsck (8)
 .ad
 .SH AUTHORS
 .nf
diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 3598781..bc7ef78 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -158,8 +158,8 @@ Russell King
 .BR fsck (8),
 .BR fsck.ext2 (8),
 .BR mkfs (8),
-.BR mkfs.minix (8),
 .BR mkfs.ext2 (8),
+.BR mkfs.minix (8),
 .BR reboot (8)
 .SH AVAILABILITY
 The fsck.minix command is part of the util-linux package and is available from
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index a758700..c4867c8 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -81,8 +81,8 @@ operation error, such as unable to allocate memory
 .PD
 .RE
 .SH "SEE ALSO"
-.BR mount (8),
-.BR fsck.cramfs (8)
+.BR fsck.cramfs (8),
+.BR mount (8)
 .SH AVAILABILITY
 The example command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index fcf0e7c..ee7050d 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -81,8 +81,8 @@ Operational error
 .IP 16
 Usage or syntax error
 .SH "SEE ALSO"
-.BR mkfs (8),
 .BR fsck (8),
+.BR mkfs (8),
 .BR reboot (8)
 .SH AVAILABILITY
 The mkfs.minix command is part of the util-linux package and is available from
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index 2985dfc..45c0492 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -65,6 +65,6 @@ enables libblkid debug output.
 The swaplabel command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .SH SEE ALSO
+.BR uuidgen (1),
 .BR mkswap (8),
-.BR swapon (8),
-.BR uuidgen (1)
+.BR swapon (8)
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 19904d7..1acc35a 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -114,13 +114,13 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .SH "SEE ALSO"
-.BR uuid (3),
 .BR uuidgen (1),
-.BR uuidd (8),
+.BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
 .BR uuid_copy (3),
 .BR uuid_is_null (3),
 .BR uuid_parse (3),
 .BR uuid_time (3),
-.BR uuid_unparse (3)
+.BR uuid_unparse (3),
+.BR uuidd (8)
diff --git a/login-utils/last.1 b/login-utils/last.1
index 719a0ed..2b0c1e5 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -192,6 +192,6 @@ The last command is part of the util-linux package and is available from
 Linux Kernel Archive
 .UE .
 .SH "SEE ALSO"
-.BR shutdown (8),
 .BR login (1),
-.BR init (8)
+.BR init (8),
+.BR shutdown (8)
diff --git a/login-utils/login.1 b/login-utils/login.1
index 8f9b710..eaa644d 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -285,12 +285,12 @@ the superuser logs in.  The default value is
 .I .hushlogin
 .fi
 .SH "SEE ALSO"
-.BR init (8),
-.BR getty (8),
 .BR mail (1),
 .BR passwd (1),
 .BR passwd (5),
 .BR environ (7),
+.BR getty (8),
+.BR init (8),
 .BR shutdown (8)
 .SH BUGS
 The undocumented BSD
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 128758c..04ce4ff 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -224,11 +224,11 @@ runuser specific logindef config file
 global logindef config file
 .PD 1
 .SH "SEE ALSO"
-.BR pam (8),
-.BR shells (5),
-.BR login.defs (5),
+.BR setpriv (1),
 .BR su (1),
-.BR setpriv (1)
+.BR login.defs (5),
+.BR shells (5),
+.BR pam (8)
 .SH HISTORY
 This \fB runuser\fR command was
 derived from coreutils' \fBsu\fR, which was based on an implementation by
diff --git a/login-utils/su.1 b/login-utils/su.1
index 5d570fb..8685061 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -250,11 +250,11 @@ be configured to update the lastlog file as well. For example by:
 session  required  pam_lastlog.so nowtmp
 .RE
 .SH "SEE ALSO"
-.BR runuser (8),
 .BR setpriv (1),
-.BR pam (8),
+.BR login.defs (5),
 .BR shells (5),
-.BR login.defs (5)
+.BR pam (8),
+.BR runuser (8)
 .SH HISTORY
 This \fBsu\fR command was
 derived from coreutils' \fBsu\fR, which was based on an implementation by
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 9e4c9e2..a40ba72 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -70,9 +70,9 @@ The editor specified by the string
 will be invoked instead of the default editor
 .BR vi (1).
 .SH SEE ALSO
+.BR vi (1),
 .BR passwd (1),
 .BR flock (2),
-.BR vi (1),
 .BR passwd (5)
 .SH HISTORY
 The
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index a8c4d14..dc32e33 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -313,8 +313,8 @@ and Karel Zak.
 .SH SEE ALSO
 .BR libblkid (3),
 .BR findfs (8),
-.BR wipefs (8),
 .BR lsblk (8),
+.BR wipefs (8)
 .SH AVAILABILITY
 The blkid command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 2a6ed3c..105f2c5 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -284,8 +284,8 @@ use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 Karel Zak <kzak@redhat.com>
 .fi
 .SH SEE ALSO
-.BR mount (8),
-.BR fstab (5)
+.BR fstab (5),
+.BR mount (8)
 .SH AVAILABILITY
 The findmnt command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index da7207f..7cde033 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -450,9 +450,9 @@ string).
 Frodo Looijaard
 .ME
 .SH "SEE ALSO"
-.BR getopt (3),
 .BR bash (1),
-.BR tcsh (1).
+.BR tcsh (1),
+.BR getopt (3)
 .SH AVAILABILITY
 The getopt command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index a7d7a74..d0626bf 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -145,8 +145,8 @@ partial success (when more than one process specified)
 .SH SEE ALSO
 .BR bash (1),
 .BR tcsh (1),
-.BR kill (2),
 .BR sigvec (2),
+.BR kill (2),
 .BR signal (7)
 
 .SH AUTHORS
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index e24eac9..e369f7c 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -341,8 +341,8 @@ For the priority order and intended purposes of these facilities and levels, see
 .br
 .B logger \-n loghost.example.com System rebooted
 .SH SEE ALSO
-.BR syslog (3),
 .BR journalctl (1),
+.BR syslog (3),
 .BR systemd.journal-fields (7)
 .SH STANDARDS
 The
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index d82d232..cb9a115 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -164,9 +164,9 @@ enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 .SH SEE ALSO
-.BR findmnt (8),
+.BR ls (1),
 .BR blkid (8),
-.BR ls (1)
+.BR findmnt (8)
 .SH AVAILABILITY
 The lsblk command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index 5863821..f66a5ed 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -56,9 +56,9 @@ It is assumed that none of the randomness sources will block.
 .br
 .I /dev/random
 .SH "SEE ALSO"
+.BR md5sum (1),
 .BR X (1),
 .BR xauth (1),
-.BR md5sum (1),
 .BR rand (3)
 .SH AVAILABILITY
 The mcookie command is part of the util-linux package and is available from
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 63972a7..869b4fd 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -152,9 +152,9 @@ may be ignored on some systems.
 Linux' default scheduling policy is
 .BR SCHED_OTHER .
 .SH SEE ALSO
-.BR taskset (1),
 .BR nice (1),
 .BR renice (1),
+.BR taskset (1),
 .BR sched (7)
 .sp
 See
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 3ea03b7..13ed583 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -119,8 +119,8 @@ A user can retrieve the affinity mask of any process.
 .BR chrt (1),
 .BR nice (1),
 .BR renice (1),
-.BR sched_setaffinity (2),
-.BR sched_getaffinity (2)
+.BR sched_getaffinity (2),
+.BR sched_setaffinity (2)
 .sp
 See
 .BR sched_setscheduler (2)
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 199eacb..6e0812f 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -227,8 +227,8 @@ The text of the message with the warning log priority.
 The text of the message that inform about segmentation fault.
 
 .SH SEE ALSO
+.BR terminal-colors.d (5),
 .BR syslogd (8)
-.BR terminal-colors.d (5)
 .SH AUTHORS
 .MT kzak@redhat.com
 Karel Zak
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index edc6a2a..9e0b40c 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -176,8 +176,8 @@ Michal Luscon
 .ME
 - util-linux version.
 .SH SEE ALSO
-.BR lsblk (8),
 .BR findmnt (8),
+.BR lsblk (8),
 .BR mount (8),
 .BR umount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 38b2217..f533e1a 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -116,9 +116,9 @@ Eric Sandeen
 Karel Zak
 .UE
 .SH SEE ALSO
+.BR truncate (1),
 .BR fallocate (2),
-.BR posix_fallocate (3),
-.BR truncate (1)
+.BR posix_fallocate (3)
 .SH AVAILABILITY
 The fallocate command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index bd9ce2e..ab32383 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -231,11 +231,11 @@ libmount based mount utility (since util-linux v2.22).
 .IR /etc/fstab ,
 .I <fstab.h>
 .SH "SEE ALSO"
+.BR getmntent (3),
+.BR fs (5),
 .BR findmnt (8),
 .BR mount (8),
-.BR swapon (8),
-.BR fs (5),
-.BR getmntent (3)
+.BR swapon (8)
 .SH HISTORY
 The ancestor of this
 .B fstab
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index b30c8c2..2a94db7 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -114,8 +114,8 @@ Lukas Czerner <lczerner@redhat.com>
 Karel Zak <kzak@redhat.com>
 .fi
 .SH SEE ALSO
-.BR mount (8),
-.BR blkdiscard (8)
+.BR blkdiscard (8),
+.BR mount (8)
 .SH AVAILABILITY
 The fstrim command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/ipcrm.1 b/sys-utils/ipcrm.1
index 68bc3f4..ebd8802 100644
--- a/sys-utils/ipcrm.1
+++ b/sys-utils/ipcrm.1
@@ -100,8 +100,8 @@ compatibility the previous syntax is still supported.
 .\" Krishna Balasubramanian (balasub@cis.ohio-state.edu)
 .SH SEE ALSO
 .nh
-.BR ipcs (1),
 .BR ipcmk (1),
+.BR ipcs (1),
 .BR msgctl (2),
 .BR msgget (2),
 .BR semctl (2),
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 6c92580..db9637d 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -77,8 +77,8 @@ Print sizes in bytes.
 .B \-\-human
 Print sizes in human-readable format.
 .SH SEE ALSO
-.BR ipcrm (1),
 .BR ipcmk (1),
+.BR ipcrm (1),
 .BR msgrcv (2),
 .BR msgsnd (2),
 .BR semget (2),
diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 04852ea..3185911 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -109,8 +109,8 @@ if incorrect arguments specified,
 2
 if a serious error occurs.
 .SH SEE ALSO
-.BR ipcrm (1),
 .BR ipcmk (1),
+.BR ipcrm (1),
 .BR msgrcv (2),
 .BR msgsnd (2),
 .BR semget (2),
diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index 7ea1cb3..652cf63 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -72,8 +72,8 @@ Karel Zak <kzak@redhat.com>
 .fi
 
 .SH "SEE ALSO"
-.BR unshare (1),
 .BR nsenter (1),
+.BR unshare (1),
 .BR clone (2)
 
 .SH AVAILABILITY
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index f00af8f..26bd449 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -3047,17 +3047,17 @@ enables loop device setup debug output
 .BR umount (2),
 .BR umount (8),
 .BR fstab (5),
-.BR findmnt (8),
 .BR nfs (5),
-.BR nfsd (8),
 .BR xfs (5),
-.BR xfs_admin (8),
-.BR mountd (8),
-.BR mke2fs (8),
-.BR tune2fs (8),
 .BR e2label (8),
+.BR findmnt (8),
+.BR losetup (8),
+.BR mke2fs (8),
+.BR mountd (8),
+.BR nfsd (8),
 .BR swapon (8),
-.BR losetup (8)
+.BR tune2fs (8),
+.BR xfs_admin (8)
 .ad
 .SH BUGS
 It is possible for a corrupted filesystem to cause a crash.
diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index ea5992e..e6969bf 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -180,8 +180,8 @@ Display version information and exit.
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .SH SEE ALSO
-.BR setns (2),
-.BR clone (2)
+.BR clone (2),
+.BR setns (2)
 .SH AUTHORS
 .UR biederm@xmission.com
 Eric Biederman
diff --git a/sys-utils/pivot_root.8 b/sys-utils/pivot_root.8
index 525eb43..64e6bc9 100644
--- a/sys-utils/pivot_root.8
+++ b/sys-utils/pivot_root.8
@@ -66,8 +66,8 @@ exec chroot . sh -c 'umount /old_root; exec /sbin/init' \\
 .fi
 .SH "SEE ALSO"
 .BR chroot (1),
-.BR mount (8),
 .BR pivot_root (2),
+.BR mount (8),
 .BR switch_root (8),
 .BR umount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 600c706..07de90f 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -104,8 +104,8 @@ processes to unlimited.
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
 .SH "SEE ALSO"
-.BR prlimit (2),
-.BR ulimit (1)
+.BR ulimit (1),
+.BR prlimit (2)
 
 .SH NOTES
 The prlimit system call is supported since Linux 2.6.36, older kernels will
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 9fec20c..11c28d4 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -147,8 +147,8 @@ For example, setting no_new_privs and then execing a program that is
 SELinux\-confined (as this tool would do) may prevent the SELinux
 restrictions from taking effect.
 .SH SEE ALSO
-.BR su (1),
 .BR runuser (1),
+.BR su (1),
 .BR prctl (2),
 .BR capabilities (7)
 .SH AUTHOR
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index eca2b65..cfa765e 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -230,13 +230,13 @@ enables libmount debug output.
 enables libblkid debug output.
 
 .SH SEE ALSO
-.BR swapon (2),
 .BR swapoff (2),
+.BR swapon (2),
 .BR fstab (5),
 .BR init (8),
 .BR mkswap (8),
-.BR rc (8),
-.BR mount (8)
+.BR mount (8),
+.BR rc (8)
 .SH FILES
 .br
 .I /dev/sd??
diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
index a8c0cb5..06ad44d 100644
--- a/sys-utils/switch_root.8
+++ b/sys-utils/switch_root.8
@@ -46,10 +46,10 @@ mount --bind $DIR $DIR
 .fi
 
 .SH "SEE ALSO"
-.BR mount (8),
 .BR chroot (2),
 .BR init (8),
-.BR mkinitrd (8)
+.BR mkinitrd (8),
+.BR mount (8)
 .SH AUTHORS
 .nf
 Peter Jones <pjones@redhat.com>
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index a3793df..1c99b90 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -220,8 +220,8 @@ overrides the default location of the mtab file (ignored for suid)
 enables libmount debug output
 .SH "SEE ALSO"
 .BR umount (2),
-.BR mount (8),
-.BR losetup (8)
+.BR losetup (8),
+.BR mount (8)
 .SH HISTORY
 A
 .B umount
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 085a92b..a82ba9c 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -186,8 +186,8 @@ Establish a persistent mount namespace referenced by the bind mount
 makes sure that the bind mount is created on a shared filesystem.
 
 .SH SEE ALSO
-.BR unshare (2),
 .BR clone (2),
+.BR unshare (2),
 .BR mount (8)
 .SH AUTHORS
 .UR dottedmag@dottedmag.net
diff --git a/term-utils/mesg.1 b/term-utils/mesg.1
index 9bdc6d5..6179a79 100644
--- a/term-utils/mesg.1
+++ b/term-utils/mesg.1
@@ -94,10 +94,10 @@ An error has occurred.
 .SH FILES
 .I /dev/[pt]ty[pq]?
 .SH "SEE ALSO"
+.BR login (1),
 .BR talk (1),
 .BR write (1),
 .BR wall (1),
-.BR login (1),
 .BR xterm (1)
 .SH HISTORY
 A
diff --git a/term-utils/script.1 b/term-utils/script.1
index 8735664..34ef624 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -167,7 +167,7 @@ automatically).
 (for the
 .I history
 mechanism),
-.BR scriptreplay (1).
+.BR scriptreplay (1)
 .SH HISTORY
 The
 .B script
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index da07624..ac0cef6 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -267,10 +267,10 @@ In scripts it is better to use the backward-compatible single hyphen
 rather than the double hyphen.  Currently there are no plans nor good
 reasons to discontinue single-hyphen compatibility.
 .SH "SEE ALSO"
-.BR tput (1),
 .BR stty (1),
-.BR terminfo (5),
-.BR tty (4)
+.BR tput (1),
+.BR tty (4),
+.BR terminfo (5)
 .SH BUGS
 Differences between the Minix and Linux versions are not documented.
 .SH AVAILABILITY
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index 88a124a..3aadd1a 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -75,10 +75,10 @@ would be:
 .B tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
 .RE
 .SH SEE ALSO
-.BR nroff (1),
-.BR troff (1),
 .BR col (1),
 .BR more (1),
+.BR nroff (1),
+.BR troff (1),
 .BR ul (1)
 .SH BUGS
 Should fold underlines onto blanks even with the
diff --git a/text-utils/more.1 b/text-utils/more.1
index af1fdd4..e9b434a 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -217,8 +217,8 @@ The editor of choice when
 .B VISUAL
 is not specified.
 .SH SEE ALSO
-.BR vi (1),
-.BR less (1)
+.BR less (1),
+.BR vi (1)
 .SH AUTHORS
 Eric Shienbrood, UC Berkeley
 .br
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index 31bc177..83de40b 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -66,8 +66,8 @@ NO WARRANTY for this program.
 
 The latest inotify-based implementation was written by Karel Zak (kzak@redhat.com).
 .SH "SEE ALSO"
-.BR tail (1),
-.BR less (1)
+.BR less (1),
+.BR tail (1)
 .SH AVAILABILITY
 The tailf command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
2.5.5

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
