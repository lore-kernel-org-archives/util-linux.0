Return-Path: util-linux-owner@vger.kernel.org
Received: from [159.226.21.127] ([159.226.21.127]:37372 "EHLO
	debian-lizhi.in.linx" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755782Ab2B2Irp (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 29 Feb 2012 03:47:45 -0500
From: Zhi Li <lizhi1215@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng@vger.kernel.org, Zhi Li <xiaoxiang.fu@163.com>,
        Zhi Li <lizhi1215@gmail.com>
Subject: [PATCH 1/1] To fix a minor bug in mountpoint.c, see:
Date: Wed, 29 Feb 2012 16:28:49 +0800
Message-Id: <1330504129-5545-1-git-send-email-lizhi1215@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

zhi@debian-lizhi:~$ mountpoint /sys
/sys is not a mountpoint
zhi@debian-lizhi:~$

The problem is in mountpoint.c, function dir_to_device(), which uses 0 as an
error return value, but for sysfs 0 is its device number:

zhi@debian-lizhi:~$ cat /proc/self/mountinfo
14 19 0:0 / /sys rw,nosuid,nodev,noexec,relatime - sysfs none rw
15 19 0:3 / /proc rw,nosuid,nodev,noexec,relatime - proc none rw

My change is on dir_to_device, seperating device number from return value.

Signed-off-by: Zhi Li <lizhi1215@gmail.com>
---
 sys-utils/mountpoint.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index b3f150c..1b29e24 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -40,12 +40,11 @@
 
 static int quiet;
 
-static dev_t dir_to_device(const char *spec)
+static int dir_to_device(const char *spec, dev_t *dev)
 {
 	struct libmnt_table *tb = mnt_new_table_from_file("/proc/self/mountinfo");
 	struct libmnt_fs *fs;
 	struct libmnt_cache *cache;
-	dev_t res = 0;
 
 	if (!tb) {
 		/*
@@ -57,7 +56,7 @@ static dev_t dir_to_device(const char *spec)
 		int len;
 
 		if (stat(spec, &st) != 0)
-			return 0;
+			return -1;
 
 		cn = mnt_resolve_path(spec, NULL);	/* canonicalize */
 
@@ -65,15 +64,17 @@ static dev_t dir_to_device(const char *spec)
 		free(cn);
 
 		if (len < 0 || (size_t) len + 1 > sizeof(buf))
-			return 0;
+			return -1;
 		if (stat(buf, &pst) !=0)
-			return 0;
+			return -1;
 
 		if ((st.st_dev != pst.st_dev) ||
-		    (st.st_dev == pst.st_dev && st.st_ino == pst.st_ino))
-			return st.st_dev;
+		    (st.st_dev == pst.st_dev && st.st_ino == pst.st_ino)) {
+			*dev = st.st_dev;
+			return 0;
+		}
 
-		return 0;
+		return -1;
 	}
 
 	/* to canonicalize all necessary paths */
@@ -81,12 +82,12 @@ static dev_t dir_to_device(const char *spec)
 	mnt_table_set_cache(tb, cache);
 
 	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
-	if (fs && mnt_fs_get_target(fs))
-		res = mnt_fs_get_devno(fs);
+	if (fs && mnt_fs_get_target(fs)) 
+		*dev = mnt_fs_get_devno(fs);
 
 	mnt_free_table(tb);
 	mnt_free_cache(cache);
-	return res;
+	return 0;
 }
 
 static int print_devno(const char *devname, struct stat *st)
@@ -185,8 +186,8 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
 			return EXIT_FAILURE;
 		}
-		src = dir_to_device(spec);
-		if (!src) {
+
+		if ( dir_to_device(spec, &src)) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
 			return EXIT_FAILURE;
-- 
1.7.2.5

