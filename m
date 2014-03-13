Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52697 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbaCMQtN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 13 Mar 2014 12:49:13 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so4201309wib.14
        for <util-linux@vger.kernel.org>; Thu, 13 Mar 2014 09:49:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc: kerolasa@iki.fi
Subject: Re: [PATCH 01/10] findfs: use symbolic exit values, and tell about them in manual
Date: Thu, 13 Mar 2014 16:49:06 +0000
Message-Id: <1394729346-2440-1-git-send-email-kerolasa@iki.fi>
References: <20140312103712.GK9303@x2.net.home>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi> <20140312103712.GK9303@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 March 2014 10:37, Karel Zak <kzak@redhat.com> wrote:
>  Do we really need to add findfs exit codes to exitcodes.h? The
>  codes are specific to findfs and no shared anywhere.
>
>  It would be also better to use FINDFS_EX_{SUCCESS,NOTFOUND,USAGE}.

Hi Karel,

Oh, I see.  I misunderstood exitcodes.h, the modified change adds a hint
to the file how to use it.

BTW I am 98.5% certain the findfs was the last utility to use none binary
exit values and have them as numbers in source.  Getting rid of such
magic was the original reason of the change.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 9 Mar 2014 10:49:44 -0500
Subject: [PATCH] findfs: use symbolic exit values, and tell about them in manual
Organization: lastminute.com

And mention the exitcodes.h is meant to be used when same exit codes are
used in multiple utilities.  See reference for advice about this.

Reference: http://www.spinics.net/lists/util-linux-ng/msg08970.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/exitcodes.h |  1 +
 misc-utils/findfs.8 | 30 ++++++++++++++++++++++++++----
 misc-utils/findfs.c | 17 +++++++++++------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/exitcodes.h b/include/exitcodes.h
index 24ee123..b7f37cd 100644
--- a/include/exitcodes.h
+++ b/include/exitcodes.h
@@ -3,6 +3,7 @@
 /*
  * BE CAREFUL
  *
+ * Exit codes in this file are shared in multiple utilities.
  * These exit codes are part of the official interface for mount,
  * fsck, mkfs, etc. wrappers.
  */
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
index bc4a843..5c834cc 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -14,6 +14,11 @@
 #include "nls.h"
 #include "closestream.h"
 #include "c.h"
+#include "exitcodes.h"
+
+#define FINDFS_EX_SUCCESS	0	/* no errors */
+#define FINDFS_EX_NOTFOUND	1	/* label or uuid cannot be found */
+#define FINDFS_EX_USAGE		2	/* user did something unexpected */
 
 static void __attribute__((__noreturn__)) usage(int rc)
 {
@@ -41,7 +46,7 @@ int main(int argc, char **argv)
 	if (argc != 2)
 		/* we return '2' for backward compatibility
 		 * with version from e2fsprogs */
-		usage(2);
+		usage(FINDFS_EX_USAGE);
 
 	if (!strncmp(argv[1], "LABEL=", 6)) {
 		tk = "LABEL";
@@ -52,18 +57,18 @@ int main(int argc, char **argv)
 	} else if (strcmp(argv[1], "-V") == 0 ||
 		   strcmp(argv[1], "--version") == 0) {
 		printf(UTIL_LINUX_VERSION);
-		return EXIT_SUCCESS;
+		return FINDFS_EX_SUCCESS;
 	} else if (strcmp(argv[1], "-h") == 0 ||
 		   strcmp(argv[1], "--help") == 0) {
-		usage(EXIT_SUCCESS);
+		usage(FINDFS_EX_SUCCESS);
 	} else
-		usage(2);
+		usage(FINDFS_EX_USAGE);
 
 	dev = blkid_evaluate_tag(tk, vl, NULL);
 	if (!dev)
-		errx(EXIT_FAILURE, _("unable to resolve '%s'"),	argv[1]);
+		errx(FINDFS_EX_NOTFOUND, _("unable to resolve '%s'"), argv[1]);
 
 	puts(dev);
-	exit(EXIT_SUCCESS);
+	return FINDFS_EX_SUCCESS;
 }
 
-- 
1.9.0

