Return-Path: util-linux-owner@vger.kernel.org
Received: from mailrelay116.isp.belgacom.be ([195.238.20.143]:6661 "EHLO
        mailrelay116.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752198AbcKOSwm (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 15 Nov 2016 13:52:42 -0500
From: Fabian Frederick <fabf@skynet.be>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
        Dongsu Park <dongsu.park@profitbricks.com>,
        Namjae Jeon <namjae.jeon@samsung.com>, P@draigBrady.com,
        fabf@skynet.be
Subject: [PATCH V2] fallocate: add insert range support
Date: Tue, 15 Nov 2016 19:52:26 +0100
Message-Id: <1479235946-4268-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Based on patch 83cc932d7412
("fallocate: introduce an option -c to support COLLAPSE_RANGE")

This patch includes FALLOC_FL_INSERT_RANGE flag
added to Linux kernel v4.1

Thanks to Pádraig Brady for insert range definition

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2: -Using definition in fallocate.c by Pádraig Brady
    -Update definition in fallocate.1

 sys-utils/fallocate.1 |  3 +++
 sys-utils/fallocate.c | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 38b2217..801d096 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -60,6 +60,9 @@ the destination file to the original, without the need for extra disk space.
 .sp
 See \fB\-\-punch\-hole\fP for a list of supported filesystems.
 .TP
+.BR \-i , " \-\-insert\-range"
+Insert a hole of \fIlength\fR bytes from \fIoffset\fR, shifting existing data.
+.TP
 .BR \-l , " \-\-length " \fIlength
 Specifies the length of the range, in bytes.
 .TP
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 4f2f74e..1663a8e 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -40,7 +40,8 @@
 
 #if defined(HAVE_LINUX_FALLOC_H) && \
     (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE) || \
-     !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE))
+     !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE) || \
+     !defined(FALLOC_FL_INSERT_RANGE))
 # include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
 #endif
 
@@ -61,6 +62,10 @@
 # define FALLOC_FL_ZERO_RANGE		0x10
 #endif
 
+#ifndef FALLOC_FL_INSERT_RANGE
+# define FALLOC_FL_INSERT_RANGE		0x20
+#endif
+
 #include "nls.h"
 #include "strutils.h"
 #include "c.h"
@@ -83,6 +88,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
 	fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"), out);
+	fputs(_(" -i, --insert-range   insert a hole at range, shifting existing data\n"), out);
 	fputs(_(" -l, --length <num>   length for range operations, in bytes\n"), out);
 	fputs(_(" -n, --keep-size      maintain the apparent size of the file\n"), out);
 	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
@@ -281,6 +287,7 @@ int main(int argc, char **argv)
 	    { "punch-hole",     0, 0, 'p' },
 	    { "collapse-range", 0, 0, 'c' },
 	    { "dig-holes",      0, 0, 'd' },
+	    { "insert-range",   0, 0, 'i' },
 	    { "zero-range",     0, 0, 'z' },
 	    { "offset",         1, 0, 'o' },
 	    { "length",         1, 0, 'l' },
@@ -300,7 +307,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "hvVncpdzl:o:", longopts, NULL))
+	while ((c = getopt_long(argc, argv, "hvVncpdizl:o:", longopts, NULL))
 			!= -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -315,6 +322,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dig = 1;
 			break;
+		case 'i':
+			mode |= FALLOC_FL_INSERT_RANGE;
+			break;
 		case 'l':
 			length = cvtnum(optarg);
 			break;
-- 
2.7.4

