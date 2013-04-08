Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:56739 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935764Ab3DHTeQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:16 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so4708044wey.33
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/14] docs: add mkfs.cramfs manual page
Date: Mon,  8 Apr 2013 20:32:58 +0100
Message-Id: <1365449579-13238-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/Makemodule.am |  1 +
 disk-utils/mkfs.cramfs.8 | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 disk-utils/mkfs.cramfs.8

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index fb5daba..70b058b 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -96,6 +96,7 @@ fsck_cramfs_LDADD = $(LDADD) -lz libcommon.la
 sbin_PROGRAMS += mkfs.cramfs
 mkfs_cramfs_SOURCES = disk-utils/mkfs.cramfs.c $(cramfs_common_sources)
 mkfs_cramfs_LDADD = $(LDADD) -lz libcommon.la
+dist_man_MANS += disk-utils/mkfs.cramfs.8
 
 check_PROGRAMS += test_fsck.cramfs
 test_fsck_cramfs_SOURCES = $(fsck_cramfs_SOURCES)
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
new file mode 100644
index 0000000..08eeb1a
--- /dev/null
+++ b/disk-utils/mkfs.cramfs.8
@@ -0,0 +1,90 @@
+.TH EXAMPLE "8" "April 2013" "util-linux" "System Administration"
+.SH NAME
+mkfs.cramfs \- make compressed ROM file system
+.SH SYNOPSIS
+.B mkfs.cramfs
+[options]
+.I directory file
+.SH DESCRIPTION
+Files on cramfs file systems are zlib-compressed one page at a time to
+allow random read access.  The metadata is not compressed, but is
+expressed in a terse representation that is more space-efficient than
+conventional file systems.
+.PP
+The file system is intentionally read-only to simplify its design; random
+write access for compressed files is difficult to implement.  cramfs
+ships with a utility (mkcramfs) to pack files into new cramfs images.
+.PP
+File sizes are limited to less than 16MB.
+.PP
+Maximum file system size is a little under 272MB.  (The last file on the
+file system must begin before the 256MB block, but can extend past it.)
+.SH ARGUMENTS
+The
+.I directory
+is simply the root of the directory tree that we want to generate a
+compressed filesystem out of.
+.PP
+The
+.I file
+will contain the cram file system, which later can be mounted.
+.SH OPTIONS
+.TP
+\fB\-v\fR
+Enable verbose messaging.
+.TP
+\fB\-E\fR
+Treat all warnings as errors, which are reflected as command return value.
+.TP
+\fB\-b\fR \fIblocksize\fR
+Use defined block size, which has to be divisible by page size.
+.TP
+\fB\-e\fR \fIedition\fR
+Use defined file system edition number in superblock.
+.TP
+\fB\-N\fR \fIbig, little, host\fR
+Use defined endianness.  Value defaults to
+.IR host .
+.TP
+\fB\-i\fR \fIfile\fR
+Insert a
+.I file
+to cramfs file system.
+.TP
+\fB\-n\fR \fIname\fR
+Set name of the cramfs file system.
+.TP
+\fB\-p\fR
+Pad by 512 bytes for boot code.
+.TP
+\fB\-s\fR
+This option is ignored.  Originally the \-s turned on directory entry
+sorting.
+.TP
+\fB\-z\fR
+Make explicit holes.  Use of this option will require 2.3.39 kernel, or newer.
+.TP
+\fB\-V\fR
+Display version information and exit.
+.TP
+\fB\-h\fR
+Display help and exit.
+.SH "EXIT STATUS"
+.RS
+.PD 0
+.TP
+.B 0
+success
+.TP
+.B 8
+operation error, such as unable to allocate memory
+.PD
+.RE
+.SH "SEE ALSO"
+.BR mount (8),
+.BR fsck.cramfs (8)
+.SH AVAILABILITY
+The example command is part of the util-linux package and is available from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.8.2.1

