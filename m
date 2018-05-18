Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.hi.is ([130.208.165.103]:58606 "EHLO mx1.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeERTdR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 May 2018 15:33:17 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by mx1.hi.is (8.14.7/8.14.7) with ESMTP id w4IJLg8V027009
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Fri, 18 May 2018 19:21:44 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w4IJLg75022539
        for <util-linux@vger.kernel.org>; Fri, 18 May 2018 19:21:42 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w4IJLg84022538
        for util-linux@vger.kernel.org; Fri, 18 May 2018 19:21:42 GMT
Date: Fri, 18 May 2018 19:21:42 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man: Use the correct macro for a font change of one argument
Message-ID: <20180518192142.GA22534@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Use the correct macro (I, B) for the font change of one argument, not
those that are used for alternating two fonts, like "BR", "IR", "RB",
or "RI".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---

  An example of a warning: 

Input file is misc-utils/wipefs.8

<wipefs.8>:14 (macro RB): only 1 argument, but more are expected
<wipefs.8>:15 (macro IR): only 1 argument, but more are expected
<wipefs.8>:20 (macro RB): only 1 argument, but more are expected
<wipefs.8>:116 (macro BR): only 1 argument, but more are expected
<wipefs.8>:119 (macro BR): only 1 argument, but more are expected
<wipefs.8>:123 (macro BR): only 1 argument, but more are expected

Output is from: test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z 

  ["test-groff" is a developmental version of "groff"]


 disk-utils/fsck.8    |  2 +-
 disk-utils/partx.8   |  4 ++--
 disk-utils/sfdisk.8  |  2 +-
 login-utils/last.1   |  2 +-
 login-utils/login.1  | 18 +++++++++---------
 login-utils/su.1     |  4 ++--
 misc-utils/cal.1     |  2 +-
 misc-utils/findfs.8  |  6 +++---
 misc-utils/findmnt.8 | 30 +++++++++++++++---------------
 misc-utils/kill.1    | 10 +++++-----
 misc-utils/logger.1  |  2 +-
 misc-utils/lsblk.8   |  2 +-
 misc-utils/rename.1  |  4 ++--
 misc-utils/whereis.1 |  6 +++---
 misc-utils/wipefs.8  | 12 ++++++------
 schedutils/chrt.1    |  8 ++++----
 schedutils/taskset.1 | 14 +++++++-------
 sys-utils/chcpu.8    |  6 +++---
 sys-utils/chmem.8    |  6 +++---
 sys-utils/choom.1    | 14 +++++++-------
 sys-utils/dmesg.1    |  2 +-
 sys-utils/flock.1    |  4 ++--
 sys-utils/fsfreeze.8 |  2 +-
 sys-utils/mount.8    | 20 ++++++++++----------
 sys-utils/nsenter.1  | 18 +++++++++---------
 sys-utils/setpriv.1  |  8 ++++----
 sys-utils/swapon.8   |  6 +++---
 sys-utils/unshare.1  | 28 ++++++++++++++--------------
 term-utils/setterm.1 |  2 +-
 text-utils/column.1  |  6 +++---
 text-utils/hexdump.1 |  2 +-
 31 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index b3096bec6..90759f243 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -344,7 +344,7 @@ with
 .BR fsck .
 Options to different filesystem-specific fsck's are not standardized.
 .SH FILES
-.IR /etc/fstab
+.I /etc/fstab
 .SH ENVIRONMENT VARIABLES
 The
 .B fsck
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 7794f41c9..223f20918 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -101,7 +101,7 @@ to get
 of all supported columns.  This option cannot be combined with the
 .BR \-\-add ,
 .BR \-\-delete ,
-.BR \-\-update
+.B \-\-update
 or
 .B \-\-list
 options.
@@ -124,7 +124,7 @@ All numbers (except SIZE) are in 512-byte sectors.
 .BR \-t , " \-\-type " \fItype
 Specify the partition table type.
 .TP
-.BR \-\-list\-types
+.B \-\-list\-types
 List supported partition types and exit.
 .TP
 .BR \-u , " \-\-update"
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 0763906bc..2fa521706 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -182,7 +182,7 @@ see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section.
 .BR \-f , " \-\-force"
 Disable all consistency checking.
 .TP
-.BR \-\-Linux
+.B \-\-Linux
 Deprecated and ignored option.  Partitioning that is compatible with
 Linux (and other modern operating systems) is the default.
 .TP
diff --git a/login-utils/last.1 b/login-utils/last.1
index 94b4ed012..069f065ac 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -61,7 +61,7 @@ will show a log of all the reboots since the log file was created.
 is the same as
 .BR last ,
 except that by default it shows a log of the
-.IR /var/log/btmp
+.I /var/log/btmp
 file, which contains all the bad login attempts.
 .SH OPTIONS
 .TP
diff --git a/login-utils/login.1 b/login-utils/login.1
index 9e4697b12..cb8addec3 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -6,17 +6,17 @@ login \- begin session on the system
 .SH SYNOPSIS
 .B login
 [
-.BR \-p
+.B \-p
 ] [
-.BR \-h
-.IR host
+.B \-h
+.I host
 ] [
-.BR \-H
+.B \-H
 ] [
-.BR \-f
-.IR username
+.B \-f
+.I username
 |
-.IR username
+.I username
 ]
 .SH DESCRIPTION
 .B login
@@ -199,9 +199,9 @@ login failure.  The default value is
 (string)
 .RS 4
 The terminal permissions.  The default value is
-.IR 0600
+.I 0600
 or
-.IR 0620
+.I 0620
 if tty group is used.
 .RE
 .PP
diff --git a/login-utils/su.1 b/login-utils/su.1
index 31801c1da..d6c615392 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -161,10 +161,10 @@ Display help text and exit.
 .SH SIGNALS
 Upon receiving either
 .BR SIGINT ,
-.BR SIGQUIT
+.B SIGQUIT
 or
 .BR SIGTERM ,
-.BR su
+.B su
 terminates its child and afterwards terminates itself with
 the received signal.
 .SH CONFIG FILES
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index c9e92d749..5a8095fb3 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -207,7 +207,7 @@ Implicit coloring can be disabled as follows:
 .RS
 
 .br
-.BI "touch /etc/terminal-colors.d/cal.disable"
+.B touch /etc/terminal-colors.d/cal.disable
 .br
 
 .RE
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index f5099ed46..33bb242d7 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -34,13 +34,13 @@ by
 .RS
 
 .br
-.BI "lsblk \-\-fs"
+.B lsblk \-\-fs
 .br
 
-.BI "partx --show <disk>"
+.B partx --show <disk>
 .br
 
-.BI blkid
+.B blkid
 .br
 
 .RE
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 9979675ac..f95aea3d9 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -12,22 +12,22 @@ findmnt \- find a filesystem
 .B findmnt
 [options]
 .RB [ \-\-source ]
-.IR device
+.I device
 .RB [ \-\-target | \-\-mountpoint ]
-.IR mountpoint
+.I mountpoint
 .SH DESCRIPTION
 .B findmnt
 will list all mounted filesystems or search for a filesystem.  The
 .B \%findmnt
 command is able to search in
 .IR /etc/fstab ,
-.IR /etc/mtab
+.I /etc/mtab
 or
 .IR /proc/self/mountinfo .
 If
-.IR device
+.I device
 or
-.IR mountpoint
+.I mountpoint
 is not given, all filesystems are shown.
 .PP
 The device may be specified by device name, major:minor numbers,
@@ -140,7 +140,7 @@ by "+" prefix.
 .BR \-o , " \-\-output \fIlist\fP"
 Define output columns.  See the \fB\-\-help\fP output to get a list of the
 currently supported columns.  The
-.BR TARGET
+.B TARGET
 column contains tree formatting if the
 .B \-\-list
 or
@@ -183,7 +183,7 @@ available for umount and move actions
 available for umount and remount actions
 .RE
 .TP
-.BR "\-\-pseudo"
+.B \-\-pseudo
 Print only pseudo filesystems.
 .TP
 .BR \-R , " \-\-submounts"
@@ -196,7 +196,7 @@ default.  This option has no effect for \fB\-\-mtab\fP or \fB\-\-fstab\fP.
 .BR \-r , " \-\-raw"
 Use raw output format.  All potentially unsafe characters are hex-escaped (\\x<code>).
 .TP
-.BR "\-\-real"
+.B \-\-real
 Print only real filesystems.
 .TP
 .BR \-S , " \-\-source \fIspec\fP"
@@ -227,7 +227,7 @@ to specify the filesystem types on which no action should be taken.  For
 more details see
 .BR mount (8).
 .TP
-.BR "\-\-tree"
+.B \-\-tree
 Enable tree-like output if possible.  The options is silently ignored for
 tables where is missing child-parent relation (e.g. fstab).
 .TP
@@ -242,7 +242,7 @@ Do not truncate text in columns.  The default is to not truncate the
 .BR UUID ,
 .BR LABEL ,
 .BR PARTUUID ,
-.BR PARTLABEL
+.B PARTLABEL
 columns.  This option disables text truncation also in all other columns.
 .TP
 .BR \-v , " \-\-nofsroot"
@@ -253,12 +253,12 @@ Specify an upper limit on the time for which \fB\-\-poll\fR will block, in milli
 .TP
 .BR \-x , " \-\-verify"
 Check mount table content. The default is to verify
-.IR /etc/fstab
+.I /etc/fstab
 parsability and usability. It's possible to use this option also with \fB\-\-tab\-file\fP.
 It's possible to specify source (device) or target (mountpoint) to filter mount table. The option
 \fB\-\-verbose\fP forces findmnt to print more details.
 .TP
-.BR "\-\-verbose"
+.B \-\-verbose
 Force findmnt to print more information (\fB\-\-verify\fP only for now).
 .SH EXAMPLES
 .IP "\fBfindmnt \-\-fstab \-t nfs\fP"
@@ -266,16 +266,16 @@ Prints all NFS filesystems defined in
 .IR /etc/fstab .
 .IP "\fBfindmnt \-\-fstab /mnt/foo\fP"
 Prints all
-.IR /etc/fstab
+.I /etc/fstab
 filesystems where the mountpoint directory is /mnt/foo.  It also prints bind mounts where /mnt/foo
 is a source.
 .IP "\fBfindmnt \-\-fstab \-\-target /mnt/foo\fP"
 Prints all
-.IR /etc/fstab
+.I /etc/fstab
 filesystems where the mountpoint directory is /mnt/foo.
 .IP "\fBfindmnt \-\-fstab \-\-evaluate\fP"
 Prints all
-.IR /etc/fstab
+.I /etc/fstab
 filesystems and converts LABEL= and UUID= tags to the real device names.
 .IP "\fBfindmnt \-n \-\-raw \-\-evaluate \-\-output=target LABEL=/boot\fP"
 Prints only the mountpoint where the filesystem with label "/boot" is mounted.
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 630aeb1f0..24c32a249 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -37,7 +37,7 @@ Most modern shells have a builtin kill command, with a usage rather similar to
 that of the command described here.  The
 .BR \-\-all ,
 .BR \-\-pid ", and"
-.BR \-\-queue
+.B \-\-queue
 options, and the possibility to specify processes by command name, are local extensions.
 .PP
 If \fIsignal\fR is 0, then no actual signal is sent, but error checking is still performed.
@@ -135,7 +135,7 @@ in the target process that is not blocking the signal.
 For more details, see
 .BR signal (7)
 and the description of
-.BR CLONE_THREAD
+.B CLONE_THREAD
 in
 .BR clone (2).
 
@@ -143,13 +143,13 @@ in
 .B kill
 has the following return codes:
 .TP
-.BR 0
+.B 0
 success
 .TP
-.BR 1
+.B 1
 failure
 .TP
-.BR 64
+.B 64
 partial success (when more than one process specified)
 
 .SH SEE ALSO
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index f121c4dc9..9e83a0b53 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -121,7 +121,7 @@ instead of to the system log socket.  Unless
 is specified, \fBlogger\fR will first try to use UDP,
 but if this fails a TCP connection is attempted.
 .TP
-.BR \-\-no\-act
+.B \-\-no\-act
 Causes everything to be done except for writing the log message to the system
 log, and removing the connection or the journal.  This option can be used
 together with \fB\-\-stderr\fR for testing purposes.
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 65f9d0dfb..708381448 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -23,7 +23,7 @@ by default.  Use
 to get a list of all available columns.
 .PP
 The default output, as well as the default output from options like
-.BR \-\-fs
+.B \-\-fs
 and
 .BR \-\-topology ,
 is subject to change.  So whenever possible, you should avoid using default
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 1f6047920..cd90e64b4 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -24,12 +24,12 @@ Show which files were renamed, if any.
 .TP
 .BR \-n , " \-\-no\-act"
 Do not make any changes; add
-.BR \-\-verbose
+.B \-\-verbose
 to see what would be made.
 .TP
 .BR \-o , " \-\-no\-overwrite"
 Do not overwrite existing files.  When
-.BR \-\-symlink
+.B \-\-symlink
 is active, do not overwrite symlinks pointing to existing targets.
 .TP
 .BR \-i , " \-\-interactive"
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 0d2cbe7e7..a69395907 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -113,7 +113,7 @@ be used when any of the
 .BR \-B ,
 .BR \-M ,
 or
-.BR \-S
+.B \-S
 options is used.
 .IP "\fB\-l"
 Output the list of effective lookup paths that
@@ -122,7 +122,7 @@ is using.  When none of
 .BR \-B ,
 .BR \-M ,
 or
-.BR \-S
+.B \-S
 is specified, the option will output the hard-coded paths
 that the command was able to find on the system.
 .TP
@@ -158,7 +158,7 @@ listing option.  Effects of the
 .BR \-B ,
 .BR \-M ,
 and
-.BR \-S
+.B \-S
 are displayed with
 .BR \-l .
 .PP
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 0685c1ac9..c26b7890f 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -11,13 +11,13 @@ wipefs \- wipe a signature from a device
 .sp
 .B wipefs
 .RB [ \-\-backup ]
-.RB  \-o
-.IR offset
+.B \-o
+.I offset
 .IR device ...
 .sp
 .B wipefs
 .RB [ \-\-backup ]
-.RB \-a
+.B \-a
 .IR device ...
 .SH DESCRIPTION
 .B wipefs
@@ -113,14 +113,14 @@ taken.  For more details see mount(8).
 Display version information and exit.
 .SH EXAMPLES
 .TP
-.BR "wipefs /dev/sda*"
+.B wipefs /dev/sda*
 Prints information about sda and all partitions on sda.
 .TP
-.BR "wipefs --all --backup /dev/sdb"
+.B wipefs --all --backup /dev/sdb
 Erases all signatures from the device /dev/sdb and creates a signature backup
 file ~/wipefs-sdb-<offset>.bak for each signature.
 .TP
-.BR "dd if=~/wipefs-sdb-0x00000438.bak of=/dev/sdb seek=$((0x00000438)) bs=1 conv=notrunc"
+.B dd if=~/wipefs-sdb-0x00000438.bak of=/dev/sdb seek=$((0x00000438)) bs=1 conv=notrunc
 Restores an ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 4b8b1e9da..166579e2d 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -68,7 +68,7 @@ Set scheduling policy to
 .TP
 .BR -d ,\  --deadline
 Set scheduling policy to
-.BR SCHED_DEADLINE
+.B SCHED_DEADLINE
 (Linux-specific, supported since 3.14).  The priority argument has to be set to zero.
 See also \fB\-\-sched\-runtime\fR, \fB\-\-sched\-deadline\fR and
 \fB\-\-sched\-period\fR.  The relation between the options required by the kernel is
@@ -136,16 +136,16 @@ Or set them:
 .I priority pid
 .SH PERMISSIONS
 A user must possess
-.BR CAP_SYS_NICE
+.B CAP_SYS_NICE
 to change the scheduling attributes of a process.  Any user can retrieve the
 scheduling information.
 
 .SH NOTES
 Only
 .BR SCHED_FIFO ,
-.BR SCHED_OTHER
+.B SCHED_OTHER
 and
-.BR SCHED_RR
+.B SCHED_RR
 are part of POSIX 1003.1b Process Scheduling.  The other scheduling attributes
 may be ignored on some systems.
 .P
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 8b9062a72..6a329782a 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -53,28 +53,28 @@ bits that correspond to CPUs physically on the system.  If an invalid mask is
 given (i.e., one that corresponds to no valid CPUs on the current system) an
 error is returned.  The masks may be specified in hexadecimal (with or without
 a leading "0x"), or as a CPU list with the
-.BR \-\-cpu\-list
+.B \-\-cpu\-list
 option.  For example,
 .RS 4
 .TP 12
-.BR 0x00000001
+.B 0x00000001
 is processor #0,
 .TP
-.BR 0x00000003
+.B 0x00000003
 is processors #0 and #1,
 .TP
-.BR 0xFFFFFFFF
+.B 0xFFFFFFFF
 is processors #0 through #31,
 .TP
-.BR 32
+.B 32
 is processors #1, #4, and #5,
 .TP
-.BR \-\-cpu\-list\ 0-2,6
+.B \-\-cpu\-list\ 0-2,6
 is processors #0, #1, #2, and #6.
 .RE
 .PP
 When
-.BR taskset
+.B taskset
 returns, it is guaranteed that the given program has been scheduled to a legal
 CPU.
 .SH OPTIONS
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 41f0e09a5..2fb71115f 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -81,13 +81,13 @@ Display help text and exit.
 .B chcpu
 has the following return codes:
 .TP
-.BR 0
+.B 0
 success
 .TP
-.BR 1
+.B 1
 failure
 .TP
-.BR 64
+.B 64
 partial success
 .RE
 .SH AUTHOR
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index dae7413d4..8a3b34d5e 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -83,13 +83,13 @@ Print the version number, then exit.
 .B chmem
 has the following return codes:
 .TP
-.BR 0
+.B 0
 success
 .TP
-.BR 1
+.B 1
 failure
 .TP
-.BR 64
+.B 64
 partial success
 .SH EXAMPLES
 .TP
diff --git a/sys-utils/choom.1 b/sys-utils/choom.1
index 68496d112..9cac198d0 100644
--- a/sys-utils/choom.1
+++ b/sys-utils/choom.1
@@ -3,18 +3,18 @@
 choom \- display and adjust OOM-killer score.
 .SH SYNOPSIS
 .B choom
-.RB \-p
+.B \-p
 .IR pid
 .sp
 .B choom
-.RB \-p
-.IR pid
-.RB \-n
-.IR number
+.B \-p
+.I pid
+.B \-n
+.I number
 .sp
 .B choom
-.RB \-n
-.IR number
+.B \-n
+.I number
 .IR command\  [ argument ...]
 
 .SH DESCRIPTION
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 2b61c3739..adf5214b4 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -160,7 +160,7 @@ Do not print kernel's timestamps.
 Print timestamps using the given \fIformat\fR, which can be
 .BR ctime ,
 .BR reltime ,
-.BR delta
+.B delta
 or
 .BR iso .
 The first three formats are aliases of the time-format-specific options.
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 72c757aed..5b1d635b4 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -74,7 +74,7 @@ and the timeout is reached.  The default value is \fB1\fR.
 Do not fork before executing
 .IR command .
 Upon execution the flock process is replaced by
-.IR command
+.I command
 which continues to hold the lock. This option is incompatible with
 \fB\-\-close\fR as there would otherwise be nothing left to hold the lock.
 .TP
@@ -112,7 +112,7 @@ Decimal fractional values are allowed.
 See the
 .B \-E
 option for the exit code used. The zero number of
-.IR seconds
+.I seconds
 is interpreted as \fB\-\-nonblock\fR.
 .TP
 .B \-\-verbose
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index 500d311cb..3cd67382e 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -4,7 +4,7 @@ fsfreeze \- suspend access to a filesystem (Ext3/4, ReiserFS, JFS, XFS)
 .SH SYNOPSIS
 .B fsfreeze
 .BR \--freeze | \--unfreeze
-.IR mountpoint
+.I mountpoint
 
 .SH DESCRIPTION
 .B fsfreeze
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 3713197da..e6afaa3dd 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -97,11 +97,11 @@ refers to the root of the filesystem on
 If only the directory or the device is given, for example:
 .RS
 .sp
-.BI "mount /dir"
+.B mount /dir
 .sp
 .RE
 then \fBmount\fR looks for a mountpoint (and if not found then for a device) in the
-.IR /etc/fstab
+.I /etc/fstab
 file.  It's possible to use the
 .B \-\-target
 or
@@ -109,7 +109,7 @@ or
 options to avoid ambivalent interpretation of the given argument.  For example:
 .RS
 .sp
-.BI "mount \-\-target /mountpoint"
+.B mount \-\-target /mountpoint
 .sp
 .RE
 
@@ -526,7 +526,7 @@ For example:
 
 .RS
 .nf
-.BI "mount \-\-make\-private \-\-make\-unbindable /dev/sda1 /foo"
+.B mount \-\-make\-private \-\-make\-unbindable /dev/sda1 /foo
 .fi
 .RE
 
@@ -534,9 +534,9 @@ is the same as:
 
 .RS
 .nf
-.BI "mount /dev/sda1 /foo"
-.BI "mount \-\-make\-private /foo"
-.BI "mount \-\-make\-unbindable /foo"
+.B mount /dev/sda1 /foox
+.B mount \-\-make\-private /foo
+.B mount \-\-make\-unbindable /foo
 .fi
 .RE
 
@@ -573,7 +573,7 @@ already mounted filesystems is cached during \fBmount \-\-all\fR. It means
 that all duplicated fstab entries will be mounted.
 .sp
 Note that it is a bad practice to use \fBmount \-a\fR for
-.IR fstab
+.I fstab
 checking. The recommended solution is \fBfindmnt \-\-verify\fR.
 .TP
 .BR \-B , " \-\-bind"
@@ -722,7 +722,7 @@ and disables \fB\-\-options\-source\-force\fR.
 Default value is \fBfstab,mtab\fR.
 
 .TP
-.BR \-\-options\-source\-force
+.B \-\-options\-source\-force
 Use options from fstab/mtab even if both \fIdevice\fR and \fIdir\fR are specified.
 
 .TP
@@ -1577,7 +1577,7 @@ To maintain backward compatibility, '-o nfs' is also accepted,
 defaulting to
 .BR stale_rw .
 .TP
-.BI tz=UTC
+.B tz=UTC
 This option disables the conversion of timestamps
 between local time (as used by Windows on FAT) and UTC
 (which Linux uses internally).  This is particularly
diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 95f28ae43..aacae5352 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -20,7 +20,7 @@ except for filesystems which are explicitly marked as shared (with
 For further details, see
 .BR mount_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWNS
+.B CLONE_NEWNS
 flag in
 .BR clone (2).
 .TP
@@ -29,7 +29,7 @@ Setting hostname or domainname will not affect the rest of the system.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWUTS
+.B CLONE_NEWUTS
 flag in
 .BR clone (2).
 .TP
@@ -40,7 +40,7 @@ semaphore sets and shared memory segments.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWIPC
+.B CLONE_NEWIPC
 flag in
 .BR clone (2).
 .TP
@@ -54,7 +54,7 @@ directory trees, sockets, etc.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWNET
+.B CLONE_NEWNET
 flag in
 .BR clone (2).
 .TP
@@ -66,7 +66,7 @@ For further details, see
 .BR pid_namespaces (7)
 and
 the discussion of the
-.BR CLONE_NEWPID
+.B CLONE_NEWPID
 flag in
 .B nsenter
 will fork by default if changing the PID namespace, so that the new program
@@ -78,7 +78,7 @@ The process will have a distinct set of UIDs, GIDs and capabilities.
 For further details, see
 .BR user_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWUSER
+.B CLONE_NEWUSER
 flag in
 .BR clone (2).
 .TP
@@ -88,7 +88,7 @@ cgroup mounts will be rooted at the namespace cgroup root.
 For further details, see
 .BR cgroup_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWCGROUP
+.B CLONE_NEWCGROUP
 flag in
 .BR clone (2).
 .TP
@@ -98,13 +98,13 @@ Various of the options below that relate to namespaces take an optional
 .I file
 argument.
 This should be one of the
-.IR /proc/[pid]/ns/*
+.I /proc/[pid]/ns/*
 files described in
 .BR namespaces (7).
 .TP
 \fB\-a\fR, \fB\-\-all\fR
 Enter all namespaces of the target process by the default
-.IR /proc/[pid]/ns/*
+.I /proc/[pid]/ns/*
 namespace paths. The default paths to the target process namespaces may be
 overwritten by namespace specific options (e.g. --all --mount=[path]).
 
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index f989bf33c..1c2423c65 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -74,11 +74,11 @@ Preserve supplementary groups.  Only useful in conjunction with
 Initialize supplementary groups using
 .BR initgroups "(3)."
 Only useful in conjunction with
-.BR \-\-ruid
+.B \-\-ruid
 or
 .BR \-\-reuid .
 .TP
-.BR \-\-list\-caps
+.B \-\-list\-caps
 List all known capabilities.  This option must be specified alone.
 .TP
 .B \-\-no\-new\-privs
@@ -94,7 +94,7 @@ AppArmor, may result in failures to execute certain programs.)  This bit is
 inherited by child processes and cannot be unset.  See
 .BR prctl (2)
 and
-.IR Documentation/\:prctl/\:no_\:new_\:privs.txt
+.I Documentation/\:prctl/\:no_\:new_\:privs.txt
 in the Linux kernel source.
 .sp
 The no_new_privs bit is supported since Linux 3.5.
@@ -107,7 +107,7 @@ For safety, you must specify one of
 .BR \-\-clear\-groups ,
 .BR \-\-groups ,
 .BR \-\-keep\-groups ", or"
-.BR \-\-init\-groups
+.B \-\-init\-groups
 if you set any primary
 .IR gid .
 .TP
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index b8fc8be71..8398f1b35 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -35,7 +35,7 @@
 .SH NAME
 swapon, swapoff \- enable/disable devices and files for paging and swapping
 .SH SYNOPSIS
-.BR swapon
+.B swapon
 [options]
 .RI [ specialfile ...]
 .br
@@ -83,10 +83,10 @@ Enable swap discards, if the swap backing device supports the discard or
 trim operation.  This may improve performance on some Solid State Devices,
 but often it does not.  The option allows one to select between two
 available swap discard policies:
-.BI \-\-discard=once
+.B \-\-discard=once
 to perform a single-time discard operation for the whole swap area at swapon;
 or
-.BI \-\-discard=pages
+.B \-\-discard=pages
 to asynchronously discard freed swap pages before they are available for reuse.
 If no policy is selected, the default behavior is to enable both discard types.
 The
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 42cd7b3c3..746c41152 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -22,7 +22,7 @@ See the \fBEXAMPLES\fR section for more details.
 .PP
 The namespaces to be unshared are indicated via options.  Unshareable namespaces are:
 .TP
-.BR "mount namespace"
+.B mount namespace
 Mounting and unmounting filesystems will not affect the rest of the system,
 except for filesystems which are explicitly marked as
 shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
@@ -30,7 +30,7 @@ shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
 For further details, see
 .BR mount_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWNS
+.B CLONE_NEWNS
 flag in
 .BR clone (2).
 .sp
@@ -41,63 +41,63 @@ unshared.  It's possible to disable this feature with option
 \fB\-\-propagation unchanged\fP.
 Note that \fBprivate\fP is the kernel default.
 .TP
-.BR "UTS namespace"
+.B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWUTS
+.B CLONE_NEWUTS
 flag in
 .BR clone (2).
 .TP
-.BR "IPC namespace"
+.B IPC namespace
 The process will have an independent namespace for POSIX message queues
 as well as System V \%message queues,
 semaphore sets and shared memory segments.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWIPC
+.B CLONE_NEWIPC
 flag in
 .BR clone (2).
 .TP
-.BR "network namespace"
+.B network namespace
 The process will have independent IPv4 and IPv6 stacks, IP routing tables,
 firewall rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees,
 sockets, etc.
 For further details, see
 .BR namespaces (7)
 and the discussion of the
-.BR CLONE_NEWNET
+.B CLONE_NEWNET
 flag in
 .BR clone (2).
 .TP
-.BR "PID namespace"
+.B PID namespace
 Children will have a distinct set of PID-to-process mappings from their parent.
 For further details, see
 .BR pid_namespaces (7)
 and
 the discussion of the
-.BR CLONE_NEWPID
+.B CLONE_NEWPID
 flag in
 .BR clone (2).
 .TP
-.BR "cgroup namespace"
+.B cgroup namespace
 The process will have a virtualized view of \fI/proc\:/self\:/cgroup\fP, and new
 cgroup mounts will be rooted at the namespace cgroup root.
 For further details, see
 .BR cgroup_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWCGROUP
+.B CLONE_NEWCGROUP
 flag in
 .BR clone (2).
 .TP
-.BR "user namespace"
+.B user namespace
 The process will have a distinct set of UIDs, GIDs and capabilities.
 For further details, see
 .BR user_namespaces (7)
 and the discussion of the
-.BR CLONE_NEWUSER
+.B CLONE_NEWUSER
 flag in
 .BR clone (2).
 .SH OPTIONS
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 22a8ff03a..07495c5e7 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -47,7 +47,7 @@ can be an
 or
 .BR grey ,
 or
-.BR bright
+.B bright
 followed
 by
 .BR red ,
diff --git a/text-utils/column.1 b/text-utils/column.1
index b25748248..e81c8c1d6 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -42,13 +42,13 @@ The
 .B column
 utility formats its input into multiple columns.  The util support three modes:
 .TP
-.BR "columns are filled before rows"
+.B columns are filled before rows
 This is the default mode (required by backward compatibility).
 .TP
-.BR "rows are filled before columns"
+.B rows are filled before columns
 This mode is enabled by option \fB-x, \-\-fillrows\fP
 .TP
-.BR "table"
+.B table
 Determine the number of columns the input contains and create a table.  This
 mode is enabled by option \fB-t, \-\-table\fP and columns formatting is
 possible to modify by \fB\-\-table-*\fP options.  Use this mode if not sure.
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 5b7e8a4f0..23c32d70c 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -267,7 +267,7 @@ unit if both a value/\:string and an offset are specified.  In that case
 the respective output string will be highlighted if and only if the
 value/\:string does not match the one at the offset.
 .TP
-.BR COLOR
+.B COLOR
 One of the 8 basic shell colors.
 .TP
 .B VALUE
-- 
2.17.0


-- 
Bjarni I. Gislason
