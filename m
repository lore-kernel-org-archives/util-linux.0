Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:51785 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbcCIKzT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Mar 2016 05:55:19 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] mount: further improve formatting of the man page
Date: Wed,  9 Mar 2016 11:55:00 +0100
Message-Id: <1457520901-4133-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
References: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mainly by using proper subsections (so they can be indexed),
protecting some things from hyphenation, and marking with \&
periods that don't end sentences.  Tweaking some wordings too.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |  244 ++++++++++++++++++++++++++---------------------------
 1 files changed, 119 insertions(+), 125 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 8464b5c..b3c6607 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -108,8 +108,7 @@ options to avoid ambivalent interpretation of the given argument.  For example:
 .sp
 .RE
 
-.B The listing.
-.RS
+.SS Listing the mounts
 The listing mode is maintained for backward compatibility only.
 
 For more robust and customizable output use
@@ -125,10 +124,8 @@ The following command lists all mounted filesystems (of type
 .sp
 .RE
 The option \fB\-l\fR adds labels to this listing.  See below.
-.RE
 
-.B The device indication.
-.RS
+.SS Indicating the device
 Most devices are indicated by a filename (of a block special device), like
 .IR /dev/sda1 ,
 but there are other possibilities.  For example, in the case of an NFS mount,
@@ -145,7 +142,7 @@ unique, especially if you move, share or copy the device.  Use
 .B "lsblk \-o +UUID,PARTUUID"
 to verify that the UUIDs are really unique in your system.
 
-The recommended setup is to use tags (e.g. \fBLABEL=\fIlabel\fR) rather than
+The recommended setup is to use tags (e.g.\& \fBLABEL=\fIlabel\fR) rather than
 .B /dev/disk/by-{label,uuid,partuuid,partlabel}
 udev symlinks in the /etc/fstab file.  Tags are
 more readable, robust and portable.  The
@@ -173,10 +170,8 @@ can be used instead of a device specification.
 is less fortunate: the error message `none busy' from
 .B umount
 can be confusing.)
-.RE
 
-.B The /etc/fstab, /etc/mtab and /proc/mounts files.
-.RS
+.SS The files /etc/fstab, /etc/mtab and /proc/mounts
 The file
 .I /etc/fstab
 (see
@@ -259,10 +254,8 @@ are specified.  For example, to mount device
 .B "mount /dev/foo /dir"
 .sp
 .RE
-.RE
 
-.B The non-superuser mounts.
-.RS
+.SS Non-superuser mounts
 Normally, only the superuser can mount filesystems.
 However, when
 .I fstab
@@ -309,11 +302,8 @@ The
 .B group
 option is similar, with the restriction that the user must be
 member of the group of the special file.
-.RE
 
-.B The bind mounts.
-.RS
-.\" In fact since 2.3.99. At first the syntax was mount -t bind.
+.SS Bind mounts
 Since Linux 2.4.0 it is possible to remount part of the
 file hierarchy somewhere else.  The call is:
 
@@ -392,8 +382,7 @@ It's impossible to change mount options recursively
 (for example with \fB-o rbind,ro\fR).
 .RE
 
-.B The move operation.
-.RS
+.SS The move operation
 Since Linux 2.5.1 it is possible to atomically move a
 .B mounted tree
 to another place.  The call is:
@@ -417,10 +406,8 @@ Note also that moving a mount residing under a shared mount is invalid and
 unsupported.  Use
 .B findmnt \-o TARGET,PROPAGATION
 to see the current propagation flags.
-.RE
 
-.B The shared subtree operations.
-.RS
+.SS Shared subtree operations
 Since Linux 2.6.15 it is possible to mark a mount and its submounts as shared,
 private, slave or unbindable.  A shared mount provides the ability to create mirrors
 of that mount such that mounts and unmounts within any of the mirrors propagate
@@ -498,7 +485,6 @@ is the same as:
 .BI "mount \-\-make\-unbindable /foo"
 .fi
 .RE
-.RE
 
 .SH COMMAND-LINE OPTIONS
 The full set of mount options used by an invocation of
@@ -514,7 +500,7 @@ option, when present.
 
 The command \fBmount\fR does not pass all command-line options to the
 \fB/sbin/mount.\fIsuffix\fR mount helpers.  The interface between \fBmount\fR
-and the mount helpers is described below in the section EXTERNAL HELPERS.
+and the mount helpers is described below in the section \fBEXTERNAL HELPERS\fR.
 .sp
 Command-line options available for the
 .B mount
@@ -530,7 +516,7 @@ keyword).  The filesystems are mounted following their order in
 .TP
 .BR \-B , " \-\-bind"
 Remount a subtree somewhere else (so that its contents are available
-in both places).  See above.
+in both places).  See above, under \fBBind mounts\fR.
 .TP
 .BR \-c , " \-\-no\-canonicalize"
 Don't canonicalize paths.  The mount command canonicalizes all paths
@@ -585,7 +571,8 @@ or for reiserfs using
 .BR reiserfstune (8).
 .TP
 .BR \-M , " \-\-move"
-Move a subtree to some other place.  See above.
+Move a subtree to some other place.  See above, the subsection
+\fBThe move operation\fR.
 .TP
 .BR \-n , " \-\-no\-mtab"
 Mount without writing in
@@ -656,7 +643,8 @@ sections.
 .TP
 .BR \-R , " \-\-rbind"
 Remount a subtree and all possible submounts somewhere else (so that its
-contents are available in both places).  See above.
+contents are available in both places).  See above, the subsection
+\fBBind mounts\fR.
 .TP
 .BR \-r , " \-\-read\-only"
 Mount the filesystem read-only.  A synonym is
@@ -731,7 +719,7 @@ mount will try to read the file
 or, if that does not exist,
 .IR /proc/filesystems .
 All of the filesystem types listed there will be tried,
-except for those that are labeled "nodev" (e.g.,
+except for those that are labeled "nodev" (e.g.\&
 .IR devpts ,
 .I proc
 and
@@ -842,17 +830,15 @@ All I/O to the filesystem should be done asynchronously.  (See also the
 option.)
 .TP
 .B atime
-Do not use the noatime feature, so the inode access time is controlled by kernel
-defaults.  See also the descriptions of the
+Do not use the \fBnoatime\fR feature, so the inode access time is controlled
+by kernel defaults.  See also the descriptions of the \fB\%relatime\fR and
 .B strictatime
-and
-.B relatime
 mount options.
 .TP
 .B noatime
-Do not update inode access times on this filesystem (e.g., for faster
-access on the news spool to speed up news servers). This works for all
-inode types (directories too), so implies nodiratime.
+Do not update inode access times on this filesystem (e.g.\& for faster
+access on the news spool to speed up news servers).  This works for all
+inode types (directories too), so it implies \fB\%nodiratime\fR.
 .TP
 .B auto
 Can be mounted with the
@@ -864,7 +850,9 @@ Can only be mounted explicitly (i.e., the
 .B \-a
 option will not cause the filesystem to be mounted).
 .TP
-\fBcontext=\fP\,\fIcontext\fP, \fBfscontext=\fP\,/\fIcontext\fP, \fBdefcontext=\fP\,/\fIcontext\fP and \fBrootcontext=\fP\,\fIcontext\fP
+.na
+.BR context=\fIcontext ", " fscontext=\fIcontext ", " defcontext=\fIcontext ", and " \%rootcontext=\fIcontext
+.ad
 The
 .B context=
 option is useful when mounting filesystems that do not support
@@ -878,7 +866,7 @@ xattrs are supported, you can save time not having to label every file by
 assigning the entire disk one security context.
 
 A commonly used option for removable media is
-.BR context="system_u:object_r:removable_t" .
+.BR \%context="system_u:object_r:removable_t" .
 
 Two other options are
 .B fscontext=
@@ -926,7 +914,7 @@ For example:
 .sp
 .nf
 .B mount \-t tmpfs none /mnt \-o \e
-.B 'context="system_u:object_r:tmp_t:s0:c127,c456",noexec'
+.B \ \ 'context="system_u:object_r:tmp_t:s0:c127,c456",noexec'
 .fi
 .sp
 .RE
@@ -951,12 +939,11 @@ system.
 .TP
 .B diratime
 Update directory inode access times on this filesystem.  This is the default.
-Directory inode will not be updated when noatime is set, regardless of this
-option.
+(This option is ignored when \fBnoatime\fR is set.)
 .TP
 .B nodiratime
-Do not update directory inode access times on this filesystem. If noatime
-option is set, this option is not needed.
+Do not update directory inode access times on this filesystem.
+(This option is implied when \fBnoatime\fR is set.)
 .TP
 .B dirsync
 All directory updates within the filesystem should be done synchronously.
@@ -1003,15 +990,15 @@ Do not report errors for this device if it does not exist.
 .B relatime
 Update inode access times relative to modify or change time.  Access
 time is only updated if the previous access time was earlier than the
-current modify or change time.  (Similar to \fBnoatime\fR, but it doesn't
+current modify or change time.  (Similar to \fB\%noatime\fR, but it doesn't
 break \fBmutt\fR or other applications that need to know if a file has been
 read since the last time it was modified.)
 
 Since Linux 2.6.30, the kernel defaults to the behavior provided by this
 option (unless
-.B noatime
+.B \%noatime
 was specified), and the
-.B strictatime
+.B \%strictatime
 option is required to obtain traditional semantics.  In addition, since Linux
 2.6.30, the file's last access time is always updated if it is more than 1
 day old.
@@ -1026,9 +1013,9 @@ mount option.
 .B strictatime
 Allows to explicitly request full atime updates.  This makes it
 possible for the kernel to default to
-.B relatime
+.B \%relatime
 or
-.B noatime
+.B \%noatime
 but still allow userspace to override it.  For more details about the default
 system mount options see /proc/mounts.
 .TP
@@ -1089,25 +1076,28 @@ used to change the mount flags for a filesystem, especially to make a
 readonly filesystem writable.  It does not change device or mount point.
 
 The remount functionality follows the standard way the mount command works
-with options from fstab.  This means that the mount command only doesn't
-read fstab (or mtab) when both the
+with options from fstab.  This means that \fBmount\fR does not
+read fstab (or mtab) only when both
 .I device
 and
 .I dir
 are specified.
-
+.sp
+.in +4
 .B "mount \-o remount,rw /dev/foo /dir"
-
+.in
+.sp
 After this call all old mount options are replaced and arbitrary stuff from
 fstab (or mtab) is ignored, except the loop= option which is internally
 generated and maintained by the mount command.
-
+.sp
+.in +4
 .B "mount \-o remount,rw  /dir"
-
-After this call mount reads fstab and merges these options with
-the options from the command line (\c
-.B \-o\c
-). If no mountpoint found in fstab than remount with unspecified source is
+.in
+.sp
+After this call, mount reads fstab and merges these options with
+the options from the command line (\fB\-o\fR).
+If no mountpoint is found in fstab, then a remount with unspecified source is
 allowed.
 .TP
 .B ro
@@ -1169,7 +1159,7 @@ What options are supported depends a bit on the running kernel.
 More info may be found in the kernel source subdirectory
 .IR Documentation/filesystems .
 
-.SH "Mount options for adfs"
+.SS "Mount options for adfs"
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of the files in the filesystem (default: uid=gid=0).
@@ -1179,7 +1169,8 @@ Set the permission mask for ADFS 'owner' permissions and 'other' permissions,
 respectively (default: 0700 and 0077, respectively).
 See also
 .IR /usr/src/linux/Documentation/filesystems/adfs.txt .
-.SH "Mount options for affs"
+
+.SS "Mount options for affs"
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of the root of the filesystem (default: uid=gid=0,
@@ -1229,7 +1220,8 @@ Give blocksize.  Allowed values are 512, 1024, 2048, 4096.
 These options are accepted but ignored.
 (However, quota utilities may react to such strings in
 .IR /etc/fstab .)
-.SH "Mount options for btrfs"
+
+.SS "Mount options for btrfs"
 Btrfs is a copy-on-write filesystem for Linux aimed at
 implementing advanced features while focusing on fault tolerance,
 repair, and easy administration.
@@ -1415,15 +1407,15 @@ to the number of CPUs + 2, or 8, whichever is smaller.
 .B user_subvol_rm_allowed
 Allow subvolumes to be deleted by a non-root user.  Use with caution.
 
-.SH "Mount options for cifs"
+.SS "Mount options for cifs"
 See the options section of the
 .BR mount.cifs (8)
 man page (cifs-utils package must be installed).
 
-.SH "Mount options for coherent"
+.SS "Mount options for coherent"
 None.
 
-.SH "Mount options for debugfs"
+.SS "Mount options for debugfs"
 The debugfs filesystem is a pseudo filesystem, traditionally mounted on
 .IR /sys/kernel/debug .
 .\" or just /debug
@@ -1435,7 +1427,8 @@ Set the owner and group of the mountpoint.
 .TP
 .BI mode= value
 Sets the mode of the mountpoint.
-.SH "Mount options for devpts"
+
+.SS "Mount options for devpts"
 The devpts filesystem is a pseudo filesystem, traditionally mounted on
 .IR /dev/pts .
 In order to acquire a pseudo terminal, a process opens
@@ -1516,7 +1509,7 @@ starting with 2.6.29.  Further, this option is valid only if
 CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the kernel
 configuration.
 
-.SH "Mount options for ext2"
+.SS "Mount options for ext2"
 The `ext2' filesystem is the standard Linux filesystem.
 Since Linux 2.5.46, for most mount options the default
 is determined by the filesystem superblock.  Set them with
@@ -1631,8 +1624,7 @@ block 32768 on a filesystem with 4\ k blocks, use "sb=131072".
 Support "user." extended attributes (or not).
 .\" requires CONFIG_EXT2_FS_XATTR
 
-
-.SH "Mount options for ext3"
+.SS "Mount options for ext3"
 The ext3 filesystem is a version of the ext2 filesystem which has been
 enhanced with journaling.  It supports the same options as ext2 as
 well as the following additions:
@@ -1727,7 +1719,7 @@ usrjquota=aquota.user and grpjquota=aquota.group are required to tell the
 quota system which quota database files to use.  Journaled quotas have the
 advantage that even after a crash no quota check is required.
 
-.SH "Mount options for ext4"
+.SS "Mount options for ext4"
 The ext4 filesystem is an advanced level of the ext3 filesystem which
 incorporates scalability and reliability enhancements for supporting large
 filesystem.
@@ -1874,7 +1866,7 @@ seriously cramp the system's style.)
 .B i_version
 Enable 64-bit inode version support.  This option is off by default.
 
-.SH "Mount options for fat"
+.SS "Mount options for fat"
 (Note:
 .I fat
 is not a separate filesystem, but a common part of the
@@ -2009,7 +2001,7 @@ sparse/thinly-provisioned LUNs.
 .TP
 .B dos1xfloppy
 If set, use a fallback default BIOS Parameter Block configuration, determined
-by backing device size. These static parameters match defaults assumed by DOS
+by backing device size.  These static parameters match defaults assumed by DOS
 1.x for 160 kiB, 180 kiB, 320 kiB, and 360 kiB floppies and floppy images.
 .TP
 .BR errors= { panic | continue | remount-ro }
@@ -2030,7 +2022,7 @@ Enable this only if you want to export the FAT filesystem over NFS.
 
 .BR stale_rw :
 This option maintains an index (cache) of directory inodes which is used by the
-nfs-related code to improve look-ups. Full file operations (read/write) over
+nfs-related code to improve look-ups.  Full file operations (read/write) over
 NFS are supported but with cache eviction at NFS server, this could result in
 spurious
 .B ESTALE
@@ -2042,10 +2034,10 @@ on the on-disk location of a file in the FAT directory entry.
 This ensures that
 .B ESTALE
 will not be returned after a file is
-evicted from the inode cache. However, it means that operations
+evicted from the inode cache.  However, it means that operations
 such as rename, create and unlink could cause filehandles that
 previously pointed at one file to point at a different file,
-potentially causing data corruption. For this reason, this
+potentially causing data corruption.  For this reason, this
 option also mounts the filesystem readonly.
 
 To maintain backward compatibility, '-o nfs' is also accepted,
@@ -2065,9 +2057,9 @@ Set offset for conversion of timestamps from local time used by FAT to UTC.
 I.e.,
 .I minutes
 minutes will be subtracted from each timestamp to convert it to UTC used
-internally by Linux. This is useful when the time zone set in the kernel via
+internally by Linux.  This is useful when the time zone set in the kernel via
 .BR settimeofday (2)
-is not the time zone used by the filesystem. Note
+is not the time zone used by the filesystem.  Note
 that this option still does not provide correct time stamps in all cases in
 presence of DST - time stamps in a different DST setting will be off by one
 hour.
@@ -2079,9 +2071,9 @@ flag.  Attempts to chown or chmod files do not return errors,
 although they fail.  Use with caution!
 .TP
 .B rodir
-FAT has the ATTR_RO (read-only) attribute. On Windows, the ATTR_RO of the
+FAT has the ATTR_RO (read-only) attribute.  On Windows, the ATTR_RO of the
 directory will just be ignored, and is used only by applications as a flag
-(e.g. it's set for the customized folder).
+(e.g.\& it's set for the customized folder).
 
 If you want to use ATTR_RO as read-only flag even for the directory, set this
 option.
@@ -2110,7 +2102,7 @@ correct, by this option you can avoid scanning disk.
 Various misguided attempts to force Unix or DOS conventions
 onto a FAT filesystem.
 
-.SH "Mount options for hfs"
+.SS "Mount options for hfs"
 .TP
 .BI creator= cccc ", type=" cccc
 Set the creator/type values as shown by the MacOS finder
@@ -2137,7 +2129,7 @@ Defaults to not parsing the partition table at all.
 .B quiet
 Don't complain about invalid mount options.
 
-.SH "Mount options for hpfs"
+.SS "Mount options for hpfs"
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of all files. (Default: the uid and gid
@@ -2170,7 +2162,7 @@ just read what is in the file.  This is the default.
 .B nocheck
 Do not abort mounting when certain consistency checks fail.
 
-.SH "Mount options for iso9660"
+.SS "Mount options for iso9660"
 ISO 9660 is a standard describing a filesystem structure to be used
 on CD-ROMs. (This filesystem type is also seen on some DVDs.  See also the
 .I udf
@@ -2272,7 +2264,7 @@ to 8 bit characters.  The default is iso8859-1.
 .B utf8
 Convert 16 bit Unicode characters on CD to UTF-8.
 
-.SH "Mount options for jfs"
+.SS "Mount options for jfs"
 .TP
 .BI iocharset= name
 Character set to use for converting from Unicode to ASCII.  The default is
@@ -2310,10 +2302,10 @@ or remount the filesystem read-only, or panic and halt the system.)
 .BR noquota | quota | usrquota | grpquota
 These options are accepted but ignored.
 
-.SH "Mount options for minix"
+.SS "Mount options for minix"
 None.
 
-.SH "Mount options for msdos"
+.SS "Mount options for msdos"
 See mount options for fat.
 If the
 .I msdos
@@ -2321,7 +2313,7 @@ filesystem detects an inconsistency, it reports an error and sets the file
 system read-only.  The filesystem can be made writable again by remounting
 it.
 
-.SH "Mount options for ncpfs"
+.SS "Mount options for ncpfs"
 Just like
 .IR nfs ", the " ncpfs
 implementation expects a binary argument (a
@@ -2332,10 +2324,10 @@ and the current version of
 .B mount
 (2.12) does not know anything about ncpfs.
 
-.SH "Mount options for nfs and nfs4"
+.SS "Mount options for nfs and nfs4"
 See the options section of the
 .BR nfs (5)
-man page (nfs-utils package must be installed).
+man page (the nfs-utils package must be installed).
 
 The
 .IR nfs " and " nfs4
@@ -2347,7 +2339,7 @@ and the current version of
 .B mount
 (2.13) does not know anything about nfs and nfs4.
 
-.SH "Mount options for ntfs"
+.SS "Mount options for ntfs"
 .TP
 .BI iocharset= name
 Character set to use when returning file names.
@@ -2380,7 +2372,7 @@ Set the file permission on the filesystem.
 The umask value is given in octal.
 By default, the files are owned by root and not readable by somebody else.
 
-.SH "Mount options for overlay"
+.SS "Mount options for overlay"
 Since Linux 3.18 the overlay pseudo filesystem implements a union mount for
 other file systems.
 
@@ -2418,17 +2410,17 @@ The upperdir is normally on a writable filesystem.
 .BI workdir= directory
 The workdir needs to be an empty directory on the same filesystem as upperdir.
 
-.SH "Mount options for proc"
+.SS "Mount options for proc"
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 These options are recognized, but have no effect as far as I can see.
 
-.SH "Mount options for ramfs"
+.SS "Mount options for ramfs"
 Ramfs is a memory based filesystem.  Mount it and you have it.  Unmount it
 and it is gone.  Present since Linux 2.3.99pre4.
 There are no mount options.
 
-.SH "Mount options for reiserfs"
+.SS "Mount options for reiserfs"
 Reiserfs is a journaling filesystem.
 .TP
 .B conv
@@ -2441,7 +2433,7 @@ Choose which hash function reiserfs will use to find files within directories.
 .RS
 .TP
 .B rupasov
-A hash invented by Yury Yu. Rupasov.  It is fast and preserves locality,
+A hash invented by Yury Yu.\& Rupasov.  It is fast and preserves locality,
 mapping lexicographically close file names to close hash values.
 This option should not be used, as it causes a high probability of hash
 collisions.
@@ -2475,7 +2467,7 @@ Tunes the block allocator.  This may provide performance improvements
 in some situations.
 .TP
 .B noborder
-Disable the border allocator algorithm invented by Yury Yu. Rupasov.
+Disable the border allocator algorithm invented by Yury Yu.\& Rupasov.
 This may provide performance improvements in some situations.
 .TP
 .B nolog
@@ -2529,13 +2521,13 @@ proper on-disk ordering of journal commits, making volatile disk write caches
 safe to use, at some performance penalty.  If your disks are battery-backed in
 one way or another, disabling barriers may safely improve performance.
 
-.SH "Mount options for romfs"
+.SS "Mount options for romfs"
 None.
 
-.SH "Mount options for squashfs"
+.SS "Mount options for squashfs"
 None.
 
-.SH "Mount options for smbfs"
+.SS "Mount options for smbfs"
 Just like
 .IR nfs ", the " smbfs
 implementation expects a binary argument (a
@@ -2546,10 +2538,10 @@ and the current version of
 .B mount
 (2.12) does not know anything about smbfs.
 
-.SH "Mount options for sysv"
+.SS "Mount options for sysv"
 None.
 
-.SH "Mount options for tmpfs"
+.SS "Mount options for tmpfs"
 .TP
 .BI size= nbytes
 Override default maximum size of the filesystem.
@@ -2623,7 +2615,7 @@ online, then it is advisable to omit the mpol option from automatic
 mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount \-o remount,mpol=Policy:NodeList MountPoint'.
 
-.SH "Mount options for ubifs"
+.SS "Mount options for ubifs"
 UBIFS is a flash file system which works on top of UBI volumes.  Note that
 .B
 atime
@@ -2686,7 +2678,7 @@ still possible to read compressed files if mounted with the
 .B none
 option.
 
-.SH "Mount options for udf"
+.SS "Mount options for udf"
 udf is the "Universal Disk Format" filesystem defined by the Optical
 Storage Technology Association, and is often used for DVD-ROM.
 See also
@@ -2744,7 +2736,7 @@ Override the fileset block location. (unused)
 .B rootdir=
 Override the root directory location. (unused)
 
-.SH "Mount options for ufs"
+.SS "Mount options for ufs"
 .TP
 .BI ufstype= value
 UFS is a filesystem widely used in different operating systems.
@@ -2801,14 +2793,14 @@ These mount options don't do anything at present;
 when an error is encountered only a console message is printed.
 .RE
 
-.SH "Mount options for umsdos"
+.SS "Mount options for umsdos"
 See mount options for msdos.
 The
 .B dotsOK
 option is explicitly killed by
 .IR umsdos .
 
-.SH "Mount options for vfat"
+.SS "Mount options for vfat"
 First of all, the mount options for
 .I fat
 are recognized.
@@ -2865,8 +2857,7 @@ Display the short name as is; store a long name when the short name is not
 all upper case.  This mode is the default since Linux 2.6.32.
 .RE
 
-
-.SH "Mount options for usbfs"
+.SS "Mount options for usbfs"
 .TP
 \fBdevuid=\fP\,\fIuid\fP and \fBdevgid=\fP\,\fIgid\fP and \fBdevmode=\fP\,\fImode\fP
 Set the owner and group and mode of the device files in the usbfs filesystem
@@ -2881,13 +2872,13 @@ Set the owner and group and mode of the file
 .I devices
 (default: uid=gid=0, mode=0444).  The mode is given in octal.
 
-.SH "Mount options for xenix"
+.SS "Mount options for xenix"
 None.
 
-.SH "Mount options for xfs"
+.SS "Mount options for xfs"
 See the options section of the
 .BR xfs (5)
-man page (xfsprogs package must be installed).
+man page (the xfsprogs package must be installed).
 
 .SH "THE LOOP DEVICE"
 One further possible type is a mount via the loop device.  For example,
@@ -2978,8 +2969,8 @@ failed, some succeeded).
 
 .SH "EXTERNAL HELPERS"
 The syntax of external mount helpers is:
-
-.RS
+.sp
+.in +4
 .BI /sbin/mount. suffix
 .I spec dir
 .RB [ \-sfnv ]
@@ -2987,8 +2978,8 @@ The syntax of external mount helpers is:
 .IR options ]
 .RB [ \-t
 .IR type \fB. subtype ]
-.RE
-
+.in
+.sp
 where the \fIsuffix\fR is the filesystem type and the \fB\-sfnvo\fR options have
 the same meaning as the normal mount options.  The \fB\-t\fR option is used for
 filesystems with subtypes support (for example
@@ -3042,26 +3033,28 @@ enables libblkid debug output
 .IP LOOPDEV_DEBUG=all
 enables loop device setup debug output
 .SH "SEE ALSO"
+.na
 .BR mount (2),
 .BR umount (2),
-.BR fstab (5),
 .BR umount (8),
-.BR swapon (8),
+.BR fstab (5),
 .BR findmnt (8),
 .BR nfs (5),
+.BR nfsd (8),
 .BR xfs (5),
-.BR e2label (8),
 .BR xfs_admin (8),
 .BR mountd (8),
-.BR nfsd (8),
 .BR mke2fs (8),
 .BR tune2fs (8),
+.BR e2label (8),
+.BR swapon (8),
 .BR losetup (8)
+.ad
 .SH BUGS
 It is possible for a corrupted filesystem to cause a crash.
 .PP
 Some Linux filesystems don't support
-.B "\-o sync and \-o dirsync"
+.BR "\-o sync " nor " \-o dirsync"
 (the ext2, ext3, fat and vfat filesystems
 .I do
 support synchronous updates (a la BSD) when mounted with the
@@ -3081,25 +3074,26 @@ or
 for the
 .IR fatfs ).
 .PP
-It is possible that files
+It is possible that the files
 .I /etc/mtab
 and
 .I /proc/mounts
-don't match on systems with regular mtab file. The first file is based only on
+don't match on systems with a regular mtab file.  The first file is based only on
 the mount command options, but the content of the second file also depends on
-the kernel and others settings (e.g.\& remote NFS server.  In particular case
-the mount command may reports unreliable information about a NFS mount point
-and the /proc/mounts file usually contains more reliable information.) This is
-another reason to replace mtab file with symlink to the
+the kernel and others settings (e.g.\& on a remote NFS server -- in certain cases
+the mount command may report unreliable information about an NFS mount point
+and the /proc/mounts file usually contains more reliable information.)  This is
+another reason to replace the mtab file with a symlink to the
 .I /proc/mounts
 file.
 .PP
-Checking files on NFS filesystem referenced by file descriptors (i.e.\& the
+Checking files on NFS filesystems referenced by file descriptors (i.e.\& the
 .B fcntl
 and
 .B ioctl
-families of functions) may lead to inconsistent result due to the lack of
-consistency check in kernel even if noac is used.
+families of functions) may lead to inconsistent results due to the lack of
+a consistency check in the kernel even if noac is used.
+.\"  What is "noac"?
 .PP
 The
 .B loop
-- 
1.7.0.4

