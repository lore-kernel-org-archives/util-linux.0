Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:57160 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819AbbAKV2V (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:28:21 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] docs: remove obsolete and unneeded comments from man-page files
Date: Sun, 11 Jan 2015 22:27:56 +0100
Message-Id: <1421011678-5890-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
References: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Transform some of them into copyright lines.
Also fix three header lines and snip some trailing whitespace.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/blockdev.8    |    2 --
 disk-utils/fsck.8        |    1 -
 disk-utils/fsck.cramfs.8 |    2 +-
 disk-utils/fsck.minix.8  |    3 +--
 disk-utils/mkfs.8        |    1 -
 disk-utils/mkfs.cramfs.8 |    2 +-
 disk-utils/mkswap.8      |    1 -
 disk-utils/raw.8         |    1 -
 login-utils/nologin.8    |    3 +--
 login-utils/vipw.8       |    2 +-
 misc-utils/blkid.8       |    4 ----
 misc-utils/findfs.8      |    1 -
 misc-utils/findmnt.8     |    1 -
 misc-utils/logger.1      |    3 ---
 misc-utils/lsblk.8       |    1 -
 misc-utils/lslocks.8     |    1 -
 misc-utils/namei.1       |    3 ---
 misc-utils/uuidgen.1     |    4 ----
 misc-utils/wipefs.8      |    1 -
 schedutils/chrt.1        |    3 ---
 schedutils/taskset.1     |    3 ---
 sys-utils/blkdiscard.8   |    1 -
 sys-utils/eject.1        |    2 +-
 sys-utils/fallocate.1    |    1 -
 sys-utils/fsfreeze.8     |    2 --
 sys-utils/fstab.5        |    9 ---------
 sys-utils/fstrim.8       |    1 -
 sys-utils/lscpu.1        |    3 ---
 sys-utils/mount.8        |    3 ---
 sys-utils/mountpoint.1   |    2 --
 sys-utils/renice.1       |    2 +-
 sys-utils/setsid.1       |    1 -
 sys-utils/swapon.8       |    7 -------
 sys-utils/tunelp.8       |    5 ++---
 sys-utils/unshare.1      |    3 ---
 term-utils/setterm.1     |    6 +-----
 term-utils/wall.1        |    2 --
 term-utils/write.1       |    2 --
 text-utils/hexdump.1     |    2 +-
 text-utils/more.1        |    3 +--
 text-utils/pg.1          |    2 +-
 text-utils/rev.1         |    4 +---
 text-utils/tailf.1       |   13 ++++++-------
 43 files changed, 20 insertions(+), 99 deletions(-)

diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index c46099d..7274e62 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .\" Copyright 1998 Andries E. Brouwer (aeb@cwi.nl)
 .\" Copyright 2007 Karel Zak <kzak@redhat.com>
 .\"
@@ -84,4 +83,3 @@ blockdev was written by Andries E.\& Brouwer and rewritten by Karel Zak.
 .SH AVAILABILITY
 The blockdev command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 7d522ab..c60eef2 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .\" Copyright 1993, 1994, 1995 by Theodore Ts'o.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
diff --git a/disk-utils/fsck.cramfs.8 b/disk-utils/fsck.cramfs.8
index d5b562e..3a6e1d3 100644
--- a/disk-utils/fsck.cramfs.8
+++ b/disk-utils/fsck.cramfs.8
@@ -1,4 +1,4 @@
-.TH EXAMPLE "8" "April 2013" "util-linux" "System Administration"
+.TH FSCK.CRAMFS 8 "April 2013" "util-linux" "System Administration"
 .SH NAME
 fsck.cramfs \- fsck compressed ROM file system
 .SH SYNOPSIS
diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index a8cbb26..b672ab7 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -1,7 +1,6 @@
 .\" Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be freely distributed.
-.\" " for hilit19
-.TH FSCK 8 "July 1996" "util-linux" "System Administration"
+.TH FSCK.MINIX 8 "July 1996" "util-linux" "System Administration"
 .SH NAME
 fsck.minix \- check consistency of Minix filesystem
 .SH SYNOPSIS
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 54bb004..9a5cdc0 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH MKFS 8 "June 2011" "util-linux" "System Administration"
 .SH NAME
 mkfs \- build a Linux filesystem
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index a427259..a758700 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -1,4 +1,4 @@
-.TH EXAMPLE "8" "April 2013" "util-linux" "System Administration"
+.TH MKFS.CRAMFS 8 "April 2013" "util-linux" "System Administration"
 .SH NAME
 mkfs.cramfs \- make compressed ROM file system
 .SH SYNOPSIS
diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index 562078d..0a0b715 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -1,7 +1,6 @@
 .\" Copyright 1998 Andries E. Brouwer (aeb@cwi.nl)
 .\"
 .\" May be distributed under the GNU General Public License
-.\" Rewritten for 2.1.117, aeb, 981010.
 .\"
 .TH MKSWAP 8 "March 2009" "util-linux" "System Administration"
 .SH NAME
diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
index 74c15a9..59d6b01 100644
--- a/disk-utils/raw.8
+++ b/disk-utils/raw.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH RAW 8 "August 1999" "util-linux" "System Administration"
 .SH NAME
 raw \- bind a Linux raw character device
diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index 269daf5..ce69a3a 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH NOLOGIN 8 "September 2013" "util-linux" "System Administration"
 .SH NAME
 nologin \- politely refuse a login
@@ -11,7 +10,7 @@ nologin \- politely refuse a login
 displays a message that an account is not available and exits non-zero.  It is
 intended as a replacement shell field to deny login access to an account.
 .PP
-If the file /etc/nologin.txt exists, nologin displays its contents to the 
+If the file /etc/nologin.txt exists, nologin displays its contents to the
 user instead of the default message.
 .PP
 The exit code returned by
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index ab7b76c..3ee3082 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -29,7 +29,7 @@
 .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 .\" SUCH DAMAGE.
 .\"
-.\"     from: @(#)vipw.8	6.7 (Berkeley) 3/16/91
+.\"     @(#)vipw.8	6.7 (Berkeley) 3/16/91
 .\"
 .TH VIPW "8" "September 2011" "util-linux" "System Administration"
 .SH NAME
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index c95b833..7a0b45c 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -1,10 +1,6 @@
 .\" Copyright 2000 Andreas Dilger (adilger@turbolinux.com)
 .\"
-.\" This man page was created for blkid from e2fsprogs-1.25.
-.\"
 .\" This file may be copied under the terms of the GNU Public License.
-.\"
-.\" Based on uuidgen, Mon Sep 17 10:42:12 2000, Andreas Dilger
 .TH BLKID 8 "March 2013" "util-linux" "System Administration"
 .SH NAME
 blkid \- locate/print block device attributes
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 385414f..5c16c15 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .\" Copyright 1993, 1994, 1995 by Theodore Ts'o.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 901b512..2878278 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH FINDMNT 8 "June 2014" "util-linux" "System Administration"
 .SH NAME
 findmnt \- find a filesystem
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 197bb38..235331e 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -31,9 +31,6 @@
 .\"
 .\"	@(#)logger.1	8.1 (Berkeley) 6/6/93
 .\"
-.\" Section on valid facility and level strings added by
-.\" and1000@debian.org, 26 Oct 1997.
-.\"
 .TH LOGGER "1" "December 2014" "util-linux" "User Commands"
 .SH NAME
 logger \- enter messages into the system log
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 7c19dd8..b259120 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH LSBLK 8 "February 2013" "util-linux" "System Administration"
 .SH NAME
 lsblk \- list block devices
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 83c7585..9dfc024 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .\" Man page for the lslocks command.
 .\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index c19ac46..7c3bb3e 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -1,6 +1,3 @@
-.\"
-.\" Version 1.4 of namei
-.\"
 .TH NAMEI 1 "June 2011" "util-linux" "User Commands"
 .SH NAME
 namei \- follow a pathname until a terminal point is found
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 4c39d1c..f725f7f 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -1,10 +1,6 @@
 .\" Copyright 1999 Andreas Dilger (adilger@enel.ucalgary.ca)
 .\"
-.\" This man page was created for libuuid.so.1.1 from e2fsprogs-1.14.
-.\"
 .\" This file may be copied under the terms of the GNU Public License.
-.\"
-.\" Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 .TH UUIDGEN 1 "June 2011" "util-linux" "User Commands"
 .SH NAME
 uuidgen \- create a new UUID value
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index c4addef..8b69772 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .\" Copyright 2009 by Karel Zak.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index e385c9f..bc65a30 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -20,9 +20,6 @@
 .\" with this program; if not, write to the Free Software Foundation, Inc.,
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
-.\" 2002-05-11 Robert Love <rml@tech9.net>
-.\" 	Initial version
-.\"
 .TH CHRT 1 "August 2014" "util-linux" "User Commands"
 .SH NAME
 chrt \- manipulate the real-time attributes of a process
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 0d62e8b..74fcf9d 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -20,9 +20,6 @@
 .\" with this program; if not, write to the Free Software Foundation, Inc.,
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
-.\" 2002-05-11 Robert Love <rml@tech9.net>
-.\" 	Initial version
-.\"
 .TH TASKSET 1 "August 2014" "util-linux" "User Commands"
 .SH NAME
 taskset \- set or retrieve a process's CPU affinity
diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index 5e094d4..f79fecb 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH BLKDISCARD 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 blkdiscard \- discard sectors on a device
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 8e0d92c..43aca27 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -1,5 +1,5 @@
 .\" Copyright (C) 1994-2005 Jeff Tranter (tranter@pobox.com)
-.\" Copyright (C) 2012 Karel Zak <kzak@redhat.com> 
+.\" Copyright (C) 2012 Karel Zak <kzak@redhat.com>
 .\"
 .\" It may be distributed under the GNU Public License, version 2, or
 .\" any higher version. See section COPYING of the GNU Public license
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 0762321..d166ad8 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH FALLOCATE 1 "September 2011" "util-linux" "User Commands"
 .SH NAME
 fallocate \- preallocate or deallocate space to a file
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index 364afca..c5bac73 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH FSFREEZE 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 fsfreeze \- suspend access to a filesystem (Ext3/4, ReiserFS, JFS, XFS)
@@ -74,4 +73,3 @@ This man page is based on
 .SH AVAILABILITY
 The fsfreeze command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index d9966c5..9287519 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -31,15 +31,6 @@
 .\"
 .\"     @(#)fstab.5	6.5 (Berkeley) 5/10/91
 .\"
-.\" Modified Sat Mar  6 20:45:03 1993, faith@cs.unc.edu, for Linux
-.\" Sat Oct  9 10:07:10 1993: converted to man format by faith@cs.unc.edu
-.\" Sat Nov 20 20:47:38 1993: hpfs documentation added
-.\" Sat Nov 27 20:23:32 1993: Updated authorship information
-.\" Wed Jul 26 00:00:00 1995: Updated some nfs stuff, joey@infodrom.north.de
-.\" Tue Apr  2 00:38:28 1996: added info about "noauto", "user", etc.
-.\" Tue Jun 15 20:02:18 1999: added LABEL and UUID
-.\" Sat Jul 14 2001: Michael K. Johnson <johnsonm@redhat.com> added -O
-.\"
 .TH FSTAB 5 "August 2010" "util-linux" "File Formats"
 .SH NAME
 fstab \- static information about the filesystems
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index 73c041d..3de8fd5 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH FSTRIM 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 fstrim \- discard unused blocks on a mounted filesystem
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 5e838fb..5502da3 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -1,6 +1,3 @@
-.\" Process this file with
-.\" groff -man -Tascii lscpu.1
-.\"
 .TH LSCPU 1 "January 2013" "util-linux" "User Commands"
 .SH NAME
 lscpu \- display information about the CPU architecture
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 6fa8a27..854268a 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1,4 +1,3 @@
-'\" t
 .\" Copyright (c) 1996-2004 Andries Brouwer
 .\" Copyright (C) 2006-2012 Karel Zak <kzak@redhat.com>
 .\"
@@ -28,7 +27,6 @@
 .\" with this program; if not, write to the Free Software Foundation, Inc.,
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
-.\"
 .TH MOUNT 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 mount \- mount a filesystem
@@ -3215,4 +3213,3 @@ Karel Zak <kzak@redhat.com>
 .SH AVAILABILITY
 The mount command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index c410f81..78990bf 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -1,4 +1,3 @@
-.\" -*- nroff -*-
 .TH MOUNTPOINT 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 mountpoint \- see if a directory or file is a mountpoint
@@ -57,4 +56,3 @@ for sysvinit suite was written by Miquel van Smoorenburg.
 .SH AVAILABILITY
 The mountpoint command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index ec505bf..4acdfb0 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -29,7 +29,7 @@
 .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 .\" SUCH DAMAGE.
 .\"
-.\"     @(#)renice.8   8.1 (Berkeley) 6/9/93
+.\"     @(#)renice.8	8.1 (Berkeley) 6/9/93
 .\"
 .TH RENICE "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index 7a30587..f7c020b 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -1,6 +1,5 @@
 .\" Rick Sladkey <jrs@world.std.com>
 .\" In the public domain.
-.\" Path modifications by faith@cs.unc.edu
 .TH SETSID 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 setsid \- run a program in a new session
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 23da280..e571a5f 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -31,13 +31,6 @@
 .\"
 .\"     @(#)swapon.8	6.3 (Berkeley) 3/16/91
 .\"
-.\" Sun Dec 27 12:31:30 1992: Modified by faith@cs.unc.edu
-.\" Sat Mar  6 20:46:02 1993: Modified by faith@cs.unc.edu
-.\" Sat Oct  9 09:35:30 1993: Converted to man format by faith@cs.unc.edu
-.\" Sat Nov 27 20:22:42 1993: Updated authorship information, faith@cs.unc.edu
-.\" Mon Sep 25 14:12:38 1995: Added -v and -p information
-.\" Tue Apr 30 03:32:07 1996: Added some text from A. Koppenhoefer
-.\"
 .TH SWAPON 8 "October 2014" "util-linux" "System Administration"
 .SH NAME
 swapon, swapoff \- enable/disable devices and files for paging and swapping
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index 444cfb4..c706236 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -1,10 +1,9 @@
-.\" This file Copyright (C) 1992-1997 Michael K. Johnson <johnsonm@redhat.com>
-.\" This file Copyright (C) 1998      Andrea Arcangeli   <andrea@e-mind.com>
+.\" Copyright (C) 1992-1997 Michael K. Johnson <johnsonm@redhat.com>
+.\" Copyright (C) 1998      Andrea Arcangeli   <andrea@e-mind.com>
 .\" It may be distributed under the terms of the GNU General Public License,
 .\" version 2, or any higher version.  See section COPYING of the GNU General
 .\" Public license for conditions under which this file may be redistributed.
 .\"
-.\" Polished a bit - aeb
 .TH TUNELP 8 "October 2011" "util-linux" "System Administration"
 .SH NAME
 tunelp \- set various parameters for the lp device
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index c9e159d..ab0614e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,6 +1,3 @@
-.\" Process this file with
-.\" groff -man -Tascii lscpu.1
-.\"
 .TH UNSHARE 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 unshare \- run program with some namespaces unshared from parent
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index a901e24..7525d41 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -1,13 +1,9 @@
 .\" Copyright 1990 Gordon Irlam (gordoni@cs.ua.oz.au)
 .\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
-.\" Most of this was copied from the source code.
+.\" Copyright 2000 Colin Watson (cjw44@cam.ac.uk)
 .\" Do not restrict distribution.
 .\" May be distributed under the GNU General Public License
 .\"
-.\" Most options documented by Colin Watson (cjw44@cam.ac.uk)
-.\" Undocumented: -snow, -softscroll, -standout; these are
-.\" commented out in the source
-.\"
 .TH SETTERM 1 "May 2014" "util-linux" "User Commands"
 .SH NAME
 setterm \- set terminal attributes
diff --git a/term-utils/wall.1 b/term-utils/wall.1
index fd6c029..33cd352 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -31,8 +31,6 @@
 .\"
 .\"     @(#)wall.1	6.5 (Berkeley) 4/23/91
 .\"
-.\" Modified for Linux, Mon Mar  8 18:07:38 1993, faith@cs.unc.edu
-.\"
 .TH WALL "1" "August 2013" "util-linux" "User Commands"
 .SH NAME
 wall \- write a message to all users
diff --git a/term-utils/write.1 b/term-utils/write.1
index ad321f4..5ad58b2 100644
--- a/term-utils/write.1
+++ b/term-utils/write.1
@@ -34,8 +34,6 @@
 .\"
 .\"     @(#)write.1	8.1 (Berkeley) 6/6/93
 .\"
-.\" Modified for Linux, Sun Mar 12 10:21:01 1995, faith@cs.unc.edu
-.\"
 .TH WRITE 1 "March 1995" "util-linux" "User Commands"
 .SH NAME
 write \- send a message to another user
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 8237fd9..f992763 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -29,7 +29,7 @@
 .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 .\" SUCH DAMAGE.
 .\"
-.\"	from: @(#)hexdump.1	8.2 (Berkeley) 4/18/94
+.\"	@(#)hexdump.1	8.2 (Berkeley) 4/18/94
 .\"
 .TH HEXDUMP "1" "April 2013" "util-linux" "User Commands"
 .SH NAME
diff --git a/text-utils/more.1 b/text-utils/more.1
index 589eaf7..af1fdd4 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -32,8 +32,7 @@
 .\"
 .\"	@(#)more.1	5.15 (Berkeley) 7/29/91
 .\"
-.\" 25Dec92: Extensive changes made by Rik Faith (faith@cs.unc.edu) to
-.\" conform with the more 5.19 currently in use by the Linux community.
+.\" Copyright (c) 1992 Rik Faith (faith@cs.unc.edu)
 .\"
 .TH MORE "1" "February 2014" "util-linux" "User Commands"
 .SH NAME
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index 7431cd1..ad6c8e3 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -1,4 +1,4 @@
-.\" @(#)pg.1	1.7 (gritter) 4/25/01
+.\" Copyright 2001 Gunnar Ritter
 .TH PG 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 pg \- browse pagewise through text files
diff --git a/text-utils/rev.1 b/text-utils/rev.1
index a8945a9..d1eaed5 100644
--- a/text-utils/rev.1
+++ b/text-utils/rev.1
@@ -29,9 +29,7 @@
 .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 .\" SUCH DAMAGE.
 .\"
-.\"	from: @(#)rev.1	6.3 (Berkeley) 3/21/92
-.\"     Modified for Linux by Charles Hannum (mycroft@gnu.ai.mit.edu)
-.\"                       and Brian Koehmstedt (bpk@gnu.ai.mit.edu)
+.\"	@(#)rev.1	6.3 (Berkeley) 3/21/92
 .\"
 .TH REV "1" "September 2011" "util-linux" "User Commands"
 .SH NAME
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index bfe97bc..d59c531 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -1,16 +1,15 @@
-.\" tailf.1 -- 
-.\" Created: Thu Jan 11 16:43:10 1996 by faith@acm.org
+.\" tailf.1 -- man page for tailf
 .\" Copyright 1996, 2003 Rickard E. Faith (faith@acm.org)
-.\" 
+.\"
 .\" Permission is granted to make and distribute verbatim copies of this
 .\" manual provided the copyright notice and this permission notice are
 .\" preserved on all copies.
-.\" 
+.\"
 .\" Permission is granted to copy and distribute modified versions of this
 .\" manual under the conditions for verbatim copying, provided that the
 .\" entire resulting derived work is distributed under the terms of a
 .\" permission notice identical to this one.
-.\" 
+.\"
 .\" Since the Linux kernel and libraries are constantly changing, this
 .\" manual page may be incorrect or out-of-date.  The author(s) assume no
 .\" responsibility for errors or omissions, or for damages resulting from
@@ -18,10 +17,10 @@
 .\" have taken the same level of care in the production of this manual,
 .\" which is licensed free of charge, as they might when working
 .\" professionally.
-.\" 
+.\"
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
-.\" 
+.\"
 .TH TAILF 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 tailf \- follow the growth of a log file
-- 
1.7.0.4

