Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758386Ab2EOItK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 04:49:10 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 86CA58FD0F
	for <util-linux@vger.kernel.org>; Tue, 15 May 2012 10:49:09 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/4] include: rename writeall.h to all-io.h
Date: Tue, 15 May 2012 10:49:01 +0200
Message-Id: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/fsck.minix.c |    2 +-
 disk-utils/mkfs.minix.c |    2 +-
 disk-utils/mkswap.c     |    2 +-
 disk-utils/swaplabel.c  |    2 +-
 include/Makefile.am     |    2 +-
 include/all-io.h        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/writeall.h      |   47 -----------------------------------------------
 lib/path.c              |    2 +-
 libblkid/src/probe.c    |    2 +-
 login-utils/login.c     |    2 +-
 misc-utils/uuidd.c      |    2 +-
 misc-utils/wipefs.c     |    2 +-
 sys-utils/dmesg.c       |    2 +-
 term-utils/agetty.c     |    2 +-
 text-utils/pg.c         |    2 +-
 15 files changed, 60 insertions(+), 60 deletions(-)
 create mode 100644 include/all-io.h
 delete mode 100644 include/writeall.h

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 139ab7a..5e56e83 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -109,7 +109,7 @@
 #include "pathnames.h"
 #include "bitops.h"
 #include "ismounted.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "closestream.h"
 
 #define ROOT_INO 1
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 051cd5f..c5baac1 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -84,7 +84,7 @@
 #include "bitops.h"
 #include "exitcodes.h"
 #include "strutils.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "closestream.h"
 
 #define MINIX_ROOT_INO 1
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 51a0c89..b3bc586 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -54,7 +54,7 @@
 #include "blkdev.h"
 #include "pathnames.h"
 #include "wholedisk.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "xalloc.h"
 #include "c.h"
 #include "closestream.h"
diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 716db9e..bf4ee71 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -27,7 +27,7 @@
 
 #include "c.h"
 #include "closestream.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "swapheader.h"
 #include "strutils.h"
 #include "nls.h"
diff --git a/include/Makefile.am b/include/Makefile.am
index f61cb04..82164e4 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -1,6 +1,7 @@
 include $(top_srcdir)/config/include-Makefile.am
 
 dist_noinst_HEADERS = \
+	all-io.h \
 	at.h \
 	bitops.h \
 	blkdev.h \
@@ -40,6 +41,5 @@ dist_noinst_HEADERS = \
 	usleep.h \
 	wholedisk.h \
 	widechar.h \
-	writeall.h \
 	xalloc.h \
 	xgetpass.h
diff --git a/include/all-io.h b/include/all-io.h
new file mode 100644
index 0000000..4d1ae1e
--- /dev/null
+++ b/include/all-io.h
@@ -0,0 +1,47 @@
+#ifndef UTIL_LINUX_ALL_IO_H
+#define UTIL_LINUX_ALL_IO_H
+
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+static inline int write_all(int fd, const void *buf, size_t count)
+{
+	while (count) {
+		ssize_t tmp;
+
+		errno = 0;
+		tmp = write(fd, buf, count);
+		if (tmp > 0) {
+			count -= tmp;
+			if (count)
+				buf += tmp;
+		} else if (errno != EINTR && errno != EAGAIN)
+			return -1;
+		if (errno == EAGAIN)	/* Try later, *sigh* */
+			usleep(10000);
+	}
+	return 0;
+}
+
+static inline int fwrite_all(const void *ptr, size_t size,
+			     size_t nmemb, FILE *stream)
+{
+	while (nmemb) {
+		size_t tmp;
+
+		errno = 0;
+		tmp = fwrite(ptr, size, nmemb, stream);
+		if (tmp > 0) {
+			nmemb -= tmp;
+			if (nmemb)
+				ptr += (tmp * size);
+		} else if (errno != EINTR && errno != EAGAIN)
+			return -1;
+		if (errno == EAGAIN)	/* Try later, *sigh* */
+			usleep(10000);
+	}
+	return 0;
+}
+
+#endif /* UTIL_LINUX_ALL_IO_H */
diff --git a/include/writeall.h b/include/writeall.h
deleted file mode 100644
index 6aa4927..0000000
--- a/include/writeall.h
+++ /dev/null
@@ -1,47 +0,0 @@
-#ifndef UTIL_LINUX_WRITEALL_H
-#define UTIL_LINUX_WRITEALL_H
-
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-
-static inline int write_all(int fd, const void *buf, size_t count)
-{
-	while (count) {
-		ssize_t tmp;
-
-		errno = 0;
-		tmp = write(fd, buf, count);
-		if (tmp > 0) {
-			count -= tmp;
-			if (count)
-				buf += tmp;
-		} else if (errno != EINTR && errno != EAGAIN)
-			return -1;
-		if (errno == EAGAIN)	/* Try later, *sigh* */
-			usleep(10000);
-	}
-	return 0;
-}
-
-static inline int fwrite_all(const void *ptr, size_t size,
-			     size_t nmemb, FILE *stream)
-{
-	while (nmemb) {
-		size_t tmp;
-
-		errno = 0;
-		tmp = fwrite(ptr, size, nmemb, stream);
-		if (tmp > 0) {
-			nmemb -= tmp;
-			if (nmemb)
-				ptr += (tmp * size);
-		} else if (errno != EINTR && errno != EAGAIN)
-			return -1;
-		if (errno == EAGAIN)	/* Try later, *sigh* */
-			usleep(10000);
-	}
-	return 0;
-}
-
-#endif /* UTIL_LINUX_WRITEALL_H */
diff --git a/lib/path.c b/lib/path.c
index ad17fef..0d4d391 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -27,7 +27,7 @@
 #include <stdio.h>
 #include <errno.h>
 
-#include "writeall.h"
+#include "all-io.h"
 #include "cpuset.h"
 #include "path.h"
 #include "nls.h"
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 6bd69d3..ce14526 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -109,7 +109,7 @@
 #endif
 
 #include "blkidP.h"
-#include "writeall.h"
+#include "all-io.h"
 
 /* chains */
 extern const struct blkid_chaindrv superblocks_drv;
diff --git a/login-utils/login.c b/login-utils/login.c
index 23b84a1..2b5c68d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -66,7 +66,7 @@
 #include "strutils.h"
 #include "nls.h"
 #include "xalloc.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "fileutils.h"
 
 #include "logindefs.h"
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index eb1ef02..65ee55a 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -33,7 +33,7 @@ extern int optind;
 
 #include "uuid.h"
 #include "uuidd.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "c.h"
 #include "closestream.h"
 
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index a9d74f0..c751c3a 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -35,7 +35,7 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "strutils.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "match.h"
 #include "c.h"
 #include "closestream.h"
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index b47fede..e47b087 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -27,7 +27,7 @@
 #include "strutils.h"
 #include "xalloc.h"
 #include "widechar.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "bitops.h"
 #include "closestream.h"
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index bed4cde..36e00eb 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -33,7 +33,7 @@
 #include <grp.h>
 
 #include "strutils.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "nls.h"
 #include "pathnames.h"
 #include "c.h"
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 2b51442..0bd8279 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -62,7 +62,7 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "widechar.h"
-#include "writeall.h"
+#include "all-io.h"
 #include "closestream.h"
 
 #define	READBUF		LINE_MAX	/* size of input buffer */
-- 
1.7.7

