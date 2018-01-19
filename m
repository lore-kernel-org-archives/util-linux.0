Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:47410 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756138AbeASSpX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Jan 2018 13:45:23 -0500
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id 9C8CB335C37
        for <util-linux@vger.kernel.org>; Fri, 19 Jan 2018 18:45:21 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount(8): drop redundant filesystem-specific sections
Date: Fri, 19 Jan 2018 13:45:20 -0500
Message-Id: <20180119184520.13067-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add a new section to the top of the filesystem-specific chapter to point
people generally to the filesystem-specific man pages.  This way we can
delete all the redundant subsections that say the same thing.

These subsections are deleted because they offer no options.  Which is
the same as all the filesystems the kernel supports but this man page
doesn't explicitly list (of which there are a few).
  coherent minix ramfs romfs squashfs sysv xenix

These subsections are deleted because they simply point to the respective
<fs>(5) or mount.<fs>(8) page which we now document at the top.  Some also
discuss the syscall ABI, but that doesn't seem appropriate for this page.
  btrfs cifs ext2 ext3 ext4 nfs nfs4 proc smbfs tmpfs xfs

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/mount.8 | 335 ++----------------------------------------------------
 1 file changed, 8 insertions(+), 327 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 954a4d3858b9..8b744e36ad67 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1205,6 +1205,14 @@ only for root users.  The option is also supported as x-mount.mkdir, this notati
 is deprecated for mount.mkdir since v2.30.
 
 .SH "FILESYSTEM-SPECIFIC MOUNT OPTIONS"
+You should consult the respective man page for the filesystem first.
+If you want to know what options the ext4 filesystem supports, then check the
+.BR ext4 (5)
+man page.
+If that doesn't exist, you can also check the corresponding mount page like
+.BR mount.cifs (8).
+Note that you might have to install the respective userland tools.
+.sp
 The following options apply only to certain filesystems.
 We sort them by filesystem.  They all follow the
 .B \-o
@@ -1276,200 +1284,6 @@ These options are accepted but ignored.
 (However, quota utilities may react to such strings in
 .IR /etc/fstab .)
 
-.SS "Mount options for btrfs"
-Btrfs is a copy-on-write filesystem for Linux aimed at
-implementing advanced features while focusing on fault tolerance,
-repair, and easy administration.
-.TP
-.BI alloc_start= bytes
-Debugging option to force all block allocations above a certain
-byte threshold on each block device.  The value is specified in
-bytes, optionally with a K, M, or G suffix, case insensitive.
-Default is 1MB.
-.TP
-.B autodefrag
-Disable/enable auto defragmentation.
-Auto defragmentation detects small random writes into files and queues
-them up for the defrag process.  Works best for small files;
-not well-suited for large database workloads.
-.TP
-.BR check_int | check_int_data | check_int_print_mask =\fIvalue\fR
-These debugging options control the behavior of the integrity checking
-module(the BTRFS_FS_CHECK_INTEGRITY config option required).
-
-.B check_int
-enables the integrity checker module, which examines all
-block-write requests to ensure on-disk consistency, at a large
-memory and CPU cost.
-
-.B check_int_data
-includes extent data in the integrity checks, and
-implies the check_int option.
-
-.B check_int_print_mask
-takes a bitmask of BTRFSIC_PRINT_MASK_* values
-as defined in fs/btrfs/check-integrity.c, to control the integrity
-checker module behavior.
-
-See comments at the top of
-.IR fs/btrfs/check-integrity.c
-for more info.
-.TP
-.BI commit= seconds
-Set the interval of periodic commit, 30 seconds by default.  Higher
-values defer data being synced to permanent storage, with obvious
-consequences when the system crashes.  The upper bound is not forced,
-but a warning is printed if it's more than 300 seconds (5 minutes).
-.TP
-.BR compress | compress= \fItype\fR| compress-force | compress-force= \fItype\fR
-Control BTRFS file data compression.  Type may be specified as "zlib"
-"lzo" or "no" (for no compression, used for remounting).  If no type
-is specified, zlib is used.  If \fBcompress-force\fR is specified,
-all files will be compressed, whether or not they compress well.
-If compression is enabled, \fBnodatacow\fR and \fBnodatasum\fR are disabled.
-.TP
-.B degraded
-Allow mounts to continue with missing devices.  A read-write mount may
-fail with too many devices missing, for example if a stripe member
-is completely missing.
-.TP
-.BI device= devicepath
-Specify a device during mount so that ioctls on the control device
-can be avoided.  Especially useful when trying to mount a multi-device
-setup as root.  May be specified multiple times for multiple devices.
-.TP
-.B discard
-Disable/enable the discard mount option.
-The discard function issues frequent commands to let the block device
-reclaim space freed by the filesystem.
-This is useful for SSD devices, thinly provisioned
-LUNs and virtual machine images, but may have a significant
-performance impact.  (The \fBfstrim\fR command is also available to
-initiate batch trims from userspace.)
-.TP
-.B enospc_debug
-Disable/enable debugging option to be more verbose in some ENOSPC conditions.
-.TP
-.BI fatal_errors= action
-Action to take when encountering a fatal error: 
-  "bug" - BUG() on a fatal error.  This is the default.
-  "panic" - panic() on a fatal error.
-.TP
-.B flushoncommit
-The
-.B flushoncommit
-mount option forces any data dirtied by a write in a
-prior transaction to commit as part of the current commit.  This makes
-the committed state a fully consistent view of the filesystem from the
-application's perspective (i.e., it includes all completed filesystem
-operations).  This was previously the behavior only when a snapshot is
-created.
-.TP
-.B inode_cache
-Enable free inode number caching.   Defaults to off due to an overflow
-problem when the free space CRCs don't fit inside a single page.
-.TP
-.BI max_inline= bytes
-Specify the maximum amount of space, in bytes, that can be inlined in
-a metadata B-tree leaf.  The value is specified in bytes, optionally
-with a K, M, or G suffix, case insensitive.  In practice, this value
-is limited by the root sector size, with some space unavailable due
-to leaf headers.  For a 4k sectorsize, max inline data is ~3900 bytes.
-.TP
-.BI metadata_ratio= value
-Specify that 1 metadata chunk should be allocated after every
-.I value
-data chunks.  Off by default.
-.TP
-.B noacl
-Enable/disable support for Posix Access Control Lists (ACLs).  See the
-.BR acl (5)
-manual page for more information about ACLs.
-.TP
-.B nobarrier
-Enable/disable the use of block-layer write barriers.  Write barriers
-ensure that certain IOs make it through the device cache and are on
-persistent storage.  If disabled on a device with a volatile
-(non-battery-backed) write-back cache, the \fBnobarrier\fR option will
-lead to filesystem corruption on a system crash or power loss.
-.TP
-.B nodatacow
-Enable/disable data copy-on-write for newly created files.
-This option implies \fBnodatasum\fR, and disables all compression.
-.TP
-.B nodatasum
-Enable/disable data checksumming for newly created files.
-This option implies \fBdatacow\fR.
-.TP
-.B notreelog
-Enable/disable the tree logging used for fsync and O_SYNC writes.
-.TP
-.B recovery
-Enable autorecovery attempts if a bad tree root is found at mount time.
-Currently this scans a list of several previous tree roots and tries to
-use the first readable.
-.TP
-.B rescan_uuid_tree
-Force check and rebuild procedure of the UUID tree.  This should not
-normally be needed.
-.TP
-.B skip_balance
-Skip automatic resume of an interrupted balance operation after mount.
-May be resumed with "btrfs balance resume."
-.TP
-.B nospace_cache
-Disable freespace cache loading without clearing the cache.
-.TP
-.B clear_cache
-Force clearing and rebuilding of the disk space cache if something
-has gone wrong.
-.TP
-.BR ssd | nossd | ssd_spread
-Options to control ssd allocation schemes.  By default, BTRFS will
-enable or disable ssd allocation heuristics depending on whether a
-rotational or non-rotational disk is in use.  The \fBssd\fR and
-\fBnossd\fR options can override this autodetection.
-
-The \fBssd_spread\fR mount option attempts to allocate into big chunks
-of unused space, and may perform better on low-end ssds.  \fBssd_spread\fR
-implies \fBssd\fR, enabling all other ssd heuristics as well.
-.TP
-.BI subvol= path
-Mount subvolume at
-.IR path
-rather than the root subvolume.  The
-.IR path
-is relative to the top level subvolume.
-.TP
-.BI subvolid= ID
-Mount subvolume specified by an ID number rather than the root subvolume.
-This allows mounting of subvolumes which are not in the root of the mounted
-filesystem.
-You can use "btrfs subvolume list" to see subvolume ID numbers.
-.TP
-.BI subvolrootid= objectid "  \fR(deprecated)"
-Mount subvolume specified by
-.IR objectid
-rather than the root subvolume.
-This allows mounting of subvolumes which are not in the root of the mounted
-filesystem.
-You can use "btrfs subvolume show " to see the object ID for a subvolume.
-.TP
-.BI thread_pool= number
-The number of worker threads to allocate.  The default number is equal
-to the number of CPUs + 2, or 8, whichever is smaller.
-.TP
-.B user_subvol_rm_allowed
-Allow subvolumes to be deleted by a non-root user.  Use with caution.
-
-.SS "Mount options for cifs"
-See the options section of the
-.BR mount.cifs (8)
-man page (cifs-utils package must be installed).
-
-.SS "Mount options for coherent"
-None.
-
 .SS "Mount options for debugfs"
 The debugfs filesystem is a pseudo filesystem, traditionally mounted on
 .IR /sys/kernel/debug .
@@ -1564,9 +1378,6 @@ starting with 2.6.29.  Further, this option is valid only if
 CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the kernel
 configuration.
 
-.SS "Mount options for ext2, ext3 and ext4"
-See the options section of the ext2(5), ext3(5) or ext4(5) man page (the e2fsprogs package must be installed).
-
 .SS "Mount options for fat"
 (Note:
 .I fat
@@ -1960,9 +1771,6 @@ or remount the filesystem read-only, or panic and halt the system.)
 .BR noquota | quota | usrquota | grpquota
 These options are accepted but ignored.
 
-.SS "Mount options for minix"
-None.
-
 .SS "Mount options for msdos"
 See mount options for fat.
 If the
@@ -1982,21 +1790,6 @@ and the current version of
 .B mount
 (2.12) does not know anything about ncpfs.
 
-.SS "Mount options for nfs and nfs4"
-See the options section of the
-.BR nfs (5)
-man page (the nfs-utils package must be installed).
-
-The
-.IR nfs " and " nfs4
-implementation expects a binary argument (a
-.IR "struct nfs_mount_data" )
-to the mount system call.  This argument is constructed by
-.BR mount.nfs (8)
-and the current version of
-.B mount
-(2.13) does not know anything about nfs and nfs4.
-
 .SS "Mount options for ntfs"
 .TP
 .BI iocharset= name
@@ -2066,16 +1859,6 @@ The upperdir is normally on a writable filesystem.
 .BI workdir= directory
 The workdir needs to be an empty directory on the same filesystem as upperdir.
 
-.SS "Mount options for proc"
-See the options section of the
-.BR proc (5)
-man page.
-
-.SS "Mount options for ramfs"
-Ramfs is a memory based filesystem.  Mount it and you have it.  Unmount it
-and it is gone.
-There are no mount options.
-
 .SS "Mount options for reiserfs"
 Reiserfs is a journaling filesystem.
 .TP
@@ -2177,100 +1960,6 @@ proper on-disk ordering of journal commits, making volatile disk write caches
 safe to use, at some performance penalty.  If your disks are battery-backed in
 one way or another, disabling barriers may safely improve performance.
 
-.SS "Mount options for romfs"
-None.
-
-.SS "Mount options for squashfs"
-None.
-
-.SS "Mount options for smbfs"
-Just like
-.IR nfs ", the " smbfs
-implementation expects a binary argument (a
-.IR "struct smb_mount_data" )
-to the mount system call.  This argument is constructed by
-.BR smbmount (8)
-and the current version of
-.B mount
-(2.12) does not know anything about smbfs.
-
-.SS "Mount options for sysv"
-None.
-
-.SS "Mount options for tmpfs"
-.TP
-.BI size= nbytes
-Override default maximum size of the filesystem.
-The size is given in bytes, and rounded up to entire pages.
-The default is half of the memory.  The size parameter also accepts a suffix %
-to limit this tmpfs instance to that percentage of your physical RAM:
-the default, when neither size nor nr_blocks is specified, is size=50%
-.TP
-.B nr_blocks=
-The same as size, but in blocks of PAGE_CACHE_SIZE
-.TP
-.B nr_inodes=
-The maximum number of inodes for this instance.  The default
-is half of the number of your physical RAM pages, or (on a
-machine with highmem) the number of lowmem RAM pages,
-whichever is the lower.
-.PP
-The tmpfs mount options for sizing (\c
-.BR size ,
-.BR nr_blocks ,
-and
-.BR nr_inodes )
-accept a suffix
-.BR k ,
-.B m
-or
-.B g
-for Ki, Mi, Gi (binary kilo (kibi), binary mega (mebi) and binary giga (gibi)) and can be changed on remount.
-
-.TP
-.B mode=
-Set initial permissions of the root directory.
-.TP
-.B uid=
-The user id.
-.TP
-.B gid=
-The group id.
-.TP
-.B mpol=[default|prefer:Node|bind:NodeList|interleave|interleave:NodeList]
-Set the NUMA memory allocation policy for all files in that
-instance (if the kernel CONFIG_NUMA is enabled) \(en which can be adjusted on the
-fly via 'mount \-o remount \&...'
-.RS
-.TP
-.B default
-prefers to allocate memory from the local node
-.TP
-.B prefer:Node
-prefers to allocate memory from the given Node
-.TP
-.B bind:NodeList
-allocates memory only from nodes in NodeList
-.TP
-.B interleave
-prefers to allocate from each node in turn
-.TP
-.B interleave:NodeList
-allocates from each node of NodeList in turn.
-.PP
-The NodeList format is a comma-separated list of decimal numbers and ranges, a
-range being two "hyphen-minus"-separated decimal numbers, the smallest and largest node
-numbers in the range.  For example, mpol=bind:0\(en3,5,7,9\(en15
-
-Note that trying to mount a tmpfs with an mpol option will fail if the
-running kernel does not support NUMA; and will fail if its nodelist
-specifies a node which is not online.  If your system relies on that
-tmpfs being mounted, but from time to time runs a kernel built without
-NUMA capability (perhaps a safe recovery kernel), or with fewer nodes
-online, then it is advisable to omit the mpol option from automatic
-mount options.  It can be added later, when the tmpfs is already mounted
-on MountPoint, by 'mount \-o remount,mpol=Policy:NodeList MountPoint'.
-
 .SS "Mount options for ubifs"
 UBIFS is a flash filesystem which works on top of UBI volumes.  Note that
 \fBatime\fR is not supported and is always turned off.
@@ -2526,14 +2215,6 @@ Set the owner and group and mode of the file
 .I devices
 (default: uid=gid=0, mode=0444).  The mode is given in octal.
 
-.SS "Mount options for xenix"
-None.
-
-.SS "Mount options for xfs"
-See the options section of the
-.BR xfs (5)
-man page (the xfsprogs package must be installed).
-
 .SH "THE LOOP DEVICE"
 One further possible type is a mount via the loop device.  For example,
 the command
-- 
2.15.1

