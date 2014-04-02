Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51774 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226AbaDBLbR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 07:31:17 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s32BVFuw010255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 07:31:15 -0400
From: Lukas Czerner <lczerner@redhat.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH] fallocate: add FALLOC_FL_ZERO_RANGE support
Date: Wed,  2 Apr 2014 13:31:05 +0200
Message-Id: <1396438265-21535-1-git-send-email-lczerner@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Recent Linux kernel supports FALLOC_FL_ZERO_RANGE in fallocate(2).
This patch adds FALLOC_FL_ZERO_RANGE support to fallocate utility,
by introducing a new option -z|--zero-range.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 sys-utils/fallocate.1 | 14 ++++++++++++++
 sys-utils/fallocate.c | 25 +++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 634c595..1177cf3 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -7,6 +7,7 @@ fallocate \- preallocate or deallocate space to a file
 .RB [ \-n ]
 .RB [ \-p ]
 .RB [ \-c ]
+.RB [ \-z ]
 .RB [ \-o
 .IR offset ]
 .B \-l
@@ -46,6 +47,9 @@ Do not modify the apparent length of the file.  This may effectively allocate
 blocks past EOF, which can be removed with a truncate.
 .IP "\fB\-p, \-\-punch-hole\fP"
 Punch holes in the file, the range should not exceed the length of the file.
+This option may not be specified at the same time as the
+.B \-z
+option.
 .IP "\fB\-d, \-\-dig-holes\fP"
 Detect and dig holes. Makes the file sparse in-place, without using extra disk
 space. The minimal size of the hole depends on filesystem I/O block size
@@ -61,6 +65,16 @@ Collapse a particular file range to nullify the hole. Extents beyond the range
 command does not leave a hole, while \fI\-\-punch-hole\fP leaves a hole
 instead of shifting extents. Both offset and length should be aligned to
 the block size of filesystem.
+.IP "\fB\-z, \-\-zero-range\fP"
+Zero range in the file. Regions that span holes in the file will be
+preallocated, this includes areas past EOF. Option
+.B \-n
+can be specified to prevent file length modification. Reads from the range
+will return zeros. This option may not be specified at the same time as the
+.B \-p
+or
+.B \-c
+option.
 .IP "\fB\-o, \-\-offset\fP \fIoffset\fP
 Specifies the beginning offset of the allocation, in bytes.
 .IP "\fB\-l, \-\-length\fP \fIlength\fP
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index f9c00e0..e5c149b 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -40,20 +40,24 @@
 
 #if defined(HAVE_LINUX_FALLOC_H) && \
     (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE) || \
-     !defined(FALLOC_FL_COLLAPSE_RANGE))
+     !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE))
 # include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
 #endif
 
 #ifndef FALLOC_FL_KEEP_SIZE
-# define FALLOC_FL_KEEP_SIZE 1
+# define FALLOC_FL_KEEP_SIZE		0x1
 #endif
 
 #ifndef FALLOC_FL_PUNCH_HOLE
-# define FALLOC_FL_PUNCH_HOLE 2
+# define FALLOC_FL_PUNCH_HOLE		0x2
 #endif
 
 #ifndef FALLOC_FL_COLLAPSE_RANGE
-# define FALLOC_FL_COLLAPSE_RANGE 8
+# define FALLOC_FL_COLLAPSE_RANGE	0x8
+#endif
+
+#ifndef FALLOC_FL_ZERO_RANGE
+# define FALLOC_FL_ZERO_RANGE		0x10
 #endif
 
 #include "nls.h"
@@ -77,6 +81,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -n, --keep-size      don't modify the length of the file\n"), out);
 	fputs(_(" -o, --offset <num>   offset of the (de)allocation, in bytes\n"), out);
 	fputs(_(" -p, --punch-hole     punch holes in the file\n"), out);
+	fputs(_(" -z, --zero-range     zeroes a range in the file\n"), out);
 	fputs(_(" -v, --verbose        verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -270,6 +275,7 @@ int main(int argc, char **argv)
 	    { "punch-hole",     0, 0, 'p' },
 	    { "collapse-range", 0, 0, 'c' },
 	    { "dig-holes",      0, 0, 'd' },
+	    { "zero-range",     0, 0, 'z' },
 	    { "offset",         1, 0, 'o' },
 	    { "length",         1, 0, 'l' },
 	    { "verbose",        0, 0, 'v' },
@@ -281,7 +287,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "hvVncpdl:o:", longopts, NULL))
+	while ((c = getopt_long(argc, argv, "hvVncpdzl:o:", longopts, NULL))
 			!= -1) {
 		switch(c) {
 		case 'h':
@@ -302,6 +308,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dig = 1;
 			break;
+		case 'z':
+			mode |= FALLOC_FL_ZERO_RANGE;
+			break;
 		case 'l':
 			length = cvtnum(optarg);
 			break;
@@ -318,7 +327,8 @@ int main(int argc, char **argv)
 	}
 	if (dig) {
 		if (mode != 0)
-			errx(EXIT_FAILURE, _("Can't use -p or -n with --dig-holes"));
+			errx(EXIT_FAILURE,
+			     _("Can't use other modes with --dig-holes"));
 		if (length == -2LL)
 			length = 0;
 		if (length < 0)
@@ -333,6 +343,9 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("invalid offset value specified"));
 	if (optind == argc)
 		errx(EXIT_FAILURE, _("no filename specified."));
+	if (mode & ~(FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE))
+		errx(EXIT_FAILURE, _("only -n mode can be used with "
+				     "--zero-range"));
 
 	filename = argv[optind++];
 
-- 
1.8.3.1

