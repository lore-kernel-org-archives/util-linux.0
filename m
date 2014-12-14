Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58373 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbaLNTp6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:45:58 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] docs: don't use bold or italics for "[option]" in synopsis of man pages
Date: Sun, 14 Dec 2014 20:45:29 +0100
Message-Id: <1418586333-5342-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As per the convention shown in Documentation/howto-man-page.txt.
Also make a few other tiny adjustments along the way.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.8     |    2 +-
 disk-utils/fdformat.8   |    2 +-
 disk-utils/fdisk.8      |    2 +-
 disk-utils/isosize.8    |    2 +-
 disk-utils/mkfs.8       |    2 +-
 disk-utils/mkfs.bfs.8   |    2 +-
 disk-utils/mkswap.8     |    2 +-
 disk-utils/partx.8      |   11 +++++++++--
 disk-utils/sfdisk.8     |   18 +++++++++---------
 login-utils/last.1      |   10 ++++------
 login-utils/lslogins.1  |    5 ++++-
 misc-utils/cal.1        |    3 ++-
 misc-utils/findmnt.8    |   10 +++++-----
 misc-utils/getopt.1     |    6 +++---
 misc-utils/logger.1     |    3 ++-
 misc-utils/look.1       |    5 +++--
 misc-utils/lsblk.8      |    2 +-
 misc-utils/lslocks.8    |    3 ++-
 misc-utils/mcookie.1    |    2 +-
 misc-utils/namei.1      |    4 ++--
 misc-utils/rename.1     |    3 ++-
 misc-utils/uuidgen.1    |    2 +-
 misc-utils/whereis.1    |    2 +-
 sys-utils/readprofile.8 |    2 +-
 term-utils/agetty.8     |    6 ++----
 25 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 6da8f43..dc30b70 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -16,7 +16,7 @@
 cfdisk \- display or manipulate a disk partition table
 .SH SYNOPSIS
 .B cfdisk
-.RB [ options ]
+[options]
 .RI [ device ]
 .SH DESCRIPTION
 .B cfdisk
diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index ae1e530..9e1b989 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -5,7 +5,7 @@
 fdformat \- low-level format a floppy disk
 .SH SYNOPSIS
 .B fdformat
-.RI [ options ] " device"
+.RI [options] " device"
 .SH DESCRIPTION
 .B fdformat
 does a low-level format on a floppy disk.
diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 56caab1..a61176d 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -10,7 +10,7 @@ fdisk \- manipulate disk partition table
 
 .SH SYNOPSIS
 .B fdisk
-.RB [ options ]
+[options]
 .I device
 .sp
 .B fdisk \-l
diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
index 07ecfdc..98382f2 100644
--- a/disk-utils/isosize.8
+++ b/disk-utils/isosize.8
@@ -3,7 +3,7 @@
 isosize \- output the length of an iso9660 filesystem
 .SH SYNOPSIS
 .B isosize
-.RI [ options ] " iso9660_image_file"
+.RI [options] " iso9660_image_file"
 .SH DESCRIPTION
 .PP
 This command outputs the length of an iso9660 filesystem that
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 675822d..54bb004 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -4,7 +4,7 @@
 mkfs \- build a Linux filesystem
 .SH SYNOPSIS
 .B mkfs
-.RI [ options ]
+[options]
 .RB [ \-t
 .IR type "] [" fs-options ] " device " [ size ]
 .SH DESCRIPTION
diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index e1afd04..0769105 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -5,7 +5,7 @@
 mkfs.bfs \- make an SCO bfs filesystem
 .SH SYNOPSIS
 .B mkfs.bfs
-.RI [ options ] " device " [ block-count ]
+.RI [options] " device " [ block-count ]
 .SH DESCRIPTION
 .B mkfs.bfs
 creates an SCO bfs filesystem on a block device
diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index c110d21..562078d 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -8,7 +8,7 @@
 mkswap \- set up a Linux swap area
 .SH SYNOPSIS
 .B mkswap
-.RI [ options ]
+[options]
 .I device
 .RI [ size ]
 .SH DESCRIPTION
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 88eef60..005fe66 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -7,9 +7,16 @@
 .SH NAME
 partx \- tell the Linux kernel about the presence and numbering of on-disk partitions
 .SH SYNOPSIS
-partx [\-a | \-d | \-s | \-u] [\-t TYPE] [\-n M:N] [\-] disk
+.B partx
+.RB [ \-a | \-d | \-s | \-u ]
+.RB [ \-t " \fItype\fR]"
+.RB [ \-n " \fIM" : \fIN\fR]
+.RB [ \- "] " \fIdisk
 .br
-partx [\-a | \-d | \-s | \-u] [\-t TYPE] partition [disk]
+.B partx
+.RB [ \-a | \-d | \-s | \-u ]
+.RB [ \-t " \fItype\fR]"
+.IR partition " [" disk ]
 .SH DESCRIPTION
 Given a device or disk-image,
 .B partx
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 08725fd..62b1dcf 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -15,14 +15,14 @@
 sfdisk \- display or manipulate a disk partition table
 .SH SYNOPSIS
 .B sfdisk
-.RB [ options ]
-.RI device
-.BR [ \-N
-.IR partno ]
+[options]
+.I device
+.RB [ \-N
+.IR partition-number ]
 .sp
 .B sfdisk
-.RB [ options ]
-.RI command
+[options]
+.I command
 .SH DESCRIPTION
 .B sfdisk
 is a script oriented tool for partitioning any block device.
@@ -48,10 +48,10 @@ partitions.
 .SH COMMANDS
 The commands are mutually exclusive.
 .TP
-.BR [\-N " \fIpartno\fR"] " " \fIdevice\fR
-The default sfdisk command is to read the specification for the desired 
+.RB [ \-N " \fIpartition-number\fR] " \fIdevice\fR
+The default sfdisk command is to read the specification for the desired
 partitioning of \fIdevice\fR from standard input, and then create a partition
-table according to the specification. See below description of the input
+table according to the specification. See below for the description of the input
 format. If the standard input is a terminal then sfdisk starts interactive session.
 
 If the option \fB\-N\fR specified then the changes are applied to the partition
diff --git a/login-utils/last.1 b/login-utils/last.1
index edaddd1..23ebaf3 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -19,14 +19,12 @@
 last, lastb \- show a listing of last logged in users
 .SH SYNOPSIS
 .B last
-.RI [ options ]
-.RI [ username ...]
-.RI [ tty ...]
+[options]
+.RI [ username "...] [" tty ...]
 .br
 .B lastb
-.RI [ options ]
-.RI [ username ...]
-.RI [ tty ...]
+[options]
+.RI [ username "...] [" tty ...]
 .SH DESCRIPTION
 .B last
 searches back through the
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 0dbeebd..fb45b79 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -5,7 +5,10 @@
 lslogins \- display information about known users in the system
 .SH SYNOPSIS
 .B lslogins
-[\fIoptions\fR] [\fB-s\fR|\fB-u\fR[=\fIUID\fR]] [\fB-g \fIgroups\fR] [\fB-l \fIlogins\fR]
+[options]
+.RB [ \-s | \-u [ =\fIUID ]]
+.RB [ \-g " \fIgroups\fR]"
+.RB [ \-l " \fIlogins\fR]"
 .SH DESCRIPTION
 .PP
 Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 3209516..92141ae 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -39,7 +39,8 @@
 cal \- display a calendar
 .SH SYNOPSIS
 .B cal
-[\fIoptions\fR] [[[\fIday\fR] \fImonth\fR] \fIyear\fR]
+[options]
+.RI [[[ day ] " month" ] " year" ]
 .SH DESCRIPTION
 .B cal
 displays a simple calendar.  If no arguments are specified, the current
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 27121d8..901b512 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -4,17 +4,17 @@
 findmnt \- find a filesystem
 .SH SYNOPSIS
 .B findmnt
-.RB [ options ]
+[options]
 .sp
 .B findmnt
-.RB [ options ]
+[options]
 .IR device | mountpoint
 .sp
 .B findmnt
-.RB [ options ]
-.RB [ \--source ]
+[options]
+.RB [ \-\-source ]
 .IR device
-.RB [ \--target ]
+.RB [ \-\-target ]
 .IR mountpoint
 .SH DESCRIPTION
 .B findmnt
diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index 6758d27..da7207f 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -6,15 +6,15 @@ getopt \- parse command options (enhanced)
 .I optstring parameters
 .br
 .B getopt
-.RI [ options ]
+[options]
 .RB [ \-\- ]
 .I optstring parameters
 .br
 .B getopt
-.RI [ options ]
+[options]
 .BR \-o | \-\-options
 .I optstring
-.RI [ options ]
+[options]
 .RB [ \-\- ]
 .I parameters
 .SH DESCRIPTION
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 3bfcb3d..2a3b47c 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -38,7 +38,8 @@
 logger \- a shell command interface to the syslog(3) system log module
 .SH SYNOPSIS
 .B logger
-.RI [ options "] [" message ]
+[options]
+.RI [ message ]
 .SH DESCRIPTION
 .B logger
 makes entries in the system log.  It provides a shell command
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index d1d8f1b..21edb66 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -36,9 +36,10 @@
 look \- display lines beginning with a given string
 .SH SYNOPSIS
 .B look
-.RI [ options ] " string " [ file ]
+[options]
+.IR "string " [ file ]
 .SH DESCRIPTION
-The 
+The
 .B look
 utility displays any lines in
 .I file
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 8c9740c..7c19dd8 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -4,7 +4,7 @@
 lsblk \- list block devices
 .SH SYNOPSIS
 .B lsblk
-.RB [ options ]
+[options]
 .RI [ device ...]
 .SH DESCRIPTION
 .B lsblk
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 20ff0dc..70a5638 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -7,7 +7,8 @@
 .SH NAME
 lslocks \- list local system locks
 .SH SYNOPSIS
-.BR lslocks " [" options ]
+.B lslocks
+[options]
 
 .SH DESCRIPTION
 .B lslocks
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index 989b7f9..6587c57 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -5,7 +5,7 @@
 mcookie \- generate magic cookies for xauth
 .SH SYNOPSIS
 .B mcookie
-[\fIoptions\fR]
+[options]
 .SH DESCRIPTION
 .B mcookie
 generates a 128-bit random hexadecimal number for use with the X authority
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index 550dc97..610d97c 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -6,8 +6,8 @@
 namei \- follow a pathname until a terminal point is found
 .SH SYNOPSIS
 .B namei
-.RI [ options ]
-.IR  pathname ...
+[options]
+.IR pathname ...
 .SH DESCRIPTION
 .B namei
 uses its arguments as pathnames to any type
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 30d9c71..c166c51 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -6,7 +6,8 @@
 rename \- rename files
 .SH SYNOPSIS
 .B rename
-.RI [ options ] " expression replacement file" ...
+[options]
+.IR "expression replacement file" ...
 .SH DESCRIPTION
 .B rename
 will rename the specified files by replacing the first occurrence of
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 4d64a10..4c39d1c 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -10,7 +10,7 @@
 uuidgen \- create a new UUID value
 .SH SYNOPSIS
 .B uuidgen
-[\fIoptions\fR]
+[options]
 .SH DESCRIPTION
 The
 .B uuidgen
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 243fc14..652f69b 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -35,7 +35,7 @@
 whereis \- locate the binary, source, and manual page files for a command
 .SH SYNOPSIS
 .B whereis
-.RB [ options ]
+[options]
 .RB [ \-BMS
 .IR directory "... " \fB\-f\fR ]
 .IR name ...
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index 8ad9dc9..c01e3ca 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -3,7 +3,7 @@
 readprofile \- read kernel profiling information
 .SH SYNOPSIS
 .B readprofile
-.RI [ options ]
+[options]
 .SH VERSION
 This manpage documents version 2.0 of the program.
 .SH DESCRIPTION
diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 12e481f..10f3395 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -4,10 +4,8 @@ agetty \- alternative Linux getty
 
 .SH SYNOPSIS
 .B agetty
-.RB [ options ]
-.I port
-.RI [ baud_rate ...]
-.RI [ term ]
+[options]
+.IR port " [" baud_rate "...] [" term ]
 
 .SH DESCRIPTION
 .ad
-- 
1.7.0.4

