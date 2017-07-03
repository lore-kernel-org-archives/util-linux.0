Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753721AbdGCLxK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:10 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M35iN-1dkdUO1yOF-00szh9 for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] sysfs: use path.h
Date: Mon,  3 Jul 2017 13:52:59 +0200
Message-Id: <1499082781-16968-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/sysfs.c | 53 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 68b43aa..8b9a6aa 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -13,6 +13,7 @@
 #include "c.h"
 #include "pathnames.h"
 #include "sysfs.h"
+#include "path.h"
 #include "fileutils.h"
 #include "all-io.h"
 
@@ -38,7 +39,7 @@ int sysfs_devno_has_attribute(dev_t devno, const char *attr)
 
 	if (!sysfs_devno_attribute_path(devno, path, sizeof(path), attr))
 		return 0;
-	if (stat(path, &info) == 0)
+	if (path_stat(path, &info) == 0)
 		return 1;
 	return 0;
 }
@@ -59,7 +60,7 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 		 */
 		struct stat st;
 
-		if (stat(name, &st) == 0)
+		if (path_stat(name, &st) == 0)
 			dev = st.st_rdev;
 		else
 			name += 5;	/* unaccesible, or not node in /dev */
@@ -114,7 +115,7 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 		FILE *f;
 		int maj = 0, min = 0;
 
-		f = fopen(path, "r" UL_CLOEXECSTR);
+		f = path_fopenP(path, "r" UL_CLOEXECSTR);
 		if (!f)
 			return 0;
 
@@ -155,7 +156,7 @@ char *sysfs_devno_to_devpath(dev_t devno, char *buf, size_t bufsiz)
 	memmove(buf + 5, name, sz + 1);
 	memcpy(buf, "/dev/", 5);
 
-	if (!stat(buf, &st) && S_ISBLK(st.st_mode) && st.st_rdev == devno)
+	if (!path_stat(buf, &st) && S_ISBLK(st.st_mode) && st.st_rdev == devno)
 		return buf;
 
 	return NULL;
@@ -172,7 +173,7 @@ int sysfs_init(struct sysfs_cxt *cxt, dev_t devno, struct sysfs_cxt *parent)
 	if (!sysfs_devno_path(devno, path, sizeof(path)))
 		goto err;
 
-	fd = open(path, O_RDONLY|O_CLOEXEC);
+	fd = path_open(path, O_RDONLY|O_CLOEXEC);
 	if (fd < 0)
 		goto err;
 	cxt->dir_fd = fd;
@@ -205,7 +206,10 @@ void sysfs_deinit(struct sysfs_cxt *cxt)
 
 int sysfs_stat(struct sysfs_cxt *cxt, const char *attr, struct stat *st)
 {
-	int rc = fstatat(cxt->dir_fd, attr, st, 0);
+	int rc;
+
+	PATH_REQUIRE_RELATIVE(attr);
+	rc = fstatat(cxt->dir_fd, attr, st, 0);
 
 	if (rc != 0 && errno == ENOENT &&
 	    strncmp(attr, "queue/", 6) == 0 && cxt->parent) {
@@ -227,7 +231,10 @@ int sysfs_has_attribute(struct sysfs_cxt *cxt, const char *attr)
 
 static int sysfs_open(struct sysfs_cxt *cxt, const char *attr, int flags)
 {
-	int fd = openat(cxt->dir_fd, attr, flags);
+	int fd;
+
+	PATH_REQUIRE_RELATIVE(attr);
+	fd = openat(cxt->dir_fd, attr, flags);
 
 	if (fd == -1 && errno == ENOENT &&
 	    strncmp(attr, "queue/", 6) == 0 && cxt->parent) {
@@ -246,11 +253,12 @@ ssize_t sysfs_readlink(struct sysfs_cxt *cxt, const char *attr,
 	if (!cxt->dir_path)
 		return -1;
 
-	if (attr)
+	if (attr) {
+		PATH_REQUIRE_RELATIVE(attr);
 		return readlinkat(cxt->dir_fd, attr, buf, bufsiz);
-
+	}
 	/* read /sys/dev/block/<maj:min> link */
-	return readlink(cxt->dir_path, buf, bufsiz);
+	return path_readlink(cxt->dir_path, buf, bufsiz);
 }
 
 DIR *sysfs_opendir(struct sysfs_cxt *cxt, const char *attr)
@@ -342,6 +350,7 @@ int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_nam
 	/* Cannot use /partition file, not supported on old sysfs */
 	snprintf(path, sizeof(path), "%s/start", d->d_name);
 
+	PATH_REQUIRE_RELATIVE(path);
 	return faccessat(dirfd(dir), path, R_OK, 0) == 0;
 }
 
@@ -601,7 +610,7 @@ static char *get_subsystem(char *chain, char *buf, size_t bufsz)
 		memcpy(chain + len, SUBSYSTEM_LINKNAME, sizeof(SUBSYSTEM_LINKNAME));
 
 		/* try if subsystem symlink exists */
-		sz = readlink(chain, buf, bufsz - 1);
+		sz = path_readlink(chain, buf, bufsz - 1);
 
 		/* remove last subsystem from chain */
 		chain[len] = '\0';
@@ -946,7 +955,7 @@ char *sysfs_scsi_host_strdup_attribute(struct sysfs_cxt *cxt,
 	    !sysfs_scsi_host_attribute_path(cxt, type, buf, sizeof(buf), attr))
 		return NULL;
 
-	if (!(f = fopen(buf, "r" UL_CLOEXECSTR)))
+	if (!(f = path_fopenP(buf, "r" UL_CLOEXECSTR)))
                 return NULL;
 
 	rc = fscanf(f, "%1023[^\n]", buf);
@@ -964,7 +973,7 @@ int sysfs_scsi_host_is(struct sysfs_cxt *cxt, const char *type)
 				buf, sizeof(buf), NULL))
 		return 0;
 
-	return stat(buf, &st) == 0 && S_ISDIR(st.st_mode);
+	return path_stat(buf, &st) == 0 && S_ISDIR(st.st_mode);
 }
 
 static char *sysfs_scsi_attribute_path(struct sysfs_cxt *cxt,
@@ -992,7 +1001,7 @@ int sysfs_scsi_has_attribute(struct sysfs_cxt *cxt, const char *attr)
 	if (!sysfs_scsi_attribute_path(cxt, path, sizeof(path), attr))
 		return 0;
 
-	return stat(path, &st) == 0;
+	return path_stat(path, &st) == 0;
 }
 
 int sysfs_scsi_path_contains(struct sysfs_cxt *cxt, const char *pattern)
@@ -1004,10 +1013,10 @@ int sysfs_scsi_path_contains(struct sysfs_cxt *cxt, const char *pattern)
 	if (!sysfs_scsi_attribute_path(cxt, path, sizeof(path), NULL))
 		return 0;
 
-	if (stat(path, &st) != 0)
+	if (path_stat(path, &st) != 0)
 		return 0;
 
-	len = readlink(path, linkc, sizeof(linkc) - 1);
+	len = path_readlink(path, linkc, sizeof(linkc) - 1);
 	if (len < 0)
 		return 0;
 
@@ -1024,6 +1033,7 @@ int main(int argc, char *argv[])
 {
 	struct sysfs_cxt cxt = UL_SYSFSCXT_EMPTY;
 	char *devname;
+	char *sysroot;
 	dev_t devno, disk_devno;
 	char path[PATH_MAX], *sub, *chain;
 	char diskname[32];
@@ -1031,10 +1041,15 @@ int main(int argc, char *argv[])
 	uint64_t u64;
 	ssize_t len;
 
-	if (argc != 2)
-		errx(EXIT_FAILURE, "usage: %s <devname>", argv[0]);
+	if (argc != 3)
+		errx(EXIT_FAILURE, "usage: %s <sysroot> <devname>", argv[0]);
+
+	sysroot = argv[1];
+	devname = argv[2];
+
+	if(path_set_prefix(sysroot))
+		err(EXIT_FAILURE, "invalid argument to %s", "--sysroot");
 
-	devname = argv[1];
 	devno = sysfs_devname_to_devno(devname, NULL);
 
 	if (!devno)
-- 
1.8.5.6

