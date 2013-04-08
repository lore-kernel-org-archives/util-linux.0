Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36444 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935764Ab3DHTeT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:19 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so6086379wgg.0
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/14] docs: add fsck.cramfs manual page
Date: Mon,  8 Apr 2013 20:32:59 +0100
Message-Id: <1365449579-13238-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/Makemodule.am |  1 +
 disk-utils/fsck.cramfs.8 | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 disk-utils/fsck.cramfs.8

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index 70b058b..22d066b 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -92,6 +92,7 @@ cramfs_common_sources = disk-utils/cramfs.h disk-utils/cramfs_common.c
 sbin_PROGRAMS += fsck.cramfs
 fsck_cramfs_SOURCES = disk-utils/fsck.cramfs.c $(cramfs_common_sources)
 fsck_cramfs_LDADD = $(LDADD) -lz libcommon.la
+dist_man_MANS += disk-utils/fsck.cramfs.8
 
 sbin_PROGRAMS += mkfs.cramfs
 mkfs_cramfs_SOURCES = disk-utils/mkfs.cramfs.c $(cramfs_common_sources)
diff --git a/disk-utils/fsck.cramfs.8 b/disk-utils/fsck.cramfs.8
new file mode 100644
index 0000000..5519cbc
--- /dev/null
+++ b/disk-utils/fsck.cramfs.8
@@ -0,0 +1,57 @@
+.TH EXAMPLE "8" "April 2013" "util-linux" "System Administration"
+.SH NAME
+fsck.cramfs \- fsck compressed ROM file system
+.SH SYNOPSIS
+.B mkfs.cramfs
+[options]
+.I file
+.SH DESCRIPTION
+.I mkfs.cramfs
+is used to check the cramfs file system.
+.SH OPTIONS
+.TP
+\fB\-v\fR, \fB\-\-verbose\fR
+Enable verbose messaging.
+.TP
+\fB\-x\fR, \fB\-\-destination\fR [\fIdirectory\fR]
+Extract contents of the
+.I file
+to
+.IR directory .
+.TP
+\fB\-a\fR
+This option is silently ignored.
+.TP
+\fB\-y\fR
+This option is silently ignored.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
+.SH "EXIT STATUS"
+.RS
+.PD 0
+.TP
+.B 0
+success
+.TP
+.B 4
+file system was left uncorrected
+.TP
+.B 8
+operation error, such as unable to allocate memory
+.TP
+.B 16
+usage information was printed
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

