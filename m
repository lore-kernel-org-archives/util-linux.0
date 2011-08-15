Return-Path: dave@gnu.org
Subject: [PATCH] partx: support loop devices
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Aug 2011 00:11:17 -0400
Message-ID: <1313381477.2509.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add support for loop devices to add partitions. For now we make use of the max_part parameter from the loop kernel module,
otherwise the feature is disabled.

Below an example output:
root@offbook:~/projects/util-linux/partx# ./partx images-pt/dos+bsd.img 
# 1:        32-     7679 (     7648 sectors,      3 MB)
# 2:      7680-    16383 (     8704 sectors,      4 MB)
# 5:      7936-    12799 (     4864 sectors,      2 MB)
# 6:     12544-    16127 (     3584 sectors,      1 MB)
root@offbook:~/projects/util-linux/partx# ./partx -a -n 1:5 images-pt/dos+bsd.img
root@offbook:~/projects/util-linux/partx# ls /dev/loop0* -ltr
brw-rw---- 1 root disk 7, 0 2011-08-15 00:07 /dev/loop0
brw-rw---- 1 root disk 7, 5 2011-08-15 00:07 /dev/loop0p5
brw-rw---- 1 root disk 7, 2 2011-08-15 00:07 /dev/loop0p2
brw-rw---- 1 root disk 7, 1 2011-08-15 00:07 /dev/loop0p1

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/Makefile.am |    2 +
 partx/partx.c     |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/partx/Makefile.am b/partx/Makefile.am
index 6a72942..080bc47 100644
--- a/partx/Makefile.am
+++ b/partx/Makefile.am
@@ -11,6 +11,8 @@ partx_SOURCES = partx.c partx.h \
 		$(top_srcdir)/lib/at.c \
 		$(top_srcdir)/lib/mbsalign.c \
 		$(top_srcdir)/lib/strutils.c \
+		$(top_srcdir)/lib/canonicalize.c \
+		$(top_srcdir)/lib/loopdev.c \
 		$(top_srcdir)/lib/linux_version.c
 
 partx_CFLAGS = -I$(ul_libblkid_incdir)
diff --git a/partx/partx.c b/partx/partx.c
index 0b35f9f..d0e40c7 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -31,6 +31,7 @@
 #include "xalloc.h"
 #include "partx.h"
 #include "sysfs.h"
+#include "loopdev.h"
 #include "at.h"
 
 /* this is the default upper limit, could be modified by --nr */
@@ -88,7 +89,49 @@ static int columns[__NCOLUMNS], ncolumns;
 
 static int verbose;
 static int partx_flags;
+static struct loopdev_cxt lc;
+static int loopdev = 0;
 
+/*
+ * Check if the kernel supports partitioned loop devices.
+ * In a near future (around linux 3.2, hopefully) this will come
+ * always out of the box, until then we need to check.
+ */
+static int loopmod_supports_parts(void)
+{
+	int rc, ret = 0;
+	FILE *f = fopen("/sys/module/loop/parameters/max_part", "r");
+	
+	if (!f)
+		return 0;
+	rc = fscanf(f, "%d", &ret);
+	fclose(f);
+	return ret;
+}
+
+static void assoc_loopdev(const char *fname)
+{
+	int rc;
+
+	loopcxt_init(&lc, 0);
+	
+	rc = loopcxt_find_unused(&lc);
+	if (rc)
+		err(EXIT_FAILURE, "failed to find unused device");
+
+	if (verbose)
+		printf("Trying to use '%s' for the loop device\n", loopcxt_get_device(&lc));
+	
+	if (loopcxt_set_backing_file(&lc, fname))
+		err(EXIT_FAILURE, "failed to set backing file");
+
+	rc = loopcxt_setup_device(&lc);
+
+	if (rc == -EBUSY)
+		err(EXIT_FAILURE, "failed to setup device for %s", fname);
+
+	loopdev = 1;
+}
 
 static inline int get_column_id(int num)
 {
@@ -278,6 +321,7 @@ static int del_parts(int fd, const char *device, dev_t devno,
 	return rc;
 }
 
+
 static void add_parts_warnx(const char *device, int first, int last)
 {
 	if (first == last)
@@ -288,7 +332,7 @@ static void add_parts_warnx(const char *device, int first, int last)
 }
 
 static int add_parts(int fd, const char *device,
-			blkid_partlist ls, int lower, int upper)
+		     blkid_partlist ls, int lower, int upper)
 {
 	int i, nparts, rc = 0, errfirst = 0, errlast = 0;
 
@@ -338,6 +382,19 @@ static int add_parts(int fd, const char *device,
 
 	if (errfirst)
 		add_parts_warnx(device, errfirst, errlast);
+
+	/* the kernel adds *all* loopdev partitions, so we should delete
+	   any extra, unwanted ones, when the -n option is passed */
+	if (loopdev && (lower || upper)) {
+		for (i = 0; i < nparts; i++) {
+			blkid_partition par = blkid_partlist_get_partition(ls, i);
+			int n = blkid_partition_get_partno(par);
+			
+			if (n < lower || n > upper)
+				partx_del_partition(fd, n);
+		}
+	}
+
 	return rc;
 }
 
@@ -800,14 +857,23 @@ int main(int argc, char **argv)
 	if (what == ACT_ADD || what == ACT_DELETE) {
 		struct stat x;
 
-		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode))
-			errx(EXIT_FAILURE, _("%s: not a block device"), wholedisk);
+		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode)) {
+			/* not a blkdev, try to associate it to a loop device */
+			if (!loopmod_supports_parts())
+				errx(EXIT_FAILURE, _("%s: does not support loop device partitions"), 
+				     wholedisk);
+			assoc_loopdev(wholedisk);
+			wholedisk = xstrdup(lc.device);
+		}
 	}
 	if ((fd = open(wholedisk, O_RDONLY)) == -1)
 		err(EXIT_FAILURE, _("%s: open failed"), wholedisk);
 
-	if (what == ACT_DELETE)
+	if (what == ACT_DELETE) {
+		if (loopdev)
+			errx(EXIT_FAILURE, _("%s: cannot delete partitions"), wholedisk);
 		rc = del_parts(fd, wholedisk, disk_devno, lower, upper);
+	}
 	else {
 		blkid_probe pr = blkid_new_probe();
 		blkid_partlist ls = NULL;
@@ -846,6 +912,9 @@ int main(int argc, char **argv)
 		blkid_free_probe(pr);
 	}
 
+	if (loopdev)
+		loopcxt_deinit(&lc);
+
 	close(fd);
 	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
1.7.4.1
