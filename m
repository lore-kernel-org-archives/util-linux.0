Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwW8p-1duS5I3XIt-018JSP for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] misc: fix gcc-7 snprintf warnings -Wformat-truncation
Date: Mon, 12 Jun 2017 10:49:57 +0200
Message-Id: <20170612084958.22054-6-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

../lib/loopdev.c: In function 'loopcxt_next_from_sysfs':
../lib/loopdev.c:545:32: warning: '/loop/backing_file' directive output may be truncated writing 18 bytes into a region of size between 1 and 256 [-Wformat-truncation=]
   snprintf(name, sizeof(name), "%s/loop/backing_file", d->d_name);
                                ^~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:545:3: note: 'snprintf' output between 19 and 274 bytes into a destination of size 256
   snprintf(name, sizeof(name), "%s/loop/backing_file", d->d_name);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

../lib/sysfs.c: In function 'sysfs_is_partition_dirent':
../lib/sysfs.c:343:31: warning: '/start' directive output may be truncated writing 6 bytes into a region of size between 1 and 256 [-Wformat-truncation=]
  snprintf(path, sizeof(path), "%s/start", d->d_name);
                               ^~~~~~~~~~
../lib/sysfs.c:343:2: note: 'snprintf' output between 7 and 262 bytes into a destination of size 256
  snprintf(path, sizeof(path), "%s/start", d->d_name);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/sysfs.c: In function 'sysfs_partno_to_devno':
../lib/sysfs.c:372:32: warning: '/partition' directive output may be truncated writing 10 bytes into a region of size between 1 and 256 [-Wformat-truncation=]
   snprintf(path, sizeof(path), "%s/partition", d->d_name);
                                ^~~~~~~~~~~~~~
../lib/sysfs.c:372:3: note: 'snprintf' output between 11 and 266 bytes into a destination of size 256
   snprintf(path, sizeof(path), "%s/partition", d->d_name);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/sysfs.c:377:33: warning: '/dev' directive output may be truncated writing 4 bytes into a region of size between 1 and 256 [-Wformat-truncation=]
    snprintf(path, sizeof(path), "%s/dev", d->d_name);
                                 ^~~~~~~~
../lib/sysfs.c:377:4: note: 'snprintf' output between 5 and 260 bytes into a destination of size 256
    snprintf(path, sizeof(path), "%s/dev", d->d_name);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/loopdev.c | 2 +-
 lib/sysfs.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 00066823c..8c653a361 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -532,7 +532,7 @@ static int loopcxt_next_from_sysfs(struct loopdev_cxt *lc)
 	fd = dirfd(iter->sysblock);
 
 	while ((d = readdir(iter->sysblock))) {
-		char name[256];
+		char name[NAME_MAX + 18 + 1];
 		struct stat st;
 
 		DBG(ITER, ul_debugobj(iter, "check %s", d->d_name));
diff --git a/lib/sysfs.c b/lib/sysfs.c
index cc290faac..68b43aaa3 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -307,7 +307,7 @@ static struct dirent *xreaddir(DIR *dp)
 
 int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
 {
-	char path[256];
+	char path[NAME_MAX + 6 + 1];
 
 #ifdef _DIRENT_HAVE_D_TYPE
 	if (d->d_type != DT_DIR &&
@@ -356,7 +356,7 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
 {
 	DIR *dir;
 	struct dirent *d;
-	char path[256];
+	char path[NAME_MAX + 10 + 1];
 	dev_t devno = 0;
 
 	dir = sysfs_opendir(cxt, NULL);
-- 
2.12.3

