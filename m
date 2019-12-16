Return-Path: <SRS0=+e2a=2G=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D1AC43603
	for <util-linux@archiver.kernel.org>; Mon, 16 Dec 2019 00:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD324681
	for <util-linux@archiver.kernel.org>; Mon, 16 Dec 2019 00:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfLPAwK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 15 Dec 2019 19:52:10 -0500
Received: from inpost.hi.is ([130.208.165.62]:38628 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfLPAwK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 15 Dec 2019 19:52:10 -0500
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id xBG0pwnm030295
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Mon, 16 Dec 2019 00:51:58 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is xBG0pwnm030295
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id xBG0pwaM009812
        for <util-linux@vger.kernel.org>; Mon, 16 Dec 2019 00:51:58 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id xBG0pvro009811
        for util-linux@vger.kernel.org; Mon, 16 Dec 2019 00:51:57 GMT
Date:   Mon, 16 Dec 2019 00:51:57 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] man pages: Change a HYPHEN-MINUS (-) to a minus (\-) for
 options and numbers
Message-ID: <20191216005157.GA9796@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Change a HYPHEN-MINUS (code 0x55, 2D) to a minus (\-), if in front of

1) a name of an option

2) a negative number to be printed.

  See man-pages(7) [Debian package "manpages"].

  The output from "nroff" is unchanged.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/fdisk.8      | 16 ++++++++--------
 disk-utils/sfdisk.8     | 26 +++++++++++++-------------
 login-utils/nologin.8   |  2 +-
 login-utils/runuser.1   |  4 ++--
 login-utils/utmpdump.1  |  2 +-
 misc-utils/blkid.8      | 22 +++++++++++-----------
 misc-utils/hardlink.1   |  4 ++--
 misc-utils/kill.1       | 12 ++++++------
 misc-utils/look.1       |  4 ++--
 misc-utils/lsblk.8      | 12 ++++++------
 misc-utils/lslocks.8    |  8 ++++----
 misc-utils/rename.1     |  2 +-
 misc-utils/uuidd.8.in   |  8 ++++----
 misc-utils/whereis.1    |  4 ++--
 misc-utils/wipefs.8     | 10 +++++-----
 schedutils/chrt.1       | 14 +++++++-------
 schedutils/ionice.1     |  6 +++---
 sys-utils/chmem.8       | 16 ++++++++--------
 sys-utils/flock.1       | 14 +++++++-------
 sys-utils/fstab.5       |  2 +-
 sys-utils/fstrim.8      |  6 +++---
 sys-utils/ipcrm.1       |  2 +-
 sys-utils/ldattach.8    |  2 +-
 sys-utils/losetup.8     | 18 +++++++++---------
 sys-utils/lscpu.1       | 16 ++++++++--------
 sys-utils/mount.8       | 24 ++++++++++++------------
 sys-utils/pivot_root.8  |  4 ++--
 sys-utils/prlimit.1     | 10 +++++-----
 sys-utils/readprofile.8 | 10 +++++-----
 sys-utils/renice.1      |  2 +-
 sys-utils/setarch.8     | 10 +++++-----
 sys-utils/setpriv.1     |  4 ++--
 sys-utils/swapon.8      |  4 ++--
 sys-utils/tunelp.8      |  2 +-
 sys-utils/umount.8      |  4 ++--
 sys-utils/unshare.1     | 36 ++++++++++++++++++------------------
 term-utils/script.1     |  4 ++--
 text-utils/column.1     | 18 +++++++++---------
 text-utils/more.1       |  2 +-
 39 files changed, 183 insertions(+), 183 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index c2321513e..cc172a0a5 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -37,7 +37,7 @@ sizes specified by the +/-<size>{M,G,...} notation are always aligned according
 to the device properties.
 
 CHS (Cylinder-Head-Sector) addressing is deprecated and not used by default.
-Please, do not follow old articles and recommendations with "fdisk -S <n> -H
+Please, do not follow old articles and recommendations with "fdisk \-S <n> \-H
 <n>" advices for SSD or 4K-sector devices.
 
 Note that
@@ -65,8 +65,8 @@ feature is supported for GPT and MBR.
 Specify the compatibility mode, 'dos' or 'nondos'.  The default is non-DOS
 mode.  For backward compatibility, it is possible to use the option without
 the \fImode\fR argument -- then the default is used.  Note that the optional
-\fImode\fR argument cannot be separated from the \fB-c\fR option by a space,
-the correct form is for example '-c=dos'.
+\fImode\fR argument cannot be separated from the \fB\-c\fR option by a space,
+the correct form is for example '\-c=dos'.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display a help text and exit.
@@ -89,7 +89,7 @@ Specify which output columns to print.  Use
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g., \fB-o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fB\-o +UUID\fP).
 .TP
 \fB\-s\fR, \fB\-\-getsz\fR
 Print the size in 512-byte sectors of each given block device.  This option is DEPRECATED
@@ -104,8 +104,8 @@ support for all other types.
 When listing partition tables, show sizes in 'sectors' or in 'cylinders'.  The
 default is to show sizes in sectors.  For backward compatibility, it is possible
 to use the option without the \fIunit\fR argument -- then the default is used.
-Note that the optional \fIunit\fR argument cannot be separated from the \fB-u\fR
-option by a space, the correct form is for example '-u=cylinders'.
+Note that the optional \fIunit\fR argument cannot be separated from the \fB\-u\fR
+option by a space, the correct form is for example '\-u=cylinders'.
 
 .TP
 \fB\-C\fR, \fB\-\-cylinders\fR \fInumber\fR
@@ -168,7 +168,7 @@ The "last sector" dialog accepts partition size specified by number of sectors
 or by +/-<size>{K,B,M,G,...} notation.
 
 If the size is prefixed by  '+' then it is interpreted as relative to the
-partition first sector.  If the size is prefixed by  '-' then it is interpreted
+partition first sector.  If the size is prefixed by  '\-' then it is interpreted
 as relative to the high limit (last available sector for the partition).
 
 In the case the size is specified in bytes than the number may be followed by
@@ -270,7 +270,7 @@ are performed before exiting when the partition table has been updated.
 .B Note that all this is deprecated.  You don't have to care about things like
 .B geometry and cylinders on modern operating systems.  If you really want
 .B DOS-compatible partitioning then you have to enable DOS mode and cylinder
-.B units by using the '-c=dos -u=cylinders' fdisk command-line options.
+.B units by using the '\-c=dos \-u=cylinders' fdisk command-line options.
 
 The DOS 6.x FORMAT command looks for some information in the first sector of
 the data area of the partition, and treats this information as more reliable
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index e7d7a272c..3ff5dd4e6 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -61,7 +61,7 @@ partitions.
 
 .B sfdisk
 uses BLKRRPART (reread partition table) ioctl to make sure that the device is
-not used by system or another tools (see also --no-reread).  It's possible that
+not used by system or another tools (see also \-\-no-reread).  It's possible that
 this feature or another sfdisk activity races with \fBudevd\fR.  The recommended way
 how to avoid possible collisions is to use exclusive flock for the whole-disk
 device to serialize device access.  The exclusive lock will cause udevd to skip
@@ -97,7 +97,7 @@ unused partition given with \fB\-N\fR.  See also \fB\-\-append\fR.
 .TP
 .BR \-A , " \-\-activate \fIdevice " [ \fIpartition-number...]
 Switch on the bootable flag for the specified partitions and switch off the
-bootable flag on all unspecified partitions. The special placeholder '-'
+bootable flag on all unspecified partitions. The special placeholder '\-'
 may be used instead of the partition numbers to switch off the bootable flag
 on all partitions.
 
@@ -227,11 +227,11 @@ and the last command reorders partitions to match disk order
 (the original sdc1 will become sdc2).
 .RS
 .sp
-.B "echo '+100M,' | sfdisk --move-data /dev/sdc -N 1"
+.B "echo '+100M,' | sfdisk \-\-move-data /dev/sdc \-N 1"
 .br
-.B "echo '2048,' | sfdisk /dev/sdc --append
+.B "echo '2048,' | sfdisk /dev/sdc \-\-append
 .br
-.B sfdisk /dev/sdc --reorder
+.B sfdisk /dev/sdc \-\-reorder
 .sp
 .RE
 
@@ -246,14 +246,14 @@ Specify which output columns to print.  Use
 to get a list of all supported columns.
 .sp
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g., \fB-o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fB\-o +UUID\fP).
 .TP
 .BR \-q , " \-\-quiet"
 Suppress extra info messages.
 .TP
 .BR \-u , " \-\-unit S"
 Deprecated option.  Only the sector unit is supported. This option is not
-supported when using the --show-size command.
+supported when using the \-\-show-size command.
 .TP
 .BR \-X , " \-\-label " \fItype
 Specify the disk label type (e.g., \fBdos\fR, \fBgpt\fR, ...).  If this option
@@ -268,7 +268,7 @@ Force editing of a nested disk label.  The primary disk label has to exist alrea
 This option allows to edit for example a hybrid/protective MBR on devices with GPT.
 
 .TP
-.BR -w , " \-\-wipe "\fIwhen
+.BR \-w , " \-\-wipe "\fIwhen
 Wipe filesystem, RAID and partition-table signatures from the device, in order
 to avoid possible collisions.  The argument \fIwhen\fR can be \fBauto\fR,
 \fBnever\fR or \fBalways\fR.  When this option is not given, the default is
@@ -281,7 +281,7 @@ partition table is created.  See also
 command.
 
 .TP
-.BR -W , " \-\-wipe-partitions "\fIwhen
+.BR \-W , " \-\-wipe-partitions "\fIwhen
 Wipe filesystem, RAID and partition-table signatures from a newly created
 partitions, in order to avoid possible collisions.  The argument \fIwhen\fR can
 be \fBauto\fR, \fBnever\fR or \fBalways\fR.  When this option is not given, the
@@ -361,8 +361,8 @@ where each line fills one partition descriptor.
 Fields are separated by whitespace, comma or semicolon possibly
 followed by whitespace; initial and trailing whitespace is ignored.
 Numbers can be octal, decimal or hexadecimal; decimal is the default.
-When a field is absent, empty or specified as '-' a default value is
-used.  But when the \fB-N\fR option (change a single partition) is
+When a field is absent, empty or specified as '\-' a default value is
+used.  But when the \fB\-N\fR option (change a single partition) is
 given, the default for each field is its previous value.
 .sp
 The default value of
@@ -504,7 +504,7 @@ to a text file.  The dump format is suitable for later \fBsfdisk\fR input.
 For example:
 .RS
 .sp
-.B "sfdisk --dump /dev/sda > sda.dump"
+.B "sfdisk \-\-dump /dev/sda > sda.dump"
 .sp
 .RE
 This can later be restored by:
@@ -524,7 +524,7 @@ Note that the same concept of backup files is used by
 For example:
 .RS
 .sp
-.B "sfdisk --backup /dev/sda"
+.B "sfdisk \-\-backup /dev/sda"
 .sp
 .RE
 The GPT header can later be restored by:
diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index d3882e2b1..054ed7344 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -43,7 +43,7 @@ is always 1.
 These shell command-line options are ignored to avoid nologin error.
 .IP "\fB\-h\fR, \fB\-\-help\fR"
 Display help text and exit.
-.IP "\fB-V\fR, \fB\-\-version\fR"
+.IP "\fB\-V\fR, \fB\-\-version\fR"
 Display version information and exit.
 .SH NOTES
 .B nologin
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 4f6064287..27dbf576c 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -106,12 +106,12 @@ Create pseudo-terminal for the session. The independent terminal provides
 better security as user does not share terminal with the original
 session.  This allow to avoid TIOCSTI ioctl terminal injection and another
 security attacks against terminal file descriptors. The all session is also
-possible to move to background (e.g., "runuser --pty -u username -- command &").
+possible to move to background (e.g., "runuser \-\-pty \-u username \-\- command &").
 If the pseudo-terminal is enabled then runuser command works
 as a proxy between the sessions (copy stdin and stdout).
 .sp
 This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal, but for example pipe (e.g., echo "date" | runuser --pty -u user)
+is not a terminal, but for example pipe (e.g., echo "date" | runuser \-\-pty \-u user)
 than ECHO flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 9e6b5a3c2..d98117da4 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -51,7 +51,7 @@ out utmp/wtmp to an ASCII file, which can then be edited to remove
 bogus entries, and reintegrated using:
 .PP
 .RS
-.B utmpdump -r < ascii_file > wtmp
+.B utmpdump \-r < ascii_file > wtmp
 .RE
 .PP
 But be warned,
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index b354f8c63..b3db17707 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -56,7 +56,7 @@ from the content metadata (e.g., LABEL or UUID fields).
 .PP
 .B It is recommended to use
 .BR lsblk (8)
-.B command to get information about block devices, or lsblk --fs to get an overview of filesystems, or
+.B command to get information about block devices, or lsblk \-\-fs to get an overview of filesystems, or
 .BR findmnt (8)
 .B to search in already mounted filesystems.
 .PP
@@ -90,7 +90,7 @@ more specified devices.
 For security reasons
 .B blkid
 silently ignores all devices where the probing result is ambivalent (multiple
-colliding filesystems are detected).  The low-level probing mode (\fB-p\fR)
+colliding filesystems are detected).  The low-level probing mode (\fB\-p\fR)
 provides more information and extra return code in this case.
 It's recommended to use
 .BR wipefs (8)
@@ -150,7 +150,7 @@ on systems where the same tag is used for multiple devices.
 .TP
 \fB\-L\fR, \fB\-\-label\fR \fIlabel\fR
 Look up the device that uses this filesystem \fIlabel\fR; this is equal to
-.BR "--list-one --output device --match-token LABEL=\fIlabel\fR" .
+.BR "\-\-list-one \-\-output device \-\-match-token LABEL=\fIlabel\fR" .
 This lookup method is able to reliably use /dev/disk/by-label
 udev symlinks (dependent on a setting in /etc/blkid.conf).  Avoid using the
 symlinks directly; it is not reliable to use the symlinks without verification.
@@ -158,9 +158,9 @@ The \fB-\-label\fR option works on systems with and without udev.
 
 Unfortunately, the original
 .BR blkid (8)
-from e2fsprogs uses the \fB-L\fR option as a
-synonym for \fB-o list\fR.  For better portability, use \fB-l -o device
--t LABEL=\fIlabel\fR and \fB-o list\fR in your scripts rather than the \fB-L\fR option.
+from e2fsprogs uses the \fB\-L\fR option as a
+synonym for \fB\-o list\fR.  For better portability, use \fB\-l \-o device
+\-t LABEL=\fIlabel\fR and \fB\-o list\fR in your scripts rather than the \fB\-L\fR option.
 .TP
 \fB\-n\fR, \fB\-\-match\-types\fR \fIlist\fR
 Restrict the probing functions to the specified (comma-separated) \fIlist\fR of
@@ -168,18 +168,18 @@ superblock types (names).
 The list items may be prefixed with "no" to specify the types which should be ignored.
 For example:
 .sp
-  blkid --probe --match-types vfat,ext3,ext4 /dev/sda1
+  blkid \-\-probe \-\-match-types vfat,ext3,ext4 /dev/sda1
 .sp
 probes for vfat, ext3 and ext4 filesystems, and
 .sp
-  blkid --probe --match-types nominix /dev/sda1
+  blkid \-\-probe \-\-match-types nominix /dev/sda1
 .sp
 probes for all supported formats except minix filesystems.
 This option is only useful together with \fB\-\-probe\fR.
 .TP
 \fB\-o\fR, \fB\-\-output\fR \fIformat\fR
 Use the specified output format.  Note that the order of variables and
-devices is not fixed.  See also option \fB-s\fR.  The
+devices is not fixed.  See also option \fB\-s\fR.  The
 .I format
 parameter may be:
 .RS
@@ -271,11 +271,11 @@ Restrict the probing functions to the specified (comma-separated) \fIlist\fR of
 Supported usage types are: filesystem, raid, crypto and other.  The list items may be
 prefixed with "no" to specify the usage types which should be ignored.  For example:
 .sp
-  blkid --probe --usages filesystem,other /dev/sda1
+  blkid \-\-probe \-\-usages filesystem,other /dev/sda1
 .sp
 probes for all filesystem and other (e.g., swap) formats, and
 .sp
-  blkid --probe --usages noraid /dev/sda1
+  blkid \-\-probe \-\-usages noraid /dev/sda1
 .sp
 probes for all supported formats except RAIDs.
 This option is only useful together with \fB\-\-probe\fR.
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index 738fac708..dcef8080e 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -34,7 +34,7 @@ Do not perform the consolidation; only print what would be changed.
 .TP
 .BR \-v , " \-\-verbose"
 Print summary after hardlinking. The option may be specified more than once. In
-this case (e.g., \fB-vv\fR) it prints every hardlinked file and bytes saved.
+this case (e.g., \fB\-vv\fR) it prints every hardlinked file and bytes saved.
 .TP
 .BR \-x , " \-\-exclude " \fIregex\fR
 Exclude files and directories matching pattern from hardlinking.
@@ -66,7 +66,7 @@ Historically \fBhardlink\fR silently excluded any names beginning with
 ".in.", as well as any names beginning with "." followed by exactly 6
 other characters. That prior behavior can be achieved by specifying
 .br
--x '^(\\.in\\.|\\.[^.]{6}$)'
+\-x '^(\\.in\\.|\\.[^.]{6}$)'
 .SH AVAILABILITY
 The hardlink command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 7a772e8d6..24cfe7999 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -7,7 +7,7 @@ kill \- terminate a process
 .SH SYNOPSIS
 .B kill
 .RB [ \- \fIsignal\fR| \-s
-.IR signal | \fB-p\fP ]
+.IR signal | \fB\-p\fP ]
 .RB [ \-q
 .IR value ]
 .RB [ \-a ]
@@ -62,17 +62,17 @@ is signaled.
 .B 0
 All processes in the current process group are signaled.
 .TP
-.B -1
+.B \-1
 All processes with a PID larger than 1 are signaled.
 .TP
-.BI - n
+.BI \- n
 where
 .I n
 is larger than 1.  All processes in process group
 .I n
-are signaled.  When an argument of the form '-n' is given, and it is meant to
+are signaled.  When an argument of the form '\-n' is given, and it is meant to
 denote a process group, either a signal must be specified first, or the
-argument must be preceded by a '--' option, otherwise it will be taken as the
+argument must be preceded by a '\-\-' option, otherwise it will be taken as the
 signal to send.
 .RE
 .TP
@@ -146,7 +146,7 @@ option.
 Example.  Send signals QUIT, TERM and KILL in sequence and wait for 1000
 milliseconds between the signals
 .br
-kill --verbose --timeout 1000 TERM --timeout 1000 KILL --signal QUIT 12345
+kill \-\-verbose \-\-timeout 1000 TERM \-\-timeout 1000 KILL \-\-signal QUIT 12345
 .SH NOTES
 Although it is possible to specify the TID (thread ID, see
 .BR gettid (2))
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 28a724d81..eb3e2103f 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -97,8 +97,8 @@ no lines were found, and >1 if an error occurred.
 .SH EXAMPLE
 .RS
 .nf
-sort -d /etc/passwd -o /tmp/look.dict
-look -t: root:foobar /tmp/look.dict
+sort \-d /etc/passwd \-o /tmp/look.dict
+look \-t: root:foobar /tmp/look.dict
 .nf
 .RE
 .SH ENVIRONMENT
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index f46f89bc7..373a80ee2 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -19,7 +19,7 @@ are necessary.
 .PP
 The command prints all block devices (except RAM disks) in a tree-like format
 by default.  Use
-.B "lsblk --help"
+.B "lsblk \-\-help"
 to get a list of all available columns.
 .PP
 The default output, as well as the default output from options like
@@ -54,7 +54,7 @@ Print the SIZE column in bytes rather than in a human-readable format.
 Print information about the discarding capabilities (TRIM, UNMAP) for each device.
 .TP
 .BR \-d , " \-\-nodeps"
-Do not print holder devices or slaves.  For example, \fBlsblk --nodeps /dev/sda\fR prints
+Do not print holder devices or slaves.  For example, \fBlsblk \-\-nodeps /dev/sda\fR prints
 information about the sda device only.
 .TP
 .BR \-E , " \-\-dedup " \fIcolumn\fP
@@ -73,7 +73,7 @@ The filter is applied to the top-level devices only. This may be confusing for
 .TP
 .BR \-f , " \-\-fs"
 Output info about filesystems.  This option is equivalent to
-.BR -o\ NAME,FSTYPE,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINT .
+.BR \-o\ NAME,FSTYPE,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINT .
 The authoritative information about filesystems and raids is provided by the
 .BR blkid (8)
 command.
@@ -104,7 +104,7 @@ Multi-path devices. The tree-like output is required.
 .TP
 .BR \-m , " \-\-perms"
 Output info about device owner, group and mode.  This option is equivalent to
-.BR -o\ NAME,SIZE,OWNER,GROUP,MODE .
+.BR \-o\ NAME,SIZE,OWNER,GROUP,MODE .
 .TP
 .BR \-n , " \-\-noheadings"
 Do not print a header line.
@@ -116,7 +116,7 @@ to get a list of all supported columns.  The columns may affect tree-like output
 The default is to use tree for the column 'NAME' (see also \fB\-\-tree\fR).
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g., \fBlsblk -o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fBlsblk \-o +UUID\fP).
 .TP
 .BR \-O , " \-\-output\-all "
 Output all available columns.
@@ -146,7 +146,7 @@ The default is NAME column.
 .BR \-t , " \-\-topology"
 Output info about block-device topology.
 This option is equivalent to
-.BR -o\ NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,RA,WSAME .
+.BR \-o\ NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,RA,WSAME .
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index bcafe43a0..f48feba19 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -14,7 +14,7 @@ lslocks \- list local system locks
 lists information about all the currently held file locks in a Linux system.
 .sp
 Note that lslocks also lists OFD (Open File Description) locks, these locks are
-not associated with any process (PID is -1).  OFD locks are associated with the
+not associated with any process (PID is \-1).  OFD locks are associated with the
 open file description on which they are acquired.  This lock type is available
 since Linux 3.15, see \fBfcntl\fR(2) for more details.
 
@@ -34,11 +34,11 @@ Do not print a header line.
 .TP
 .BR \-o , " \-\-output " \fIlist\fP
 Specify which output columns to print.  Use
-.B "--help"
+.B \-\-help
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g., \fBlslocks -o +BLOCKER\fP).
+specified in the format \fI+list\fP (e.g., \fBlslocks \-o +BLOCKER\fP).
 .TP
 .B \-\-output\-all
 Output all available columns.
@@ -62,7 +62,7 @@ Display help text and exit.
 .IP "COMMAND"
 The command name of the process holding the lock.
 .IP "PID"
-The process ID of the process which holds the lock or -1 for OFDLCK.
+The process ID of the process which holds the lock or \-1 for OFDLCK.
 .IP "TYPE"
 The type of lock; can be FLOCK (created with \fBflock\fR(2)), POSIX
 (created with \fBfcntl\fR(2) and \fBlockf\fR(3)) or OFDLCK (created with fcntl(2).
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index cd90e64b4..d8fdd6d94 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -92,7 +92,7 @@ mode, run for example:
 .RS
 .PP
 .nf
-sh -c 'stty -icanon min 1; "$0" "$@"; stty icanon' rename -i from to files
+sh \-c 'stty \-icanon min 1; "$0" "$@"; stty icanon' rename \-i from to files
 .fi
 .PP
 .RE
diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index 0a5cf471b..75bcc7c67 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -48,7 +48,7 @@ request it to return a random-based UUID.
 .TP
 .BR \-S , " \-\-socket-activation "
 Do not create a socket but instead expect it to be provided by the calling
-process.  This implies \fB--no-fork\fR and \fB--no-pid\fR.  This option is
+process.  This implies \fB\-\-no-fork\fR and \fB\-\-no-pid\fR.  This option is
 intended to be used only with \fBsystemd\fR(1).  It needs to be enabled with
 a configure option.
 .TP
@@ -75,9 +75,9 @@ Start up a daemon, print 42 random keys, and then stop the daemon:
 .PP
 .RS
 .nf
-uuidd -p /tmp/uuidd.pid -s /tmp/uuidd.socket
-uuidd -d -r -n 42 -s /tmp/uuidd.socket
-uuidd -d -k -s /tmp/uuidd.socket
+uuidd \-p /tmp/uuidd.pid \-s /tmp/uuidd.socket
+uuidd \-d \-r \-n 42 \-s /tmp/uuidd.socket
+uuidd \-d \-k \-s /tmp/uuidd.socket
 .nf
 .RE
 .SH AUTHOR
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index a69395907..83182b067 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -63,7 +63,7 @@ the command line.  Any new search restriction resets the search mask.
 For example,
 .RS
 .sp
-.B "whereis -bm ls tr -m gcc"
+.B "whereis \-bm ls tr \-m gcc"
 .sp
 .RE
 searches for "ls" and "tr" binaries and man pages, and for "gcc" man pages only.
@@ -72,7 +72,7 @@ The options \fB\-B\fP, \fB\-M\fP and \fB\-S\fP reset search paths for the
 subsequent \fIname\fP patterns.  For example,
 .RS
 .sp
-.B "whereis -m ls -M /usr/share/man/man1 -f cal"
+.B "whereis \-m ls \-M /usr/share/man/man1 \-f cal"
 .sp
 .RE
 searches for "ls" man pages in all default paths, but for "cal" in
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index e47b780d3..a6f8be7a5 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -47,7 +47,7 @@ the device (e.g., FAT, ZFS, GPT).  The
 command (since v2.31) lists all the offset where a magic strings have been
 detected.
 
-When option \fB-a\fR is used, all magic strings that are visible for libblkid are
+When option \fB\-a\fR is used, all magic strings that are visible for libblkid are
 erased. In this case the
 .B wipefs
 scans the device again after each modification (erase) until no magic string is found.
@@ -84,13 +84,13 @@ Do not print a header line.
 Specify which output columns to print.  Use \-\-help to
 get a list of all supported columns.
 .TP
-.BR -n , " \-\-no\-act"
+.BR \-n , " \-\-no\-act"
 Causes everything to be done except for the write() call.
 .TP
 .BR \-o , " \-\-offset " \fIoffset\fP
 Specify the location (in bytes) of the signature which should be erased from the
 device.  The \fIoffset\fR number may include a "0x" prefix; then the number will be
-interpreted as a hex value.  It is possible to specify multiple \fB-o\fR options.
+interpreted as a hex value.  It is possible to specify multiple \fB\-o\fR options.
 .sp
 The \fIoffset\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
@@ -110,14 +110,14 @@ be specified in a comma-separated list.  The list or individual types
 can be prefixed with 'no' to specify the types on which no action should be
 taken.  For more details see mount(8).
 .TP
-.BR -V , " \-\-version"
+.BR \-V , " \-\-version"
 Display version information and exit.
 .SH EXAMPLES
 .TP
 .B wipefs /dev/sda*
 Prints information about sda and all partitions on sda.
 .TP
-.B wipefs --all --backup /dev/sdb
+.B wipefs \-\-all \-\-backup /dev/sdb
 Erases all signatures from the device /dev/sdb and creates a signature backup
 file ~/wipefs-sdb-<offset>.bak for each signature.
 .TP
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 166579e2d..6dbb0ec03 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -66,7 +66,7 @@ Set scheduling policy to
 .B SCHED_IDLE
 (Linux-specific, supported since 2.6.23).  The priority argument has to be set to zero.
 .TP
-.BR -d ,\  --deadline
+.BR \-d ,\  \-\-deadline
 Set scheduling policy to
 .B SCHED_DEADLINE
 (Linux-specific, supported since 3.14).  The priority argument has to be set to zero.
@@ -102,23 +102,23 @@ scheduling policy (Linux-specific, supported since 2.6.31).
 
 .SH OPTIONS
 .TP
-.BR -a ,\  --all-tasks
+.BR \-a ,\  \-\-all-tasks
 Set or retrieve the scheduling attributes of all the tasks (threads) for a
 given PID.
 .TP
-.BR -m ,\  --max
+.BR \-m ,\  \-\-max
 Show minimum and maximum valid priorities, then exit.
 .TP
-.BR -p ,\  --pid
+.BR \-p ,\  \-\-pid
 Operate on an existing PID and do not launch a new task.
 .TP
-.BR -v ,\  --verbose
+.BR \-v ,\  \-\-verbose
 Show status information.
 .TP
-.BR -V ,\  --version
+.BR \-V ,\  \-\-version
 Display version information and exit.
 .TP
-.BR -h ,\  --help
+.BR \-h ,\  \-\-help
 Display help text and exit.
 .SH USAGE
 .TP
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 1b075d3e3..fa5c1ad19 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -116,15 +116,15 @@ Display version information and exit.
 .SH EXAMPLES
 .LP
 .TP 7
-# \fBionice\fP -c 3 -p 89
+# \fBionice\fP \-c 3 \-p 89
 .TP 7
 Sets process with PID 89 as an idle I/O process.
 .TP 7
-# \fBionice\fP -c 2 -n 0 bash
+# \fBionice\fP \-c 2 \-n 0 bash
 .TP 7
 Runs 'bash' as a best-effort program with highest priority.
 .TP 7
-# \fBionice\fP -p 89 91
+# \fBionice\fP \-p 89 91
 .TP 7
 Prints the class and priority of the processes with PID 89 and 91.
 .SH NOTES
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index 21bcc14c0..c0941ea70 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -24,15 +24,15 @@ Specify \fIBLOCKRANGE\fP in the form <first>-<last> or <block> as shown in the
 output of the \fBlsmem\fP command. <first> is the number of the first memory block
 and <last> is the number of the last memory block in the memory
 range. Alternatively a single block can be specified. \fIBLOCKRANGE\fP requires
-the \fB--blocks\fP option.
+the \fB\-\-blocks\fP option.
 .
 .IP "\(hy" 2
 Specify \fIZONE\fP as the name of a memory zone, as shown in the output of the
-\fBlsmem -o +ZONES\fP command. The output shows one or more valid memory zones
+\fBlsmem \-o +ZONES\fP command. The output shows one or more valid memory zones
 for each memory range. If multiple zones are shown, then the memory range
 currently belongs to the first zone. By default, chmem will set memory online
 to the zone Movable, if this is among the valid zones. This default can be
-changed by specifying the \fB--zone\fP option with another valid zone.
+changed by specifying the \fB\-\-zone\fP option with another valid zone.
 For memory ballooning, it is recommended to select the zone Movable for memory
 online and offline, if possible. Memory in this zone is much more likely to be
 able to be offlined again, but it cannot be used for arbitrary kernel
@@ -57,7 +57,7 @@ block numbers.
 .TP
 .BR \-b ", " \-\-blocks
 Use a \fIBLOCKRANGE\fP parameter instead of \fIRANGE\fP or \fISIZE\fP for the
-\fB--enable\fP and \fB--disable\fP options.
+\fB\-\-enable\fP and \fB\-\-disable\fP options.
 .TP
 .BR \-d ", " \-\-disable
 Set the specified \fIRANGE\fP, \fISIZE\fP, or \fIBLOCKRANGE\fP of memory offline.
@@ -93,17 +93,17 @@ failure
 partial success
 .SH EXAMPLES
 .TP
-.B chmem --enable 1024
+.B chmem \-\-enable 1024
 This command requests 1024 MiB of memory to be set online.
 .TP
-.B chmem -e 2g
+.B chmem \-e 2g
 This command requests 2 GiB of memory to be set online.
 .TP
-.B chmem --disable 0x00000000e4000000-0x00000000f3ffffff
+.B chmem \-\-disable 0x00000000e4000000-0x00000000f3ffffff
 This command requests the memory range starting with 0x00000000e4000000
 and ending with 0x00000000f3ffffff to be set offline.
 .TP
-.B chmem -b -d 10
+.B chmem \-b \-d 10
 This command requests the memory block number 10 to be set offline.
 .SH SEE ALSO
 .BR lsmem (1)
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 5b1d635b4..0a4da9d46 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -126,23 +126,23 @@ Display version information and exit.
 Display help text and exit.
 .SH EXAMPLES
 .TP
-shell1> flock /tmp -c cat
+shell1> flock /tmp \-c cat
 .TQ
-shell2> flock -w .007 /tmp -c echo; /bin/echo $?
+shell2> flock \-w .007 /tmp \-c echo; /bin/echo $?
 Set exclusive lock to directory /tmp and the second command will fail.
 .TP
-shell1> flock -s /tmp -c cat
+shell1> flock \-s /tmp \-c cat
 .TQ
-shell2> flock -s -w .007 /tmp -c echo; /bin/echo $?
+shell2> flock \-s \-w .007 /tmp \-c echo; /bin/echo $?
 Set shared lock to directory /tmp and the second command will not fail.
 Notice that attempting to get exclusive lock with second command would fail.
 .TP
-shell> flock -x local-lock-file echo 'a b c'
+shell> flock \-x local-lock-file echo 'a b c'
 Grab the exclusive lock "local-lock-file" before running echo with 'a b c'.
 .TP
 (
 .TQ
-  flock -n 9 || exit 1
+  flock \-n 9 || exit 1
 .TQ
   # ... commands executed under lock ...
 .TQ
@@ -159,7 +159,7 @@ write permission is required.  Using
 .I <
 requires that the file already exists but only read permission is required.
 .TP
-[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@" || :
+[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock \-en "$0" "$0" "$@" || :
 This is useful boilerplate code for shell scripts.  Put it at the top of the
 shell script you want to lock and it'll automatically lock itself on the first
 run.  If the env var $FLOCKER is not set to the shell script that is being run,
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 6e2ea7abc..94235b2ae 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -174,7 +174,7 @@ Basic filesystem-independent options are:
 use default options: rw, suid, dev, exec, auto, nouser, and async.
 .TP
 .B noauto
-do not mount when "mount -a" is given (e.g., at boot time)
+do not mount when "mount \-a" is given (e.g., at boot time)
 .TP
 .B user
 allow a user to mount
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index eba52ab9e..a7adc6a03 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -32,7 +32,7 @@ is mounted.
 Running
 .B fstrim
 frequently, or even using
-.BR "mount -o discard" ,
+.BR "mount \-o discard" ,
 might negatively affect the lifetime of poor-quality SSD devices.  For most
 desktop and server systems a sufficient trimming frequency is once a week.
 Note that not all
@@ -96,7 +96,7 @@ storage device.  Further, the kernel block layer reserves the right to adjust
 the discard ranges to fit raid stripe geometry, non-trim capable devices in a
 LVM setup, etc.  These reductions would not be reflected in fstrim_range.len
 (the
-.B --length
+.B \-\-length
 option).
 .TP
 .B \-\-quiet
@@ -125,7 +125,7 @@ all failed
 some filesystem discards have succeeded, some failed
 .PP
 The command
-.B fstrim --all
+.B fstrim \-\-all
 returns 0 (all succeeded), 32 (all failed) or 64 (some failed, some succeeded).
 
 .SH AUTHOR
diff --git a/sys-utils/ipcrm.1 b/sys-utils/ipcrm.1
index be73dff5a..6bb93f6bc 100644
--- a/sys-utils/ipcrm.1
+++ b/sys-utils/ipcrm.1
@@ -47,7 +47,7 @@ The identifiers and keys can be found by using
 .BR ipcs (1).
 .SH OPTIONS
 .TP
-\fB-a\fR, \fB\-\-all\fR [\fBshm\fR] [\fBmsg\fR] [\fBsem\fR]
+\fB\-a\fR, \fB\-\-all\fR [\fBshm\fR] [\fBmsg\fR] [\fBsem\fR]
 Remove all resources.  When an option argument is provided, the removal is
 performed only for the specified resource types.  \fIWarning!\fR  Do not use
 .B \-a
diff --git a/sys-utils/ldattach.8 b/sys-utils/ldattach.8
index 1b4683dcd..5c71dbcab 100644
--- a/sys-utils/ldattach.8
+++ b/sys-utils/ldattach.8
@@ -113,7 +113,7 @@ and to print verbose messages about its progress to standard error output.
 .BR \-e , " \-\-evenparity"
 Set the parity of the serial line to even.
 .TP
-.BR -i , " --iflag " [ \- ] \fIvalue\fR...
+.BR \-i , " \-\-iflag " [ \- ] \fIvalue\fR...
 Set the specified bits in the c_iflag word of the serial line.
 The given \fIvalue\fP may be a number or a symbolic name.
 If \fIvalue\fP is prefixed by a minus sign, the specified bits are cleared
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index a14e7cb33..4cf548741 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -9,10 +9,10 @@ Get info:
 .B losetup
 [\fIloopdev\fP]
 .sp
-.B losetup -l
+.B losetup \-l
 .RB [ \-a ]
 .sp
-.B losetup -j
+.B losetup \-j
 .I file
 .RB [ \-o
 .IR offset ]
@@ -61,8 +61,8 @@ to detach loop devices, and to query the status of a loop device.  If only the
 \fIloopdev\fP argument is given, the status of the corresponding loop
 device is shown.  If no option is given, all loop devices are shown.
 .sp
-Note that the old output format (i.e., \fBlosetup -a\fR) with comma-delimited
-strings is deprecated in favour of the \fB--list\fR output format.
+Note that the old output format (i.e., \fBlosetup \-a\fR) with comma-delimited
+strings is deprecated in favour of the \fB\-\-list\fR output format.
 .sp
 It's possible to create more independent loop devices for the same backing
 file.
@@ -80,7 +80,7 @@ KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .BR \-a , " \-\-all"
 Show the status of all loop devices.  Note that not all information is accessible
 for non-root users.  See also \fB\-\-list\fR.  The old output format (as printed
-without \fB--list)\fR is deprecated.
+without \fB\-\-list)\fR is deprecated.
 .TP
 .BR \-d , " \-\-detach " \fIloopdev\fR...
 Detach the file or device associated with the specified loop device(s). Note
@@ -140,7 +140,7 @@ to \fBon\fR.
 Verbose mode.
 .TP
 .BR \-l , " \-\-list"
-If a loop device or the \fB-a\fR option is specified, print the default columns
+If a loop device or the \fB\-a\fR option is specified, print the default columns
 for either the specified loop device or all loop devices; the default is to
 print info about all devices.  See also \fB\-\-output\fP, \fB\-\-noheadings\fP,
 \fB\-\-raw\fP, and \fB\-\-json\fP.
@@ -191,13 +191,13 @@ The following commands can be used as an example of using the loop device.
 .nf
 .IP
 # dd if=/dev/zero of=~/file.img bs=1024k count=10
-# losetup --find --show ~/file.img
+# losetup \-\-find \-\-show ~/file.img
 /dev/loop0
-# mkfs -t ext2 /dev/loop0
+# mkfs \-t ext2 /dev/loop0
 # mount /dev/loop0 /mnt
  ...
 # umount /dev/loop0
-# losetup --detach /dev/loop0
+# losetup \-\-detach /dev/loop0
 .fi
 .SH ENVIRONMENT
 .IP LOOPDEV_DEBUG=all
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 9abffc6fe..8f45997c2 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -104,15 +104,15 @@ Minimum megahertz value for the CPU.
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
-Include lines for online and offline CPUs in the output (default for \fB-e\fR).
-This option may only be specified together with option \fB-e\fR or \fB-p\fR.
+Include lines for online and offline CPUs in the output (default for \fB\-e\fR).
+This option may only be specified together with option \fB\-e\fR or \fB\-p\fR.
 .TP
 .BR \-B , " \-\-bytes"
 Print the sizes in bytes rather than in a human-readable format.
 .TP
 .BR \-b , " \-\-online"
-Limit the output to online CPUs (default for \fB-p\fR).
-This option may only be specified together with option \fB-e\fR or \fB-p\fR.
+Limit the output to online CPUs (default for \fB\-p\fR).
+This option may only be specified together with option \fB\-e\fR or \fB\-p\fR.
 .TP
 .BR \-C , " \-\-caches" [=\fIlist\fP]
 Display details about CPU caches.  For details about available information see \fB\-\-help\fR
@@ -123,11 +123,11 @@ are included in the command output.
 
 When specifying the \fIlist\fP argument, the string of option, equal sign (=), and
 \fIlist\fP must not contain any blanks or other whitespace.
-Examples: '\fB-C=NAME,ONE-SIZE\fP' or '\fB--caches=NAME,ONE-SIZE\fP'.
+Examples: '\fB\-C=NAME,ONE-SIZE\fP' or '\fB\-\-caches=NAME,ONE-SIZE\fP'.
 .TP
 .BR \-c , " \-\-offline"
 Limit the output to offline CPUs.
-This option may only be specified together with option \fB-e\fR or \fB-p\fR.
+This option may only be specified together with option \fB\-e\fR or \fB\-p\fR.
 .TP
 .BR \-e , " \-\-extended" [=\fIlist\fP]
 Display the CPU information in human-readable format.
@@ -137,7 +137,7 @@ are included in the command output.
 
 When specifying the \fIlist\fP argument, the string of option, equal sign (=), and
 \fIlist\fP must not contain any blanks or other whitespace.
-Examples: '\fB-e=cpu,node\fP' or '\fB--extended=cpu,node\fP'.
+Examples: '\fB\-e=cpu,node\fP' or '\fB\-\-extended=cpu,node\fP'.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
@@ -156,7 +156,7 @@ If the \fIlist\fP argument is used, cache columns are separated with a colon (:)
 
 When specifying the \fIlist\fP argument, the string of option, equal sign (=), and
 \fIlist\fP must not contain any blanks or other whitespace.
-Examples: '\fB-p=cpu,node\fP' or '\fB--parse=cpu,node\fP'.
+Examples: '\fB\-p=cpu,node\fP' or '\fB\-\-parse=cpu,node\fP'.
 .TP
 .BR \-s , " \-\-sysroot " \fIdirectory\fP
 Gather CPU data for a Linux instance other than the instance from which the
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 97ee5bddd..6a02a85bf 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -154,8 +154,8 @@ adding or removing a device can cause changes in names. This is the reason why i
 strongly recommended to use filesystem or partition identifiers like UUID or
 LABEL.
 
-The command \fBlsblk --fs\fR provides an overview of filesystems, LABELs and UUIDs
-on available block devices.  The command \fBblkid -p <device>\fR provides details about
+The command \fBlsblk \-\-fs\fR provides an overview of filesystems, LABELs and UUIDs
+on available block devices.  The command \fBblkid \-p <device>\fR provides details about
 a filesystem on the specified device.
 
 Don't forget that there is no guarantee that UUIDs and labels are really
@@ -403,7 +403,7 @@ For example:
 
 .RS
 .br
-.B mount -o bind,ro foo foo
+.B mount \-o bind,ro foo foo
 .RE
 
 This feature is not supported by the Linux kernel; it is implemented in userspace
@@ -432,14 +432,14 @@ will be read-only.
 It's also possible to change nosuid, nodev, noexec, noatime, nodiratime and
 relatime VFS entry flags by "remount,bind" operation.  The another (for example
 filesystem specific flags) are silently ignored.  It's impossible to change mount
-options recursively (for example with \fB-o rbind,ro\fR).
+options recursively (for example with \fB\-o rbind,ro\fR).
 
 .BR mount (8)
 since v2.31 ignores the \fBbind\fR flag from
 .I /etc/fstab
 on
 .B remount operation
-(if "-o remount" specified on command line). This is necessary to fully control
+(if "\-o remount" specified on command line). This is necessary to fully control
 mount options on remount by command line. In the previous versions the bind
 flag has been always applied and it was impossible to re-define mount options
 without interaction with the bind semantic. This
@@ -606,7 +606,7 @@ Don't canonicalize paths.  The mount command canonicalizes all paths
 together with the
 .B \-f
 flag for already canonicalized absolute paths.  The option is designed for mount
-helpers which call \fBmount -i\fR.  It is strongly recommended to not use this
+helpers which call \fBmount \-i\fR.  It is strongly recommended to not use this
 command-line option for normal mount operations.
 .sp
 Note that \fBmount\fR(8) does not pass this option to the
@@ -827,7 +827,7 @@ is used to indicate the filesystem type.  The filesystem types which are
 currently supported depend on the running kernel.  See
 .I /proc/filesystems
 and
-.I /lib/modules/$(uname -r)/kernel/fs
+.I /lib/modules/$(uname \-r)/kernel/fs
 for a complete list of the filesystems.  The most common are ext2, ext3, ext4,
 xfs, btrfs, vfat, sysfs, proc, nfs and cifs.
 .sp
@@ -1244,7 +1244,7 @@ mount(8) allows to use \fB\-\-all\fR to remount all already mounted filesystems
 which match a specified filter (\fB\-O\fR and \fB\-t\fR).  For example:
 .sp
 .in +4
-.B "mount \-\-all \-o remount,ro -t vfat"
+.B "mount \-\-all \-o remount,ro \-t vfat"
 .in
 .sp
 remounts all already mounted vfat filesystems in read-only mode. The each of the
@@ -1634,7 +1634,7 @@ previously pointed at one file to point at a different file,
 potentially causing data corruption.  For this reason, this
 option also mounts the filesystem readonly.
 
-To maintain backward compatibility, '-o nfs' is also accepted,
+To maintain backward compatibility, '\-o nfs' is also accepted,
 defaulting to
 .BR stale_rw .
 .TP
@@ -2144,7 +2144,7 @@ Make all files in the filesystem belong to the given user.
 uid=forget can be specified independently of (or usually in
 addition to) uid=<user> and results in UDF
 not storing uids to the media. In fact the recorded uid
-is the 32-bit overflow uid -1 as defined by the UDF standard.
+is the 32-bit overflow uid \-1 as defined by the UDF standard.
 The value is given as either <user> which is a valid user name or the corresponding
 decimal user id, or the special string "forget".
 .TP
@@ -2153,7 +2153,7 @@ Make all files in the filesystem belong to the given group.
 gid=forget can be specified independently of (or usually in
 addition to) gid=<group> and results in UDF
 not storing gids to the media. In fact the recorded gid
-is the 32-bit overflow gid -1 as defined by the UDF standard.
+is the 32-bit overflow gid \-1 as defined by the UDF standard.
 The value is given as either <group> which is a valid group name or the corresponding
 decimal group id, or the special string "forget".
 .TP
@@ -2423,7 +2423,7 @@ For example commands:
 .B mksquashfs /etc /tmp/etc.squashfs
 .B dd if=/dev/zero of=/tmp/etc.hash bs=1M count=10
 .B veritysetup format /tmp/etc.squashfs /tmp/etc.hash
-.B mount -o verity.hashdevice=/tmp/etc.hash,verity.roothash=<hash> /tmp/etc.squashfs /mnt
+.B mount \-o verity.hashdevice=/tmp/etc.hash,verity.roothash=<hash> /tmp/etc.squashfs /mnt
 .fi
 .RE
 .sp
diff --git a/sys-utils/pivot_root.8 b/sys-utils/pivot_root.8
index febedd03b..ace49dac7 100644
--- a/sys-utils/pivot_root.8
+++ b/sys-utils/pivot_root.8
@@ -57,11 +57,11 @@ Mount the new root file system over NFS from 10.0.0.1:/my_root and run
 ifconfig lo 127.0.0.1 up   # for portmap
 # configure Ethernet or such
 portmap   # for lockd (implicitly started by mount)
-mount -o ro 10.0.0.1:/my_root /mnt
+mount \-o ro 10.0.0.1:/my_root /mnt
 killall portmap   # portmap keeps old root busy
 cd /mnt
 pivot_root . old_root
-exec chroot . sh -c 'umount /old_root; exec /sbin/init' \\
+exec chroot . sh \-c 'umount /old_root; exec /sbin/init' \\
   <dev/console >dev/console 2>&1
 .fi
 .SH "SEE ALSO"
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 86d3e2123..96cb92d44 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -26,7 +26,7 @@ The \fIlimits\fP parameter is composed of a soft and a hard value, separated
 by a colon (:), in order to modify the existing values.  If no \fIlimits\fR are
 given, \fBprlimit\fP will display the current values.  If one of the values
 is not given, then the existing one will be used.  To specify the unlimited or
-infinity limit (RLIM_INFINITY), the -1 or 'unlimited' string can be passed.
+infinity limit (RLIM_INFINITY), the \-1 or 'unlimited' string can be passed.
 
 Because of the nature of limits, the soft limit must be lower or equal to the
 high limit (also called the ceiling).  To see all available resource limits,
@@ -92,15 +92,15 @@ Timeout for real-time tasks.
 .SH EXAMPLES
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
-.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
+.IP "\fBprlimit \-\-pid 13134 \-\-rss \-\-nofile=1024:4095\fP"
 Display the limits of the RSS, and set the soft and hard limits for the number
 of open files to 1024 and 4095, respectively.
-.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
+.IP "\fBprlimit \-\-pid 13134 \-\-nproc=512:\fP"
 Modify only the soft limit for the number of processes.
-.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
+.IP "\fBprlimit \-\-pid $$ \-\-nproc=unlimited\fP"
 Set for the current process both the soft and ceiling values for the number of
 processes to unlimited.
-.IP "\fBprlimit --cpu=10 sort -u hugefile\fP"
+.IP "\fBprlimit \-\-cpu=10 sort \-u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
 .SH "SEE ALSO"
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index a37aa0a91..9aef1bfba 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -93,12 +93,12 @@ Display help text and exit.
 .SH EXAMPLES
 Browse the profiling buffer ordering by clock ticks:
 .nf
-   readprofile | sort -nr | less
+   readprofile | sort \-nr | less
 
 .fi
 Print the 20 most loaded procedures:
 .nf
-   readprofile | sort -nr +2 | head -20
+   readprofile | sort \-nr +2 | head \-20
 
 .fi
 Print only filesystem profile:
@@ -108,17 +108,17 @@ Print only filesystem profile:
 .fi
 Look at all the kernel information, with ram addresses:
 .nf
-   readprofile -av | less
+   readprofile \-av | less
 
 .fi
 Browse a `frozen' profile buffer for a non current kernel:
 .nf
-   readprofile -p ~/profile.freeze -m /zImage.map.gz
+   readprofile \-p ~/profile.freeze \-m /zImage.map.gz
 
 .fi
 Request profiling at 2kHz per CPU, and reset the profiling buffer:
 .nf
-   sudo readprofile -M 20
+   sudo readprofile \-M 20
 .fi
 .SH BUGS
 .LP
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 513d98422..44af9e065 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -81,7 +81,7 @@ Display help text and exit.
 The following command would change the priority of the processes with
 PIDs 987 and 32, plus all processes owned by the users daemon and root:
 .TP
-.B "       renice" +1 987 -u daemon root -p 32
+.B "       renice" +1 987 \-u daemon root \-p 32
 .SH NOTES
 Users other than the superuser may only alter the priority of processes they
 own.  Furthermore, an unprivileged user can only
diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index e59921476..cee9717f2 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -19,7 +19,7 @@ setarch \- change reported architecture in new program environment and/or set pe
 .B setarch
 modifies execution domains and process personality flags.
 .PP
-The execution domains currently only affects the output of \fBuname -m\fR.
+The execution domains currently only affects the output of \fBuname \-m\fR.
 For example, on an AMD64 system, running \fBsetarch i386 \fIprogram\fR
 will cause \fIprogram\fR to see i686 instead of x86_64 as the machine type.
 It also allows to set various personality options.
@@ -114,13 +114,13 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 .SH EXAMPLES
-setarch --addr-no-randomize mytestprog
+setarch \-\-addr-no-randomize mytestprog
 .br
-setarch ppc32 rpmbuild --target=ppc --rebuild foo.src.rpm
+setarch ppc32 rpmbuild \-\-target=ppc \-\-rebuild foo.src.rpm
 .br
-setarch ppc32 -v -vL3 rpmbuild --target=ppc --rebuild bar.src.rpm
+setarch ppc32 \-v \-vL3 rpmbuild \-\-target=ppc \-\-rebuild bar.src.rpm
 .br
-setarch ppc32 --32bit rpmbuild --target=ppc --rebuild foo.src.rpm
+setarch ppc32 \-\-32bit rpmbuild \-\-target=ppc \-\-rebuild foo.src.rpm
 .SH AUTHOR
 .MT sopwith@redhat.com
 Elliot Lee
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 09092efa7..7b7110381 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -142,7 +142,7 @@ and is therefore not allowed.
 .BR "\-\-pdeathsig keep" | clear | <signal>
 Keep, clear or set the parent death signal.  Some LSMs, most notably SELinux and
 AppArmor, clear the signal when the process' credentials change.  Using
-\fB--pdeathsig keep\fR will restore the parent death signal after changing
+\fB\-\-pdeathsig keep\fR will restore the parent death signal after changing
 credentials to remedy that situation.
 .TP
 .BI \-\-selinux\-label " label"
@@ -194,7 +194,7 @@ restrictions from taking effect.
 If you're looking for behaviour similar to
 .BR su (1)/ runuser "(1), or " sudo (8)
 (without the
-.B -g
+.B \-g
 option), try something like:
 .sp
 .B "    setpriv \-\-reuid=1000 \-\-regid=1000 \-\-init\-groups"
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index fc9a577b1..c8ad3bfff 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -129,7 +129,7 @@ For example:
 .RS
 .RS
 .sp
-.B "swapon -o pri=1,discard=pages,nofail /dev/sda2"
+.B "swapon \-o pri=1,discard=pages,nofail /dev/sda2"
 .sp
 .RE
 The \fIopts\fP string is evaluated last and overrides all other
@@ -147,7 +147,7 @@ for a full description of swap priorities.  Add
 to the option field of
 .I /etc/fstab
 for use with
-.BR "swapon -a" .
+.BR "swapon \-a" .
 When no priority is defined, it defaults to \-1.
 .TP
 .BR \-s , " \-\-summary"
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index 90db83491..5c927458f 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -23,7 +23,7 @@ characteristics accordingly.
 specifies the IRQ to use for the parallel port in question.  If this is set
 to something non-zero, \-t and \-c have no effect.  If your port does not use
 interrupts, this option will make printing stop.  The command
-.B tunelp -i 0
+.B tunelp \-i 0
 restores non-interrupt driven (polling) action, and your printer should work
 again.  If your parallel port does support interrupts, interrupt-driven
 printing should be somewhat faster and efficient, and will probably be
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 785393f0c..b075467d5 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -123,7 +123,7 @@ anymore.
 
 A system reboot would be expected in near future if you're going to use this
 option for network filesystem or local filesystem with submounts.  The
-recommended use-case for \fBumount -l\fR is to prevent hangs on shutdown due to
+recommended use-case for \fBumount \-l\fR is to prevent hangs on shutdown due to
 an unreachable network share where a normal umount will hang due to a downed
 server or a network partition. Remounts of the share will not be possible.
 
@@ -219,7 +219,7 @@ command independently of /etc/mtab.
 In this case the device is initialized with "autoclear" flag (see
 .BR losetup (8)
 output for more details), otherwise it's necessary to use the option \fB \-\-detach\-loop\fR
-or call \fBlosetup -d <device>\fR. The autoclear feature is supported since Linux 2.6.25.
+or call \fBlosetup \-d <device>\fR. The autoclear feature is supported since Linux 2.6.25.
 .SH EXTERNAL HELPERS
 The syntax of external unmount helpers is:
 .PP
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 9a4196743..597e6160e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -25,8 +25,8 @@ The namespaces to be unshared are indicated via options.  Unshareable namespaces
 .B mount namespace
 Mounting and unmounting filesystems will not affect the rest of the system,
 except for filesystems which are explicitly marked as
-shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
-\fBfindmnt -o+PROPAGATION\fP for the \fBshared\fP flags).
+shared (with \fBmount \-\-make-shared\fP; see \fI/proc/self/mountinfo\fP or
+\fBfindmnt \-o+PROPAGATION\fP for the \fBshared\fP flags).
 For further details, see
 .BR mount_namespaces (7)
 and the discussion of the
@@ -110,7 +110,7 @@ namespace is created by a bind mount.
 Unshare the mount namespace.  If \fIfile\fP is specified, then a persistent
 namespace is created by a bind mount.
 Note that \fIfile\fP has to be located on a filesystem with the propagation
-flag set to \fBprivate\fP.  Use the command \fBfindmnt -o+PROPAGATION\fP
+flag set to \fBprivate\fP.  Use the command \fBfindmnt \-o+PROPAGATION\fP
 when not sure about the current setting.  See also the examples below.
 .TP
 .BR \-n , " \-\-net" [ =\fIfile ]
@@ -119,8 +119,8 @@ namespace is created by a bind mount.
 .TP
 .BR \-p , " \-\-pid" [ =\fIfile ]
 Unshare the PID namespace.  If \fIfile\fP is specified then persistent
-namespace is created by a bind mount.  See also the \fB--fork\fP and
-\fB--mount-proc\fP options.
+namespace is created by a bind mount.  See also the \fB\-\-fork\fP and
+\fB\-\-mount-proc\fP options.
 .TP
 .BR \-u , " \-\-uts" [ =\fIfile ]
 Unshare the UTS namespace.  If \fIfile\fP is specified, then a persistent
@@ -139,15 +139,15 @@ Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
 running it directly.  This is useful when creating a new PID namespace.
 .TP
 .B \-\-keep\-caps
-When the \fB--user\fP option is given, ensure that capabilities granted
+When the \fB\-\-user\fP option is given, ensure that capabilities granted
 in the user namespace are preserved in the child process.
 .TP
 .BR \-\-kill\-child [ =\fIsigname ]
 When \fBunshare\fR terminates, have \fIsigname\fP be sent to the forked child process.
-Combined with \fB--pid\fR this allows for an easy and reliable killing of the entire
+Combined with \fB\-\-pid\fR this allows for an easy and reliable killing of the entire
 process tree below \fBunshare\fR.
 If not given, \fIsigname\fP defaults to \fBSIGKILL\fR.
-This option implies \fB--fork\fR.
+This option implies \fB\-\-fork\fR.
 .TP
 .BR \-\-mount\-proc [ =\fImountpoint ]
 Just before running the program, mount the proc filesystem at \fImountpoint\fP
@@ -163,12 +163,12 @@ conveniently gain capabilities needed to manage various aspects of the newly cre
 namespaces (such as configuring interfaces in the network namespace or mounting filesystems in
 the mount namespace) even when run unprivileged.  As a mere convenience feature, it does not support
 more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
-This option implies \fB--setgroups=deny\fR and \fB--user\fR.
+This option implies \fB\-\-setgroups=deny\fR and \fB\-\-user\fR.
 .TP
 .BR \-c , " \-\-map\-current\-user"
 Run the program only after the current effective user and group IDs have been mapped to
 the same UID and GID in the newly created user namespace. This option implies
-\fB--setgroups=deny\fR and \fB--user\fR.
+\fB\-\-setgroups=deny\fR and \fB\-\-user\fR.
 .TP
 .BR "\-\-propagation private" | shared | slave | unchanged
 Recursively set the mount propagation flag in the new mount namespace.  The default
@@ -220,14 +220,14 @@ files that a more privileged user made unavailable. In short the rule for proc
 and sysfs is as close to a bind mount as possible.
 .SH EXAMPLES
 .TP
-.B # unshare --fork --pid --mount-proc readlink /proc/self
+.B # unshare \-\-fork \-\-pid \-\-mount-proc readlink /proc/self
 .TQ
 1
 .br
 Establish a PID namespace, ensure we're PID 1 in it against a newly mounted
 procfs instance.
 .TP
-.B $ unshare --map-root-user --user sh -c whoami
+.B $ unshare \-\-map-root-user \-\-user sh \-c whoami
 .TQ
 root
 .br
@@ -235,9 +235,9 @@ Establish a user namespace as an unprivileged user with a root user within it.
 .TP
 .B # touch /root/uts-ns
 .TQ
-.B # unshare --uts=/root/uts-ns hostname FOO
+.B # unshare \-\-uts=/root/uts-ns hostname FOO
 .TQ
-.B # nsenter --uts=/root/uts-ns hostname
+.B # nsenter \-\-uts=/root/uts-ns hostname
 .TQ
 FOO
 .TQ
@@ -247,19 +247,19 @@ Establish a persistent UTS namespace, and modify the hostname.  The namespace
 is then entered with \fBnsenter\fR.  The namespace is destroyed by unmounting
 the bind reference.
 .TP
-.B # mount --bind /root/namespaces /root/namespaces
+.B # mount \-\-bind /root/namespaces /root/namespaces
 .TQ
-.B # mount --make-private /root/namespaces
+.B # mount \-\-make-private /root/namespaces
 .TQ
 .B # touch /root/namespaces/mnt
 .TQ
-.B # unshare --mount=/root/namespaces/mnt
+.B # unshare \-\-mount=/root/namespaces/mnt
 .br
 Establish a persistent mount namespace referenced by the bind mount
 /root/namespaces/mnt.  This example shows a portable solution, because it
 makes sure that the bind mount is created on a shared filesystem.
 .TP
-.B # unshare -pf --kill-child -- bash -c "(sleep 999 &) && sleep 1000" &
+.B # unshare \-pf \-\-kill-child \-\- bash \-c "(sleep 999 &) && sleep 1000" &
 .TQ
 .B # pid=$!
 .TQ
diff --git a/term-utils/script.1 b/term-utils/script.1
index 1b70dec5c..daf4a6ff3 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -110,7 +110,7 @@ the child process is always stored in type script file too.
 .TP
 \fB\-f\fR, \fB\-\-flush\fR
 Flush output after each write.  This is nice for telecooperation: one person
-does `mkfifo foo; script -f foo', and another can supervise real-time what is
+does `mkfifo foo; script \-f foo', and another can supervise real-time what is
 being done using `cat foo'.  Note that flush has an impact on performance, it's
 possible to use SIGUSR1 to flush logs on demand.
 .TP
@@ -228,7 +228,7 @@ by login shells only:
 .na
 .RS
 .nf
-if test -t 0 ; then
+if test \-t 0 ; then
     script
     exit
 fi
diff --git a/text-utils/column.1 b/text-utils/column.1
index fd1aaabed..237b26b36 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -46,11 +46,11 @@ utility formats its input into multiple columns.  The util support three modes:
 This is the default mode (required by backward compatibility).
 .TP
 .B rows are filled before columns
-This mode is enabled by option \fB-x, \-\-fillrows\fP
+This mode is enabled by option \fB\-x, \-\-fillrows\fP
 .TP
 .B table
 Determine the number of columns the input contains and create a table.  This
-mode is enabled by option \fB-t, \-\-table\fP and columns formatting is
+mode is enabled by option \fB\-t, \-\-table\fP and columns formatting is
 possible to modify by \fB\-\-table-*\fP options.  Use this mode if not sure.
 .PP
 Input is taken from \fIfile\fR, or otherwise from standard input.  Empty lines
@@ -66,7 +66,7 @@ Use JSON output format to print the table, the option
 \fB\-\-table\-columns\fP is required and the option \fB\-\-table\-name\fP is recommended.
 .IP "\fB\-c, \-\-output\-width\fP \fIwidth\fP"
 Output is formatted to a width specified as number of characters. The original
-name of this option is --columns; this name is deprecated since v2.30. Note that input
+name of this option is \-\-columns; this name is deprecated since v2.30. Note that input
 longer than \fIwidth\fP is not truncated by default.
 .IP "\fB\-d, \-\-table\-noheadings\fP"
 Do not print header. This option allows to use logical column names on command line, but keep the header hidden when print the table.
@@ -100,8 +100,8 @@ Print header line for each page.
 Specify columns where is possible to use multi-line cell for long text when
 necessary.
 .IP "\fB\-H, \-\-table-hide\fP \fIcolumns\fP"
-Don't print specified columns. The special placeholder '-' may be used to
-hide all unnamed columns (see --table-columns).
+Don't print specified columns. The special placeholder '\-' may be used to
+hide all unnamed columns (see \-\-table-columns).
 .IP "\fB\-O, \-\-table-order\fP \fIcolumns\fP"
 Specify columns order on output.
 .IP "\fB\-n, \-\-table-name\fP \fIname\fP"
@@ -129,19 +129,19 @@ the screen if no other information is available.
 .SH EXAMPLES
 Print fstab with header line and align number to the right:
 .EX
-\fBsed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ --table-right PASS,FREQ\fR
+\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ \-\-table-right PASS,FREQ\fR
 .EE
 .PP
 Print fstab and hide unnamed columns:
 .EX
-\fBsed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE --table-hide -\fR
+\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE \-\-table-hide \-\fR
 .EE
 .PP
 
 .PP
 Print a tree:
 .EX
-\fBecho -e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column --tree-id 1 --tree-parent 2 --tree 3\fR
+\fBecho \-e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column \-\-tree-id 1 \-\-tree-parent 2 \-\-tree 3\fR
 1  0  A
 2  1  |-AA
 4  2  | |-AAA
@@ -154,7 +154,7 @@ Version 2.23 changed the
 option to be non-greedy, for example:
 .PP
 .EX
-\fBprintf "a:b:c\\n1::3\\n" | column  -t -s ':'\fR
+\fBprintf "a:b:c\\n1::3\\n" | column \-t \-s ':'\fR
 .EE
 .PP
 Old output:
diff --git a/text-utils/more.1 b/text-utils/more.1
index 8b2407ec6..56d054df1 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -231,7 +231,7 @@ Eric Shienbrood, UC Berkeley
 .br
 Modified by Geoff Peck, UCB to add underlining, single spacing
 .br
-Modified by John Foderaro, UCB to add -c and MORE environment variable
+Modified by John Foderaro, UCB to add \-c and MORE environment variable
 .SH HISTORY
 The
 .B more
-- 
2.24.0
