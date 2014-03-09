Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55112 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUab (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:31 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so6226580oah.1
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/10] findfs: use symbolic exit values, and tell about them in manual
Date: Sun,  9 Mar 2014 15:30:14 -0500
Message-Id: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/exitcodes.h |  5 +++++
 misc-utils/findfs.8 | 30 ++++++++++++++++++++++++++----
 misc-utils/findfs.c | 13 +++++++------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/exitcodes.h b/include/exitcodes.h
index 24ee123..fc893f1 100644
--- a/include/exitcodes.h
+++ b/include/exitcodes.h
@@ -32,4 +32,9 @@
 #define MOUNT_EX_FAIL		32	/* mount failure */
 #define MOUNT_EX_SOMEOK		64	/* some mount succeeded */
 
+/* Exit codes used by findfs. */
+#define FINDFS_SUCCESS		0	/* no errors */
+#define FINDFS_NOT_FOUND	1	/* label or uuid cannot be found */
+#define FINDFS_USAGE_ERROR	2	/* user did something unexpected */
+
 #endif	/* UTIL_LINUX_EXITCODES_H */
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 8a6bca1..1469df2 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -2,7 +2,7 @@
 .\" Copyright 1993, 1994, 1995 by Theodore Ts'o.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
-.TH FINDFS 8 "February 2009" "util-linux" "System Administration"
+.TH FINDFS 8 "March 2014" "util-linux" "System Administration"
 .SH NAME
 findfs \- find a filesystem by label or UUID
 .SH SYNOPSIS
@@ -21,10 +21,30 @@ or a UUID equal to
 If the filesystem is found, the device name for the filesystem will
 be printed on stdout.
 .PP
+.SH "EXIT STATUS"
+.RS
+.PD 0
+.TP
+.B 0
+success
+.TP
+.B 1
+label or uuid cannot be found
+.TP
+.B 2
+usage error, wrong number of arguments or unknown option
+.PD
+.RE
 .SH AUTHOR
 .B findfs
-was originally written by Theodore Ts'o (tytso@mit.edu) and re-written for
-the util-linux package by Karel Zak (kzak@redhat.com).
+was originally written by
+.MT tytso@mit.edu
+Theodore Ts'o
+.ME
+and re-written for the util-linux package by
+.MT kzak@redhat.com
+Karel Zak
+.ME .
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=0xffff
 enables debug output.
@@ -33,4 +53,6 @@ enables debug output.
 .BR fsck (8)
 .SH AVAILABILITY
 The findfs command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index bc4a843..aff6ba8 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -14,6 +14,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "c.h"
+#include "exitcodes.h"
 
 static void __attribute__((__noreturn__)) usage(int rc)
 {
@@ -41,7 +42,7 @@ int main(int argc, char **argv)
 	if (argc != 2)
 		/* we return '2' for backward compatibility
 		 * with version from e2fsprogs */
-		usage(2);
+		usage(FINDFS_USAGE_ERROR);
 
 	if (!strncmp(argv[1], "LABEL=", 6)) {
 		tk = "LABEL";
@@ -52,18 +53,18 @@ int main(int argc, char **argv)
 	} else if (strcmp(argv[1], "-V") == 0 ||
 		   strcmp(argv[1], "--version") == 0) {
 		printf(UTIL_LINUX_VERSION);
-		return EXIT_SUCCESS;
+		return FINDFS_SUCCESS;
 	} else if (strcmp(argv[1], "-h") == 0 ||
 		   strcmp(argv[1], "--help") == 0) {
-		usage(EXIT_SUCCESS);
+		usage(FINDFS_SUCCESS);
 	} else
-		usage(2);
+		usage(FINDFS_USAGE_ERROR);
 
 	dev = blkid_evaluate_tag(tk, vl, NULL);
 	if (!dev)
-		errx(EXIT_FAILURE, _("unable to resolve '%s'"),	argv[1]);
+		errx(FINDFS_NOT_FOUND, _("unable to resolve '%s'"), argv[1]);
 
 	puts(dev);
-	exit(EXIT_SUCCESS);
+	return FINDFS_SUCCESS;
 }
 
-- 
1.9.0

