Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34774 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbHQRoq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 17 Aug 2015 13:44:46 -0400
Received: by wicne3 with SMTP id ne3so80996844wic.1
        for <util-linux@vger.kernel.org>; Mon, 17 Aug 2015 10:44:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] misc: fix shadow declarations
Date: Mon, 17 Aug 2015 18:44:28 +0100
Message-Id: <1439833468-527-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/zramctl.c: In function 'get_mm_stat':
sys-utils/zramctl.c:276:58: warning: declaration of 'inbytes' shadows a global declaration [-Wshadow]
 static char *get_mm_stat(struct zram *z, size_t idx, int inbytes)
sys-utils/zramctl.c:119:39: note: shadowed declaration is here
 static unsigned int raw, no_headings, inbytes;

libmount/src/tab.c: In function 'mnt_table_get_fs_root':
libmount/src/tab.c:1221:22: warning: declaration of 'fs' shadows a parameter [-Wshadow]
    struct libmnt_fs *fs = mnt_table_find_mountpoint(tb,
libmount/src/tab.c:1197:24: note: shadowed declaration is here
      struct libmnt_fs *fs,

disk-utils/fsck.minix.c: In function 'main':
disk-utils/fsck.minix.c:1364:17: warning: declaration of 'i' shadows a previous local [-Wshadow]
   unsigned long i, free;
disk-utils/fsck.minix.c:1250:6: note: shadowed declaration is here
  int i;

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 10 +++++-----
 libmount/src/tab.c      |  6 +++---
 sys-utils/zramctl.c     |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 13ca7ca..3d73d49 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1361,16 +1361,16 @@ main(int argc, char **argv) {
 		check();
 	}
 	if (verbose) {
-		unsigned long i, free;
+		unsigned long inode, free;
 
-		for (i = 1, free = 0; i <= get_ninodes(); i++)
-			if (!inode_in_use(i))
+		for (inode = 1, free = 0; inode <= get_ninodes(); inode++)
+			if (!inode_in_use(inode))
 				free++;
 		printf(_("\n%6ld inodes used (%ld%%)\n"),
 		       (get_ninodes() - free),
 		       100 * (get_ninodes() - free) / get_ninodes());
-		for (i = get_first_zone(), free = 0; i < get_nzones(); i++)
-			if (!zone_in_use(i))
+		for (inode = get_first_zone(), free = 0; inode < get_nzones(); inode++)
+			if (!zone_in_use(inode))
 				free++;
 		printf(_("%6ld zones used (%ld%%)\n"), (get_nzones() - free),
 		       100 * (get_nzones() - free) / get_nzones());
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index d616547..0df8d49 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1218,10 +1218,10 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 
 		src = xsrc = mnt_resolve_spec(mnt_fs_get_source(fs), tb->cache);
 		if (src) {
-			struct libmnt_fs *fs = mnt_table_find_mountpoint(tb,
+			struct libmnt_fs *f = mnt_table_find_mountpoint(tb,
 							src, MNT_ITER_BACKWARD);
-			if (fs)
-				mnt = mnt_fs_get_target(fs);
+			if (f)
+				mnt = mnt_fs_get_target(f);
 		}
 
 		if (mnt)
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 957c1c0..9959823 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -273,7 +273,7 @@ static struct zram *find_free_zram(void)
 
 #include "path.h"
 
-static char *get_mm_stat(struct zram *z, size_t idx, int inbytes)
+static char *get_mm_stat(struct zram *z, size_t idx, int bytes)
 {
 	struct sysfs_cxt *sysfs;
 	const char *name;
@@ -302,7 +302,7 @@ static char *get_mm_stat(struct zram *z, size_t idx, int inbytes)
 	}
 
 	if (z->mm_stat) {
-		if (inbytes)
+		if (bytes)
 			return xstrdup(z->mm_stat[idx]);
 
 		num = strtou64_or_err(z->mm_stat[idx], _("Failed to parse mm_stat"));
@@ -311,7 +311,7 @@ static char *get_mm_stat(struct zram *z, size_t idx, int inbytes)
 
 	/* Linux < 4.1 uses /sys/block/zram<id>/<attrname> */
 	name = mm_stat_names[idx];
-	if (inbytes)
+	if (bytes)
 		return sysfs_strdup(sysfs, name);
 	else if (sysfs_read_u64(sysfs, name, &num) == 0)
 		return size_to_human_string(SIZE_SUFFIX_1LETTER, num);
-- 
2.5.0

