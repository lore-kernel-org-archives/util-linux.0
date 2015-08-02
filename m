Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35469 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbHBS3J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Aug 2015 14:29:09 -0400
Received: by wibxm9 with SMTP id xm9so93675706wib.0
        for <util-linux@vger.kernel.org>; Sun, 02 Aug 2015 11:29:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] tests: add way to control mkfs.minix time stamps
Date: Sun,  2 Aug 2015 19:28:59 +0100
Message-Id: <1438540140-959-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Needed in order to create reproducable file systems image files, so that
out come of mkfs.minix can be checksum'ed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/Makemodule.am |  5 +++++
 disk-utils/mkfs.minix.c  | 22 ++++++++++++++++++----
 tests/commands.sh        |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index 3a2b36d..a2e1994 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -13,6 +13,11 @@ mkfs_minix_SOURCES = \
 	disk-utils/minix_programs.h \
 	disk-utils/mkfs.minix.c
 mkfs_minix_LDADD = $(LDADD) libcommon.la
+
+check_PROGRAMS += test_mkfs_minix
+test_mkfs_minix_SOURCES = $(mkfs_minix_SOURCES)
+test_mkfs_minix_LDADD = $(mkfs_minix_LDADD)
+test_mkfs_minix_CFLAGS = -DTEST_SCRIPT
 endif
 
 
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 2da0e68..94ffacb 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -148,6 +148,20 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? MKFS_EX_USAGE : MKFS_EX_OK);
 }
 
+#ifdef TEST_SCRIPT
+static inline time_t mkfs_minix_time(time_t *t)
+{
+	const char *str = getenv("MKFS_MINIX_TEST_SECOND_SINCE_EPOCH");
+	time_t sec;
+
+	if (str && sscanf(str, "%ld", &sec) == 1)
+		return sec;
+	return time(t);
+}
+#else				/* !TEST_SCRIPT */
+# define mkfs_minix_time(x) time(x)
+#endif
+
 static void super_set_state(void)
 {
 	switch (fs_version) {
@@ -251,7 +265,7 @@ static void make_bad_inode_v1(struct fs_control *ctl)
 		return;
 	mark_inode(MINIX_BAD_INO);
 	inode->i_nlinks = 1;
-	inode->i_time = time(NULL);
+	inode->i_time = mkfs_minix_time(NULL);
 	inode->i_mode = S_IFREG + 0000;
 	inode->i_size = ctl->fs_bad_blocks * MINIX_BLOCK_SIZE;
 	zone = next(0);
@@ -299,7 +313,7 @@ static void make_bad_inode_v2_v3 (struct fs_control *ctl)
 		return;
 	mark_inode (MINIX_BAD_INO);
 	inode->i_nlinks = 1;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
+	inode->i_atime = inode->i_mtime = inode->i_ctime = mkfs_minix_time(NULL);
 	inode->i_mode = S_IFREG + 0000;
 	inode->i_size = ctl->fs_bad_blocks * MINIX_BLOCK_SIZE;
 	zone = next (0);
@@ -351,7 +365,7 @@ static void make_root_inode_v1(struct fs_control *ctl) {
 	mark_inode(MINIX_ROOT_INO);
 	inode->i_zone[0] = get_free_block(ctl);
 	inode->i_nlinks = 2;
-	inode->i_time = time(NULL);
+	inode->i_time = mkfs_minix_time(NULL);
 	if (ctl->fs_bad_blocks)
 		inode->i_size = 3 * ctl->fs_dirsize;
 	else {
@@ -372,7 +386,7 @@ static void make_root_inode_v2_v3 (struct fs_control *ctl) {
 	mark_inode (MINIX_ROOT_INO);
 	inode->i_zone[0] = get_free_block (ctl);
 	inode->i_nlinks = 2;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
+	inode->i_atime = inode->i_mtime = inode->i_ctime = mkfs_minix_time(NULL);
 
 	if (ctl->fs_bad_blocks)
 		inode->i_size = 3 * ctl->fs_dirsize;
diff --git a/tests/commands.sh b/tests/commands.sh
index b5098c8..bb985c7 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -22,6 +22,7 @@ TS_HELPER_PYLIBMOUNT_UPDATE="$top_srcdir/libmount/python/test_mount_tab_update.p
 TS_HELPER_LOGGER="$top_builddir/test_logger"
 TS_HELPER_LOGINDEFS="$top_builddir/test_logindefs"
 TS_HELPER_MD5="$top_builddir/test_md5"
+TS_HELPER_MKFS_MINIX="$top_builddir/test_mkfs_minix"
 TS_HELPER_MORE=${TS_HELPER_MORE-"$top_builddir/test_more"}
 TS_HELPER_PARTITIONS="$top_builddir/sample-partitions"
 TS_HELPER_PATHS="$top_builddir/test_pathnames"
-- 
2.5.0

