Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33106 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdFHTw3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id v104so22591365wrb.0
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/11] misc: fix reassigned values before old ones has been used [cppcheck]
Date: Thu,  8 Jun 2017 20:52:11 +0100
Message-Id: <20170608195215.1702-8-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c           | 2 +-
 libblkid/src/devno.c          | 2 +-
 libblkid/src/probe.c          | 2 +-
 libfdisk/src/gpt.c            | 2 +-
 libfdisk/src/script.c         | 2 +-
 libmount/src/btrfs.c          | 2 +-
 libmount/src/cache.c          | 6 +++---
 libmount/src/context.c        | 2 +-
 libmount/src/context_umount.c | 2 +-
 libmount/src/optstr.c         | 2 +-
 libmount/src/tab_diff.c       | 4 ++--
 libmount/src/tab_update.c     | 2 +-
 libsmartcols/src/column.c     | 2 +-
 misc-utils/findmnt-verify.c   | 2 +-
 misc-utils/findmnt.c          | 8 ++++----
 sys-utils/losetup.c           | 2 +-
 sys-utils/swapon.c            | 2 +-
 17 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 1b2bc11fb..b09ae8f7b 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -323,7 +323,7 @@ static char *table_to_string(struct cfdisk *cf, struct fdisk_table *tb)
 {
 	struct fdisk_partition *pa;
 	struct fdisk_label *lb;
-	struct fdisk_iter *itr = NULL;
+	struct fdisk_iter *itr;
 	struct libscols_table *table = NULL;
 	struct libscols_iter *s_itr = NULL;
 	char *res = NULL;
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index 71eb4a533..8882cddad 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -225,7 +225,7 @@ static char *scandev_devno_to_devpath(dev_t devno)
  */
 char *blkid_devno_to_devname(dev_t devno)
 {
-	char *path = NULL;
+	char *path;
 	char buf[PATH_MAX];
 
 	path = sysfs_devno_to_devpath(devno, buf, sizeof(buf));
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 7eaceac6d..77c46cccc 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -206,7 +206,7 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
  */
 blkid_probe blkid_new_probe_from_filename(const char *filename)
 {
-	int fd = -1;
+	int fd;
 	blkid_probe pr = NULL;
 
 	fd = open(filename, O_RDONLY|O_CLOEXEC);
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 6b894aa23..249feb74d 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1913,7 +1913,7 @@ fail:
 static int gpt_write_pmbr(struct fdisk_context *cxt)
 {
 	off_t offset;
-	struct gpt_legacy_mbr *pmbr = NULL;
+	struct gpt_legacy_mbr *pmbr;
 
 	assert(cxt);
 	assert(cxt->firstsector);
diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
index 198e9edb9..be325bc09 100644
--- a/libfdisk/src/script.c
+++ b/libfdisk/src/script.c
@@ -1528,7 +1528,7 @@ static int test_apply(struct fdisk_test *ts, int argc, char *argv[])
 {
 	char *devname = argv[1], *scriptname = argv[2];
 	struct fdisk_context *cxt;
-	struct fdisk_script *dp = NULL;
+	struct fdisk_script *dp;
 	struct fdisk_table *tb = NULL;
 	struct fdisk_iter *itr = NULL;
 	struct fdisk_partition *pa = NULL;
diff --git a/libmount/src/btrfs.c b/libmount/src/btrfs.c
index be4d144bf..0b09053bb 100644
--- a/libmount/src/btrfs.c
+++ b/libmount/src/btrfs.c
@@ -105,7 +105,7 @@ uint64_t btrfs_get_default_subvol_id(const char *path)
 {
 	int iocret;
 	int fd;
-	DIR *dirstream = NULL;
+	DIR *dirstream;
 	struct btrfs_ioctl_search_args args;
 	struct btrfs_ioctl_search_key *sk = &args.key;
 	struct btrfs_ioctl_search_header *sh;
diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 6ff997140..b52ca8098 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -489,9 +489,9 @@ char *mnt_get_fstype(const char *devname, int *ambi, struct libmnt_cache *cache)
 static char *canonicalize_path_and_cache(const char *path,
 						struct libmnt_cache *cache)
 {
-	char *p = NULL;
-	char *key = NULL;
-	char *value = NULL;
+	char *p;
+	char *key;
+	char *value;
 
 	DBG(CACHE, ul_debugobj(cache, "canonicalize path %s", path));
 	p = canonicalize_path(path);
diff --git a/libmount/src/context.c b/libmount/src/context.c
index 5725ab1ad..fdbb02585 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1965,7 +1965,7 @@ static int apply_table(struct libmnt_context *cxt, struct libmnt_table *tb,
 		     int direction)
 {
 	struct libmnt_fs *fs = NULL;
-	const char *src = NULL, *tgt = NULL;
+	const char *src, *tgt;
 	int rc;
 
 	assert(cxt);
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 4a4c5bfe5..a97c28ba6 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -478,7 +478,7 @@ static int evaluate_permissions(struct libmnt_context *cxt)
 	 */
 	if (u_flags & (MNT_MS_USER | MNT_MS_OWNER | MNT_MS_GROUP)) {
 
-		char *curr_user = NULL;
+		char *curr_user;
 		char *mtab_user = NULL;
 		size_t sz;
 
diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 4b9622ed5..8248f0dee 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -382,7 +382,7 @@ insert_value(char **str, char *pos, const char *substr, char **next)
 	size_t strsz = strlen(*str);
 	size_t possz = strlen(pos);
 	size_t posoff;
-	char *p = NULL;
+	char *p;
 	int sep;
 
 	/* is it necessary to prepend '=' before the substring ? */
diff --git a/libmount/src/tab_diff.c b/libmount/src/tab_diff.c
index 7cf9e57ef..6caaa2a2d 100644
--- a/libmount/src/tab_diff.c
+++ b/libmount/src/tab_diff.c
@@ -305,8 +305,8 @@ done:
 
 static int test_diff(struct libmnt_test *ts, int argc, char *argv[])
 {
-	struct libmnt_table *tb_old = NULL, *tb_new = NULL;
-	struct libmnt_tabdiff *diff = NULL;
+	struct libmnt_table *tb_old, *tb_new;
+	struct libmnt_tabdiff *diff;
 	struct libmnt_iter *itr;
 	struct libmnt_fs *old, *new;
 	int rc = -1, change;
diff --git a/libmount/src/tab_update.c b/libmount/src/tab_update.c
index d85cb89da..52e1dd444 100644
--- a/libmount/src/tab_update.c
+++ b/libmount/src/tab_update.c
@@ -291,7 +291,7 @@ static int utab_new_entry(struct libmnt_update *upd, struct libmnt_fs *fs,
 			  unsigned long mountflags)
 {
 	int rc = 0;
-	const char *o = NULL, *a = NULL;
+	const char *o, *a;
 	char *u = NULL;
 
 	assert(fs);
diff --git a/libsmartcols/src/column.c b/libsmartcols/src/column.c
index 1d3287960..ce1ed7e22 100644
--- a/libsmartcols/src/column.c
+++ b/libsmartcols/src/column.c
@@ -293,7 +293,7 @@ size_t scols_wrapnl_chunksize(const struct libscols_column *cl __attribute__((un
 	size_t sum = 0;
 
 	while (data && *data) {
-		const char *p = data;
+		const char *p;
 		size_t sz;
 
 		p = strchr(data, '\n');
diff --git a/misc-utils/findmnt-verify.c b/misc-utils/findmnt-verify.c
index e3fb391d4..b32901d66 100644
--- a/misc-utils/findmnt-verify.c
+++ b/misc-utils/findmnt-verify.c
@@ -472,7 +472,7 @@ static int verify_filesystem(struct verify_context *vfy)
 int verify_table(struct libmnt_table *tb)
 {
 	struct verify_context vfy = { .nerrors = 0 };
-	struct libmnt_iter *itr = NULL;
+	struct libmnt_iter *itr;
 	int rc = 0;		/* overall return code (alloc errors, etc.) */
 	int check_order = is_listall_mode();
 	static int has_read_fs = 0;
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 5b8d345b1..db9b5c24e 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -873,7 +873,7 @@ static void cache_set_targets(struct libmnt_cache *tmp)
 static int tab_is_tree(struct libmnt_table *tb)
 {
 	struct libmnt_fs *fs = NULL;
-	struct libmnt_iter *itr = NULL;
+	struct libmnt_iter *itr;
 	int rc = 0;
 
 	itr = mnt_new_iter(MNT_ITER_BACKWARD);
@@ -892,7 +892,7 @@ static int tab_is_tree(struct libmnt_table *tb)
 static int tab_is_kernel(struct libmnt_table *tb)
 {
 	struct libmnt_fs *fs = NULL;
-	struct libmnt_iter *itr = NULL;
+	struct libmnt_iter *itr;
 
 	itr = mnt_new_iter(MNT_ITER_BACKWARD);
 	if (!itr)
@@ -1008,7 +1008,7 @@ again:
 static int add_matching_lines(struct libmnt_table *tb,
 			      struct libscols_table *table, int direction)
 {
-	struct libmnt_iter *itr = NULL;
+	struct libmnt_iter *itr;
 	struct libmnt_fs *fs;
 	int nlines = 0, rc = -1;
 
@@ -1068,7 +1068,7 @@ static int poll_table(struct libmnt_table *tb, const char *tabfile,
 	FILE *f = NULL;
 	int rc = -1;
 	struct libmnt_iter *itr = NULL;
-	struct libmnt_table *tb_new = NULL;
+	struct libmnt_table *tb_new;
 	struct libmnt_tabdiff *diff = NULL;
 	struct pollfd fds[1];
 
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 8a9bdf55d..e0676c9fd 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -113,7 +113,7 @@ static int printf_loopdev(struct loopdev_cxt *lc)
 	uint64_t x;
 	dev_t dev = 0;
 	ino_t ino = 0;
-	char *fname = NULL;
+	char *fname;
 	uint32_t type;
 
 	fname = loopcxt_get_backing_file(lc);
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index f4ca781d8..6bd057dd2 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -501,7 +501,7 @@ static void swap_get_info(struct swap_device *dev, const char *hdr)
 static int swapon_checks(const struct swapon_ctl *ctl, struct swap_device *dev)
 {
 	struct stat st;
-	int fd = -1, sig;
+	int fd, sig;
 	char *hdr = NULL;
 	unsigned long long devsize = 0;
 	int permMask;
-- 
2.13.1

