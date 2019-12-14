Return-Path: <SRS0=wda/=2E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F33C43603
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D2520724
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLNWmz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:42:55 -0500
Received: from inpost.hi.is ([130.208.165.62]:53722 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLNWmz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 14 Dec 2019 17:42:55 -0500
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id xBEMglpg016676
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 22:42:47 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is xBEMglpg016676
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id xBEMglvn015568
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 22:42:47 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id xBEMgllk015567
        for util-linux@vger.kernel.org; Sat, 14 Dec 2019 22:42:47 GMT
Date:   Sat, 14 Dec 2019 22:42:47 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] man pages: Add a comma after "e.g." and "i.e."
Message-ID: <20191214224247.GA15526@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Add a comma (,) after "e.g." and "i.e.", or use English words
(man-pages(7) [package "manpages"]).

  Abbreviation points should be protected (usually with the
non-printing, zero width character '\&') from being interpreted as an
end of sentence, if they are not, and that independent of their current
place on the line.

  This is important when typing, as one does not usually know in
advance when the editor jumps to a new line.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/cfdisk.8       |  2 +-
 disk-utils/fdisk.8        |  6 +++---
 disk-utils/fsck.8         |  6 +++---
 disk-utils/mkfs.8         |  2 +-
 disk-utils/sfdisk.8       | 16 ++++++++--------
 lib/terminal-colors.d.5   |  2 +-
 libblkid/libblkid.3       |  2 +-
 login-utils/chfn.1        |  2 +-
 login-utils/login.1       |  6 +++---
 login-utils/lslogins.1    |  4 ++--
 login-utils/runuser.1     |  8 ++++----
 login-utils/su.1          | 10 +++++-----
 misc-utils/blkid.8        | 10 +++++-----
 misc-utils/cal.1          |  8 ++++----
 misc-utils/findmnt.8      |  4 ++--
 misc-utils/hardlink.1     |  2 +-
 misc-utils/logger.1       |  2 +-
 misc-utils/look.1         |  4 ++--
 misc-utils/lsblk.8        |  4 ++--
 misc-utils/lslocks.8      |  2 +-
 misc-utils/wipefs.8       |  4 ++--
 sys-utils/chmem.8         |  2 +-
 sys-utils/dmesg.1         |  6 +++---
 sys-utils/eject.1         |  8 ++++----
 sys-utils/lscpu.1         |  2 +-
 sys-utils/lsmem.1         |  4 ++--
 sys-utils/lsns.8          |  2 +-
 sys-utils/mount.8         | 10 +++++-----
 sys-utils/nsenter.1       |  2 +-
 sys-utils/rtcwake.8.in    |  2 +-
 sys-utils/swapon.8        |  2 +-
 sys-utils/umount.8        |  4 ++--
 sys-utils/unshare.1       |  2 +-
 term-utils/script.1       |  2 +-
 term-utils/scriptreplay.1 |  2 +-
 text-utils/hexdump.1      |  4 ++--
 36 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 9b7db00eb..89d932143 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -101,7 +101,7 @@ position.
 
 The size may be followed by a multiplicative suffix: KiB (=1024),
 MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB").
+(the "iB" is optional, e.g., "K" has the same meaning as "KiB").
 .TP
 .B q
 Quit the program.  This will exit the program without writing any data to
diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 364451711..c2321513e 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -32,7 +32,7 @@ All partitioning is driven by device I/O limits (the topology) by default.
 .B fdisk
 is able to optimize the disk layout for a 4K-sector size and use an alignment offset on
 modern devices for MBR and GPT.  It is always a good idea to follow \fBfdisk\fR's defaults
-as the default values (e.g. first and last partition sectors) and partition
+as the default values (e.g., first and last partition sectors) and partition
 sizes specified by the +/-<size>{M,G,...} notation are always aligned according
 to the device properties.
 
@@ -89,7 +89,7 @@ Specify which output columns to print.  Use
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fB-o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fB-o +UUID\fP).
 .TP
 \fB\-s\fR, \fB\-\-getsz\fR
 Print the size in 512-byte sectors of each given block device.  This option is DEPRECATED
@@ -173,7 +173,7 @@ as relative to the high limit (last available sector for the partition).
 
 In the case the size is specified in bytes than the number may be followed by
 the multiplicative suffixes KiB=1024, MiB=1024*1024, and so on for GiB, TiB,
-PiB, EiB, ZiB and YiB. The "iB" is optional, e.g. "K" has the same meaning as
+PiB, EiB, ZiB and YiB. The "iB" is optional, e.g., "K" has the same meaning as
 "KiB".
 
 The relative sizes are always aligned according to device I/O limits.  The
diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index aa48108c6..10728c861 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -20,11 +20,11 @@ fsck \- check and repair a Linux filesystem
 .B fsck
 is used to check and optionally repair one or more Linux filesystems.
 .I filesys
-can be a device name (e.g.
+can be a device name (e.g.,
 .IR /dev/hdc1 ", " /dev/sdb2 ),
-a mount point (e.g.
+a mount point (e.g.,
 .IR / ", " /usr ", " /home ),
-or an filesystem label or UUID specifier (e.g.
+or an filesystem label or UUID specifier (e.g.,
 UUID=8868abf6-88c5-4a83-98b8-bfc24057f7bd or LABEL=root).
 Normally, the
 .B fsck
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index e3a7f8b6b..e8edb0f4a 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -13,7 +13,7 @@ mkfs \- build a Linux filesystem
 is used to build a Linux filesystem on a device, usually
 a hard disk partition.  The
 .I device
-argument is either the device name (e.g.
+argument is either the device name (e.g.,
 .IR /dev/hda1 ,
 .IR /dev/sdb2 ),
 or a regular file that shall contain the filesystem.  The
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 8c1fe1622..e7d7a272c 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -39,7 +39,7 @@ sense for new devices.
 (since version 2.26)
 .B aligns the start and end of partitions
 to block-device I/O limits when relative sizes are specified, when the default
-values are used or when multiplicative suffixes (e.g. MiB) are used for sizes.
+values are used or when multiplicative suffixes (e.g., MiB) are used for sizes.
 It is possible that partition size will be optimized (reduced or enlarged) due
 to alignment if the start offset is specified exactly in sectors and partition
 size relative or by multiplicative suffixes.
@@ -199,7 +199,7 @@ Do not check through the re-read-partition-table ioctl whether the device is in
 .B \-\-no\-tell\-kernel
 Don't tell the kernel about partition changes. This option is recommended together
 with \fB\-\-no\-reread\fR to modify a partition on used disk. The modified partition
-should not be used (e.g. mounted).
+should not be used (e.g., mounted).
 .TP
 .BR \-O , " \-\-backup\-file " \fIpath
 Override the default backup file name.  Note that the device name and offset
@@ -221,7 +221,7 @@ Note that this operation is risky and not atomic. \fBDon't forget to backup your
 See also \fB\-\-move\-use\-fsync\fR.
 
 In the example below, the first command creates a 100MiB free area before
-the first partition and moves the data it contains (e.g. a filesystem),
+the first partition and moves the data it contains (e.g., a filesystem),
 the next command creates a new partition from the free space (at offset 2048),
 and the last command reorders partitions to match disk order
 (the original sdc1 will become sdc2).
@@ -246,7 +246,7 @@ Specify which output columns to print.  Use
 to get a list of all supported columns.
 .sp
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fB-o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fB-o +UUID\fP).
 .TP
 .BR \-q , " \-\-quiet"
 Suppress extra info messages.
@@ -256,7 +256,7 @@ Deprecated option.  Only the sector unit is supported. This option is not
 supported when using the --show-size command.
 .TP
 .BR \-X , " \-\-label " \fItype
-Specify the disk label type (e.g. \fBdos\fR, \fBgpt\fR, ...).  If this option
+Specify the disk label type (e.g., \fBdos\fR, \fBgpt\fR, ...).  If this option
 is not given, then \fBsfdisk\fR defaults to the existing label, but if there
 is no label on the device yet, then the type defaults to \fBdos\fR. The default
 or the current label may be overwritten by the "label: <name>" script header
@@ -374,7 +374,7 @@ EiB, ZiB and YiB) then the number is interpreted as offset in bytes.
 .sp
 The default value of
 .I size
-indicates "as much as possible"; i.e. until the next partition or
+indicates "as much as possible"; i.e., until the next partition or
 end-of-device.  A numerical argument is by default interpreted as a
 number of sectors, however if the size is followed by one of the
 multiplicative suffixes (KiB, MiB, GiB, TiB, PiB, EiB, ZiB and YiB)
@@ -430,7 +430,7 @@ loaders and for other operating systems.
 .B Named-fields format
 .RS
 This format is more readable, robust, extensible and allows to specify additional
-information (e.g. a UUID).  It is recommended to use this format to keep your scripts
+information (e.g., a UUID).  It is recommended to use this format to keep your scripts
 more readable.
 .RS
 .sp
@@ -446,7 +446,7 @@ Don't use it if you are not sure.
 
 The
 .I value
-can be between quotation marks (e.g. name="This is partition name").
+can be between quotation marks (e.g., name="This is partition name").
 The currently supported fields are:
 .RS
 .TP
diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index e0bec23fc..a8fe08e09 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -42,7 +42,7 @@ the default format is described below.
 If there are more files that match for a utility, then the file with the more
 specific filename wins.  For example, the filename "@xterm.scheme" has less
 priority than "dmesg@xterm.scheme".  The lowest priority are those files without a
-utility name and terminal identifier (e.g. "disable").
+utility name and terminal identifier (e.g., "disable").
 
 The user-specific
 .I $XDG_CONFIG_HOME/terminal-colors.d
diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index f5e00094a..6b58b1670 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -18,7 +18,7 @@ libblkid \- block device identification library
 .SH DESCRIPTION
 The
 .B libblkid
-library is used to identify block devices (disks) as to their content (e.g.
+library is used to identify block devices (disks) as to their content (e.g.,
 filesystem type) as well as extracting additional information such as
 filesystem labels/volume names, unique identifiers/serial numbers.
 A common use is to allow use of LABEL= and UUID= tags instead of hard-coding
diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index c7130c47e..afc29c36c 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -74,7 +74,7 @@ Display version information and exit.
 reads the
 .IR /etc\:/login.defs (5)
 configuration file.  Note that the configuration file could be
-distributed with another package (e.g. shadow-utils).  The following
+distributed with another package (e.g., shadow-utils).  The following
 configuration items are relevant for
 .BR chfn (1):
 .PP
diff --git a/login-utils/login.1 b/login-utils/login.1
index 084f6c90a..29fe1b7a6 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -119,7 +119,7 @@ with the
 .B \-h
 option the name is
 .IR remote .
-It is necessary to create proper PAM config files (e.g.
+It is necessary to create proper PAM config files (e.g.,
 .I /etc\:/pam.d\:/login
 and
 .IR /etc\:/pam.d\:/remote ).
@@ -144,7 +144,7 @@ Display version information and exit.
 reads the
 .IR /etc\:/login.defs (5)
 configuration file.  Note that the configuration file could be
-distributed with another package (e.g. shadow-utils).  The following
+distributed with another package (e.g., shadow-utils).  The following
 configuration items are relevant for
 .BR login (1):
 .PP
@@ -226,7 +226,7 @@ can be either the name of a group or a numeric group identifier.
 (string)
 .RS 4
 If defined, this file can inhibit all the usual chatter during the
-login sequence.  If a full pathname (e.g.
+login sequence.  If a full pathname (e.g.,
 .IR /etc\:/hushlogins )
 is specified, then hushed mode will be enabled if the user\'s name or
 shell are found in the file.  If this global hush login file is empty
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 04237939d..06bad42ab 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -51,7 +51,7 @@ may be specified; the list has to be comma-separated.  The unknown group
 names are ignored.
 
 Note that relation between user and group may be invisible for primary group if
-the user is not explicitly specify as group member (e.g. in /etc/group). If the
+the user is not explicitly specify as group member (e.g., in /etc/group). If the
 command lslogins scans for groups than it uses groups database only, and user
 database with primary GID is not used at all.
 .TP
@@ -131,7 +131,7 @@ if OK,
 if incorrect arguments specified,
 .TP
 2
-if a serious error occurs (e.g. a corrupt log).
+if a serious error occurs (e.g., a corrupt log).
 .SH SEE ALSO
 \fBgroup\fP(5), \fBpasswd\fP(5), \fBshadow\fP(5), \fButmp\fP(5)
 .SH HISTORY
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 4eecd9c6a..4f6064287 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -106,16 +106,16 @@ Create pseudo-terminal for the session. The independent terminal provides
 better security as user does not share terminal with the original
 session.  This allow to avoid TIOCSTI ioctl terminal injection and another
 security attacks against terminal file descriptors. The all session is also
-possible to move to background (e.g. "runuser --pty -u username -- command &").
+possible to move to background (e.g., "runuser --pty -u username -- command &").
 If the pseudo-terminal is enabled then runuser command works
 as a proxy between the sessions (copy stdin and stdout).
 .sp
 This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal, but for example pipe (e.g. echo "date" | runuser --pty -u user)
+is not a terminal, but for example pipe (e.g., echo "date" | runuser --pty -u user)
 than ECHO flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
-Preserve the entire environment, i.e. it does not set
+Preserve the entire environment, i.e., it does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -146,7 +146,7 @@ o
 /bin/sh
 .RE
 .IP
-If the target user has a restricted shell (i.e. not listed in
+If the target user has a restricted shell (i.e., not listed in
 /etc/shells) the
 .B \-\-shell
 option and the
diff --git a/login-utils/su.1 b/login-utils/su.1
index 887ca3f27..8c67dc402 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -49,7 +49,7 @@ configured via PAM.
 .PP
 .B su
 is mostly designed for unprivileged users, the recommended solution for
-privileged users (e.g. scripts executed by root) is to use
+privileged users (e.g., scripts executed by root) is to use
 non-set-user-ID command
 .BR runuser (1)
 that does not require authentication and provide separate PAM configuration. If
@@ -106,7 +106,7 @@ in order to make the shell a login shell
 .RE
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
-Preserve the entire environment, i.e. it does not set
+Preserve the entire environment, i.e., it does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -119,12 +119,12 @@ Create pseudo-terminal for the session. The independent terminal provides
 better security as user does not share terminal with the original
 session.  This allow to avoid TIOCSTI ioctl terminal injection and another
 security attacks against terminal file descriptors. The all session is also
-possible to move to background (e.g. "su --pty - username -c
+possible to move to background (e.g., "su \-\-pty \- username \-c
 application &"). If the pseudo-terminal is enabled then su command works
 as a proxy between the sessions (copy stdin and stdout).
 .sp
 This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal, but for example pipe (e.g. echo "date" | su --pty) than ECHO
+is not a terminal, but for example pipe (e.g., echo "date" | su --pty) than ECHO
 flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-s , " \-\-shell" = \fIshell
@@ -150,7 +150,7 @@ o
 /bin/sh
 .RE
 .IP
-If the target user has a restricted shell (i.e. not listed in
+If the target user has a restricted shell (i.e., not listed in
 /etc/shells), the
 .B \-\-shell
 option and the
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 1ff44403c..b354f8c63 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -50,9 +50,9 @@ The
 .B blkid
 program is the command-line interface to working with the
 .BR libblkid (3)
-library.  It can determine the type of content (e.g. filesystem or swap)
+library.  It can determine the type of content (e.g., filesystem or swap)
 that a block device holds, and also the attributes (tokens, NAME=value pairs)
-from the content metadata (e.g. LABEL or UUID fields).
+from the content metadata (e.g., LABEL or UUID fields).
 .PP
 .B It is recommended to use
 .BR lsblk (8)
@@ -99,14 +99,14 @@ to get a detailed overview and to erase obsolete stuff (magic strings) from the
 .SH OPTIONS
 The \fIsize\fR and \fIoffset\fR arguments may be followed by the multiplicative
 suffixes like KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
+(the "iB" is optional, e.g., "K" has the same meaning as "KiB"), or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
 \fB\-c\fR, \fB\-\-cache\-file\fR \fIcachefile\fR
 Read from
 .I cachefile
 instead of reading from the default cache file (see the CONFIGURATION FILE section
-for more details).  If you want to start with a clean cache (i.e. don't report
+for more details).  If you want to start with a clean cache (i.e., don't report
 devices previously scanned but not necessarily available at this time), specify
 .IR /dev/null .
 .TP
@@ -273,7 +273,7 @@ prefixed with "no" to specify the usage types which should be ignored.  For exam
 .sp
   blkid --probe --usages filesystem,other /dev/sda1
 .sp
-probes for all filesystem and other (e.g. swap) formats, and
+probes for all filesystem and other (e.g., swap) formats, and
 .sp
   blkid --probe --usages noraid /dev/sda1
 .sp
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 5a8095fb3..066d9f6ed 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -166,12 +166,12 @@ Display version information and exit.
 Display help text and exit.
 .SH PARAMETERS
 .TP
-\fBSingle digits-only parameter (e.g. 'cal 2020')\fR
+\fBSingle digits-only parameter (e.g., 'cal 2020')\fR
 Specifies the \fIyear\fR to be displayed; note the year must be fully specified:
 .B "cal 89"
 will not display a calendar for 1989.
 .TP
-\fBSingle string parameter (e.g. 'cal tomorrow' or 'cal August')\fR
+\fBSingle string parameter (e.g., 'cal tomorrow' or 'cal August')\fR
 Specifies \fItimestamp\fR or a \fImonth name\fR (or abbreviated name) according to the current
 locales.
 .sp
@@ -186,10 +186,10 @@ specified time span, for example '+2days'. Instead of prefixing the time span
 with "+" or "-", it may also be suffixed with a space and the word "left" or
 "ago" (for example '1 week ago').
 .TP
-\fBTwo parameters (e.g. 'cal 11 2020')\fR
+\fBTwo parameters (e.g., 'cal 11 2020')\fR
 Denote the \fImonth\fR (1 - 12) and \fIyear\fR.
 .TP
-\fBThree parameters (e.g. 'cal 25 11 2020')\fR
+\fBThree parameters (e.g., 'cal 25 11 2020')\fR
 Denote the \fIday\fR (1-31), \fImonth and \fIyear\fR, and the day will be
 highlighted if the calendar is displayed on a terminal.  If no parameters are
 specified, the current month's calendar is displayed.
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index f95aea3d9..6fe35ab86 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -148,7 +148,7 @@ or
 options are not specified.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fBfindmnt \-o +PROPAGATION\fP).
+specified in the format \fI+list\fP (e.g., \fBfindmnt \-o +PROPAGATION\fP).
 .TP
 .B \-\-output\-all
 Output almost all available columns.  The columns that require
@@ -229,7 +229,7 @@ more details see
 .TP
 .B \-\-tree
 Enable tree-like output if possible.  The options is silently ignored for
-tables where is missing child-parent relation (e.g. fstab).
+tables where is missing child-parent relation (e.g., fstab).
 .TP
 .BR \-U , " \-\-uniq"
 Ignore filesystems with duplicate mount targets, thus effectively skipping
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index 97fc569da..738fac708 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -34,7 +34,7 @@ Do not perform the consolidation; only print what would be changed.
 .TP
 .BR \-v , " \-\-verbose"
 Print summary after hardlinking. The option may be specified more than once. In
-this case (e.g. \fB-vv\fR) it prints every hardlinked file and bytes saved.
+this case (e.g., \fB-vv\fR) it prints every hardlinked file and bytes saved.
 .TP
 .BR \-x , " \-\-exclude " \fIregex\fR
 Exclude files and directories matching pattern from hardlinking.
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 3530cd9e8..e4a52228e 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -59,7 +59,7 @@ is defined to be a line without any characters.  Thus a line consisting
 only of whitespace is NOT considered empty.
 Note that when the \fB\-\-prio\-prefix\fR option is specified, the priority
 is not part of the line.  Thus an empty line in this mode is a line that does
-not have any characters after the priority prefix (e.g. \fB<13>\fR).
+not have any characters after the priority prefix (e.g., \fB<13>\fR).
 .TP
 .BR \-f , " \-\-file " \fIfile
 Log the contents of the specified \fIfile\fR.
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index cca83416e..28a724d81 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -68,7 +68,7 @@ alphabetic characters is ignored.
 Use the alternative dictionary file.
 .TP
 .BR \-d , " \-\-alphanum"
-Use normal dictionary character set and order, i.e. only blanks and
+Use normal dictionary character set and order, i.e., only blanks and
 alphanumeric characters are compared.  This is on by default if no file is
 specified.
 
@@ -80,7 +80,7 @@ Ignore the case of alphabetic characters.  This is on by default if no file is
 specified.
 .TP
 .BR \-t , " \-\-terminate " \fIcharacter\fR
-Specify a string termination character, i.e. only the characters
+Specify a string termination character, i.e., only the characters
 in \fIstring\fR up to and including the first occurrence of \fIcharacter\fR
 are compared.
 .TP
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index dabf913de..f46f89bc7 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -116,7 +116,7 @@ to get a list of all supported columns.  The columns may affect tree-like output
 The default is to use tree for the column 'NAME' (see also \fB\-\-tree\fR).
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fBlsblk -o +UUID\fP).
+specified in the format \fI+list\fP (e.g., \fBlsblk -o +UUID\fP).
 .TP
 .BR \-O , " \-\-output\-all "
 Output all available columns.
@@ -166,7 +166,7 @@ instance to be inspected.  The real device nodes in the target directory can
 be replaced by text files with udev attributes.
 
 .SH NOTES
-For partitions, some information (e.g. queue attributes) is inherited from the
+For partitions, some information (e.g., queue attributes) is inherited from the
 parent device.
 .PP
 The
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 40b2cebf6..bcafe43a0 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -38,7 +38,7 @@ Specify which output columns to print.  Use
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fBlslocks -o +BLOCKER\fP).
+specified in the format \fI+list\fP (e.g., \fBlslocks -o +BLOCKER\fP).
 .TP
 .B \-\-output\-all
 Output all available columns.
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 3874e1a7f..e47b780d3 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -42,7 +42,7 @@ to inform the kernel about the change. The ioctl is called as the last step
 and when all specified signatures from all specified devices are already erased.
 
 Note that some filesystems and some partition tables store more magic strings on
-the device (e.g. FAT, ZFS, GPT).  The
+the device (e.g., FAT, ZFS, GPT).  The
 .B wipefs
 command (since v2.31) lists all the offset where a magic strings have been
 detected.
@@ -94,7 +94,7 @@ interpreted as a hex value.  It is possible to specify multiple \fB-o\fR options
 .sp
 The \fIoffset\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
+(the "iB" is optional, e.g., "K" has the same meaning as "KiB"), or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
 .BR \-p , " \-\-parsable"
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index 8a3b34d5e..21bcc14c0 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -36,7 +36,7 @@ changed by specifying the \fB--zone\fP option with another valid zone.
 For memory ballooning, it is recommended to select the zone Movable for memory
 online and offline, if possible. Memory in this zone is much more likely to be
 able to be offlined again, but it cannot be used for arbitrary kernel
-allocations, only for migratable pages (e.g. anonymous and page cache pages).
+allocations, only for migratable pages (e.g., anonymous and page cache pages).
 Use the \fB\-\-help\fR option to see all available zones.
 .
 .PP
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 2c06f69ad..2afc07890 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -114,7 +114,7 @@ will
 .I not
 print or clear the kernel ring buffer.
 .IP "\fB\-\-noescape\fR"
-The unprintable and potentially unsafe characters (e.g. broken multi-byte
+The unprintable and potentially unsafe characters (e.g., broken multi-byte
 sequences, terminal controlling chars, etc.) are escaped in format \\x<hex> for
 security reason by default.  This option disables this feature at all. It's
 usable for example for debugging purpose together with \fB\-\-raw\fR.  Be
@@ -124,7 +124,7 @@ Do not pipe output into a pager.  A pager is enabled by default for \fB\-\-human
 .IP "\fB\-p\fR, \fB\-\-force\-prefix\fR"
 Add facility, level or timestamp information to each line of a multi-line message.
 .IP "\fB\-r\fR, \fB\-\-raw\fR"
-Print the raw message buffer, i.e. do not strip the log-level prefixes, but
+Print the raw message buffer, i.e., do not strip the log-level prefixes, but
 all unprintable characters are still escaped (see also \fB\-\-noescape\fR).
 
 Note that the real raw format depends on the method how
@@ -212,7 +212,7 @@ The logical color names supported by
 are:
 .TP
 .B subsys
-The message sub-system prefix (e.g. "ACPI:").
+The message sub-system prefix (e.g., "ACPI:").
 .TP
 .B time
 The message timestamp.
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 0958e052e..313f9fd18 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -20,7 +20,7 @@ and close the disc tray of some CD-ROM drives.
 .PP
 The device corresponding to \fIdevice\fP or \fImountpoint\fP is ejected.  If no
 name is specified, the default name \fB/dev/cdrom\fR is used.  The device may be
-addressed by device name (e.g. 'sda'), device path (e.g. '/dev/sda'),
+addressed by device name (e.g., 'sda'), device path (e.g., '/dev/sda'),
 UUID=\fIuuid\fR or LABEL=\fIlabel\fR tags.
 .PP
 There are four different methods of ejecting, depending on whether the device
@@ -122,7 +122,7 @@ correctly report the speed and therefore this option does not work with them.
 .BR \-x , " \-\-cdspeed " \fIspeed
 With this option the drive is given a CD-ROM select speed command.  The
 .I speed
-argument is a number indicating the desired speed (e.g. 8 for 8X speed), or 0
+argument is a number indicating the desired speed (e.g., 8 for 8X speed), or 0
 for maximum data rate.  Not all devices support this command and you can only
 specify speeds that the drive is capable of.  Every time the media is changed
 this option is cleared.  This option can be used alone, or with the
@@ -149,7 +149,7 @@ eject.  More than one method can be specified.  If none of these options are
 specified, it tries all four (this works fine in most cases).
 .PP
 .B eject
-may not always be able to determine if the device is mounted (e.g. if it has
+may not always be able to determine if the device is mounted (e.g., if it has
 several names).  If the device name is a symbolic link,
 .B eject
 will follow the link and use the device that it points to.
@@ -169,7 +169,7 @@ after running this command.  Not all Linux kernel CD-ROM drivers support the
 auto-eject mode.  There is no way to find out the state of the auto-eject mode.
 .PP
 You need appropriate privileges to access the device files.  Running as root is
-required to eject some devices (e.g. SCSI devices).
+required to eject some devices (e.g., SCSI devices).
 .SH AUTHORS
 .MT tranter@\:pobox.com
 Jeff Tranter
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index cd509f72b..9abffc6fe 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -31,7 +31,7 @@ Not all columns are supported on all architectures.  If an unsupported column is
 specified, \fBlscpu\fP prints the column but does not provide any data for it.
 .sp
 The default output formatting on terminal maybe optimized for better
-readability.  The output for non-terminals (e.g. pipes) is never affected by
+readability.  The output for non-terminals (e.g., pipes) is never affected by
 this optimization and it is always in "Field: data\\n" format.
 .sp
 The cache sizes are reported as summary from all CPUs.  The versions before
diff --git a/sys-utils/lsmem.1 b/sys-utils/lsmem.1
index 4476d3eaf..0e563daf5 100644
--- a/sys-utils/lsmem.1
+++ b/sys-utils/lsmem.1
@@ -17,7 +17,7 @@ together with a columns list in environments where a stable output is required.
 
 The \fBlsmem\fP command lists a new memory range always when the current memory
 block distinguish from the previous block by some output column.  This default
-behavior is possible to override by the \fB\-\-split\fR option (e.g. \fBlsmem
+behavior is possible to override by the \fB\-\-split\fR option (e.g., \fBlsmem
 \-\-split=ZONES\fR).  The special word "none" may be used to ignore all
 differences between memory blocks and to create as large as possible continuous
 ranges.  The opposite semantic is \fB\-\-all\fR to list individual memory
@@ -55,7 +55,7 @@ Do not print a header line.
 Specify which output columns to print.  Use \fB\-\-help\fR
 to get a list of all supported columns.
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fB+\fIlist\fP (e.g. \fBlsmem \-o +NODE\fP).
+specified in the format \fB+\fIlist\fP (e.g., \fBlsmem \-o +NODE\fP).
 .TP
 .B \-\-output\-all
 Output all available columns.
diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index aba372669..3d13ea36b 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -49,7 +49,7 @@ Specify which output columns to print.  Use \fB\-\-help\fR
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fB+\fIlist\fP (e.g. \fBlsns \-o +PATH\fP).
+specified in the format \fB+\fIlist\fP (e.g., \fBlsns \-o +PATH\fP).
 .TP
 .B \-\-output\-all
 Output all available columns.
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 0b914b03e..97ee5bddd 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -113,7 +113,7 @@ options to avoid ambivalent interpretation of the given argument.  For example:
 .sp
 .RE
 
-The same filesystem may be mounted more than once, and in some cases (e.g.
+The same filesystem may be mounted more than once, and in some cases (e.g.,
 network filesystems) the same filesystem may be mounted on the same
 mountpoint more times. The mount command does not implement any policy to
 control this behavior. All behavior is controlled by the kernel and it is usually
@@ -318,7 +318,7 @@ to use NFS or CIFS source on command line.
 Since version 2.35 \fBmount\fR command does not exit when user permissions are
 inadequate by internal libmount security rules.  It drops suid permissions
 and continue as regular non-root user. It allows to support use-cases where
-root permissions are not necessary (e.g. fuse filesystems, user namespaces,
+root permissions are not necessary (e.g., fuse filesystems, user namespaces,
 etc).
 .PP
 For more details, see
@@ -390,7 +390,7 @@ a second place by using:
 .RE
 
 Note that the filesystem mount options maintained by kernel will remain the same as those
-on the original mount point.  The userspace mount options (e.g. _netdev) will not be copied
+on the original mount point.  The userspace mount options (e.g., _netdev) will not be copied
 by
 .BR mount (8)
 and it's necessary explicitly specify the options on mount command line.
@@ -1287,7 +1287,7 @@ This option implies the options
 .TP
 .B X-*
 All options prefixed with "X-" are interpreted as comments or as userspace
-application-specific options.  These options are not stored in the user space (e.g. mtab file),
+application-specific options.  These options are not stored in the user space (e.g., mtab file),
 nor sent to the mount.\fItype\fR helpers nor to the
 .BR mount (2)
 system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
@@ -1440,7 +1440,7 @@ independent of indices created in other instances of devpts.
 
 All mounts of devpts without this
 .B newinstance
-option share the same set of pty indices (i.e. legacy mode).
+option share the same set of pty indices (i.e., legacy mode).
 Each mount of devpts with the
 .B newinstance
 option has a private set of pty indices.
diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index aacae5352..6a96f77ec 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -106,7 +106,7 @@ files described in
 Enter all namespaces of the target process by the default
 .I /proc/[pid]/ns/*
 namespace paths. The default paths to the target process namespaces may be
-overwritten by namespace specific options (e.g. --all --mount=[path]).
+overwritten by namespace specific options (e.g., --all --mount=[path]).
 
 The user namespace will be ignored if the same as the caller's current user
 namespace. It prevents a caller that has dropped capabilities from regaining
diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 4f70c39c9..6891f3a0e 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -134,7 +134,7 @@ Disable a previously set alarm.
 .TP
 .B show
 Print alarm information in format: "alarm: off|on  <time>".
-The time is in ctime() output format, e.g. "alarm: on  Tue Nov 16 04:48:45 2010".
+The time is in ctime() output format, e.g., "alarm: on  Tue Nov 16 04:48:45 2010".
 .RE
 .TP
 .BR \-n , " \-\-dry-run"
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 1b82fa5e6..fc9a577b1 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -217,7 +217,7 @@ Swap over \fBNFS\fR may not work.
 .SS Suspend
 .B swapon
 automatically detects and rewrites a swap space signature with old software
-suspend data (e.g. S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't
+suspend data (e.g., S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't
 do it, then we get data corruption the next time an attempt at unsuspending is
 made.
 .SH ENVIRONMENT
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 9bec521e7..785393f0c 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -180,7 +180,7 @@ Note that
 .B umount
 reads information about mounted filesystems from kernel (/proc/mounts) and
 filesystem names may be different than filesystem names used in the /etc/fstab
-(e.g. "nfs4" vs. "nfs").
+(e.g., "nfs4" vs. "nfs").
 .TP
 .BR \-v , " \-\-verbose"
 Verbose mode.
@@ -207,7 +207,7 @@ user= mount option is not required.
 Since version 2.35 \fBumount\fR command does not exit when user permissions are
 inadequate by internal libmount security rules.  It drops suid permissions
 and continue as regular non-root user. It allows to support use-cases where
-root permissions are not necessary (e.g. fuse filesystems, user namespaces,
+root permissions are not necessary (e.g., fuse filesystems, user namespaces,
 etc).
 .SH "LOOP DEVICE"
 The
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 8e8d89006..9a4196743 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -190,7 +190,7 @@ the kernel gives permission to call
 only after the GID map (\fB/proc/\fIpid\fB/gid_map\fR) has been set.
 The GID map is writable by root when
 .BR \%setgroups (2)
-is enabled (i.e. \fBallow\fR, the default), and
+is enabled (i.e., \fBallow\fR, the default), and
 the GID map becomes writable by unprivileged processes when
 .BR \%setgroups (2)
 is permanently disabled (with \fBdeny\fR).
diff --git a/term-utils/script.1 b/term-utils/script.1
index 815707e91..1b70dec5c 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -71,7 +71,7 @@ means also passwords) independently on the terminal echo flag setting.
 .SH OPTIONS
 Below, the \fIsize\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
+(the "iB" is optional, e.g., "K" has the same meaning as "KiB"), or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
 \fB\-a\fR, \fB\-\-append\fR
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 626b5a1bf..22f8d6b27 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -102,7 +102,7 @@ are
 .IR signal ,
 or
 .IR info .
-This option is recommended for multi-stream logs (e.g. --log-io)
+This option is recommended for multi-stream logs (e.g., \-\-log-io)
 to print only specified data.
 .TP
 .BR \-V , " \-\-version"
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 1ff33256b..eb508f6d4 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -46,7 +46,7 @@ format.
 .SH OPTIONS
 Below, the \fIlength\fR and \fIoffset\fR arguments may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
+(the "iB" is optional, e.g., "K" has the same meaning as "KiB"), or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
 \fB\-b\fR, \fB\-\-one\-byte\-octal\fR
@@ -323,7 +323,7 @@ If, as a result of the specification of the
 .B \-n
 option or end-of-file being reached, input data only partially satisfies a
 format string, the input block is zero-padded sufficiently to display all
-available data (i.e. any format units overlapping the end of data will
+available data (i.e., any format units overlapping the end of data will
 display some number of the zero bytes).
 .PP
 Further output by such format strings is replaced by an equivalent number of
-- 
2.24.0
