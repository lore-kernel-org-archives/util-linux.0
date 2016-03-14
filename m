Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:56845 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755470AbcCNJK3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 05:10:29 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] fallocate: restore man-page content that was deleted in commit 5b033bfd
Date: Mon, 14 Mar 2016 10:10:10 +0100
Message-Id: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/fallocate.1 |  120 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index f68112d..dd9f293 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -1,3 +1,114 @@
+.TH FALLOCATE 1 "September 2011" "util-linux" "User Commands"
+.SH NAME
+fallocate \- preallocate or deallocate space to a file
+.SH SYNOPSIS
+.B fallocate
+.RB [ \-c ]
+.RB [ \-n ]
+.RB [ \-p ]
+.RB [ \-z ]
+.RB [ \-o
+.IR offset ]
+.B \-l
+.IR length
+.I filename
+.PP
+.B fallocate \-d
+.RB [ \-o
+.IR offset ]
+.RB [ \-l
+.IR length ]
+.I filename
+.SH DESCRIPTION
+.B fallocate
+is used to manipulate the allocated disk space for a file, either to deallocate
+or preallocate it.  For filesystems which support the fallocate system call,
+preallocation is done quickly by allocating blocks and marking them as
+uninitialized, requiring no IO to the data blocks.  This is much faster than
+creating a file by filling it with zeros.
+.PP
+The exit code returned by
+.B fallocate
+is 0 on success and 1 on failure.
+.SH OPTIONS
+The \fIlength\fR and \fIoffset\fR
+arguments may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+.PP
+The options \fB\-\-collapse\-range\fP, \fB\-\-dig\-holes\fP, \fB\-\-punch\-hole\fP and
+\fB\-\-zero\-range\fP are mutually exclusive.
+.TP
+.BR \-c , " \-\-collapse\-range"
+Removes a byte range from a file, without leaving a hole.  The byte range
+to be collapsed starts at \fIoffset\fP and continues
+for \fIlength\fR bytes.  At the completion of the operation, the contents of
+the file starting at the location \fIoffset\fR+\fIlength\fR will be appended at the
+location \fIoffset\fR, and the file will be \fIlength\fR bytes smaller.  The option
+\fB\-\-keep\-size\fR may not be specified for colapse range operation.
+.sp
+Available since Linux 3.15 for ext4 (only for extent-based files) and XFS.
+.TP
+.BR \-d , " \-\-dig\-holes"
+Detect and dig holes.  This makes the file sparse in-place, without using extra
+disk space.  The minimum size of the hole depends on filesystem I/O block size
+(usually 4096 bytes).  Also, when using this option, \fB\-\-keep\-size\fP is
+implied.  If no range is specified by \fB\-\-offset\fP and \fB\-\-length\fP,
+then the entire file is analyzed for holes.
+.sp
+You can think of this option as doing a "\fBcp --sparse\fP" and then renaming
+the destination file to the original, without the need for extra disk space.
+.sp
+See \fB\-\-punch\-hole\fP for a list of supported filesystems.
+.TP
+.BR \-l , " \-\-length " \fIlength
+Specifies the length of the range, in bytes.
+.TP
+.BR \-n , " \-\-keep\-size"
+Do not modify the apparent length of the file.  This may effectively allocate
+blocks past EOF, which can be removed with a truncate.
+.TP
+.BR \-o , " \-\-offset " \fIoffset
+Specifies the beginning offset of the range, in bytes.
+.TP
+.BR \-p , " \-\-punch\-hole"
+Deallocates space (i.e., creates a hole) in the byte range starting at
+\fIoffset\fP and continuing for \fIlength\fR bytes.  Within the
+specified range, partial filesystem blocks are zeroed, and whole
+filesystem blocks are removed from the file.  After a successful
+call, subsequent reads from this range will return zeroes.  This option
+may not be specified at the same time as  the \fB\-\-zero\-range\fP option.
+Also, when using this option, \fB\-\-keep\-size\fP is implied.
+.sp
+Supported for XFS (since Linux 2.6.38), ext4 (since Linux 3.0),
+Btrfs (since Linux 3.7) and tmpfs (since Linux 3.5).
+.TP
+.BR \-v , " \-\-verbose"
+Enable verbose mode.
+.TP
+.BR \-z , " \-\-zero\-range"
+Zeroes space in the byte range starting at \fIoffset\fP and
+continuing for \fIlength\fR bytes.  Within the specified range, blocks are
+preallocated for the regions that span the holes in the file.  After
+a successful call, subsequent reads from this range will return zeroes.
+.sp
+Zeroing is done within the filesystem preferably by converting the
+range into unwritten extents.  This approach means that the specified
+range will not be physically zeroed out on the device (except for
+partial blocks at the either end of the range), and I/O is
+(otherwise) required only to update metadata.
+.sp
+Option \fB\-\-keep\-size\fP can be specified to prevent file length
+modification.
+.sp
+Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHORS
 .UR sandeen@redhat.com
 Eric Sandeen
@@ -6,3 +117,12 @@ Eric Sandeen
 .UR kzak@redhat.com
 Karel Zak
 .UE
+.SH SEE ALSO
+.BR fallocate (2),
+.BR posix_fallocate (3),
+.BR truncate (1)
+.SH AVAILABILITY
+The fallocate command is part of the util-linux package and is available from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.7.0.4

