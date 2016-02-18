Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:64384 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426391AbcBRNMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:53 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0Ltqb7-1Zmqsz0VxV-011EVK for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/15] include: provide MAP_ANONYMOUS on OSX
Date: Thu, 18 Feb 2016 14:12:47 +0100
Message-Id: <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.cramfs.c | 8 ++++++++
 disk-utils/mkfs.cramfs.c | 8 ++++++++
 login-utils/sulogin.c    | 9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index d5d3790..6ca6094 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -33,6 +33,10 @@
  *                            use read if mmap fails, standardize messages)
  */
 
+#if defined __APPLE__
+# define _DARWIN_C_SOURCE
+#endif
+
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdint.h>
@@ -62,6 +66,10 @@
 #define XALLOC_EXIT_CODE FSCK_EX_ERROR
 #include "xalloc.h"
 
+#if !defined MAP_ANONYMOUS && defined MAP_ANON
+# define MAP_ANONYMOUS  (MAP_ANON)
+#endif
+
 static int fd;			/* ROM image file descriptor */
 static char *filename;		/* ROM image filename */
 struct cramfs_super super;	/* just find the cramfs superblock once */
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 0096cd4..d6fb646 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -23,6 +23,10 @@
  * files one by one instaed of all simultaneously. - aeb, 2002-11-01
  */
 
+#if defined __APPLE__
+# define _DARWIN_C_SOURCE
+#endif
+
 #include <sys/types.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -48,6 +52,10 @@
 #define XALLOC_EXIT_CODE MKFS_EX_ERROR
 #include "xalloc.h"
 
+#if !defined MAP_ANONYMOUS && defined MAP_ANON
+# define MAP_ANONYMOUS  (MAP_ANON)
+#endif
+
 /* The kernel only supports PAD_SIZE of 0 and 512. */
 #define PAD_SIZE 512
 
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 643712f..c83ce6d 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -24,6 +24,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
+
+#if defined __APPLE__
+# define _DARWIN_C_SOURCE
+#endif
+
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -63,6 +68,10 @@
 #include "sulogin-consoles.h"
 #define CONMAX		16
 
+#if !defined MAP_ANONYMOUS && defined MAP_ANON
+# define MAP_ANONYMOUS  (MAP_ANON)
+#endif
+
 static unsigned int timeout;
 static int profile;
 static volatile uint32_t openfd;		/* Remember higher file descriptors */
-- 
1.8.4.5

