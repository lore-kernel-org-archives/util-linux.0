Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56884 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2LPKoo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:44 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1394275wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/14] lib/ismounted: detect loopback mounts
Date: Sun, 16 Dec 2012 10:44:01 +0000
Message-Id: <1355654642-22106-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While double checking the minix changes worked I noticed fsck.minix not
to abort check if the file system was mounted using loopback device.  The
commands before this commit which one needs to reproduce the issue are:

dd if=/dev/zero count=100 of=minixfs
./mkfs.minix ./minixfs
mkdir x
./mount ./minixfs x
./fsck.minix minixfs

One would expect to see following print out.

minixfs is mounted.
check aborted.

Neither did that appear, nor the fsck check got to be aborted.  It seems
the generic fsck, and mkswap had same problem as they rely on
is_mounted().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/Makemodule.am | 1 +
 lib/ismounted.c   | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 806f9e5..244a9e8 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -76,6 +76,7 @@ test_blkdev_LDADD = libcommon.la
 
 test_ismounted_SOURCES = lib/ismounted.c
 test_ismounted_CFLAGS = -DTEST_PROGRAM
+test_ismounted_LDADD = $(LDADD) libcommon.la libmount.la
 
 test_wholedisk_SOURCES = lib/wholedisk.c
 test_wholedisk_CFLAGS = -DTEST_PROGRAM
diff --git a/lib/ismounted.c b/lib/ismounted.c
index 273a7d9..c3545bb 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -25,6 +25,7 @@
 
 #include "pathnames.h"
 #include "ismounted.h"
+#include "loopdev.h"
 #include "c.h"
 
 #ifdef HAVE_MNTENT_H
@@ -42,7 +43,7 @@ static int check_mntent_file(const char *mtab_file, const char *file,
 	dev_t		file_dev=0, file_rdev=0;
 	ino_t		file_ino=0;
 	FILE		*f;
-	int		fd;
+	int		fd, src_is_file = 1;
 
 	*mount_flags = 0;
 	if ((f = setmntent (mtab_file, "r")) == NULL)
@@ -55,6 +56,7 @@ static int check_mntent_file(const char *mtab_file, const char *file,
 		} else {
 			file_dev = st_buf.st_dev;
 			file_ino = st_buf.st_ino;
+			src_is_file = 0;
 		}
 	}
 	while ((mnt = getmntent (f)) != NULL) {
@@ -63,12 +65,14 @@ static int check_mntent_file(const char *mtab_file, const char *file,
 		if (strcmp(file, mnt->mnt_fsname) == 0)
 			break;
 		if (stat(mnt->mnt_fsname, &st_buf) == 0) {
-			if (S_ISBLK(st_buf.st_mode)) {
+			if (S_ISBLK(st_buf.st_mode) && src_is_file) {
 #ifndef __GNU__
 				if (file_rdev && (file_rdev == st_buf.st_rdev))
 					break;
 #endif	/* __GNU__ */
 			} else {
+				if (is_loopdev(mnt->mnt_fsname))
+					stat(loopdev_get_backing_file(mnt->mnt_fsname), &st_buf);
 				if (file_dev && ((file_dev == st_buf.st_dev) &&
 						 (file_ino == st_buf.st_ino)))
 					break;
-- 
1.8.0.2

