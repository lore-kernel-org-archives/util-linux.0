Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:52322 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbaLNTqD (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:46:03 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] docs: adjust some formatting and wordings in a handful of man pages
Date: Sun, 14 Dec 2014 20:45:31 +0100
Message-Id: <1418586333-5342-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/partx.8   |  129 +++++++++++++++++++++++++++-----------------------
 misc-utils/look.1    |   14 +++--
 misc-utils/lslocks.8 |   33 +++++-------
 misc-utils/mcookie.1 |   36 +++++++-------
 misc-utils/namei.1   |   36 +++++++++-----
 misc-utils/rename.1  |   14 +++---
 6 files changed, 137 insertions(+), 125 deletions(-)

diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 005fe66..fb0fe38 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -3,7 +3,8 @@
 .\" Copyright 2007 Red Hat, Inc.
 .\" Copyright 2010 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
-.TH PARTX "8" "June 2012" "util-linux" "System Administration"
+.\"
+.TH PARTX "8" "December 2014" "util-linux" "System Administration"
 .SH NAME
 partx \- tell the Linux kernel about the presence and numbering of on-disk partitions
 .SH SYNOPSIS
@@ -43,24 +44,49 @@ The
 tells the kernel about the presence and numbering of on-disk
 partitions.
 .SH OPTIONS
-.IP "\fB\-a\fR, \fB\-\-add\fP"
+.TP
+.BR \-a , " \-\-add"
 Add the specified partitions, or read the disk and add all partitions.
-.IP "\fB\-b\fR, \fB\-\-bytes\fP"
+.TP
+.BR \-b , " \-\-bytes"
 Print the SIZE column in bytes rather than in human-readable format.
-.IP "\fB\-d\fR, \fB\-\-delete\fP"
+.TP
+.BR \-d , " \-\-delete"
 Delete the specified partitions or all partitions.
-.IP "\fB\-u\fR, \fB\-\-update\fP"
-Update the specified partitions.
-.IP "\fB\-g\fR, \fB\-\-noheadings\fP"
+.TP
+.BR \-g , " \-\-noheadings"
 Do not print a header line.
-.IP "\fB\-h\fR, \fB\-\-help\fP"
-Display help text and exit.
-.IP "\fB\-l\fR, \fB\-\-list\fP"
+.TP
+.BR \-l , " \-\-list"
 List the partitions.  Note that all numbers are in 512-byte sectors.
 This output format is DEPRECATED in favour of
 .BR \-\-show .
 Do not use it in newly written scripts.
-.IP "\fB\-o\fR, \fB\-\-output \fIlist\fP"
+.TP
+.BR \-n , " \-\-nr " \fIM : \fIN
+Specify the range of partitions.  For backward compatibility also the
+format \fIM\fB\-\fIN\fR is supported.
+The range may contain negative numbers, for example
+.B \-\-nr :\-1
+means the last partition, and
+.B \-\-nr \-2:\-1
+means the last two partitions.  Supported range specifications are:
+.RS 14
+.TP
+.I M
+Specifies just one partition (e.g.\& \fB\-\-nr 3\fR).
+.TP
+.IB M :
+Specifies the lower limit only (e.g.\& \fB\-\-nr 2:\fR).
+.TP
+.BI : N
+Specifies the upper limit only (e.g.\& \fB\-\-nr :4\fR).
+.TP
+.IB M : N
+Specifies the lower and upper limits (e.g.\& \fB\-\-nr 2:4\fR).
+.RE
+.TP
+.BR \-o , " \-\-output " \fIlist
 Define the output columns to use for
 .B \-\-show
 and
@@ -70,66 +96,49 @@ used.  Use
 .B \-\-help
 to get
 .I list
-of all supported columns.  This option cannot be combined with
+of all supported columns.  This option cannot be combined with the
 .BR \-\-add ,
 .BR \-\-delete ,
 or
 .B \-\-list
 options.
-.IP "\fB\-P\fR, \fB\-\-pairs\fP"
-Output using key="value" format.
-.IP "\fB\-n\fR, \fB\-\-nr \fIM:N\fP"
-Specify the range of partitions.  For backward compatibility also the
-format
-.I M\(enN
-is supported.  The range may contain negative numbers, for example
-.BI \-\-nr \ :\-1
-means the last partition, and
-.BI \-\-nr \ \-2:\-1
-means the last two partitions.  Supported range specifications are:
-.RS 14
 .TP
-.I M
-Specifies just one partition (e.g.\& \fB\-\-nr\fR
-.IR 3 ).
+.BR \-P , " \-\-pairs"
+Output using key="value" format.
 .TP
-.I M:
-Specifies lower limit only (e.g.\& \fB\-\-nr\fR
-.IR 2: ).
+.BR \-r , " \-\-raw"
+Use the raw output format.
 .TP
-.I :N
-Specifies upper limit only (e.g.\& \fB\-\-nr\fR
-.IR :4 ).
+.BR \-s , "\-\-show"
+List the partitions.  All numbers (except SIZE) are in 512-byte sectors.
+The output columns can be rearranged with the \fB\-\-output\fR option.
 .TP
-.IR M:N \ or
-.TQ
-.I M\(enN
-Specifies lower and upper limits (e.g.\& \fB\-\-nr\fR
-.IR 2:4 ).
-.RE
-.IP "\fB\-r\fR, \fB\-\-raw\fP"
-Use the raw output format.
-.IP "\fB\-s\fR, \fB\-\-show\fP"
-List the partitions.  All numbers (except SIZE) are in 512-byte
-sectors.  The output columns can be rearranged with the
-.B \-\-output
-option.
-.IP "\fB\-t\fR, \fB\-\-type \fItype\fP"
-Specify the partition table type
-.IR aix ,
-.IR bsd ,
-.IR dos ,
-.IR gpt ,
-.IR mac ,
-.IR minix ,
-.IR sgi ,
-.IR solaris_x86 ,
-.IR sun ,
-.IR ultrix ,
+.BR \-t , " \-\-type " \fItype
+Specify the partition table type, which can be one of
+.BR aix ,
+.BR bsd ,
+.BR dos ,
+.BR gpt ,
+.BR mac ,
+.BR minix ,
+.BR sgi ,
+.BR solaris_x86 ,
+.BR sun ,
+.BR ultrix ,
 or
-.IR unixware .
-.IP "\fB\-v\fR, \fB\-\-verbose\fP"
+.BR unixware .
+.TP
+.BR \-u , " \-\-update"
+Update the specified partitions.
+.TP
+.BR \-v , " \-\-verbose"
 Verbose mode.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH EXAMPLES
 .TP
 partx \-\-show /dev/sdb3
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 21edb66..d54751c 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -49,7 +49,9 @@ As
 .B look
 performs a binary search, the lines in
 .I file
-must be sorted (where sort(1) got the same options
+must be sorted (where
+.BR sort (1)
+was given the same options
 .BR "\-d " and/or " \-f " that
 .B look
 is invoked with).
@@ -78,11 +80,11 @@ Specify a string termination character, i.e. only the characters
 in \fIstring\fR up to and including the first occurrence of \fIcharacter\fR
 are compared.
 .TP
-.BR \-h , " \-\-help"
-Display help text and exit.
-.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .PP
 The
 .B look
@@ -106,8 +108,8 @@ the alternative dictionary
 .BR sort (1)
 .SH COMPATIBILITY
 The original manual page stated that tabs and blank characters participated
-in comparisons when the alphanum option was specified.  This was incorrect,
-and the current man page matches the historic implementation.
+in comparisons when the \fB\-\-alphanum\fR option was specified.  This was
+incorrect, and the current man page matches the historic implementation.
 .SH HISTORY
 The
 .B look
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 70a5638..83c7585 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -3,7 +3,7 @@
 .\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
 
-.TH LSLOCKS 8 "February 2012" "util-linux" "System Administration"
+.TH LSLOCKS 8 "December 2014" "util-linux" "System Administration"
 .SH NAME
 lslocks \- list local system locks
 .SH SYNOPSIS
@@ -16,9 +16,6 @@ lists information about all the currently held file locks in a Linux system.
 
 .SH OPTIONS
 .TP
-.BR \-h , " \-\-help"
-Display help text and exit.
-.TP
 .BR \-n , " \-\-noheadings"
 Do not print a header line.
 .TP
@@ -38,47 +35,45 @@ Use the raw output format.
 .TP
 .BR \-u , " \-\-notruncate"
 Do not truncate text in columns.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 
 .SH OUTPUT
 .IP "COMMAND"
 The command name of the process holding the lock.
-
 .IP "PID"
 The process ID of the process which holds the lock.
-
 .IP "TYPE"
-The type of lock; can be FLOCK (created with flock(2)) or POSIX (created with fcntl(2) and lockf(3)).
-
+The type of lock; can be FLOCK (created with \fBflock\fR(2)) or POSIX
+(created with \fBfcntl\fR(2) and \fBlockf\fR(3)).
 .IP "SIZE"
 Size of the locked file.
-
 .IP "MODE"
 The lock's access permissions (read, write).  If the process is blocked and waiting for the lock,
 then the mode is postfixed with an '*' (asterisk).
-
 .IP "M"
 Whether the lock is mandatory; 0 means no (meaning the lock is only advisory), 1 means yes.
-(See fcntl(2)).
-
+(See \fBfcntl\fR(2).)
 .IP "START"
 Relative byte offset of the lock.
-
 .IP "END"
 Ending offset of the lock.
-
 .IP "PATH"
 Full path of the lock.  If none is found, or there are no permissions to read the path,
 it will fall back to the device's mountpoint.  The path might be truncated; use
-.B "--notruncate"
-to get the full path.
-
+\fB\-\-notruncate\fR to get the full path.
 .IP "BLOCKER"
 The PID of the process which blocks the lock.
 
 .SH NOTES
 .nf
-The lslocks command is meant to replace the lslk(8) command, originally written by
-Victor A. Abell <abe@purdue.edu> and unmaintained since 2001.
+The \fBlslocks\fR command is meant to replace the \fBlslk\fR(8) command,
+originally written by Victor A. Abell <abe@purdue.edu> and unmaintained
+since 2001.
 .fi
 
 .SH AUTHORS
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index 6587c57..5863821 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -1,6 +1,6 @@
 .\" mcookie.1 --
 .\" Public Domain 1995 Rickard E. Faith (faith@cs.unc.edu)
-.TH MCOOKIE 1 "March 2014" "util-linux" "User Commands"
+.TH MCOOKIE 1 "December 2014" "util-linux" "User Commands"
 .SH NAME
 mcookie \- generate magic cookies for xauth
 .SH SYNOPSIS
@@ -10,30 +10,28 @@ mcookie \- generate magic cookies for xauth
 .B mcookie
 generates a 128-bit random hexadecimal number for use with the X authority
 system.  Typical usage:
+.sp
 .RS
-xauth add :0 . `mcookie`
+.B xauth add :0 . `mcookie`
 .RE
 .PP
-The "random" number generated is actually the output of the MD5 message
-digest fed with random information from one of the sources
+The "random" number generated is actually the MD5 message
+digest of random information coming from one of the sources
 .IR /dev/urandom ,
 .IR /dev/random ,
-or
-.I "libc pseudo-random functions"
+or the
+.IR "libc pseudo-random functions" ,
 in this preference order.
 .SH OPTIONS
 .TP
-\fB\-f\fR, \fB\-\-file\fR=\fIFILE\fR
-Use additional file as a macig cookie random seed.  When file is defined
-as '-' character input is read from stdin.
+.BR \-f , " \-\-file " \fIfile
+Use this \fIfile\fR as an additional source of randomness.
+When \fIfile\fR is '-', characters are read from standard input.
 .TP
-\fB\-m\fR, \fB\-\-max\-size\fR=\fInumber\fR
-Read form
-.I FILE
-only
-.I number
-of bytes.  This option is meant to be used when reading additional
-randomness from a device.
+.BR \-m , " \-\-max\-size " \fInumber
+Read from \fIfile\fR only this \fInumber\fR of bytes.
+This option is meant to be used when reading additional
+randomness from a file or device.
 .IP
 The
 .I number
@@ -42,14 +40,14 @@ MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
 optional, e.g., "K" has the same meaning as "KiB") or the suffixes
 KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
 .TP
-\fB\-v\fR, \fB\-\-verbose\fR
+.BR \-v , " \-\-verbose"
 Inform where randomness originated, with amount of entropy read from each
 source.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
+.BR \-h , " \-\-help"
 Display help text and exit.
 .SH BUGS
 It is assumed that none of the randomness sources will block.
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index 610d97c..c19ac46 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -10,7 +10,7 @@ namei \- follow a pathname until a terminal point is found
 .IR pathname ...
 .SH DESCRIPTION
 .B namei
-uses its arguments as pathnames to any type
+interprets its arguments as pathnames to any type
 of Unix file (symlinks, files, directories, and so forth).
 .B namei
 then follows each pathname until an endpoint
@@ -41,29 +41,37 @@ uses the following characters to identify the file type found:
 prints an informative message when
 the maximum number of symbolic links this system can have has been exceeded.
 .SH OPTIONS
-.IP "\fB\-l, \-\-long\fP"
-Use the long listing format (same as -m -o -v).
-.IP "\fB\-m, \-\-modes\fP"
+.TP
+.BR \-l , " \-\-long"
+Use the long listing format (same as \fB\-m \-o \-v\fR).
+.TP
+.BR \-m , " \-\-modes"
 Show the mode bits of each file type in the style of ls(1),
 for example 'rwxr-xr-x'.
-.IP "\fB\-o, \-\-owners\fP"
-Show owner and group name of each file.
-.IP "\fB\-n, \-\-nosymlinks\fP"
+.TP
+.BR \-n , " \-\-nosymlinks"
 Don't follow symlinks.
-.IP "\fB\-v, \-\-vertical\fP"
+.TP
+.BR \-o , " \-\-owners"
+Show owner and group name of each file.
+.TP
+.BR \-v , " \-\-vertical"
 Vertically align the modes and owners.
-.IP "\fB\-x, \-\-mountpoints\fP"
+.TP
+.BR \-x , " \-\-mountpoints"
 Show mountpoint directories with a 'D' rather than a 'd'.
-.IP "\fB\-h\fR, \fB\-\-help\fR"
-Display help text and exit.
-.IP "\fB\-V\fR, \fB\-\-version\fR"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHOR
 The original
 .B namei
 program was written by Roger Southwick <rogers@amadeus.wr.tek.com>.
-
-The program was re-written by Karel Zak <kzak@redhat.com>.
+.sp
+The program was rewritten by Karel Zak <kzak@redhat.com>.
 .SH BUGS
 To be discovered.
 .SH "SEE ALSO"
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index c166c51..f63d2f2 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -16,16 +16,16 @@ in their name by
 .IR replacement .
 .SH OPTIONS
 .TP
-\fB\-v\fR, \fB\-\-verbose\fR
-Give visual feedback which files where renamed, if any.
+.BR \-s , " \-\-symlink"
+Do not rename a symlink but its target.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
-Display version information and exit.
+.BR \-v , " \-\-verbose"
+Show which files where renamed, if any.
 .TP
-\fB\-s\fR, \fB\-\-symlink\fR
-Peform rename on symlink target
+.BR \-V , " \-\-version"
+Display version information and exit.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
+.BR \-h , " \-\-help"
 Display help text and exit.
 .SH EXAMPLES
 Given the files
-- 
1.7.0.4

