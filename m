Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53605 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M5Z5A-1ZkMUY2sCe-00xc0p for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:34 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/14] misc: fix some includes
Date: Fri, 26 Feb 2016 04:03:28 +0100
Message-Id: <1456455812-19453-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

features.h:  any glibc header includes this already
libgen.h:    was unused there
sys/uio.h:   for writev(3p)
sys/queue.h  seems like it was never used

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac            | 1 -
 lib/blkdev.c            | 7 -------
 misc-utils/logger.c     | 1 +
 misc-utils/test_uuidd.c | 1 -
 sys-utils/ipcs.c        | 1 -
 sys-utils/lsipc.c       | 1 -
 sys-utils/rtcwake.c     | 1 -
 text-utils/pg.c         | 1 -
 8 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index b8b0074..e3b0bf5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,7 +242,6 @@ AC_CHECK_HEADERS([ \
 	sys/mount.h \
 	sys/param.h \
 	sys/prctl.h \
-	sys/queue.h \
 	sys/resource.h \
 	sys/socket.h \
 	sys/sockio.h \
diff --git a/lib/blkdev.c b/lib/blkdev.c
index 403e9e4..ddd6e9b 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -18,13 +18,6 @@
 #include <sys/disklabel.h>
 #endif
 
-#ifdef HAVE_SYS_DISK_H
-# ifdef HAVE_SYS_QUEUE_H
-#  include <sys/queue.h>	/* for LIST_HEAD */
-# endif
-# include <sys/disk.h>
-#endif
-
 #ifndef EBADFD
 # define EBADFD 77		/* File descriptor in bad state */
 #endif
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index d9aee0e..896d1b8 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -53,6 +53,7 @@
 #include <pwd.h>
 #include <sys/types.h>
 #include <signal.h>
+#include <sys/uio.h>
 
 #include "all-io.h"
 #include "c.h"
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 1262e35..78399b9 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -24,7 +24,6 @@
  *	make uuidd uuidgen localstatedir=/var
  */
 #include <error.h>
-#include <libgen.h>
 #include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 5877c46..0ebcc4c 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -16,7 +16,6 @@
  */
 
 #include <errno.h>
-#include <features.h>
 #include <getopt.h>
 
 #include "c.h"
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 9e34e6b..938728a 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -25,7 +25,6 @@
  */
 
 #include <errno.h>
-#include <features.h>
 #include <getopt.h>
 #include <sys/time.h>
 #include <unistd.h>
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 842ea50..7c748dc 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -22,7 +22,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <libgen.h>
 #include <linux/rtc.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 998010a..9ef00f0 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -58,7 +58,6 @@
 #include <unistd.h>
 #include <signal.h>
 #include <setjmp.h>
-#include <libgen.h>
 
 #ifdef HAVE_NCURSES_H
 # include <ncurses.h>
-- 
1.8.4.5

