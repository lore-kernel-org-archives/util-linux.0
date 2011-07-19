Return-Path: dave@gnu.org
Subject: [PATCH] partx: get partition number with sysfs lib
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 19:17:08 -0400
Message-ID: <1311117428.3215.4.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 17 Jul 2011 12:47:30 -0400

Now that we have this feature, there's no need to manually parse sysfs in partx.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/Makefile.am |    1 +
 partx/partx.c     |   22 +++++-----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/partx/Makefile.am b/partx/Makefile.am
index 46fc641..6a72942 100644
--- a/partx/Makefile.am
+++ b/partx/Makefile.am
@@ -6,6 +6,7 @@ dist_man_MANS = addpart.8 delpart.8
 usrsbin_exec_PROGRAMS += partx
 partx_SOURCES = partx.c partx.h \
 		$(top_srcdir)/lib/blkdev.c \
+		$(top_srcdir)/lib/sysfs.c \
 		$(top_srcdir)/lib/tt.c \
 		$(top_srcdir)/lib/at.c \
 		$(top_srcdir)/lib/mbsalign.c \
diff --git a/partx/partx.c b/partx/partx.c
index d8a4119..e29e50d 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -30,6 +30,7 @@
 #include "strutils.h"
 #include "xalloc.h"
 #include "partx.h"
+#include "sysfs.h"
 #include "at.h"
 
 /* this is the default upper limit, could be modified by --nr */
@@ -123,8 +124,6 @@ static int column_name_to_id(const char *name, size_t namesz)
  *
  * Note that this function tries to use sysfs, otherwise it assumes that the
  * last characters are always numeric (sda1, sdc20, etc).
- *
- * Returns -1 on error.
  */
 static int get_partno_from_device(char *partition, dev_t devno)
 {
@@ -135,21 +134,10 @@ static int get_partno_from_device(char *partition, dev_t devno)
 	assert(partition);
 
 	if (devno) {
-		/* the device exists, read the partition number from /sys
-		 * TODO: move this to stuff to lib/sysfs.c */
-		char path[PATH_MAX];
-		FILE *f;
-
-		snprintf(path, sizeof(path),
-				_PATH_SYS_DEVBLOCK "/%d:%d/partition",
-				major(devno), minor(devno));
-		f = fopen(path, "r");
-		if (f) {
-			if (fscanf(f, "%d", &partno) != 1)
-				partno = 0;
-			fclose(f);
-		}
-		if (partno)
+		struct sysfs_cxt cxt;
+
+		sysfs_init(&cxt, devno, NULL);
+		if (sysfs_read_int(&cxt, "partition", &partno) >= 0)
 			return partno;
 	}
 
-- 
1.7.4.1
