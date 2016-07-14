Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35116 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbcGNN3M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:29:12 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 108ACAC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:29:11 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 4/7] Add sizelimit to internal API
Message-ID: <29ddb250-a7dd-f037-109f-e4a9a524443f@suse.cz>
Date: Thu, 14 Jul 2016 15:29:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fully safe checks of loop device need to check sizelimit. To prevent need of two
nearly equal functions, introduce sizelimit parameter to several internal
functions:
loopdev_is_used()
loopdev_find_by_backing_file()
loopcxt_is_used()
loopcxt_find_by_backing_file()

If sizelimit is zero, fall back to the old behavior (ignoring of sizelimit).

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 include/loopdev.h              |  8 +++++---
 lib/ismounted.c                |  2 +-
 lib/loopdev.c                  | 26 +++++++++++++++++++-------
 libmount/src/context_loopdev.c |  6 +++---
 libmount/src/context_umount.c  |  2 +-
 libmount/src/tab.c             |  2 +-
 sys-utils/losetup.c            |  8 ++++----
 7 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/loopdev.h b/include/loopdev.h
index 18ca41f..57fcc1b 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -133,9 +133,9 @@ extern int loopdev_is_autoclear(const char *device);
 
 extern char *loopdev_get_backing_file(const char *device);
 extern int loopdev_is_used(const char *device, const char *filename,
-			   uint64_t offset, int flags);
+			   uint64_t offset, uint64_t sizelimit, int flags);
 extern char *loopdev_find_by_backing_file(const char *filename,
-					  uint64_t offset, int flags);
+				uint64_t offset, uint64_t sizelimit, int flags);
 extern int loopcxt_find_unused(struct loopdev_cxt *lc);
 extern int loopdev_delete(const char *device);
 extern int loopdev_count_by_backing_file(const char *filename, char **loopdev);
@@ -186,12 +186,14 @@ extern int loopcxt_is_dio(struct loopdev_cxt *lc);
 extern int loopcxt_is_partscan(struct loopdev_cxt *lc);
 extern int loopcxt_find_by_backing_file(struct loopdev_cxt *lc,
 				const char *filename,
-                                uint64_t offset, int flags);
+				uint64_t offset, uint64_t sizelimit,
+				int flags);
 
 extern int loopcxt_is_used(struct loopdev_cxt *lc,
                     struct stat *st,
                     const char *backing_file,
                     uint64_t offset,
+                    uint64_t sizelimit,
                     int flags);
 
 #endif /* UTIL_LINUX_LOOPDEV_H */
diff --git a/lib/ismounted.c b/lib/ismounted.c
index f83be65..dd2d356 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -85,7 +85,7 @@ static int check_mntent_file(const char *mtab_file, const char *file,
 			/* maybe the file is loopdev backing file */
 			if (file_dev
 			    && major(st_buf.st_rdev) == LOOPDEV_MAJOR
-			    && loopdev_is_used(mnt->mnt_fsname, file, 0, 0))
+			    && loopdev_is_used(mnt->mnt_fsname, file, 0, 0, 0))
 				break;
 #endif /* __linux__ */
 #endif	/* __GNU__ */
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 73bbf8b..2db80fc 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -980,12 +980,15 @@ int loopcxt_is_dio(struct loopdev_cxt *lc)
  * @backing_file: filename
  * @offset: offset
  * @flags: LOOPDEV_FL_OFFSET if @offset should not be ignored
+ * @flags: LOOPDEV_FL_SIZELIMIT if @sizelimit should not be ignored
  *
  * Returns 1 if the current @lc loopdev is associated with the given backing
  * file. Note that the preferred way is to use devno and inode number rather
  * than filename. The @backing_file filename is poor solution usable in case
  * that you don't have rights to call stat().
  *
+ * LOOPDEV_FL_SIZELIMIT requires LOOPDEV_FL_OFFSET being set as well.
+ *
  * Don't forget that old kernels provide very restricted (in size) backing
  * filename by LOOP_GET_STAT64 ioctl only.
  */
@@ -993,6 +996,7 @@ int loopcxt_is_used(struct loopdev_cxt *lc,
 		    struct stat *st,
 		    const char *backing_file,
 		    uint64_t offset,
+		    uint64_t sizelimit,
 		    int flags)
 {
 	ino_t ino;
@@ -1030,7 +1034,15 @@ found:
 	if (flags & LOOPDEV_FL_OFFSET) {
 		uint64_t off;
 
-		return loopcxt_get_offset(lc, &off) == 0 && off == offset;
+		int rc = loopcxt_get_offset(lc, &off) == 0 && off == offset;
+
+		if (rc && flags & LOOPDEV_FL_SIZELIMIT) {
+			uint64_t sz;
+
+			return loopcxt_get_sizelimit(lc, &sz) == 0 && sz == sizelimit;
+		}
+		else
+			return rc;
 	}
 	return 1;
 }
@@ -1485,7 +1497,7 @@ char *loopdev_get_backing_file(const char *device)
  * Returns: TRUE/FALSE
  */
 int loopdev_is_used(const char *device, const char *filename,
-		    uint64_t offset, int flags)
+		    uint64_t offset, uint64_t sizelimit, int flags)
 {
 	struct loopdev_cxt lc;
 	struct stat st;
@@ -1501,7 +1513,7 @@ int loopdev_is_used(const char *device, const char *filename,
 		return rc;
 
 	rc = !stat(filename, &st);
-	rc = loopcxt_is_used(&lc, rc ? &st : NULL, filename, offset, flags);
+	rc = loopcxt_is_used(&lc, rc ? &st : NULL, filename, offset, sizelimit, flags);
 
 	loopcxt_deinit(&lc);
 	return rc;
@@ -1528,7 +1540,7 @@ int loopdev_delete(const char *device)
  * Returns: 0 = success, < 0 error, 1 not found
  */
 int loopcxt_find_by_backing_file(struct loopdev_cxt *lc, const char *filename,
-				 uint64_t offset, int flags)
+				 uint64_t offset, uint64_t sizelimit, int flags)
 {
 	int rc, hasst;
 	struct stat st;
@@ -1545,7 +1557,7 @@ int loopcxt_find_by_backing_file(struct loopdev_cxt *lc, const char *filename,
 	while ((rc = loopcxt_next(lc)) == 0) {
 
 		if (loopcxt_is_used(lc, hasst ? &st : NULL,
-					filename, offset, flags))
+				    filename, offset, sizelimit, flags))
 			break;
 	}
 
@@ -1556,7 +1568,7 @@ int loopcxt_find_by_backing_file(struct loopdev_cxt *lc, const char *filename,
 /*
  * Returns allocated string with device name
  */
-char *loopdev_find_by_backing_file(const char *filename, uint64_t offset, int flags)
+char *loopdev_find_by_backing_file(const char *filename, uint64_t offset, uint64_t sizelimit, int flags)
 {
 	struct loopdev_cxt lc;
 	char *res = NULL;
@@ -1566,7 +1578,7 @@ char *loopdev_find_by_backing_file(const char *filename, uint64_t offset, int fl
 
 	if (loopcxt_init(&lc, 0))
 		return NULL;
-	if (loopcxt_find_by_backing_file(&lc, filename, offset, flags) == 0)
+	if (loopcxt_find_by_backing_file(&lc, filename, offset, sizelimit, flags) == 0)
 		res = loopcxt_strdup_device(&lc);
 	loopcxt_deinit(&lc);
 
diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 7530632..8a5706a 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -119,13 +119,13 @@ is_mounted_same_loopfile(struct libmnt_context *cxt,
 		rc = 0;
 
 		if (strncmp(src, "/dev/loop", 9) == 0) {
-			rc = loopdev_is_used((char *) src, bf, offset, LOOPDEV_FL_OFFSET);
+			rc = loopdev_is_used((char *) src, bf, offset, 0, LOOPDEV_FL_OFFSET);
 
 		} else if (opts && (cxt->user_mountflags & MNT_MS_LOOP) &&
 		    mnt_optstr_get_option(opts, "loop", &val, &len) == 0 && val) {
 
 			val = strndup(val, len);
-			rc = loopdev_is_used((char *) val, bf, offset, LOOPDEV_FL_OFFSET);
+			rc = loopdev_is_used((char *) val, bf, offset, 0, LOOPDEV_FL_OFFSET);
 			free(val);
 		}
 	}
@@ -219,7 +219,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	if (rc)
 		goto done_no_deinit;
 	if (backing_file && !(loopcxt_find_by_backing_file(&lc,
-			backing_file, offset, LOOPDEV_FL_OFFSET))) {
+			backing_file, offset, sizelimit, LOOPDEV_FL_OFFSET))) {
 		DBG(LOOP, ul_debugobj(cxt, "using existing loop device %s",
 					loopcxt_get_device(&lc)));
 		/* Once a loop is initialized RO, there is no way to safely
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 707665d..20819c4 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -328,7 +328,7 @@ static int is_associated_fs(const char *devname, struct libmnt_fs *fs)
 			return 0;
 	}
 
-	return loopdev_is_used(devname, src, offset, flags);
+	return loopdev_is_used(devname, src, offset, 0, flags);
 }
 
 static int prepare_helper_from_options(struct libmnt_context *cxt,
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 155c65e..341e5e3 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1555,7 +1555,7 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, struct libmnt_fs *fstab_fs)
 
 			DBG(FS, ul_debugobj(fs, "checking for loop: src=%s", mnt_fs_get_srcpath(fs)));
 #if __linux__
-			if (!loopdev_is_used(mnt_fs_get_srcpath(fs), src, offset, flags))
+			if (!loopdev_is_used(mnt_fs_get_srcpath(fs), src, offset, 0, flags))
 				continue;
 
 			DBG(FS, ul_debugobj(fs, "used loop"));
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 2ae6ace..d9c75b9 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -178,10 +178,10 @@ static int show_all_loops(struct loopdev_cxt *lc, const char *file,
 			int used;
 			const char *bf = cn_file ? cn_file : file;
 
-			used = loopcxt_is_used(lc, st, bf, offset, flags);
+			used = loopcxt_is_used(lc, st, bf, offset, 0, flags);
 			if (!used && !cn_file) {
 				bf = cn_file = canonicalize_path(file);
-				used = loopcxt_is_used(lc, st, bf, offset, flags);
+				used = loopcxt_is_used(lc, st, bf, offset, 0, flags);
 			}
 			if (!used)
 				continue;
@@ -344,10 +344,10 @@ static int show_table(struct loopdev_cxt *lc,
 				int used;
 				const char *bf = cn_file ? cn_file : file;
 
-				used = loopcxt_is_used(lc, st, bf, offset, flags);
+				used = loopcxt_is_used(lc, st, bf, offset, 0, flags);
 				if (!used && !cn_file) {
 					bf = cn_file = canonicalize_path(file);
-					used = loopcxt_is_used(lc, st, bf, offset, flags);
+					used = loopcxt_is_used(lc, st, bf, offset, 0, flags);
 				}
 				if (!used)
 					continue;
-- 
2.9.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
