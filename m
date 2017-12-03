Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44624 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdLCMvZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Dec 2017 07:51:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so1400711wmc.3
        for <util-linux@vger.kernel.org>; Sun, 03 Dec 2017 04:51:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] docs: improve setarch(8) manual page
Date: Sun,  3 Dec 2017 12:51:16 +0000
Message-Id: <20171203125117.28159-3-kerolasa@iki.fi>
In-Reply-To: <20171203125117.28159-1-kerolasa@iki.fi>
References: <20171203125117.28159-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add more information when and why one might want to use various options.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.8 | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index 73874c8b6..ce7ba97ac 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -1,4 +1,4 @@
-.TH SETARCH 8 "December 2014" "util-linux" "System Administration"
+.TH SETARCH 8 "December 2017" "util-linux" "System Administration"
 .SH NAME
 setarch \- change reported architecture in new program environment and set personality flags
 .SH SYNOPSIS
@@ -30,41 +30,70 @@ can actually set each of these architectures depends on the running kernel.
 .TP
 .B \-\-uname\-2.6
 Causes the \fIprogram\fR to see a kernel version number beginning with 2.6.
+Turns on UNAME26.
 .TP
 .BR \-v , " \-\-verbose"
 Be verbose.
 .TP
 \fB\-3\fR, \fB\-\-3gb\fR
-Specifies that processes should use a maximum of 3GB of address space on systems where it is supported (ADDR_LIMIT_3GB).
+Specifies
+.I program
+should use a maximum of 3GB of address space.  Supported on x86 (as of
+2017-12-02).  Turns on ADDR_LIMIT_3GB.
 .TP
 \fB\-\-4gb\fR
-Ignored (for backward compatibility only).
+Ignored for backward compatibility only.
 .TP
 \fB\-B\fR, \fB\-\-32bit\fR
-Turns on ADDR_LIMIT_32BIT.
+Limit the address space to 32 bits to emulate hardware.  Supported on ARM
+and Alpha (as of 2017-12-02).  Turns on ADDR_LIMIT_32BIT.
 .TP
 \fB\-F\fR, \fB\-\-fdpic\-funcptrs\fR
-Userspace function pointers point to descriptors (turns on FDPIC_FUNCPTRS).
+User-space function pointers to signal handlers point.  Use when kernel does
+not have MMU.  Supported on ARM, Blackfin, Fujitsu FR-V, and SuperH (as of
+2017-12-02).  Turns on FDPIC_FUNCPTRS.
 .TP
 \fB\-I\fR, \fB\-\-short\-inode\fR
-Turns on SHORT_INODE.
+Obsolete bug emulation flag.  Turns on SHORT_INODE.
 .TP
 \fB\-L\fR, \fB\-\-addr\-compat\-layout\fR
-Changes the way virtual memory is allocated (turns on the ADDR_COMPAT_LAYOUT).
+Provide legacy virtual address space layout.  Use when the
+.I program
+binary does not have PT_GNU_STACK ELF header.  Turns on
+ADDR_COMPAT_LAYOUT.
 .TP
 \fB\-R\fR, \fB\-\-addr\-no\-randomize\fR
-Disables randomization of the virtual address space (turns on ADDR_NO_RANDOMIZE).
+Disables randomization of the virtual address space.  Turns on
+ADDR_NO_RANDOMIZE.
 .TP
 \fB\-S\fR, \fB\-\-whole\-seconds\fR
-Turns on WHOLE_SECONDS.
+Obsolete bug emulation flag.  Turns on WHOLE_SECONDS.
 .TP
 \fB\-T\fR, \fB\-\-sticky\-timeouts\fR
+This makes
+.BR select (2),
+.BR pselect (2),
+and
+.BR ppoll (2)
+system calls preserve the timeout value instead of storing the unslept time
+when interrupted by a signal handler.  Use when
+.I program
+depends on this behavior, and the source code is not available to be fixed.
 Turns on STICKY_TIMEOUTS.
 .TP
 \fB\-X\fR, \fB\-\-read\-implies\-exec\fR
-Turns on READ_IMPLIES_EXEC.
+If this is set then
+.BR mmap (3)
+PROT_READ will also add the PROT_EXEC bit - as expected by legacy x86
+binaries.  Notice that the ELF loader will automatically set this bit when
+it encounters a legacy binary.  Turns on READ_IMPLIES_EXEC.
 .TP
 \fB\-Z\fR, \fB\-\-mmap\-page\-zero\fR
+SVr4 bug emulation that will set
+.BR mmap (3)
+page zero as read-only.  Use when
+.I program
+depends on this behavior, and the source code is not available to be fixed.
 Turns on MMAP_PAGE_ZERO.
 .TP
 .BR \-V , " \-\-version"
@@ -86,6 +115,8 @@ Elliot Lee
 .MT jnovy@redhat.com
 Jindrich Novy
 .ME
+.SH "SEE ALSO"
+.BR personality (2)
 .SH AVAILABILITY
 The setarch command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-- 
2.15.1

