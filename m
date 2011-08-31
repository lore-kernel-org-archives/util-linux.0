Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462Ab1HaO4W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Aug 2011 10:56:22 -0400
Date: Wed, 31 Aug 2011 16:56:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] partx: support loop devices
Message-ID: <20110831145618.GA3413@nb.net.home>
References: <1313381477.2509.1.camel@offbook> <20110815115855.GE1843@nb.net.home> <1313500807.2586.1.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313500807.2586.1.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 16, 2011 at 09:20:07AM -0400, Davidlohr Bueso wrote:
> +static int loopmod_supports_parts(void)
> +{
> +	int rc, ret = 0;
> +	FILE *f = fopen("/sys/module/loop/parameters/max_part", "r");
> +	
> +	if (!f)
> +		return 0;
> +	rc = fscanf(f, "%d", &ret);
> +	fclose(f);
> +	return ret;

 return rc = 1 ? ret : 0;  
 
    Right?

> +}
> +
> +static void assoc_loopdev(const char *fname)
> +{
[...]
> +		err(EXIT_FAILURE, "failed to find unused device");

> +		printf("Trying to use '%s' for the loop device\n", loopcxt_get_device(&lc));

> +		err(EXIT_FAILURE, "failed to set backing file");

> +		err(EXIT_FAILURE, "failed to setup device for %s", fname);

 you forgot _( )

> +		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode) && S_ISREG(x.st_mode)) {

  || && :-)

> +			/* not a blkdev, try to associate it to a loop device */
> +			if (what == ACT_DELETE)
> +				errx(EXIT_FAILURE, _("%s: cannot delete partitions"), wholedisk);
> +
> +			if (!loopmod_supports_parts())
> +				errx(EXIT_FAILURE, _("%s: does not support loop device partitions"), 
> +				     wholedisk);
> +			assoc_loopdev(wholedisk);
> +			wholedisk = xstrdup(lc.device);
> +		}

 Fixed (see below), applied to may private repository. Thanks.

 Note that Kay's loopdev changes are in Linus' tree, so we can start
 to play with that (kernel will not add all partition).

    Karel


>From 0e9381133e2d4a79715d5b9e2326198f8ed72d35 Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@gnu.org>
Date: Tue, 16 Aug 2011 09:20:07 -0400
Subject: [PATCH] partx: support loop devices

Add support for loop devices to add partitions. For now we make use of the
max_part parameter from the loop kernel module, otherwise the feature is
disabled.

Below an example output:

root@offbook:~/projects/util-linux/partx# ./partx -a -n 1:5 images-pt/dos+bsd.img
root@offbook:~/projects/util-linux/partx# ls /dev/loop0* -ltr
brw-rw---- 1 root disk 7, 0 2011-08-15 00:07 /dev/loop0
brw-rw---- 1 root disk 7, 5 2011-08-15 00:07 /dev/loop0p5
brw-rw---- 1 root disk 7, 2 2011-08-15 00:07 /dev/loop0p2
brw-rw---- 1 root disk 7, 1 2011-08-15 00:07 /dev/loop0p1

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 partx/Makefile.am |    2 +
 partx/partx.c     |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

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
index ca19344..3a9da9e 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -31,6 +31,7 @@
 #include "xalloc.h"
 #include "partx.h"
 #include "sysfs.h"
+#include "loopdev.h"
 #include "at.h"
 
 /* this is the default upper limit, could be modified by --nr */
@@ -88,7 +89,51 @@ static int columns[__NCOLUMNS], ncolumns;
 
 static int verbose;
 static int partx_flags;
+static struct loopdev_cxt lc;
+static int loopdev;
 
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
+	return rc = 1 ? ret : 0;
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
+		err(EXIT_FAILURE, _("%s: failed to find unused loop device"),
+		    fname);
+
+	if (verbose)
+		printf(_("Trying to use '%s' for the loop device\n"),
+		       loopcxt_get_device(&lc));
+
+	if (loopcxt_set_backing_file(&lc, fname))
+		err(EXIT_FAILURE, _("%s: failed to set backing file"), fname);
+
+	rc = loopcxt_setup_device(&lc);
+
+	if (rc == -EBUSY)
+		err(EXIT_FAILURE, _("%s: failed to setup loop device"), fname);
+
+	loopdev = 1;
+}
 
 static inline int get_column_id(int num)
 {
@@ -278,6 +323,7 @@ static int del_parts(int fd, const char *device, dev_t devno,
 	return rc;
 }
 
+
 static void add_parts_warnx(const char *device, int first, int last)
 {
 	if (first == last)
@@ -288,7 +334,7 @@ static void add_parts_warnx(const char *device, int first, int last)
 }
 
 static int add_parts(int fd, const char *device,
-			blkid_partlist ls, int lower, int upper)
+		     blkid_partlist ls, int lower, int upper)
 {
 	int i, nparts, rc = 0, errfirst = 0, errlast = 0;
 
@@ -338,6 +384,19 @@ static int add_parts(int fd, const char *device,
 
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
 
@@ -799,7 +858,20 @@ int main(int argc, char **argv)
 	if (what == ACT_ADD || what == ACT_DELETE) {
 		struct stat x;
 
-		if (stat(wholedisk, &x) || !S_ISBLK(x.st_mode))
+		if (stat(wholedisk, &x))
+			errx(EXIT_FAILURE, "%s", wholedisk);
+
+		if  (S_ISREG(x.st_mode)) {
+			/* not a blkdev, try to associate it to a loop device */
+			if (what == ACT_DELETE)
+				errx(EXIT_FAILURE, _("%s: cannot delete partitions"),
+				     wholedisk);
+			if (!loopmod_supports_parts())
+				errx(EXIT_FAILURE, _("%s: partitioned loop devices unsupported"),
+				     wholedisk);
+			assoc_loopdev(wholedisk);
+			wholedisk = xstrdup(lc.device);
+		} else if (!S_ISBLK(x.st_mode))
 			errx(EXIT_FAILURE, _("%s: not a block device"), wholedisk);
 	}
 	if ((fd = open(wholedisk, O_RDONLY)) == -1)
@@ -845,6 +917,9 @@ int main(int argc, char **argv)
 		blkid_free_probe(pr);
 	}
 
+	if (loopdev)
+		loopcxt_deinit(&lc);
+
 	close(fd);
 	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
1.7.6

