Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56363 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcCALoS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Mar 2016 06:44:18 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Luajs-1Zsgl61ERc-00zqzi for
 <util-linux@vger.kernel.org>; Tue, 01 Mar 2016 12:44:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] lib: remove openat fallback functions (include/at.h)
Date: Tue,  1 Mar 2016 12:44:11 +0100
Message-Id: <1456832654-11268-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
References: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

I have validated that we are still compatible at least back to
  - openSUSE 11.4
  - SLE 11
  - RHEL/CentOS 6
  - OSX 10.10.x, (Xcode 6.3)
  - FreeBSD 10.2

Confirmed incompatibility:
  - OSX 10.9.x, (Xcode 6.2)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/partx.c       |   3 +-
 include/at.h             |  12 +----
 lib/Makemodule.am        |   4 --
 lib/at.c                 | 123 +----------------------------------------------
 lib/loopdev.c            |   3 +-
 lib/procutils.c          |   6 +--
 lib/sysfs.c              |  15 +++---
 libblkid/src/devname.c   |   3 +-
 libblkid/src/devno.c     |   5 +-
 libmount/src/tab_parse.c |   9 ++--
 misc-utils/lsblk.c       |  11 ++---
 misc-utils/lslocks.c     |   6 +--
 12 files changed, 29 insertions(+), 171 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index f01cf22..50bd6a4 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -32,7 +32,6 @@
 #include "partx.h"
 #include "sysfs.h"
 #include "loopdev.h"
-#include "at.h"
 #include "closestream.h"
 #include "optutils.h"
 
@@ -249,7 +248,7 @@ static int get_max_partno(const char *disk, dev_t devno)
 			continue;
 		snprintf(path, sizeof(path), "%s/partition", d->d_name);
 
-		fd = open_at(dirfd(dir), dirname, path, O_RDONLY);
+		fd = openat(dirfd(dir), path, O_RDONLY);
 		if (fd) {
 			int x = 0;
 			FILE *f = fdopen(fd, "r");
diff --git a/include/at.h b/include/at.h
index 63a80f0..a1c6a8b 100644
--- a/include/at.h
+++ b/include/at.h
@@ -16,17 +16,7 @@
 
 #include "c.h"
 
-extern int fstat_at(int dir, const char *dirname,
-			const char *filename, struct stat *st, int nofollow);
-
-extern int open_at(int dir, const char *dirname,
-			const char *filename, int flags);
-
-extern FILE *fopen_at(int dir, const char *dirname, const char *filename,
+extern FILE *fopen_at(int dir, const char *filename,
 			int flags, const char *mode);
 
-extern ssize_t readlink_at(int dir, const char *dirname, const char *pathname,
-                    char *buf, size_t bufsiz);
-
-
 #endif /* UTIL_LINUX_AT_H */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 94e8453..25e1ba0 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -52,7 +52,6 @@ dist_man_MANS += lib/terminal-colors.d.5
 
 
 check_PROGRAMS += \
-	test_at \
 	test_blkdev \
 	test_canonicalize \
 	test_colors \
@@ -91,9 +90,6 @@ test_ismounted_LDADD = $(LDADD) libcommon.la
 test_mangle_SOURCES = lib/mangle.c
 test_mangle_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 
-test_at_SOURCES = lib/at.c
-test_at_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM_AT
-
 test_strutils_SOURCES = lib/strutils.c
 test_strutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 
diff --git a/lib/at.c b/lib/at.c
index f7074bb..438b865 100644
--- a/lib/at.c
+++ b/lib/at.c
@@ -7,68 +7,15 @@
  * Written by Karel Zak <kzak@redhat.com>
  */
 #include <stdio.h>
-#include <stdlib.h>
 #include <fcntl.h>
-#include <sys/stat.h>
 
 #include "at.h"
 #include "c.h"
 
-#ifdef HAVE_FSTATAT
-int fstat_at(int dir, const char *dirname __attribute__ ((__unused__)),
-	     const char *filename, struct stat *st, int nofollow)
-{
-	return fstatat(dir, filename, st,
-			nofollow ? AT_SYMLINK_NOFOLLOW : 0);
-}
-#else
-int fstat_at(int dir __attribute__ ((__unused__)), const char *dirname,
-	     const char *filename, struct stat *st, int nofollow)
-{
-
-	if (*filename != '/') {
-		char path[PATH_MAX];
-		int len;
-
-		len = snprintf(path, sizeof(path), "%s/%s", dirname, filename);
-		if (len < 0 || len + 1 > sizeof(path))
-			return -1;
-
-		return nofollow ? lstat(path, st) : stat(path, st);
-	}
-
-	return nofollow ? lstat(filename, st) : stat(filename, st);
-}
-#endif
-
-#ifdef HAVE_FSTATAT
-int open_at(int dir, const char *dirname __attribute__ ((__unused__)),
-	    const char *filename, int flags)
-{
-	return openat(dir, filename, flags);
-}
-#else
-int open_at(int dir __attribute__((__unused__)), const char *dirname,
-	    const char *filename, int flags)
-{
-	if (*filename != '/') {
-		char path[PATH_MAX];
-		int len;
-
-		len = snprintf(path, sizeof(path), "%s/%s", dirname, filename);
-		if (len < 0 || len + 1 > sizeof(path))
-			return -1;
-
-		return open(path, flags);
-	}
-	return open(filename, flags);
-}
-#endif
-
-FILE *fopen_at(int dir, const char *dirname, const char *filename, int flags,
+FILE *fopen_at(int dir, const char *filename, int flags,
 			const char *mode)
 {
-	int fd = open_at(dir, dirname, filename, flags);
+	int fd = openat(dir, filename, flags);
 
 	if (fd < 0)
 		return NULL;
@@ -76,69 +23,3 @@ FILE *fopen_at(int dir, const char *dirname, const char *filename, int flags,
 	return fdopen(fd, mode);
 }
 
-#ifdef HAVE_FSTATAT
-ssize_t readlink_at(int dir, const char *dirname __attribute__ ((__unused__)),
-		    const char *pathname, char *buf, size_t bufsiz)
-{
-	return readlinkat(dir, pathname, buf, bufsiz);
-}
-#else
-ssize_t readlink_at(int dir __attribute__((__unused__)), const char *dirname,
-		    const char *pathname, char *buf, size_t bufsiz)
-{
-	if (*pathname != '/') {
-		char path[PATH_MAX];
-		int len;
-
-		len = snprintf(path, sizeof(path), "%s/%s", dirname, pathname);
-		if (len < 0 || len + 1 > sizeof(path))
-			return -1;
-
-		return readlink(path, buf, bufsiz);
-	}
-	return readlink(pathname, buf, bufsiz);
-}
-#endif
-
-#ifdef TEST_PROGRAM_AT
-#include <errno.h>
-#include <sys/types.h>
-#include <dirent.h>
-#include <string.h>
-
-int main(int argc, char *argv[])
-{
-	DIR *dir;
-	struct dirent *d;
-	char *dirname;
-
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s <directory>\n", argv[0]);
-		exit(EXIT_FAILURE);
-	}
-	dirname = argv[1];
-
-	dir = opendir(dirname);
-	if (!dir)
-		err(EXIT_FAILURE, "cannot open %s", dirname);
-
-	while ((d = readdir(dir))) {
-		struct stat st;
-		FILE *f;
-
-		printf("%32s ", d->d_name);
-
-		if (fstat_at(dirfd(dir), dirname, d->d_name, &st, 0) == 0)
-			printf("%16zd bytes ", st.st_size);
-		else
-			printf("%16s bytes ", "???");
-
-		f = fopen_at(dirfd(dir), dirname, d->d_name, O_RDONLY, "r");
-		printf("   %s\n", f ? "OK" : strerror(errno));
-		if (f)
-			fclose(f);
-	}
-	closedir(dir);
-	return EXIT_SUCCESS;
-}
-#endif
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 5f3c3a2..b2c8b98 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -40,7 +40,6 @@
 #include "pathnames.h"
 #include "loopdev.h"
 #include "canonicalize.h"
-#include "at.h"
 #include "blkdev.h"
 #include "debug.h"
 
@@ -546,7 +545,7 @@ static int loopcxt_next_from_sysfs(struct loopdev_cxt *lc)
 			continue;
 
 		snprintf(name, sizeof(name), "%s/loop/backing_file", d->d_name);
-		if (fstat_at(fd, _PATH_SYS_BLOCK, name, &st, 0) != 0)
+		if (fstatat(fd, name, &st, 0) != 0)
 			continue;
 
 		if (loopiter_set_device(lc, d->d_name) == 0)
diff --git a/lib/procutils.c b/lib/procutils.c
index 2e9a053..6f01634 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -18,6 +18,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
 #include <ctype.h>
@@ -199,7 +200,7 @@ int proc_next_pid(struct proc_processes *ps, pid_t *pid)
 		if (ps->has_fltr_uid) {
 			struct stat st;
 
-			if (fstat_at(dirfd(ps->dir), "/proc", d->d_name, &st, 0))
+			if (fstatat(dirfd(ps->dir), d->d_name, &st, 0))
 				continue;
 			if (ps->fltr_uid != st.st_uid)
 				continue;
@@ -211,8 +212,7 @@ int proc_next_pid(struct proc_processes *ps, pid_t *pid)
 			FILE *f;
 
 			snprintf(buf, sizeof(buf), "%s/stat", d->d_name);
-			f = fopen_at(dirfd(ps->dir), "/proc", buf,
-						O_CLOEXEC|O_RDONLY, "r");
+			f = fopen_at(dirfd(ps->dir), buf, O_CLOEXEC|O_RDONLY, "r");
 			if (!f)
 				continue;
 
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 53aba3a..1f8d2cb 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -6,9 +6,11 @@
  */
 #include <ctype.h>
 #include <libgen.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
 #include "c.h"
-#include "at.h"
 #include "pathnames.h"
 #include "sysfs.h"
 #include "fileutils.h"
@@ -203,7 +205,7 @@ void sysfs_deinit(struct sysfs_cxt *cxt)
 
 int sysfs_stat(struct sysfs_cxt *cxt, const char *attr, struct stat *st)
 {
-	int rc = fstat_at(cxt->dir_fd, cxt->dir_path, attr, st, 0);
+	int rc = fstatat(cxt->dir_fd, attr, st, 0);
 
 	if (rc != 0 && errno == ENOENT &&
 	    strncmp(attr, "queue/", 6) == 0 && cxt->parent) {
@@ -211,8 +213,7 @@ int sysfs_stat(struct sysfs_cxt *cxt, const char *attr, struct stat *st)
 		/* Exception for "queue/<attr>". These attributes are available
 		 * for parental devices only
 		 */
-		return fstat_at(cxt->parent->dir_fd,
-				cxt->parent->dir_path, attr, st, 0);
+		return fstatat(cxt->parent->dir_fd, attr, st, 0);
 	}
 	return rc;
 }
@@ -226,7 +227,7 @@ int sysfs_has_attribute(struct sysfs_cxt *cxt, const char *attr)
 
 static int sysfs_open(struct sysfs_cxt *cxt, const char *attr, int flags)
 {
-	int fd = open_at(cxt->dir_fd, cxt->dir_path, attr, flags);
+	int fd = openat(cxt->dir_fd, attr, flags);
 
 	if (fd == -1 && errno == ENOENT &&
 	    strncmp(attr, "queue/", 6) == 0 && cxt->parent) {
@@ -234,7 +235,7 @@ static int sysfs_open(struct sysfs_cxt *cxt, const char *attr, int flags)
 		/* Exception for "queue/<attr>". These attributes are available
 		 * for parental devices only
 		 */
-		fd = open_at(cxt->parent->dir_fd, cxt->dir_path, attr, flags);
+		fd = openat(cxt->parent->dir_fd, attr, flags);
 	}
 	return fd;
 }
@@ -246,7 +247,7 @@ ssize_t sysfs_readlink(struct sysfs_cxt *cxt, const char *attr,
 		return -1;
 
 	if (attr)
-		return readlink_at(cxt->dir_fd, cxt->dir_path, attr, buf, bufsiz);
+		return readlinkat(cxt->dir_fd, attr, buf, bufsiz);
 
 	/* read /sys/dev/block/<maj:min> link */
 	return readlink(cxt->dir_path, buf, bufsiz);
diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index fdbb5c9..dbbe5b5 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -39,7 +39,6 @@
 #include "canonicalize.h"		/* $(top_srcdir)/include */
 #include "pathnames.h"
 #include "sysfs.h"
-#include "at.h"
 
 /*
  * Find a dev struct in the cache by device name, if available.
@@ -397,7 +396,7 @@ ubi_probe_all(blkid_cache cache, int only_if_new)
 				continue;
 			if (!strcmp(name, "ubi_ctrl"))
 				continue;
-			if (fstat_at(dirfd(dir), *dirname, name, &st, 0))
+			if (fstatat(dirfd(dir), name, &st, 0))
 				continue;
 
 			dev = st.st_rdev;
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index f4a36e4..58fbce5 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -34,7 +34,6 @@
 
 #include "blkidP.h"
 #include "pathnames.h"
-#include "at.h"
 #include "sysfs.h"
 
 static char *blkid_strconcat(const char *a, const char *b, const char *c)
@@ -126,7 +125,7 @@ void blkid__scan_dir(char *dirname, dev_t devno, struct dir_list **list,
 		     ((dp->d_name[1] == '.') && (dp->d_name[2] == 0))))
 			continue;
 
-		if (fstat_at(dirfd(dir), dirname, dp->d_name, &st, 0))
+		if (fstatat(dirfd(dir), dp->d_name, &st, 0))
 			continue;
 
 		if (S_ISBLK(st.st_mode) && st.st_rdev == devno) {
@@ -146,7 +145,7 @@ void blkid__scan_dir(char *dirname, dev_t devno, struct dir_list **list,
 		if (dp->d_type == DT_UNKNOWN)
 #endif
 		{
-			if (fstat_at(dirfd(dir), dirname, dp->d_name, &st, 1) ||
+			if (fstatat(dirfd(dir), dp->d_name, &st, 1) ||
 			    !S_ISDIR(st.st_mode))
 				continue;	/* symlink or lstat() failed */
 		}
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index c67479b..9536ebe 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -15,6 +15,7 @@
 #include <limits.h>
 #include <dirent.h>
 #include <fcntl.h>
+#include <sys/stat.h>
 
 #include "at.h"
 #include "mangle.h"
@@ -753,11 +754,11 @@ static int __mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 		struct stat st;
 		FILE *f;
 
-		if (fstat_at(dd, ".", d->d_name, &st, 0) ||
+		if (fstatat(dd, d->d_name, &st, 0) ||
 		    !S_ISREG(st.st_mode))
 			continue;
 
-		f = fopen_at(dd, ".", d->d_name, O_RDONLY|O_CLOEXEC, "r" UL_CLOEXECSTR);
+		f = fopen_at(dd, d->d_name, O_RDONLY|O_CLOEXEC, "r" UL_CLOEXECSTR);
 		if (f) {
 			mnt_table_parse_stream(tb, f, d->d_name);
 			fclose(f);
@@ -793,11 +794,11 @@ static int __mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 		struct stat st;
 		FILE *f;
 
-		if (fstat_at(dirfd(dir), _PATH_MNTTAB_DIR, d->d_name, &st, 0) ||
+		if (fstatat(dirfd(dir), d->d_name, &st, 0) ||
 		    !S_ISREG(st.st_mode))
 			continue;
 
-		f = fopen_at(dirfd(dir), _PATH_MNTTAB_DIR, d->d_name,
+		f = fopen_at(dirfd(dir), d->d_name,
 				O_RDONLY|O_CLOEXEC, "r" UL_CLOEXECSTR);
 		if (f) {
 			mnt_table_parse_stream(tb, f, d->d_name);
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 5c065a9..c9a39b3 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -56,7 +56,6 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "strutils.h"
-#include "at.h"
 #include "sysfs.h"
 #include "closestream.h"
 #include "mangle.h"
@@ -1320,15 +1319,14 @@ static int list_partitions(struct blkdev_cxt *wholedisk_cxt, struct blkdev_cxt *
 	return r;
 }
 
-static int get_wholedisk_from_partition_dirent(DIR *dir, const char *dirname,
+static int get_wholedisk_from_partition_dirent(DIR *dir,
 				struct dirent *d, struct blkdev_cxt *cxt)
 {
 	char path[PATH_MAX];
 	char *p;
 	int len;
 
-	if ((len = readlink_at(dirfd(dir), dirname,
-			       d->d_name, path, sizeof(path) - 1)) < 0)
+	if ((len = readlinkat(dirfd(dir), d->d_name, path, sizeof(path) - 1)) < 0)
 		return 0;
 
 	path[len] = '\0';
@@ -1355,7 +1353,6 @@ static int list_deps(struct blkdev_cxt *cxt)
 	DIR *dir;
 	struct dirent *d;
 	struct blkdev_cxt dep = { 0 };
-	char dirname[PATH_MAX];
 	const char *depname;
 
 	assert(cxt);
@@ -1375,12 +1372,10 @@ static int list_deps(struct blkdev_cxt *cxt)
 
 	DBG(CXT, ul_debugobj(cxt, "%s: checking for '%s' dependence", cxt->name, depname));
 
-	snprintf(dirname, sizeof(dirname), "%s/%s", cxt->sysfs.dir_path, depname);
-
 	while ((d = xreaddir(dir))) {
 		/* Is the dependency a partition? */
 		if (sysfs_is_partition_dirent(dir, d, NULL)) {
-			if (!get_wholedisk_from_partition_dirent(dir, dirname, d, &dep)) {
+			if (!get_wholedisk_from_partition_dirent(dir, d, &dep)) {
 				DBG(CXT, ul_debugobj(cxt, "%s: %s: dependence is partition",
 								cxt->name, d->d_name));
 				process_blkdev(&dep, cxt, 1, d->d_name);
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 389a3e4..a47c1d0 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -39,7 +39,6 @@
 #include "canonicalize.h"
 #include "nls.h"
 #include "xalloc.h"
-#include "at.h"
 #include "strutils.h"
 #include "c.h"
 #include "list.h"
@@ -180,12 +179,11 @@ static char *get_filename_sz(ino_t inode, pid_t lock_pid, size_t *size)
 		if (!strtol(dp->d_name, (char **) NULL, 10))
 			continue;
 
-		if (!fstat_at(fd, path, dp->d_name, &sb, 0)
+		if (!fstatat(fd, dp->d_name, &sb, 0)
 		    && inode != sb.st_ino)
 			continue;
 
-		if ((len = readlink_at(fd, path, dp->d_name,
-				       sym, sizeof(sym) - 1)) < 1)
+		if ((len = readlinkat(fd, dp->d_name, sym, sizeof(sym) - 1)) < 1)
 			goto out;
 
 		*size = sb.st_size;
-- 
1.8.4.5

