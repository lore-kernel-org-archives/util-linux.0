Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:52174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab2JBSoE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2012 14:44:04 -0400
Received: by weyt9 with SMTP id t9so3798033wey.19
        for <util-linux@vger.kernel.org>; Tue, 02 Oct 2012 11:44:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] docs: align blkdiscard.8 with how-to-man-page.txt
Date: Tue,  2 Oct 2012 19:43:59 +0100
Message-Id: <1349203439-4904-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Add spaces after dots (English spacing).
* Remove use of inline emphasis where possible.
* Use mail and url macros.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/blkdiscard.8 | 62 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index fcc38f6..47d3ae5 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -1,5 +1,5 @@
 .\" -*- nroff -*-
-.TH BLKDISCARD 8 "September 2012" "util-linux" "System Administration"
+.TH BLKDISCARD 8 "October 2012" "util-linux" "System Administration"
 .SH NAME
 blkdiscard \- discard sectors on a device
 .SH SYNOPSIS
@@ -11,56 +11,62 @@ blkdiscard \- discard sectors on a device
 .RB [ \-s ]
 .RB [ \-v ]
 .I device
-
 .SH DESCRIPTION
 .B blkdiscard
-is used to discard device sectors. This is useful for solid-state
-drivers (SSDs) and thinly-provisioned storage. Unlike
+is used to discard device sectors.  This is useful for solid-state
+drivers (SSDs) and thinly-provisioned storage.  Unlike
 .BR fstrim (8)
 this command is used directly on the block device.
 .PP
 By default,
 .B blkdiscard
-will discard all blocks on the device. Options may be used to
-modify this behavior based on range or size, as explained below.
+will discard all blocks on the device.  Options may be used to modify
+this behavior based on range or size, as explained below.
 .PP
 The
 .I device
 argument is the pathname of the block device.
-
+.PP
 .B WARNING: All data in the discarded region on the device will be lost!
-
 .SH OPTIONS
-The \fIoffset\fR and \fIlength\fR arguments may be
-followed by the multiplicative suffixes KiB=1024, MiB=1024*1024, and so on for
-GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g. "K" has the same
-meaning as "KiB") or the suffixes KB=1000, MB=1000*1000, and so on for GB, PB,
-EB, ZB and YB.
+The
+.I offset
+and
+.I length
+arguments may be followed by the multiplicative suffixes KiB=1024,
+MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB=1000, MB=1000*1000, and so on for GB, PB, EB, ZB and YB.
 .IP "\fB\-h, \-\-help\fP"
 Print help and exit.
 .IP "\fB\-o, \-\-offset\fP \fIoffset\fP"
-Byte offset in the device from which to discard. Provided value will be
-aligned to the device sector size. Default value is zero.
+Byte offset in the device from which to discard.  Provided value will be
+aligned to the device sector size.  Default value is zero.
 .IP "\fB\-l, \-\-length\fP \fIlength\fP"
-Number of bytes after starting point to discard. Provided value will be
-aligned to the device sector size. If the specified value extends past the
-end of the device,
+Number of bytes after starting point to discard.  Provided value will be
+aligned to the device sector size.  If the specified value extends past
+the end of the device,
 .B blkdiscard
-will stop at the device size boundary. Default value extends to the end
+will stop at the device size boundary.  Default value extends to the end
 of the device.
 .IP "\fB\-s, \-\-secure\fP"
-Perform secure discard. Secure discard is the same as regular discard except
-all copies of the discarded blocks possibly created by garbage collection must
-also be erased. It has to be supported by the device.
+Perform secure discard.  Secure discard is the same as regular discard
+except all copies of the discarded blocks possibly created by garbage
+collection must also be erased.  It has to be supported by the device.
 .IP "\fB\-v, \-\-verbose\fP"
-Print aligned \fIoffset\fR and \fIlength\fR arguments.
-
+Print aligned
+.I offset
+and
+.I length
+arguments.
 .SH AUTHOR
-.nf
-Lukas Czerner <lczerner@redhat.com>
-.fi
+.MT lczerner@redhat.com
+Lukas Czerner
+.ME
 .SH SEE ALSO
 .BR fstrim (8)
 .SH AVAILABILITY
 The blkdiscard command is part of the util-linux package and is available
-from ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.7.12.2

