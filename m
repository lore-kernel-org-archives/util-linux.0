Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.hi.is ([130.208.165.104]:40698 "EHLO mx2.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeCaWu4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 31 Mar 2018 18:50:56 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by mx2.hi.is (8.14.7/8.14.7) with ESMTP id w2VMonPE001947
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 31 Mar 2018 22:50:51 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w2VMon6B032422
        for <util-linux@vger.kernel.org>; Sat, 31 Mar 2018 22:50:49 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w2VMonp1032421
        for util-linux@vger.kernel.org; Sat, 31 Mar 2018 22:50:49 GMT
Date: Sat, 31 Mar 2018 22:50:49 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] sys-utils/fallocate.1: Some tidying of the manual
Message-ID: <20180331225048.GA32373@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Test nr. 2:

Enable and fix warnings from 'test-groff'.

Input file is /tmp/fallocate.1

<fallocate.1>:10 (macro IR): only 1 argument, but more are expected
<fallocate.1>:24 (macro RB): only 1 argument, but more are expected
<fallocate.1>:25 (macro IR): only 1 argument, but more are expected

chk_manuals: Output is from: test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z

  and

Test nr. 15:

Change the name of a macro for two fonts (e.g., BR and IR) to one letter,
if there is only one argument.
Add the second argument if needed.  It is sometimes part of the first one.

10:.IR length
24:.RB \-l
25:.IR length

#####

Test nr. 12:

Change -- in x--y to \(em (em-dash), or, if an
option, to \-\-

65:You can think of this option as doing a "\fBcp --sparse\fP" and then renaming

#####

Test nr. 20:

Use a macro to change to the italic font, instead of \fI [1], if
possible.
The macros have the italic corrections, but "\c" removes them.
[1] man-pages(7)

39:The \fIlength\fR and \fIoffset\fR
50:to be collapsed starts at \fIoffset\fP and continues
51:for \fIlength\fR bytes.  At the completion of the operation, the contents of
52:the file starting at the location \fIoffset\fR+\fIlength\fR will be appended at the
53:location \fIoffset\fR, and the file will be \fIlength\fR bytes smaller.  The option
71:Insert a hole of \fIlength\fR bytes from \fIoffset\fR, shifting existing data.
85:\fIoffset\fP and continuing for \fIlength\fR bytes.  Within the
103:Zeroes space in the byte range starting at \fIoffset\fP and
104:continuing for \fIlength\fR bytes.  Within the specified range, blocks are

#####

Test nr. 27:

Split lines longer than 80 characters into two or more lines.
Apropriate break points are the end of a sentence and a subordinate
clause.

fallocate.1: line 45	length 86
fallocate.1: line 52	length 83
fallocate.1: line 53	length 83
fallocate.1: line 100	length 95

#####

Test nr. 28:

Wrong distance between sentences or protect the indicator.

1) Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) and "info groff".

Or

2) Adjust space between sentences (two spaces),

3) or protect the indicator by adding "\&" after it.

The "indicator" is an "end-of-sentence character" (.!?).

99:Enable POSIX operation mode. In that mode allocation operation always completes,

#####

Test nr. 37:

Have a space after a comma in an argument to an alternating fonts macro.
The space belongs to the comma, so ', '.

48:.BR \-c , " \-\-collapse\-range"
58:.BR \-d , " \-\-dig\-holes"
70:.BR \-i , " \-\-insert\-range"
73:.BR \-l , " \-\-length " \fIlength
76:.BR \-n , " \-\-keep\-size"
80:.BR \-o , " \-\-offset " \fIoffset
83:.BR \-p , " \-\-punch\-hole"
95:.BR \-v , " \-\-verbose"
98:.BR \-x , " \-\-posix"
102:.BR \-z , " \-\-zero\-range"
119:.BR \-V , " \-\-version"
122:.BR \-h , " \-\-help"

#####

Test nr. 38:

Email addresses use the macro ".MT" and end with ".ME".

125:.UR sandeen@redhat.com
129:.UR kzak@redhat.com

#####

Test nr. 40:

Add a comma before "and", "or", or "nor" if a series contains three or
more words

41:MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
43:KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
45:The options \fB\-\-collapse\-range\fP, \fB\-\-dig\-holes\fP, \fB\-\-punch\-hole\fP and

#####

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/fallocate.1 | 151 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 98 insertions(+), 53 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 0cbb5c994..d4821dcd1 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -7,7 +7,7 @@ fallocate \- preallocate or deallocate space to a file
 .RB [ \-o
 .IR offset ]
 .B \-l
-.IR length
+.I length
 .RB [ \-n ]
 .I filename
 .PP
@@ -21,89 +21,134 @@ fallocate \- preallocate or deallocate space to a file
 .B fallocate \-x
 .RB [ \-o
 .IR offset ]
-.RB \-l
-.IR length
+.B \-l
+.I length
 .I filename
 .SH DESCRIPTION
 .B fallocate
-is used to manipulate the allocated disk space for a file, either to deallocate
-or preallocate it.  For filesystems which support the fallocate system call,
+is used to manipulate the allocated disk space for a file,
+either to deallocate or preallocate it.
+For filesystems which support the fallocate system call,
 preallocation is done quickly by allocating blocks and marking them as
-uninitialized, requiring no IO to the data blocks.  This is much faster than
-creating a file by filling it with zeroes.
+uninitialized, requiring no IO to the data blocks.
+This is much faster than creating a file by filling it with zeroes.
 .PP
 The exit code returned by
 .B fallocate
 is 0 on success and 1 on failure.
 .SH OPTIONS
-The \fIlength\fR and \fIoffset\fR
+The
+.I length
+and
+.I offset
 arguments may be followed by the multiplicative suffixes KiB (=1024),
-MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB, and YiB (the "iB" is
 optional, e.g., "K" has the same meaning as "KiB") or the suffixes
-KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB, and YB.
 .PP
-The options \fB\-\-collapse\-range\fP, \fB\-\-dig\-holes\fP, \fB\-\-punch\-hole\fP and
-\fB\-\-zero\-range\fP are mutually exclusive.
+The options
+.BR \-\-collapse\-range ", " \-\-dig\-holes ", " \-\-punch\-hole ,
+and
+.B \-\-zero\-range
+are mutually exclusive.
 .TP
-.BR \-c , " \-\-collapse\-range"
-Removes a byte range from a file, without leaving a hole.  The byte range
-to be collapsed starts at \fIoffset\fP and continues
-for \fIlength\fR bytes.  At the completion of the operation, the contents of
-the file starting at the location \fIoffset\fR+\fIlength\fR will be appended at the
-location \fIoffset\fR, and the file will be \fIlength\fR bytes smaller.  The option
-\fB\-\-keep\-size\fR may not be specified for the collapse-range operation.
+.BR \-c ", " \-\-collapse\-range
+Removes a byte range from a file, without leaving a hole.
+The byte range to be collapsed starts at
+.I offset
+and continues for
+.I length
+bytes.
+At the completion of the operation,
+the contents of the file starting at the location
+.IR offset + length
+will be appended at the location
+.IR offset ,
+and the file will be
+.I length
+bytes smaller.
+The option
+.B \-\-keep\-size
+may not be specified for the collapse-range operation.
 .sp
 Available since Linux 3.15 for ext4 (only for extent-based files) and XFS.
 .TP
-.BR \-d , " \-\-dig\-holes"
-Detect and dig holes.  This makes the file sparse in-place, without using extra
-disk space.  The minimum size of the hole depends on filesystem I/O block size
-(usually 4096 bytes).  Also, when using this option, \fB\-\-keep\-size\fP is
-implied.  If no range is specified by \fB\-\-offset\fP and \fB\-\-length\fP,
+.BR \-d ", " \-\-dig\-holes
+Detect and dig holes.
+This makes the file sparse in-place, without using extra disk space.
+The minimum size of the hole depends on filesystem I/O block size
+(usually 4096 bytes).
+Also, when using this option,
+.B \-\-keep\-size
+is implied.  If no range is specified by
+.B \-\-offset
+and
+.BR \-\-length ,
 then the entire file is analyzed for holes.
 .sp
-You can think of this option as doing a "\fBcp --sparse\fP" and then renaming
-the destination file to the original, without the need for extra disk space.
+You can think of this option as doing a
+.RB """" "cp \-\-sparse" """"
+and then renaming the destination file to the original,
+without the need for extra disk space.
 .sp
 See \fB\-\-punch\-hole\fP for a list of supported filesystems.
 .TP
-.BR \-i , " \-\-insert\-range"
-Insert a hole of \fIlength\fR bytes from \fIoffset\fR, shifting existing data.
+.BR \-i ", " \-\-insert\-range
+Insert a hole of
+.I length
+bytes from
+.IR offset ,
+shifting existing data.
 .TP
-.BR \-l , " \-\-length " \fIlength
+.BR \-l ", " "\-\-length " \fIlength
 Specifies the length of the range, in bytes.
 .TP
-.BR \-n , " \-\-keep\-size"
+.BR \-n ", " \-\-keep\-size
 Do not modify the apparent length of the file.  This may effectively allocate
 blocks past EOF, which can be removed with a truncate.
 .TP
-.BR \-o , " \-\-offset " \fIoffset
+.BR \-o ", " "\-\-offset " \fIoffset
 Specifies the beginning offset of the range, in bytes.
 .TP
-.BR \-p , " \-\-punch\-hole"
+.BR \-p ", " \-\-punch\-hole
 Deallocates space (i.e., creates a hole) in the byte range starting at
-\fIoffset\fP and continuing for \fIlength\fR bytes.  Within the
-specified range, partial filesystem blocks are zeroed, and whole
-filesystem blocks are removed from the file.  After a successful
-call, subsequent reads from this range will return zeroes.  This option
-may not be specified at the same time as  the \fB\-\-zero\-range\fP option.
-Also, when using this option, \fB\-\-keep\-size\fP is implied.
+.I offset
+and continuing for
+.I length
+bytes.
+Within the specified range, partial filesystem blocks are zeroed,
+and whole filesystem blocks are removed from the file.
+After a successful call,
+subsequent reads from this range will return zeroes.
+This option may not be specified at the same time as the
+.B \-\-zero\-range
+option.
+Also, when using this option,
+.B \-\-keep\-size
+is implied.
 .sp
 Supported for XFS (since Linux 2.6.38), ext4 (since Linux 3.0),
 Btrfs (since Linux 3.7) and tmpfs (since Linux 3.5).
 .TP
-.BR \-v , " \-\-verbose"
+.BR \-v ", " \-\-verbose
 Enable verbose mode.
 .TP
-.BR \-x , " \-\-posix"
-Enable POSIX operation mode. In that mode allocation operation always completes,
-but it may take longer time when fast allocation is not supported by the underlying filesystem.
+.BR \-x ", " \-\-posix
+Enable POSIX operation mode.
+In that mode allocation operation always completes,
+but it may take longer time when fast allocation is not supported by
+the underlying filesystem.
 .TP
-.BR \-z , " \-\-zero\-range"
-Zeroes space in the byte range starting at \fIoffset\fP and
-continuing for \fIlength\fR bytes.  Within the specified range, blocks are
-preallocated for the regions that span the holes in the file.  After
-a successful call, subsequent reads from this range will return zeroes.
+.BR \-z ", " \-\-zero\-range
+Zeroes space in the byte range starting at
+.I offset
+and continuing for
+.I length
+bytes.
+Within the specified range, blocks are preallocated for the regions
+that span the holes in the file.
+After a successful call,
+subsequent reads from this range will return zeroes.
 .sp
 Zeroing is done within the filesystem preferably by converting the
 range into unwritten extents.  This approach means that the specified
@@ -116,19 +161,19 @@ modification.
 .sp
 Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
 .TP
-.BR \-V , " \-\-version"
+.BR \-V ", " \-\-version
 Display version information and exit.
 .TP
-.BR \-h , " \-\-help"
+.BR \-h ", " \-\-help
 Display help text and exit.
 .SH AUTHORS
-.UR sandeen@redhat.com
+.MT sandeen@redhat.com
 Eric Sandeen
-.UE
+.ME
 .br
-.UR kzak@redhat.com
+.MT kzak@redhat.com
 Karel Zak
-.UE
+.ME
 .SH SEE ALSO
 .BR truncate (1),
 .BR fallocate (2),
-- 
2.16.2

-- 
Bjarni I. Gislason
