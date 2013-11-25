Return-Path: util-linux-owner@vger.kernel.org
Received: from [75.180.132.120] ([75.180.132.120]:56368 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753989Ab3KYPht (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Nov 2013 10:37:49 -0500
Message-ID: <52936E4C.7020605@ubuntu.com>
Date: Mon, 25 Nov 2013 10:35:40 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: mount man page cleanups
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wCkQT5oIea4Preb6CO7MplktitWTkWcjU"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wCkQT5oIea4Preb6CO7MplktitWTkWcjU
Content-Type: multipart/mixed;
 boundary="------------070507020502020806050802"

This is a multi-part message in MIME format.
--------------070507020502020806050802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Fowarding this patch submitted by Bjarni Ingi Gislason
<bjarniig@rhi.hi.is> to deb bug #674595.


--------------070507020502020806050802
Content-Type: text/plain; charset=windows-1252;
 name="mount.8.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="mount.8.diff"

--- mount.8	2012-05-24 22:28:03.000000000 +0000
+++ mount.8.new	2012-05-25 01:19:35.000000000 +0000
@@ -1,3 +1,4 @@
+'\" t
 .\" Copyright (c) 1996-2004 Andries Brouwer
 .\"
 .\" This page is somewhat derived from a page that was
@@ -323,7 +324,7 @@
 .br
 .I /olddir
 .I /newdir
-.B  none  bind
+.B none bind
 .RE
=20
 After this call the same contents is accessible in two places.
@@ -499,7 +500,7 @@
 .BR "\-o ro" .
=20
 Note that, depending on the filesystem type, state and kernel behavior, =
the
-system may still write to the device. For example, Ext3 or ext4 will rep=
lay its
+system may still write to the device. For example, ext3 or ext4 will rep=
lay its
 journal if the filesystem is dirty. To prevent this kind of write access=
, you
 may want to mount ext3 or ext4 filesystem with "ro,noload" mount options=
 or
 set the block device to read-only mode, see command
@@ -854,7 +855,7 @@
 .TP
 .B keybits
 Specifies the key size to use for an encryption algorithm. Used in conju=
nction
-with the=20
+with the
 .BR loop " and " encryption " options."
 .B nofail
 Do not report errors for this device if it does not exist.
@@ -1173,16 +1174,25 @@
 .B bsddf
 behaviour (which is the default) is to subtract the overhead blocks
 used by the ext2 filesystem and not available for file storage. Thus
-.nf
-
+.sp 1
 % mount /k -o minixdf; df /k; umount /k
-Filesystem   1024-blocks  Used Available Capacity Mounted on
-/dev/sda6      2630655   86954  2412169      3%   /k
+.TS
+tab(#);
+l2 l2 r2 l2 l2 l
+l c r c c l.
+Filesystem#1024-blocks#Used#Available#Capacity#Mounted on
+/dev/sda6#2630655#86954#2412169#3%#/k
+.TE
+.sp 1
 % mount /k -o bsddf; df /k; umount /k
-Filesystem   1024-blocks  Used Available Capacity Mounted on
-/dev/sda6      2543714      13  2412169      0%   /k
-
-.fi
+.TS
+tab(#);
+l2 l2 r2 l2 l2 l
+l c r c c l.
+Filesystem#1024-blocks#Used#Available#Capacity#Mounted on
+/dev/sda6#2543714#13#2412169#0%#/k
+.TE
+.sp 1
 (Note that this example shows that one can add command line options
 to the options given in
 .IR /etc/fstab .)
@@ -1250,8 +1260,8 @@
 that this may mean that ext2 filesystems created by a recent
 .B mke2fs
 cannot be mounted r/w under Linux 2.0.*.)
-The block number here uses 1k units. Thus, if you want to use logical
-block 32768 on a filesystem with 4k blocks, use "sb=3D131072".
+The block number here uses 1\ k units. Thus, if you want to use logical
+block 32768 on a filesystem with 4\ k blocks, use "sb=3D131072".
 .TP
 .BR user_xattr | nouser_xattr
 Support "user." extended attributes (or not).
@@ -1272,7 +1282,7 @@
 .BR journal=3Dinum
 When a journal already exists, this option is ignored. Otherwise, it
 specifies the number of the inode which will represent the ext3 filesyst=
em's
-journal file;  ext3 will create a new journal, overwriting the old conte=
nts
+journal file; ext3 will create a new journal, overwriting the old conten=
ts
 of the file whose inode number is
 .IR inum .
 .TP
@@ -1283,7 +1293,7 @@
 Specifies the journalling mode for file data.  Metadata is always journa=
led.
 To use modes other than
 .B ordered
-on the root filesystem, pass the mode to the kernel as boot parameter, e=
=2Eg.
+on the root filesystem, pass the mode to the kernel as boot parameter, e=
=2Eg.\&
 .IR rootflags=3Ddata=3Djournal .
 .RS
 .TP
@@ -1303,7 +1313,7 @@
 in files after a crash and journal recovery.
 .RE
 .TP
-.BR barrier=3D0 " / "  barrier=3D1 "
+.BR barrier=3D0 " / " barrier=3D1 "
 This enables/disables barriers.  barrier=3D0 disables it, barrier=3D1 en=
ables it.
 Write barriers enforce proper on-disk ordering of journal commits, makin=
g
 volatile disk write caches safe to use, at some performance penalty.  Th=
e ext3
@@ -1352,7 +1362,7 @@
 .BR journal=3Dupdate
 Update the ext4 filesystem's journal to the current format.
 .TP
-.BR barrier=3D0 " / "  barrier=3D1 " / " barrier " / " nobarrier
+.BR barrier=3D0 " / " barrier=3D1 " / " barrier " / " nobarrier
 This enables/disables the use of write barriers in the jbd code.  barrie=
r=3D0
 disables, barrier=3D1 enables.  This also requires an IO stack which can=
 support
 barriers, and if jbd gets an error on a barrier write, it will disable a=
gain
@@ -1394,7 +1404,7 @@
 If the time that the transactoin has been running is less than the commi=
t time,
 ext4 will try sleeping for the commit time to see if other operations wi=
ll join
 the transaction. The commit time is capped by the max_batch_time, which
-defaults to 15000us (15ms). This optimization can be turned off entirely=
 by
+defaults to 15000\ \[mc]s (15\ ms). This optimization can be turned off =
entirely by
 setting max_batch_time to 0.
 .TP
 .BI min_batch_time=3D usec
@@ -1489,7 +1499,7 @@
 .TP
 .BR r [ elaxed ]
 Upper and lower case are accepted and equivalent, long name parts are
-truncated (e.g.
+truncated (e.g.\&
 .I verylongname.foobar
 becomes
 .IR verylong.foo ),
@@ -1747,7 +1757,7 @@
 .B cruft
 If the high byte of the file length contains other garbage,
 set this mount option to ignore the high order bits of the file length.
-This implies that a file cannot be larger than 16MB.
+This implies that a file cannot be larger than 16\ MB.
 .TP
 .BI session=3D x
 Select number of session on multisession CD. (Since 2.3.4.)
@@ -1916,7 +1926,7 @@
 Instructs
 .IR mount
 to detect which hash function is in use by examining
-the filesystem being mounted,  and to write this information into
+the filesystem being mounted, and to write this information into
 the reiserfs superblock. This is only useful on the first mount of
 an old format filesystem.
 .RE
@@ -1975,7 +1985,7 @@
 .BR acl (5)
 manual page.
 .TP
-.BR barrier=3Dnone " / "  barrier=3Dflush "
+.BR barrier=3Dnone " / " barrier=3Dflush "
 This enables/disables the use of write barriers in the journaling code.
 barrier=3Dnone disables it, barrier=3Dflush enables it. Write barriers e=
nforce
 proper on-disk ordering of journal commits, making volatile disk write c=
aches
@@ -2077,8 +2087,6 @@
 online, then it is advisable to omit the mpol option from automatic
 mount options.  It can be added later, when the tmpfs is already mounted=

 on MountPoint, by 'mount -o remount,mpol=3DPolicy:NodeList MountPoint'.
-.PE
-
 .SH "Mount options for ubifs"
 UBIFS is a flash file system which works on top of UBI volumes. Note tha=
t
 .B
@@ -2340,9 +2348,9 @@
 .TP
 .BI allocsize=3D size
 Sets the buffered I/O end-of-file preallocation size when
-doing delayed allocation writeout (default size is 64KiB).
-Valid values for this option are page size (typically 4KiB)
-through to 1GiB, inclusive, in power-of-2 increments.
+doing delayed allocation writeout (default size is 64\ KiB).
+Valid values for this option are page size (typically 4\ KiB)
+through to 1\ GiB, inclusive, in power-of-2 increments.
 .TP
 .BR attr2 | noattr2
 The options enable/disable (default is enabled) an "opportunistic"
@@ -2426,8 +2434,8 @@
 Set the number of in-memory log buffers.  Valid numbers range
 from 2-8 inclusive.
 The default value is 8 buffers for filesystems with a
-blocksize of 64KiB, 4 buffers for filesystems with a blocksize
-of 32KiB, 3 buffers for filesystems with a blocksize of 16KiB
+blocksize of 64\ KiB, 4 buffers for filesystems with a blocksize
+of 32\ KiB, 3 buffers for filesystems with a blocksize of 16\ KiB
 and 2 buffers for all other configurations.  Increasing the
 number of buffers may increase performance on some workloads
 at the cost of the memory used for the additional log buffers
@@ -2436,10 +2444,10 @@
 .BI logbsize=3D value
 Set the size of each in-memory log buffer.
 Size may be specified in bytes, or in kilobytes with a "k" suffix.
-Valid sizes for version 1 and version 2 logs are 16384 (16k) and
-32768 (32k).  Valid sizes for version 2 logs also include
-65536 (64k), 131072 (128k) and 262144 (256k).
-The default value for machines with more than 32MiB of memory
+Valid sizes for version 1 and version 2 logs are 16384 (16\ k) and
+32768 (32\ k).  Valid sizes for version 2 logs also include
+65536 (64\ k), 131072 (128\ k) and 262144 (256\ k).
+The default value for machines with more than 32\ MiB of memory
 is 32768, machines with less memory use 16384 by default.
 .TP
 \fBlogdev=3D\fP\fIdevice\fP and \fBrtdev=3D\fP\fIdevice\fP
@@ -2451,7 +2459,7 @@
 Refer to
 .BR xfs (5).
 .TP
-.BI  mtpt=3D mountpoint
+.BI mtpt=3D mountpoint
 Use with the
 .B dmapi
 option. The value specified here will be
@@ -2676,7 +2684,7 @@
 may not be able to change mount parameters (all
 .IR ext2fs -specific
 parameters, except
-.BR  sb ,
+.BR sb ,
 are changeable with a remount, for example, but you can't change
 .B gid
 or
@@ -2694,7 +2702,7 @@
 and
 .IR /proc/mounts
 don't match. The first file is based only on the mount command options, =
but the
-content of the second file also depends on the kernel and others setting=
s (e.g.
+content of the second file also depends on the kernel and others setting=
s (e.g.\&
 remote NFS server. In particular case the mount command may reports unre=
liable
 information about a NFS mount point and the /proc/mounts file usually co=
ntains
 more reliable information.)

--------------070507020502020806050802--

--wCkQT5oIea4Preb6CO7MplktitWTkWcjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSk25RAAoJEJrBOlT6nu75nVcH/2bQCfmD7oX/rj8oq86iCJY7
Bn42oJNimwODIzSHwBQ4R7BBjQqMG7tjzFXmkNcz0KvZDlwZgJWMCAGdbsf0jeh7
+925eJ8+5YQQ4hzzJhYiqUq3O0YV8DikSrmqIjUIRgosDUwHO7pWu7A35yjtwZlb
kc++bxdsdl5QjwCer/HdJbZfSXT/w878YcggFSuW12DFIcyF+KiYNjxO2A6kqWqh
G2fSsXhlFjWsmeUSsnlxPDfnmOjxYTeJUlNM5CYgpZfEBte2d/Sj1VHGlXIQ31WW
BqCy8PotER4k2sh7SQeA9hn/udRwpn33ZhQvTDv3wLkDSsqIQf03lL73Kqbi2Rs=
=OrPi
-----END PGP SIGNATURE-----

--wCkQT5oIea4Preb6CO7MplktitWTkWcjU--
