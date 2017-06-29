Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdF2CJL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 22:09:11 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBWIM-1dYcdP3Hb4-00AT7d for
 <util-linux@vger.kernel.org>; Thu, 29 Jun 2017 04:09:09 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] docs: remove some old history from manpages
Date: Thu, 29 Jun 2017 04:09:06 +0200
Message-Id: <1498702148-11755-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
References: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We assume that users will have a kernel >= 2.6.0 and removel
references to earlier kernels. There are still a few ones
left.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/mkfs.cramfs.8   |  2 +-
 disk-utils/mkfs.cramfs.c   |  5 ++-
 include/pt-mbr-partnames.h |  2 +-
 include/pt-mbr.h           |  2 +-
 sys-utils/eject.1          |  6 ++--
 sys-utils/mount.8          | 88 +++++++++-------------------------------------
 sys-utils/readprofile.8    |  6 ++--
 sys-utils/swapon.8         |  2 +-
 sys-utils/umount.8         |  5 ++-
 9 files changed, 30 insertions(+), 88 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index 9701e10..31cf84b 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -62,7 +62,7 @@ This option is ignored.  Originally the \-s turned on directory entry
 sorting.
 .TP
 \fB\-z\fR
-Make explicit holes.  Use of this option will require 2.3.39 kernel, or newer.
+Make explicit holes.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 9adc289..ec83f48 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -133,12 +133,11 @@ static void __attribute__((__noreturn__)) usage(void)
 		  " -b blksize use this blocksize, must equal page size\n"
 		  " -e edition set edition number (part of fsid)\n"
 		  " -N endian  set cramfs endianness (big|little|host), default host\n"
-		  " -i file    insert a file image into the filesystem "
-		    "(requires >= 2.4.0)\n"
+		  " -i file    insert a file image into the filesystem\n"
 		  " -n name    set name of cramfs filesystem\n"
 		  " -p         pad by %d bytes for boot code\n"
 		  " -s         sort directory entries (old option, ignored)\n"
-		  " -z         make explicit holes (requires >= 2.3.39)\n"
+		  " -z         make explicit holes\n"
 		  " dirname    root of the filesystem to be compressed\n"
 		  " outfile    output file\n"),
 		program_invocation_short_name, PAD_SIZE);
diff --git a/include/pt-mbr-partnames.h b/include/pt-mbr-partnames.h
index 223fa49..c9ab626 100644
--- a/include/pt-mbr-partnames.h
+++ b/include/pt-mbr-partnames.h
@@ -100,7 +100,7 @@
 	{0xf2, N_("DOS secondary")},	/* DOS 3.3+ secondary */
 	{0xfb, N_("VMware VMFS")},
 	{0xfc, N_("VMware VMKCORE")},	/* VMware kernel dump partition */
-	{0xfd, N_("Linux raid autodetect")},/* New (2.2.x) raid partition with
+	{0xfd, N_("Linux raid autodetect")},/* Linux raid partition with
 					       autodetect using persistent
 					       superblock */
 	{0xfe, N_("LANstep")},		/* SpeedStor >1024 cyl. or LANstep */
diff --git a/include/pt-mbr.h b/include/pt-mbr.h
index 177cc74..1f265ed 100644
--- a/include/pt-mbr.h
+++ b/include/pt-mbr.h
@@ -177,7 +177,7 @@ enum {
 	MBR_DOS_SECONDARY_PARTITION	= 0xf2, /* DOS 3.3+ secondary */
 	MBR_VMWARE_VMFS_PARTITION	= 0xfb,
 	MBR_VMWARE_VMKCORE_PARTITION	= 0xfc, /* VMware kernel dump partition */
-	MBR_LINUX_RAID_PARTITION	= 0xfd, /* New (2.2.x) raid partition with autodetect using persistent superblock */
+	MBR_LINUX_RAID_PARTITION	= 0xfd, /* Linux raid partition with autodetect using persistent superblock */
 	MBR_LANSTEP_PARTITION		= 0xfe, /* SpeedStor >1024 cyl. or LANstep */
 	MBR_XENIX_BBT_PARTITION		= 0xff, /* Xenix Bad Block Table */
 };
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 13707a4..f901b23 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -37,9 +37,9 @@ enabled, the drive automatically ejects when the device is closed.
 .TP
 .BR \-c , " \-\-changerslot " \fIslot
 With this option a CD slot can be selected from an ATAPI/IDE CD-ROM changer.
-Linux 2.0 or higher is required to use this feature.  The CD-ROM drive cannot
-be in use (mounted data CD or playing a music CD) for a change request to work.
-Please also note that the first slot of the changer is referred to as 0, not 1.
+The CD-ROM drive cannot be in use (mounted data CD or playing a music CD) for
+a change request to work. Please also note that the first slot of the changer
+is referred to as 0, not 1.
 .TP
 .BR \-d , " \-\-default"
 List the default device name.
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 3bd278e..25c9b4c 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -307,8 +307,7 @@ option is similar, with the restriction that the user must be
 member of the group of the special file.
 
 .SS Bind mounts
-Since Linux 2.4.0 it is possible to remount part of the
-file hierarchy somewhere else.  The call is:
+Remount part of the file hierarchy somewhere else.  The call is:
 
 .RS
 .br
@@ -402,9 +401,9 @@ file.
 .RE
 
 .SS The move operation
-Since Linux 2.5.1 it is possible to atomically move a
+Move a
 .B mounted tree
-to another place.  The call is:
+to another place (atomically).  The call is:
 
 .RS
 .br
@@ -982,8 +981,6 @@ Permit execution of binaries.
 .TP
 .B noexec
 Do not permit direct execution of any binaries on the mounted filesystem.
-(Until recently it was possible to run binaries anyway using a command like
-/lib/ld*.so /mnt/binary.  This trick fails since Linux 2.4.25 / 2.6.0.)
 .TP
 .B group
 Allow an ordinary user to mount the filesystem if one
@@ -1555,7 +1552,7 @@ configuration.
 
 .SS "Mount options for ext2"
 The `ext2' filesystem is the standard Linux filesystem.
-Since Linux 2.5.46, for most mount options the default
+For most mount options the default
 is determined by the filesystem superblock.  Set them with
 .BR tune2fs (8).
 .TP
@@ -1652,17 +1649,9 @@ These options determine who can use the reserved blocks.
 Instead of block 1, use block
 .I n
 as superblock.  This could be useful when the filesystem has been damaged.
-(Earlier, copies of the superblock would be made every 8192 blocks: in
-block 1, 8193, 16385, \&...\& (and one got thousands of copies on
-a big filesystem).  Since version 1.08,
-.B mke2fs
-has a \-s (sparse superblock) option to reduce the number of backup
-superblocks, and since version 1.15 this is the default.  Note
-that this may mean that ext2 filesystems created by a recent
-.B mke2fs
-cannot be mounted r/w under Linux 2.0.*.)
-The block number here uses 1\ k units.  Thus, if you want to use logical
-block 32768 on a filesystem with 4\ k blocks, use "sb=131072".
+See
+.B dumpe2fs /dev/foo | grep superblock
+to list alternatively usable superblocks.
 .TP
 .BR user_xattr | nouser_xattr
 Support "user." extended attributes (or not).
@@ -1937,13 +1926,11 @@ The value is given in octal.
 Set the umask applied to directories only.
 The default is the umask of the current process.
 The value is given in octal.
-.\" Present since Linux 2.5.43.
 .TP
 .BI fmask= value
 Set the umask applied to regular files only.
 The default is the umask of the current process.
 The value is given in octal.
-.\" Present since Linux 2.5.43.
 .TP
 .BI allow_utime= value
 This option controls the permission check of mtime/atime.
@@ -1993,33 +1980,7 @@ Sets the codepage for converting to shortname characters on FAT
 and VFAT filesystems.  By default, codepage 437 is used.
 .TP
 .BI conv= mode
-The
-.I fat
-filesystem can perform CRLF<-->NL conversion (MS-DOS text format to UNIX text
-format) in the kernel.  The following conversion \fImode\fRs are available:
-.RS
-.TP
-.BR b [ inary ]
-No translation is performed.  This is the default.
-.TP
-.BR t [ ext ]
-CRLF<-->NL translation is performed on all files.
-.TP
-.BR a [ uto ]
-CRLF<-->NL translation is performed on all files that don't have a
-"well-known binary" extension.  The list of known extensions can be found at
-the beginning of
-.I fs/fat/misc.c
-(as of 2.0, the list is: exe, com, bin, app, sys, drv, ovl, ovr, obj,
-lib, dll, pif, arc, zip, lha, lzh, zoo, tar, z, arj, tz, taz, tzp, tpz,
-gz, tgz, deb, gif, bmp, tif, gl, jpg, pcx, tfm, vf, gf, pk, pxl, dvi).
-.PP
-Programs that do computed lseeks won't like in-kernel text conversion.
-Several people have had their data ruined by this translation.  Beware!
-
-For filesystems mounted in binary mode, a conversion tool
-(fromdos/todos) is available.  This option is obsolete.
-.RE
+This option is obsolete and may fail or being ignored.
 .TP
 .BI cvf_format= module
 Forces the driver to use the CVF (Compressed Volume File) module
@@ -2190,18 +2151,8 @@ Convert all files names to lower case, or leave them.
 (Default:
 .BR case=lower .)
 .TP
-.BR conv= { binary | text | auto }
-For
-.BR conv=text ,
-delete some random CRs (in particular, all followed by NL)
-when reading a file.
-For
-.BR conv=auto ,
-choose more or less at random between
-.BR conv=binary " and " conv=text .
-For
-.BR conv=binary ,
-just read what is in the file.  This is the default.
+.BI conv= mode
+This option is obsolete and may fail or being ignored.
 .TP
 .B nocheck
 Do not abort mounting when certain consistency checks fail.
@@ -2267,8 +2218,7 @@ but also apply Acorn extensions if present.
 .BI mode= value
 For non-Rock Ridge volumes, give all files the indicated mode.
 (Default: read and execute permission for everybody.)
-Since Linux 2.1.37 one no longer needs to specify the mode in
-decimal. (Octal is indicated by a leading 0.)
+Octal mode values require a leading 0.
 .TP
 .B unhide
 Also show hidden and associated files.
@@ -2280,12 +2230,8 @@ Set the block size to the indicated value.
 (Default:
 .BR block=1024 .)
 .TP
-.BR conv= { a [ uto ]| b [ inary ]| m [ text ]| t [ ext ]}
-(Default:
-.BR conv=binary .)
-Since Linux 1.3.54 this option has no effect anymore.
-(And non-binary settings used to be very dangerous,
-possibly leading to silent data corruption.)
+.BI conv= mode
+This option is obsolete and may fail or being ignored.
 .TP
 .B cruft
 If the high byte of the file length contains other garbage,
@@ -2293,10 +2239,10 @@ set this mount option to ignore the high order bits of the file length.
 This implies that a file cannot be larger than 16\ MB.
 .TP
 .BI session= x
-Select number of session on multisession CD. (Since 2.3.4.)
+Select number of session on multisession CD.
 .TP
 .BI sbsector= xxx
-Session begins from sector xxx. (Since 2.3.4.)
+Session begins from sector xxx.
 .LP
 The following options are the same as for vfat and specifying them only makes
 sense when using discs encoded using Microsoft's Joliet extensions.
@@ -2389,12 +2335,10 @@ and the current version of
 Character set to use when returning file names.
 Unlike VFAT, NTFS suppresses names that contain
 nonconvertible characters.  Deprecated.
-.\" since 2.5.11
 .TP
 .BI nls= name
 New name for the option earlier called
 .IR iocharset .
-.\" since 2.5.11
 .TP
 .B utf8
 Use UTF-8 for converting file names.
@@ -2461,7 +2405,7 @@ These options are recognized, but have no effect as far as I can see.
 
 .SS "Mount options for ramfs"
 Ramfs is a memory based filesystem.  Mount it and you have it.  Unmount it
-and it is gone.  Present since Linux 2.3.99pre4.
+and it is gone.
 There are no mount options.
 
 .SS "Mount options for reiserfs"
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index 60a7ada..9686380 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -52,9 +52,9 @@ fly.
 On some architectures it is possible to alter the frequency at which
 the kernel delivers profiling interrupts to each CPU.  This option
 allows you to set the frequency, as a multiplier of the system clock
-frequency, HZ.  This is supported on i386-SMP (2.2 and 2.4 kernel)
-and also on sparc-SMP and sparc64-SMP (2.4 kernel).  This option also
-resets the profiling buffer, and requires superuser privileges.
+frequency, HZ. Linux 2.6.16 dropped multiplier support for most systems.
+This option also resets the profiling buffer, and requires superuser
+privileges.
 .TP
 \fB\-p\fR, \fB\-\-profile\fR \fIpro-file\fR
 Specify a different profiling buffer, which by default is
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 2a9a826..3c66c81 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -152,7 +152,7 @@ When no priority is defined, it defaults to \-1.
 .TP
 .BR \-s , " \-\-summary"
 Display swap usage summary by device.  Equivalent to "cat /proc/swaps".
-Not available before Linux 2.1.25.  This output format is DEPRECATED in favour
+This output format is DEPRECATED in favour
 of \fB\-\-show\fR that provides better control on output data.
 .TP
 .BR \-\-show [ =\fIcolumn\fR ...]
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 80df50c..1e27f01 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -105,8 +105,7 @@ that were unmounted earlier with the
 option.
 .TP
 .BR \-f , " \-\-force"
-Force an unmount (in case of an unreachable NFS system).  (Requires kernel
-2.1.116 or later.)
+Force an unmount (in case of an unreachable NFS system).
 
 Note that this option does not guarantee that umount command does not hang.
 It's strongly recommended to use absolute paths without symlinks to avoid
@@ -119,7 +118,7 @@ By default such a helper program is called if it exists.
 .BR \-l , " \-\-lazy"
 Lazy unmount.  Detach the filesystem from the file hierarchy now,
 and clean up all references to this filesystem as soon as it is not busy
-anymore.  (Requires kernel 2.4.11 or later.)
+anymore.
 .TP
 .BR \-n , " \-\-no\-mtab"
 Unmount without writing in
-- 
1.8.5.6

