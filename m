Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:49689 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbaDAR0o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Apr 2014 13:26:44 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s31HQfFj012517
	for <util-linux@vger.kernel.org>; Tue, 1 Apr 2014 17:26:41 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s31HQen8012511
	for util-linux@vger.kernel.org; Tue, 1 Apr 2014 17:26:40 GMT
Date: Tue, 1 Apr 2014 17:26:40 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount.8: Some typographical and prefix corrections to
 the manual
Message-ID: <20140401172640.GA12159@rhi.hi.is>
References: <20140331171117.GA4657@rhi.hi.is>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
In-Reply-To: <20140331171117.GA4657@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  I forgot to add the patch to the attachment.

  Additional changes to "Changes:"

  " \(em " changed to " \(en ", as the em-dash with a word space on each
side is to long (troff)

  ".na/.ad" is not used but .nf/.fi for a long command line and it is
split into two lines

  Word "illegal" is changed to "invalid"

  Word "hyphen-separated" is changed to '"hyphen-minus"-separated' as
the meaning is the code and not the glyph (on the command line) (beware
of UTF-8)

-- 
Bjarni I. Gislason

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mount.8.diff"

--- mount.8	2014-01-14 12:05:22.000000000 +0000
+++ mount.8.new	2014-04-01 14:48:55.000000000 +0000
@@ -1,6 +1,6 @@
 '\" t
 .\" Copyright (c) 1996-2004 Andries Brouwer
-.\" Copyright (C) 2006-2012 Karel Zak <kzak@redhat.com> 
+.\" Copyright (C) 2006-2012 Karel Zak <kzak@redhat.com>
 .\"
 .\" This page is somewhat derived from a page that was
 .\" (c) 1980, 1989, 1991 The Regents of the University of California
@@ -36,7 +36,8 @@ mount \- mount a filesystem
 .B mount
 .RB [ \-lhV ]
 .LP
-.BI "mount \-a
+.\" Quote used to include space between arguments
+.B "mount \-a
 .RB [ \-fFnrsvw ]
 .RB [ \-t
 .IR vfstype ]
@@ -101,14 +102,14 @@ If only directory or device is given, fo
 .RE
 then mount looks for a mountpoint and if not found then for a device in the
 /etc/fstab file. It's possible to use
-.B --target 
+.B \-\-target
 or
-.B --source
+.B \-\-source
 options to avoid ambivalent interpretation of the given argument. For example
 .RS
 
 .br
-.BI "mount --target /mountpoint"
+.BI "mount \-\-target /mountpoint"
 .br
 
 .RE
@@ -124,7 +125,7 @@ For more robust and definable output use
 mountpoint name are replaced with '?'.
 
 .TP
-.BR "mount " [ -l "] [" "-t \fItype\fP" ]
+.BR "mount " [ \-l "] [" "\-t \fItype\/\fP" ]
 lists all mounted filesystems (of type
 .IR type ).
 The option \-l adds the labels in this listing.
@@ -154,7 +155,7 @@ partition tables).
 
 Don't forget that there is no guarantee that UUIDs and labels are really
 unique, especially if you move, share or copy the device.  Use
-.BR "lsblk -o +UUID,PARTUUID"
+.B "lsblk \-o +UUID,PARTUUID"
 to verify that the UUIDs are really unique in your system.
 
 The recommended setup is to use tags (e.g. LABEL=<label>) rather than
@@ -196,7 +197,7 @@ The file
 may contain lines describing what devices are usually
 mounted where, using which options. The default location of the
 .BR fstab (5)
-file could be overridden by --fstab <path> command line option (see below for
+file could be overridden by \-\-fstab <path> command line option (see below for
 more details).
 .LP
 The command
@@ -220,9 +221,9 @@ option will make mount fork, so that the
 filesystems are mounted simultaneously.
 .LP
 When mounting a filesystem mentioned in
-.IR fstab
+.I fstab
 or
-.IR mtab,
+.IR mtab ,
 it suffices to give only the device, or only the mount point.
 
 
@@ -255,7 +256,7 @@ If you want to override mount options fr
 you have to use:
 .RS
 .sp
-.B "mount device|dir -o <options>"
+.B "mount device|dir \-o <options>"
 .sp
 .RE
 and then the mount options from command line will be appended to
@@ -274,7 +275,7 @@ and
 .I /proc/mounts
 have very similar contents. The former has somewhat
 more information, such as the mount options used,
-but is not necessarily up-to-date (cf. the
+but is not necessarily up-to-date (cf.\& the
 .B \-n
 option below). It is possible to replace
 .I /etc/mtab
@@ -329,7 +330,7 @@ The
 option is similar to the
 .B user
 option, with the restriction that the user must be the owner
-of the special file. This may be useful e.g. for
+of the special file. This may be useful e.g.\& for
 .I /dev/fd
 if a login script makes the console user owner of this device.
 The
@@ -346,13 +347,13 @@ Since Linux 2.4.0 it is possible to remo
 file hierarchy somewhere else. The call is
 .RS
 .br
-.B mount --bind
+.B mount \-\-bind
 .I olddir newdir
 .RE
 or shortoption
 .RS
 .br
-.B mount -B
+.B mount \-B
 .I olddir newdir
 .RE
 or fstab entry is:
@@ -370,7 +371,7 @@ directory, for example:
 
 .RS
 .br
-.B mount --bind
+.B mount \-\-bind
 .I foo foo
 .RE
 
@@ -380,7 +381,7 @@ a second place using
 
 .RS
 .br
-.B mount --rbind
+.B mount \-\-rbind
 .I olddir newdir
 .RE
 
@@ -388,22 +389,22 @@ or shortoption
 
 .RS
 .br
-.B mount -R
+.B mount \-R
 .I olddir newdir
 .RE
 .\" available since Linux 2.4.11.
 
 Note that the filesystem mount options will remain the same as those
-on the original mount point, and cannot be changed by passing the -o
-option along with --bind/--rbind. The mount options can be
+on the original mount point, and cannot be changed by passing the \-o
+option along with \-\-bind/\-\-rbind. The mount options can be
 changed by a separate remount command, for example:
 
 .RS
 .br
-.B mount --bind
+.B mount \-\-bind
 .I olddir newdir
 .br
-.B mount -o remount,ro
+.B mount \-o remount,ro
 .I newdir
 .RE
 
@@ -416,10 +417,10 @@ command (then mount(8) does not read /et
 
 .RS
 .br
-.B mount --bind
+.B mount \-\-bind
 .I olddir newdir
 .br
-.B mount -o remount,ro,bind
+.B mount \-o remount,ro,bind
 .I olddir newdir
 .RE
 
@@ -440,13 +441,13 @@ Since Linux 2.5.1 it is possible to atom
 to another place. The call is
 .RS
 .br
-.B mount --move
+.B mount \-\-move
 .I olddir newdir
 .RE
 or shortoption
 .RS
 .br
-.B mount -M
+.B mount \-M
 .I olddir newdir
 .RE
 This will cause the contents which previously appeared under olddir to be
@@ -457,7 +458,7 @@ has to be a mountpoint.
 
 Note that moving a mount residing under a shared mount is invalid and
 unsupported. Use
-.B findmnt -o TARGET,PROPAGATION /dir
+.B findmnt \-o TARGET,PROPAGATION /dir
 to see the current propagation flags.
 .RE
 
@@ -476,10 +477,10 @@ file in the kernel source tree.
 Supported operations:
 .RS
 .nf
-.BI "mount --make-shared " mountpoint
-.BI "mount --make-slave " mountpoint
-.BI "mount --make-private " mountpoint
-.BI "mount --make-unbindable " mountpoint
+.BI "mount \-\-make-shared " mountpoint
+.BI "mount \-\-make-slave " mountpoint
+.BI "mount \-\-make-private " mountpoint
+.BI "mount \-\-make-unbindable " mountpoint
 .fi
 .RE
 
@@ -488,17 +489,17 @@ mounts under a given mountpoint.
 
 .RS
 .nf
-.BI "mount --make-rshared " mountpoint
-.BI "mount --make-rslave " mountpoint
-.BI "mount --make-rprivate " mountpoint
-.BI "mount --make-runbindable " mountpoint
+.BI "mount \-\-make-rshared " mountpoint
+.BI "mount \-\-make-rslave " mountpoint
+.BI "mount \-\-make-rprivate " mountpoint
+.BI "mount \-\-make-runbindable " mountpoint
 .fi
 .RE
 
 .BR mount (8)
 .B does not read
 .BR fstab (5)
-when --make-* operation is requested. All necessary information has to be
+when \-\-make-* operation is requested. All necessary information has to be
 specified on command line.
 
 Note that Linux kernel does not allow to change more propagation flags by one
@@ -524,7 +525,7 @@ as mount options
 For example
 .RS
 .nf
-.BI "mount --make-private --make-unbindable /dev/sda1 /A"
+.BI "mount \-\-make-private \-\-make-unbindable /dev/sda1 /A"
 .fi
 .RE
 
@@ -532,8 +533,8 @@ is the same as
 .RS
 .nf
 .BI "mount /dev/sda1 /A"
-.BI "mount --make-private /A"
-.BI "mount --make-unbindable /A"
+.BI "mount \-\-make-private /A"
+.BI "mount \-\-make-unbindable /A"
 .fi
 .RE
 .RE
@@ -561,7 +562,7 @@ Display help text and exit.
 Verbose mode.
 .IP "\fB\-a, \-\-all\fP"
 Mount all filesystems (of the given types) mentioned in
-.IR fstab
+.I fstab
 (except for those whose line contains the
 .B noauto
 keyword).
@@ -585,30 +586,30 @@ conjunction with the
 flag to determine what the
 .B mount
 command is trying to do. It can also be used to add entries for devices
-that were mounted earlier with the -n option. The -f option checks for
+that were mounted earlier with the \-n option. The \-f option checks for
 existing record in /etc/mtab and fails when the record already
 exists (with regular non-fake mount, this check is done by kernel).
-.IP "\fB\-i, \-\-internal\-only\fP"
+.IP "\fB\-i, \-\-internal-only\fP"
 Don't call the /sbin/mount.<filesystem> helper even if it exists.
-.IP "\fB\-l, \-\-show\-labels\fP"
+.IP "\fB\-l, \-\-show-labels\fP"
 Add the labels in the mount output. Mount must have
-permission to read the disk device (e.g. be suid root) for this to work.
+permission to read the disk device (e.g.\& be suid root) for this to work.
 One can set such a label for ext2, ext3 or ext4 using the
 .BR e2label (8)
 utility, or for XFS using
 .BR xfs_admin (8),
 or for reiserfs using
 .BR reiserfstune (8).
-.IP "\fB\-n, \-\-no\-mtab\fP"
+.IP "\fB\-n, \-\-no-mtab\fP"
 Mount without writing in
 .IR /etc/mtab .
 This is necessary for example when
 .I /etc
 is on a read-only filesystem.
-.IP "\fB\-c, \-\-no\-canonicalize\fP"
-Don't canonicalize paths. The mount command canonicalizes all paths 
-(from command line or fstab) and stores canonicalized paths to the 
-.IR /etc/mtab
+.IP "\fB\-c, \-\-no-canonicalize\fP"
+Don't canonicalize paths. The mount command canonicalizes all paths
+(from command line or fstab) and stores canonicalized paths to the
+.I /etc/mtab
 file. This option can be used together with the
 .B \-f
 flag for already canonicalized absolute paths.
@@ -620,7 +621,7 @@ option. Currently it's supported by the
 If only one argument for the mount command is given then the argument might be
 interpreted as target (mountpoint) or source (device). This option allows to
 explicitly define that the argument is mount source.
-.IP "\fB\-r, \-\-read\-only\fP"
+.IP "\fB\-r, \-\-read-only\fP"
 Mount the filesystem read-only. A synonym is
 .BR "\-o ro" .
 
@@ -630,7 +631,7 @@ journal if the filesystem is dirty. To p
 may want to mount ext3 or ext4 filesystem with "ro,noload" mount options or
 set the block device to read-only mode, see command
 .BR blockdev (8).
-.IP "\fB\-w, \-\-rw, \-\-read\-write\fP"
+.IP "\fB\-w, \-\-rw, \-\-read-write\fP"
 Mount the filesystem read/write. This is the default. A synonym is
 .BR "\-o rw" .
 .IP "\fB\-L, \-\-label \fIlabel\fP"
@@ -646,7 +647,7 @@ These two options require the file
 Specifies alternative fstab file. If the \fIpath\fP is directory then the files
 in the directory are sorted by
 .BR strverscmp (3),
-files that starts with "." or without .fstab extension are ignored. The option
+files that starts with "."\& or without \&.fstab extension are ignored. The option
 can be specified more than once. This option is mostly designed for initramfs
 or chroot scripts where additional configuration is specified outside standard
 system configuration.
@@ -707,7 +708,7 @@ Note that coherent, sysv and xenix are e
 .I xenix
 and
 .I coherent
-will be removed at some point in the future \(em use
+will be removed at some point in the future \(en use
 .I sysv
 instead. Since kernel version 2.1.21 the types
 .I ext
@@ -878,7 +879,7 @@ in the system kernel. To check the curre
 in /proc/mounts.
 
 The following options apply to any filesystem that is being
-mounted (but not every filesystem actually honors them - e.g., the
+mounted (but not every filesystem actually honors them \(en e.g.\&, the
 .B sync
 option today has effect only for ext2, ext3, fat, vfat and ufs):
 
@@ -910,14 +911,14 @@ Can only be mounted explicitly (i.e., th
 .B \-a
 option will not cause the filesystem to be mounted).
 .TP
-\fBcontext=\fP\fIcontext\fP, \fBfscontext=\fP\fIcontext\fP, \fBdefcontext=\fP\fIcontext\fP and \fBrootcontext=\fP\fIcontext\fP
+\fBcontext=\fP\,\fIcontext\fP, \fBfscontext=\fP\,/\fIcontext\fP, \fBdefcontext=\fP\,/\fIcontext\fP and \fBrootcontext=\fP\,\fIcontext\fP
 The
-.BR context=
+.B context=
 option is useful when mounting filesystems that do not support
 extended attributes, such as a floppy or hard disk formatted with VFAT, or
 systems that are not normally running under SELinux, such as an ext3 formatted
 disk from a non-SELinux workstation. You can also use
-.BR context=
+.B context=
 on filesystems you do not trust, such as a floppy. It also helps in compatibility with
 xattr-supporting filesystems on earlier 2.4.<x> kernel versions. Even where
 xattrs are supported, you can save time not having to label every file by
@@ -927,7 +928,7 @@ A commonly used option for removable med
 .BR context="system_u:object_r:removable_t" .
 
 Two other options are
-.BR fscontext=
+.B fscontext=
 and
 .BR defcontext= ,
 both of which are mutually exclusive of the context option. This means you
@@ -935,7 +936,7 @@ can use fscontext and defcontext with ea
 context.
 
 The
-.BR fscontext=
+.B fscontext=
 option works for all filesystems, regardless of their xattr
 support. The fscontext option sets the overarching filesystem label to a
 specific security context. This filesystem label is separate from the
@@ -947,12 +948,12 @@ fscontext provides, in addition to suppl
 files.
 
 You can set the default security context for unlabeled files using
-.BR defcontext=
+.B defcontext=
 option. This overrides the value set for unlabeled files in the policy and requires a
 filesystem that supports xattr labeling.
 
 The
-.BR rootcontext=
+.B rootcontext=
 option allows you to explicitly label the root inode of a FS being mounted
 before that FS or inode becomes visible to userspace.  This was found to be
 useful for things like stateless linux.
@@ -970,7 +971,10 @@ For example:
 .RS
 .RS
 .sp
-.B mount -t tmpfs none /mnt \-o 'context="system_u:object_r:tmp_t:s0:c127,c456",noexec'
+.nf
+.B mount \-t tmpfs none /mnt \-o \e
+.B 'context="system_u:object_r:tmp_t:s0:c127,c456",noexec'
+.fi
 .sp
 .RE
 For more details, see
@@ -1103,22 +1107,22 @@ readonly filesystem writable. It does no
 The remount functionality follows the standard way how the mount command works
 with options from fstab. It means the mount command doesn't read fstab (or
 mtab) only when a
-.IR device
+.I device
 and
-.IR dir
+.I dir
 are fully specified.
 
-.BR "mount -o remount,rw /dev/foo /dir"
+.B "mount \-o remount,rw /dev/foo /dir"
 
 After this call all old mount options are replaced and arbitrary stuff from
 fstab is ignored, except the loop= option which is internally generated and
 maintained by the mount command.
 
-.BR "mount -o remount,rw  /dir"
+.B "mount \-o remount,rw  /dir"
 
 After this call mount reads fstab (or mtab) and merges these options with
-options from command line (
-.B -o
+options from command line (\c
+.B \-o\c
 ).
 .TP
 .B ro
@@ -1129,7 +1133,7 @@ Mount the filesystem read-write.
 .TP
 .B sync
 All I/O to the filesystem should be done synchronously. In case of media with limited number of write cycles
-(e.g. some flash drives) "sync" may cause life-cycle shortening.
+(e.g.\& some flash drives) "sync" may cause life-cycle shortening.
 .TP
 .B user
 Allow an ordinary user to mount the filesystem.
@@ -1155,13 +1159,13 @@ This option implies the options
 All options prefixed with "x-" are interpreted as comments or userspace
 applications specific options. These options are not stored to mtab file, send
 to mount.<type> helpers or
-.B mount(2)
-system call. The suggested format is x-<appname>.<option> (e.g. x-systemd.automount).
+.BR mount (2)
+system call. The suggested format is x-<appname>.<option> (e.g.\& x-systemd.automount).
 .TP
 .B x-mount.mkdir[=<mode>]
 Allow to make a target directory (mountpoint). The optional argument <mode>
 specifies the file system access mode used for
-.B mkdir (2)
+.BR mkdir (2)
 in octal notation. The default mode is 0755. This functionality is supported
 only for root users.
 
@@ -1177,17 +1181,17 @@ More info may be found in the kernel sou
 
 .SH "Mount options for adfs"
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of the files in the filesystem (default: uid=gid=0).
 .TP
-\fBownmask=\fP\fIvalue\fP and \fBothmask=\fP\fIvalue\fP
+\fBownmask=\fP\,\fIvalue\fP and \fBothmask=\fP\,\fIvalue\fP
 Set the permission mask for ADFS 'owner' permissions and 'other' permissions,
 respectively (default: 0700 and 0077, respectively).
 See also
 .IR /usr/src/linux/Documentation/filesystems/adfs.txt .
 .SH "Mount options for affs"
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of the root of the filesystem (default: uid=gid=0,
 but with option
 .B uid
@@ -1195,7 +1199,7 @@ or
 .B gid
 without specified value, the uid and gid of the current process are taken).
 .TP
-\fBsetuid=\fP\fIvalue\fP and \fBsetgid=\fP\fIvalue\fP
+\fBsetuid=\fP\,\fIvalue\fP and \fBsetgid=\fP\,\fIvalue\fP
 Set the owner and group of all files.
 .TP
 .BI mode= value
@@ -1265,7 +1269,7 @@ the number of the pseudo terminal is the
 and the pseudo terminal slave can be accessed as
 .IR /dev/pts/ <number>.
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 This sets the owner or the group of newly created PTYs to
 the specified values. When nothing is specified, they will
 be set to the UID and GID of the creating process.
@@ -1301,33 +1305,33 @@ only if CONFIG_DEVPTS_MULTIPLE_INSTANCES
 kernel configuration.
 
 To use this option effectively,
-.IR /dev/ptmx
+.I /dev/ptmx
 must be a symbolic link to
-.IR pts/ptmx.
+.I pts/ptmx.
 See
-.IR Documentation/filesystems/devpts.txt
+.I Documentation/filesystems/devpts.txt
 in the linux kernel source tree for details.
 .TP
 .BI ptmxmode= value
 
 Set the mode for the new
-.IR ptmx
+.I ptmx
 device node in the devpts filesystem.
 
 With the support for multiple instances of devpts (see
 .B newinstance
 option above), each instance has a private
-.IR ptmx
+.I ptmx
 node in the root of the devpts filesystem (typically
-.IR /dev/pts/ptmx).
+.IR /dev/pts/ptmx ).
 
 For compatibility with older versions of the kernel, the
 default mode of the new
-.IR ptmx
+.I ptmx
 node is 0000.
 .BI ptmxmode= value
 specifies a more useful mode for the
-.IR ptmx
+.I ptmx
 node and is highly recommended when the
 .B newinstance
 option is specified.
@@ -1366,7 +1370,7 @@ field the total number of blocks of the
 behaviour (which is the default) is to subtract the overhead blocks
 used by the ext2 filesystem and not available for file storage. Thus
 .sp 1
-% mount /k -o minixdf; df /k; umount /k
+% mount /k \-o minixdf; df /k; umount /k
 .TS
 tab(#);
 l2 l2 r2 l2 l2 l
@@ -1375,7 +1379,7 @@ Filesystem#1024-blocks#Used#Available#Ca
 /dev/sda6#2630655#86954#2412169#3%#/k
 .TE
 .sp 1
-% mount /k -o bsddf; df /k; umount /k
+% mount /k \-o bsddf; df /k; umount /k
 .TS
 tab(#);
 l2 l2 r2 l2 l2 l
@@ -1393,7 +1397,7 @@ to the options given in
 No checking is done at mount time. This is the default. This is fast.
 It is wise to invoke
 .BR e2fsck (8)
-every now and then, e.g. at boot time. The non-default behavior is unsupported
+every now and then, e.g.\& at boot time. The non-default behavior is unsupported
 (check=normal and check=strict options have been removed). Note that these mount options
 don't have to be supported if ext4 kernel driver is used for ext2 and ext3 filesystems.
 .TP
@@ -1411,7 +1415,7 @@ changed using
 .BR grpid | bsdgroups " and " nogrpid | sysvgroups
 These options define what group id a newly created file gets.
 When
-.BR grpid
+.B grpid
 is set, it takes the group id of the directory in which it is created;
 otherwise (the default) it takes the fsgid of the current process, unless
 the directory has the setgid bit set, in which case it takes the gid
@@ -1423,14 +1427,14 @@ The usrquota (same as quota) mount optio
 filesystem. grpquota enables group quotas support. You need the quota utilities
 to actually enable and manage the quota system.
 .TP
-.BR nouid32
+.B nouid32
 Disables 32-bit UIDs and GIDs.  This is for interoperability with older
 kernels which only store and expect 16-bit values.
 .TP
 .BR oldalloc " or " orlov
 Use old allocator or Orlov allocator for new inodes. Orlov is default.
 .TP
-\fBresgid=\fP\fIn\fP and \fBresuid=\fP\fIn\fP
+\fBresgid=\fP\,\fIn\fP and \fBresuid=\fP\,\fIn\fP
 The ext2 filesystem reserves a certain percentage of the available
 space (by default 5%, see
 .BR mke2fs (8)
@@ -1444,7 +1448,7 @@ Instead of block 1, use block
 .I n
 as superblock. This could be useful when the filesystem has been damaged.
 (Earlier, copies of the superblock would be made every 8192 blocks: in
-block 1, 8193, 16385, ... (and one got thousands of copies on
+block 1, 8193, 16385, \&...\& (and one got thousands of copies on
 a big filesystem). Since version 1.08,
 .B mke2fs
 has a \-s (sparse superblock) option to reduce the number of backup
@@ -1468,10 +1472,10 @@ well as the following additions:
 .\" .BR abort
 .\" Mount the filesystem in abort mode, as if a fatal error has occurred.
 .TP
-.BR journal=update
+.B journal=update
 Update the ext3 filesystem's journal to the current format.
 .TP
-.BR journal=inum
+.B journal=inum
 When a journal already exists, this option is ignored. Otherwise, it
 specifies the number of the inode which will represent the ext3 filesystem's
 journal file; ext3 will create a new journal, overwriting the old contents
@@ -1509,18 +1513,18 @@ This is the default mode.  All data is f
 system prior to its metadata being committed to the journal.
 .TP
 .B writeback
-Data ordering is not preserved - data may be written into the main
+Data ordering is not preserved \(en data may be written into the main
 filesystem after its metadata has been committed to the journal.
 This is rumoured to be the highest-throughput option.  It guarantees
 internal filesystem integrity, however it can allow old data to appear
 in files after a crash and journal recovery.
 .RE
 .TP
-.BR data_err=ignore
+.B data_err=ignore
 Just print an error message if an error occurs in a file data buffer in
 ordered mode.
 .TP
-.BR data_err=abort
+.B data_err=abort
 Abort the journal if an error occurs in a file data buffer in ordered mode.
 .TP
 .BR barrier=0 " / " barrier=1 "
@@ -1536,12 +1540,12 @@ Sync all data and metadata every
 .I nrsec
 seconds. The default value is 5 seconds. Zero means default.
 .TP
-.BR user_xattr
+.B user_xattr
 Enable Extended User Attributes. See the
 .BR attr (5)
 manual page.
 .TP
-.BR acl
+.B acl
 Enable POSIX Access Control Lists. See the
 .BR acl (5)
 manual page.
@@ -1566,12 +1570,12 @@ The options
 .B usrjquota, grpjquota and jqfmt
 are backwardly compatible with ext3 or ext2.
 .TP
-.BR journal_checksum
+.B journal_checksum
 Enable checksumming of the journal transactions.  This will allow the recovery
 code in e2fsck and the kernel to detect corruption in the kernel.  It is a
 compatible change and will be ignored by older kernels.
 .TP
-.BR journal_async_commit
+.B journal_async_commit
 Commit block can be written to disk without waiting for descriptor blocks. If
 enabled older kernels cannot mount the device.
 This will enable 'journal_checksum' internally.
@@ -1599,10 +1603,10 @@ Number of filesystem blocks that mballoc
 and alignment. For RAID5/6 systems this should be the number of data disks *
 RAID chunk size in filesystem blocks.
 .TP
-.BR delalloc
+.B delalloc
 Deferring block allocation until write-out time.
 .TP
-.BR nodelalloc
+.B nodelalloc
 Disable delayed allocation. Blocks are allocated when data is copied from user
 to page cache.
 .TP
@@ -1633,7 +1637,7 @@ used for I/O operations submitted by kjo
 This defaults to 3, which is a slightly higher priority than the default I/O
 priority.
 .TP
-.BR abort
+.B abort
 Simulate the effects of calling ext4_abort() for
 debugging purposes.  This is normally used while
 remounting a filesystem which is already mounted.
@@ -1642,11 +1646,11 @@ remounting a filesystem which is already
 Many broken applications don't use fsync() when
 replacing existing files via patterns such as
 
-fd = open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo")
+fd = open("foo.new")/write(fd,...)/close(fd)/ rename("foo.new", "foo")
 
 or worse yet
 
-fd = open("foo", O_TRUNC)/write(fd,..)/close(fd).
+fd = open("foo", O_TRUNC)/write(fd,...)/close(fd).
 
 If auto_da_alloc is enabled, ext4 will detect the replace-via-rename and
 replace-via-truncate patterns and force that any delayed allocation blocks are
@@ -1656,13 +1660,13 @@ operation is committed.  This provides r
 ext3, and avoids the "zero-length" problem that can happen when a system
 crashes before the delayed allocation blocks are forced to disk.
 .TP
-.BR noinit_itable
+.B noinit_itable
 Do not initialize any uninitialized inode table blocks in the background. This
 feature may be used by installation CD's so that the install process can
 complete as quickly as possible; the inode table initialization process would
 then be deferred until the next time the filesystem is mounted.
 .TP
-.BR init_itable=n
+.B init_itable=n
 The lazy itable init code will wait n times the number of milliseconds it took
 to zero out the previous block group's inode table. This minimizes the impact on
 system performance while the filesystem's inode table is being initialized.
@@ -1673,14 +1677,14 @@ block device when blocks are freed.  Thi
 sparse/thinly-provisioned LUNs, but it is off by default until sufficient
 testing has been done.
 .TP
-.BR nouid32
+.B nouid32
 Disables 32-bit UIDs and GIDs.  This is for
 interoperability  with  older kernels which only
 store and expect 16-bit values.
 .TP
 .BR block_validity / noblock_validity
 This options allows to enables/disables the in-kernel facility for tracking
-filesystem metadata blocks within internal data structures. This allows multi-
+filesystem metadata blocks within internal data structures. This allows multi-\c
 block allocator and other routines to quickly locate extents which might
 overlap with filesystem metadata blocks. This option is intended for debugging
 purposes and since it negatively affects the performance, it is off by default.
@@ -1694,17 +1698,17 @@ scalability on high speed storages. Howe
 journaling and dioread_nolock option will be ignored with kernel warning.
 Note that dioread_nolock code path is only used for extent-based files.
 Because of the restrictions this options comprises it is off by default
-(e.g. dioread_lock).
+(e.g.\& dioread_lock).
 .TP
-.BR max_dir_size_kb=n
+.B max_dir_size_kb=n
 This limits the size of the directories so that any attempt to expand them
 beyond the specified limit in kilobytes will cause an ENOSPC error. This is
 useful in memory-constrained environments, where a very large directory can
 cause severe performance problems or even provoke the Out Of Memory killer. (For
-example, if there is only 512mb memory available, a 176mb directory may
+example, if there is only 512\ MB memory available, a 176\ MB directory may
 seriously cramp the system's style.)
 .TP
-.BR i_version
+.B i_version
 Enable 64-bit inode version support. This option is off by default.
 
 .SH "Mount options for fat"
@@ -1720,7 +1724,7 @@ filesystems.)
 .BR blocksize= { 512 | 1024 | 2048 }
 Set blocksize (default 512). This option is obsolete.
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of all files.
 (Default: the uid and gid of the current process.)
 .TP
@@ -1754,7 +1758,7 @@ Other users can change timestamp.
 .PP
 The default is set from `dmask' option. (If the directory is writable,
 .BR utime (2)
-is also allowed. I.e. ~dmask & 022)
+is also allowed. I.e.\& \s+3~\s0dmask & 022)
 
 Normally
 .BR utime (2)
@@ -1764,7 +1768,7 @@ normal check is too inflexible. With thi
 .RE
 .TP
 .BI check= value
-Three different levels of pickyness can be chosen:
+Three different levels of pickiness can be chosen:
 .RS
 .TP
 .BR r [ elaxed ]
@@ -1871,7 +1875,7 @@ although they fail. Use with caution!
 .TP
 .B showexec
 If set, the execute permission bits of the file will be allowed only if
-the extension part of the name is .EXE, .COM, or .BAT. Not set by default.
+the extension part of the name is \&.EXE, \&.COM, or \&.BAT. Not set by default.
 .TP
 .B sys_immutable
 If set, ATTR_SYS attribute on FAT is handled as IMMUTABLE flag on Linux.
@@ -1922,7 +1926,7 @@ Don't complain about invalid mount optio
 
 .SH "Mount options for hpfs"
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of all files. (Default: the uid and gid
 of the current process.)
 .TP
@@ -1991,7 +1995,7 @@ and
 (Default:
 .BR check=strict .)
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Give all files in the filesystem the indicated user or group id,
 possibly overriding the information found in the Rock Ridge extensions.
 (Default:
@@ -2008,7 +2012,7 @@ no name translation is done. See
 .BR map=normal .)
 .B map=acorn
 is like
-.BR map=normal
+.B map=normal
 but also apply Acorn extensions if present.
 .TP
 .BI mode= value
@@ -2143,7 +2147,7 @@ New name for the option earlier called
 .IR iocharset .
 .\" since 2.5.11
 .TP
-.BR utf8
+.B utf8
 Use UTF-8 for converting file names.
 .TP
 .BR uni_xlate= { 0 | 1 | 2 }
@@ -2158,14 +2162,14 @@ If enabled (posix=1), the filesystem dis
 upper and lower case. The 8.3 alias names are presented as
 hard links instead of being suppressed. This option is obsolete.
 .TP
-\fBuid=\fP\fIvalue\fP, \fBgid=\fP\fIvalue\fP and \fBumask=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP, \fBgid=\fP\,\fIvalue\fP and \fBumask=\fP\,\fIvalue\fP
 Set the file permission on the filesystem.
 The umask value is given in octal.
 By default, the files are owned by root and not readable by somebody else.
 
 .SH "Mount options for proc"
 .TP
-\fBuid=\fP\fIvalue\fP and \fBgid=\fP\fIvalue\fP
+\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 These options are recognized, but have no effect as far as I can see.
 
 .SH "Mount options for ramfs"
@@ -2176,7 +2180,7 @@ There are no mount options.
 .SH "Mount options for reiserfs"
 Reiserfs is a journaling filesystem.
 .TP
-.BR conv
+.B conv
 Instructs version 3.6 reiserfs software to mount a version 3.5 filesystem,
 using the 3.6 format for newly created objects. This filesystem will no
 longer be compatible with reiserfs 3.5 tools.
@@ -2204,41 +2208,41 @@ unusual file-name patterns.
 .TP
 .B detect
 Instructs
-.IR mount
+.I mount
 to detect which hash function is in use by examining
 the filesystem being mounted, and to write this information into
 the reiserfs superblock. This is only useful on the first mount of
 an old format filesystem.
 .RE
 .TP
-.BR hashed_relocation
+.B hashed_relocation
 Tunes the block allocator. This may provide performance improvements
 in some situations.
 .TP
-.BR no_unhashed_relocation
+.B no_unhashed_relocation
 Tunes the block allocator. This may provide performance improvements
 in some situations.
 .TP
-.BR noborder
+.B noborder
 Disable the border allocator algorithm invented by Yury Yu. Rupasov.
 This may provide performance improvements in some situations.
 .TP
-.BR nolog
+.B nolog
 Disable journaling. This will provide slight performance improvements in
 some situations at the cost of losing reiserfs's fast recovery from crashes.
 Even with this option turned on, reiserfs still performs all journaling
 operations, save for actual writes into its journaling area.  Implementation
 of
-.IR nolog
+.I nolog
 is a work in progress.
 .TP
-.BR notail
+.B notail
 By default, reiserfs stores small files and `file tails' directly into its
 tree. This confuses some utilities such as
 .BR LILO (8).
 This option is used to disable packing of files into the tree.
 .TP
-.BR replayonly
+.B replayonly
 Replay the transactions which are in the journal, but do not actually
 mount the filesystem. Mainly used by
 .IR reiserfsck .
@@ -2255,12 +2259,12 @@ There is a special
 utility which can be obtained from
 .IR ftp://ftp.namesys.com/pub/reiserfsprogs .
 .TP
-.BR user_xattr
+.B user_xattr
 Enable Extended User Attributes. See the
 .BR attr (5)
 manual page.
 .TP
-.BR acl
+.B acl
 Enable POSIX Access Control Lists. See the
 .BR acl (5)
 manual page.
@@ -2312,7 +2316,7 @@ is half of the number of your physical R
 machine with highmem) the number of lowmem RAM pages,
 whichever is the lower.
 .PP
-The tmpfs mount options for sizing (
+The tmpfs mount options for sizing (\c
 .BR size ,
 .BR nr_blocks ,
 and
@@ -2322,7 +2326,7 @@ accept a suffix
 .B m
 or
 .B g
-for Ki, Mi, Gi (binary kilo, mega and giga) and can be changed on remount.
+for Ki, Mi, Gi (binary kilo (kibi), binary mega (mebi) and binary giga (gibi)) and can be changed on remount.
 
 .TP
 .B mode=
@@ -2336,8 +2340,8 @@ The group id.
 .TP
 .B mpol=[default|prefer:Node|bind:NodeList|interleave|interleave:NodeList]
 Set the NUMA memory allocation policy for all files in that
-instance (if the kernel CONFIG_NUMA is enabled) - which can be adjusted on the
-fly via 'mount -o remount ...'
+instance (if the kernel CONFIG_NUMA is enabled) \(en which can be adjusted on the
+fly via 'mount \-o remount \&...'
 .RS
 .TP
 .B default
@@ -2356,8 +2360,8 @@ prefers to allocate from each node in tu
 allocates from each node of NodeList in turn.
 .PP
 The NodeList format is a comma-separated list of decimal numbers and ranges, a
-range being two hyphen-separated decimal numbers, the smallest and largest node
-numbers in the range.  For example, mpol=bind:0-3,5,7,9-15
+range being two "hyphen-minus"-separated decimal numbers, the smallest and largest node
+numbers in the range.  For example, mpol=bind:0\(en3,5,7,9\(en15
 
 Note that trying to mount a tmpfs with an mpol option will fail if the
 running kernel does not support NUMA; and will fail if its nodelist
@@ -2366,7 +2370,7 @@ tmpfs being mounted, but from time to ti
 NUMA capability (perhaps a safe recovery kernel), or with fewer nodes
 online, then it is advisable to omit the mpol option from automatic
 mount options.  It can be added later, when the tmpfs is already mounted
-on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.
+on MountPoint, by 'mount \-o remount,mpol=Policy:NodeList MountPoint'.
 
 .SH "Mount options for ubifs"
 UBIFS is a flash file system which works on top of UBI volumes. Note that
@@ -2407,19 +2411,19 @@ separator may be used instead of
 .TP
 The following mount options are available:
 .TP
-.BR bulk_read
+.B bulk_read
 Enable bulk-read. VFS read-ahead is disabled because it slows down the file
 system. Bulk-Read is an internal optimization. Some flashes may read faster if
 the data are read at one go, rather than at several read requests. For
 example, OneNAND can do "read-while-load" if it reads more than one NAND page.
 .TP
-.BR no_bulk_read
+.B no_bulk_read
 Do not bulk-read. This is the default.
 .TP
-.BR chk_data_crc
+.B chk_data_crc
 Check data CRC-32 checksums. This is the default.
 .TP
-.BR no_chk_data_crc.
+.BR no_chk_data_crc .
 Do not check data CRC-32 checksums. With this option, the filesystem does not
 check CRC-32 checksum for data, but it does check it for the internal indexing
 information. This option only affects reading, not writing. CRC-32 is always
@@ -2505,7 +2509,7 @@ Old format of ufs, this is the default,
 (Don't forget to give the \-r option.)
 .TP
 .B 44bsd
-For filesystems created by a BSD-like system (NetBSD,FreeBSD,OpenBSD).
+For filesystems created by a BSD-like system (NetBSD, FreeBSD, OpenBSD).
 .TP
 .B ufs2
 Used in FreeBSD 5.x supported as read-write.
@@ -2568,7 +2572,7 @@ Translate unhandled Unicode characters t
 This lets you backup and restore filenames that are created with any
 Unicode characters. Without this option, a '?' is used when no
 translation is possible. The escape character is ':' because it is
-otherwise illegal on the vfat filesystem. The escape sequence
+otherwise invalid on the vfat filesystem. The escape sequence
 that gets used, where u is the unicode character,
 is: ':', (u & 0x3f), ((u>>6) & 0x3f), (u>>12).
 .TP
@@ -2579,7 +2583,7 @@ This option is obsolete.
 .B nonumtail
 First try to make a short name without sequence number,
 before trying
-.IR name~num.ext .
+.IR name\s+3~\s0num.ext .
 .TP
 .B utf8
 UTF8 is the filesystem safe 8-bit encoding of Unicode that is used by the
@@ -2615,15 +2619,15 @@ all upper case. This mode is the default
 
 .SH "Mount options for usbfs"
 .TP
-\fBdevuid=\fP\fIuid\fP and \fBdevgid=\fP\fIgid\fP and \fBdevmode=\fP\fImode\fP
+\fBdevuid=\fP\,\fIuid\fP and \fBdevgid=\fP\,\fIgid\fP and \fBdevmode=\fP\,\fImode\fP
 Set the owner and group and mode of the device files in the usbfs filesystem
 (default: uid=gid=0, mode=0644). The mode is given in octal.
 .TP
-\fBbusuid=\fP\fIuid\fP and \fBbusgid=\fP\fIgid\fP and \fBbusmode=\fP\fImode\fP
+\fBbusuid=\fP\,\fIuid\fP and \fBbusgid=\fP\,\fIgid\fP and \fBbusmode=\fP\,\fImode\fP
 Set the owner and group and mode of the bus directories in the usbfs
 filesystem (default: uid=gid=0, mode=0555). The mode is given in octal.
 .TP
-\fBlistuid=\fP\fIuid\fP and \fBlistgid=\fP\fIgid\fP and \fBlistmode=\fP\fImode\fP
+\fBlistuid=\fP\,\fIuid\fP and \fBlistgid=\fP\,\fIgid\fP and \fBlistmode=\fP\,\fImode\fP
 Set the owner and group and mode of the file
 .I devices
 (default: uid=gid=0, mode=0444). The mode is given in octal.
@@ -2633,7 +2637,7 @@ None.
 
 .SH "Mount options for xfs"
 .TP
-.BR allocsize=size
+.B allocsize=size
 Sets the buffered I/O end-of-file preallocation size when
 doing delayed allocation writeout (default size is 64\ KiB).
 Valid values for this option are page size (typically 4\ KiB)
@@ -2688,7 +2692,7 @@ setgid bit set, in which case it takes t
 parent directory, and also gets the setgid bit set if it is
 a directory itself.
 .TP
-.BR filestreams
+.B filestreams
 Make the data allocator use the filestreams allocation mode
 across the entire filesystem rather than just on directories
 configured to use it.
@@ -2707,7 +2711,7 @@ numbers with more than 32 bits of signif
 When inode64 is specified, it indicates that XFS is allowed
 to create inodes at any location in the filesystem,
 including those which will result in inode numbers occupying
-more than 32 bits of significance. 
+more than 32 bits of significance.
 .sp
 inode32 is provided for backwards compatibility with older
 systems and applications, since 64 bits inode numbers might
@@ -2730,9 +2734,9 @@ specified but does specify an "allocsize
 (in bytes) will be returned instead. Otherwise the behaviour
 is the same as if "nolargeio" was specified.
 .TP
-.BR logbufs=value
+.B logbufs=value
 Set the number of in-memory log buffers.  Valid numbers
-range from 2-8 inclusive.
+range from 2\(en8 inclusive.
 .sp
 The default value is 8 buffers.
 .sp
@@ -2742,12 +2746,12 @@ on metadata intensive workloads. The log
 controls the size of each buffer and so is also relevant to
 this case.
 .TP
-.BR logbsize=value
+.B logbsize=value
 Set the size of each in-memory log buffer.  The size may be
-specified in bytes, or in kilobytes with a "k" suffix.
-Valid sizes for version 1 and version 2 logs are 16384 (16\ k)
-and 32768 (32\ k).  Valid sizes for version 2 logs also
-include 65536 (64\ k), 131072 (128\ k) and 262144 (256\ k). The
+specified in bytes, or in kibibytes (KiB) with a "k" suffix.
+Valid sizes for version 1 and version 2 logs are 16384 (value=16k)
+and 32768 (value=32k).  Valid sizes for version 2 logs also
+include 65536 (value=64k), 131072 (value=128k) and 262144 (value=256k). The
 logbsize must be an integer multiple of the log
 stripe unit configured at mkfs time.
 .sp
@@ -2761,13 +2765,13 @@ section, and a real-time section.  The r
 optional, and the log section can be separate from the data
 section or contained within it.
 .TP
-.BR noalign
+.B noalign
 Data allocations will not be aligned at stripe unit
 boundaries. This is only relevant to filesystems created
 with non-zero data alignment parameters (sunit, swidth) by
 mkfs.
 .TP
-.BR norecovery
+.B norecovery
 The filesystem will be mounted without running log recovery.
 If the filesystem was not cleanly unmounted, it is likely to
 be inconsistent when mounted in "norecovery" mode.
@@ -2775,25 +2779,25 @@ Some files or directories may not be acc
 Filesystems mounted "norecovery" must be mounted read-only or
 the mount will fail.
 .TP
-.BR nouuid
+.B nouuid
 Don't check for double mounted file systems using the file
 system uuid.  This is useful to mount LVM snapshot volumes,
 and often used in combination with "norecovery" for mounting
 read-only snapshots.
 .TP
-.BR noquota
+.B noquota
 Forcibly turns off all quota accounting and enforcement
 within the filesystem.
 .TP
-.BR uquota/usrquota/uqnoenforce/quota
+.B uquota/usrquota/uqnoenforce/quota
 User disk quota accounting enabled, and limits (optionally)
 enforced.  Refer to xfs_quota(8) for further details.
 .TP
-.BR gquota/grpquota/gqnoenforce
+.B gquota/grpquota/gqnoenforce
 Group disk quota accounting enabled and limits (optionally)
 enforced.  Refer to xfs_quota(8) for further details.
 .TP
-.BR pquota/prjquota/pqnoenforce
+.B pquota/prjquota/pqnoenforce
 Project disk quota accounting enabled and limits (optionally)
 enforced.  Refer to xfs_quota(8) for further details.
 .TP
@@ -2814,12 +2818,12 @@ after an underlying RAID device has had
 modified, such as adding a new disk to a RAID5 lun and
 reshaping it.
 .TP
-.BR swalloc
+.B swalloc
 Data allocations will be rounded up to stripe width boundaries
 when the current end of file is being extended and the file
 size is larger than the stripe width size.
 .TP
-.BR wsync
+.B wsync
 When specified, all filesystem namespace operations are
 executed synchronously. This ensures that when the namespace
 operation (create, unlink, etc) completes, the change to the
@@ -2838,7 +2842,7 @@ One further possible type is a mount via
 the command
 .RS
 .sp
-.B "mount /tmp/disk.img /mnt -t vfat -o loop=/dev/loop"
+.B "mount /tmp/disk.img /mnt \-t vfat \-o loop=/dev/loop"
 .sp
 .RE
 will set up the loop device
@@ -2854,7 +2858,7 @@ If no explicit loop device is mentioned
 will try to find some unused loop device and use that, for example
 .RS
 .sp
-.B "mount /tmp/disk.img /mnt -o loop"
+.B "mount /tmp/disk.img /mnt \-o loop"
 .sp
 .RE
 The mount command
@@ -2865,7 +2869,7 @@ not specified or the filesystem is known
 .sp
 .B "mount /tmp/disk.img /mnt"
 .sp
-.B "mount -t ext3 /tmp/disk.img /mnt"
+.B "mount \-t ext3 /tmp/disk.img /mnt"
 .sp
 .RE
 This type of mount knows about four options, namely
@@ -2883,40 +2887,40 @@ will be freed by
 independently on
 .IR /etc/mtab .
 
-You can also free a loop device by hand, using `losetup -d' or `umount -d`.
+You can also free a loop device by hand, using `losetup \-d' or `umount \-d`.
 
 .SH RETURN CODES
 .B mount
 has the following return codes (the bits can be ORed):
 .TP
-.BR 0
+.B 0
 success
 .TP
-.BR 1
+.B 1
 incorrect invocation or permissions
 .TP
-.BR 2
+.B 2
 system error (out of memory, cannot fork, no more loop devices)
 .TP
-.BR 4
+.B 4
 internal
 .B mount
 bug
 .TP
-.BR 8
+.B 8
 user interrupt
 .TP
-.BR 16
+.B 16
 problems writing or locking /etc/mtab
 .TP
-.BR 32
+.B 32
 mount failure
 .TP
-.BR 64
+.B 64
 some mount succeeded
 .RE
 
-The command mount -a returns 0 (all success), 32 (all failed) or 64 (some
+The command mount \-a returns 0 (all success), 32 (all failed) or 64 (some
 failed, some success).
 
 .SH "EXTERNAL HELPERS"
@@ -2934,7 +2938,7 @@ The syntax of external mount helpers is:
 
 where the <type> is filesystem type and \-sfnvo options have same meaning like
 standard mount options. The \-t option is used  for filesystems with subtypes
-support (for example /sbin/mount.fuse -t fuse.sshfs).
+support (for example /sbin/mount.fuse \-t fuse.sshfs).
 
 The command mount does not pass mount options
 .BR unbindable ,
@@ -2948,13 +2952,13 @@ The command mount does not pass mount op
 .BR auto ,
 .BR noauto ,
 .BR comment ,
-.BR x-*,
+.BR x-* ,
 .BR loop ,
-.BR offset
+.B offset
 and
-.BR sizelimit
+.B sizelimit
 to mount.<suffix> helpers. The all others options are
-used in comma delimited list as argument for the option -o.
+used in comma delimited list as argument for the option \-o.
 
 .SH FILES
 .TP 18n
@@ -2964,7 +2968,7 @@ filesystem table
 .I /etc/mtab
 table of mounted filesystems
 .TP
-.I /etc/mtab~
+.I /etc/mtab\s+3~\s0
 lock file
 .TP
 .I /etc/mtab.tmp
@@ -3020,19 +3024,19 @@ for the
 .IR fatfs ).
 .PP
 It is possible that files
-.IR /etc/mtab
+.I /etc/mtab
 and
-.IR /proc/mounts
+.I /proc/mounts
 don't match. The first file is based only on the mount command options, but the
 content of the second file also depends on the kernel and others settings (e.g.\&
 remote NFS server. In particular case the mount command may reports unreliable
 information about a NFS mount point and the /proc/mounts file usually contains
 more reliable information.)
 .PP
-Checking files on NFS filesystem referenced by file descriptors (i.e. the
-.BR fcntl
+Checking files on NFS filesystem referenced by file descriptors (i.e.\& the
+.B fcntl
 and
-.BR ioctl
+.B ioctl
 families of functions) may lead to inconsistent result due to the lack of
 consistency check in kernel even if noac is used.
 .PP

--gKMricLos+KVdGMg--
