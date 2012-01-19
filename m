Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52400 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2ASE2m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Jan 2012 23:28:42 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0J4SgJq026607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 18 Jan 2012 23:28:42 -0500
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q0J4Sfq9006285
	for <util-linux@vger.kernel.org>; Wed, 18 Jan 2012 23:28:42 -0500
Date: Thu, 19 Jan 2012 13:28:41 +0900 (JST)
Message-Id: <20120119.132841.785556956001804188.yamato@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] Use filter arg of scandir* to pickup
 /etc/fstab.d/*.fstab files
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch is based on my last patch:

     [PATCH 1/2] scandirat based mnt_table_parse_dir implementation

scandir* used in `mnt_table_parse_dir in libmount/src/tab_parse.c
can take filter function as an argument.

`mnt_table_parse_dir' picks up fstab files from namelist returned from
scandir* for itself. However, some parts of picking-up job can be done 
in the filter function.

This patch introduces a new function `mnt_table_parse_dir_filter' to
share the code for picking-up job between two implementations of
`mnt_table_parse_dir_filter', scandir based and scandirat based.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 libmount/src/tab_parse.c |   63 +++++++++++++++++++--------------------------
 1 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index dbedb27..b7462a0 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -435,6 +435,30 @@ int mnt_table_parse_file(struct libmnt_table *tb, const char *filename)
 	return rc;
 }
 
+static int mnt_table_parse_dir_filter(const struct dirent *d)
+{
+	size_t namesz;
+
+#ifdef _DIRENT_HAVE_D_TYPE
+	if (d->d_type != DT_UNKNOWN && d->d_type != DT_REG &&
+	    d->d_type != DT_LNK)
+		return 0;
+#endif
+	if (*d->d_name == '.')
+		return 0;
+
+#define MNT_MNTTABDIR_EXTSIZ	(sizeof(MNT_MNTTABDIR_EXT) - 1)
+	
+	namesz = strlen(d->d_name);
+	if (!namesz || namesz < MNT_MNTTABDIR_EXTSIZ + 1 ||
+	    strcmp(d->d_name + (namesz - MNT_MNTTABDIR_EXTSIZ),
+		   MNT_MNTTABDIR_EXT))
+		return 0;
+
+	/* Accept this */
+	return 1;
+}
+
 #ifdef HAVE_SCANDIRAT
 static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 {
@@ -445,7 +469,8 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 	dd = open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
 	if (dd < 0)
 	        return -errno;
-	n = scandirat(dd, ".", &namelist, NULL, versionsort);
+
+	n = scandirat(dd, ".", &namelist, mnt_table_parse_dir_filter, versionsort);
 	if (n <= 0) {
 	        close(dd);
 	        return 0;
@@ -454,25 +479,8 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 	for (i = 0; i < n; i++) {
 		struct dirent *d = namelist[i];
 		struct stat st;
-		size_t namesz;
 		FILE *f;
 
-#ifdef _DIRENT_HAVE_D_TYPE
-		if (d->d_type != DT_UNKNOWN && d->d_type != DT_REG &&
-		    d->d_type != DT_LNK)
-			continue;
-#endif
-		if (*d->d_name == '.')
-			continue;
-
-#define MNT_MNTTABDIR_EXTSIZ	(sizeof(MNT_MNTTABDIR_EXT) - 1)
-
-		namesz = strlen(d->d_name);
-		if (!namesz || namesz < MNT_MNTTABDIR_EXTSIZ + 1 ||
-		    strcmp(d->d_name + (namesz - MNT_MNTTABDIR_EXTSIZ),
-			    MNT_MNTTABDIR_EXT))
-				continue;
-
 		if (fstat_at(dd, ".", d->d_name, &st, 0) ||
 		    !S_ISREG(st.st_mode))
 			continue;
@@ -497,7 +505,7 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 	DIR *dir = NULL;
 	struct dirent **namelist = NULL;
 
-	n = scandir(dirname, &namelist, NULL, versionsort);
+	n = scandir(dirname, &namelist, mnt_table_parse_dir_filter, versionsort);
 	if (n <= 0)
 		return 0;
 
@@ -509,25 +517,8 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 	for (i = 0; i < n; i++) {
 		struct dirent *d = namelist[i];
 		struct stat st;
-		size_t namesz;
 		FILE *f;
 
-#ifdef _DIRENT_HAVE_D_TYPE
-		if (d->d_type != DT_UNKNOWN && d->d_type != DT_REG &&
-		    d->d_type != DT_LNK)
-			continue;
-#endif
-		if (*d->d_name == '.')
-			continue;
-
-#define MNT_MNTTABDIR_EXTSIZ	(sizeof(MNT_MNTTABDIR_EXT) - 1)
-
-		namesz = strlen(d->d_name);
-		if (!namesz || namesz < MNT_MNTTABDIR_EXTSIZ + 1 ||
-		    strcmp(d->d_name + (namesz - MNT_MNTTABDIR_EXTSIZ),
-			    MNT_MNTTABDIR_EXT))
-				continue;
-
 		if (fstat_at(dirfd(dir), _PATH_MNTTAB_DIR, d->d_name, &st, 0) ||
 		    !S_ISREG(st.st_mode))
 			continue;
-- 
1.7.7.5

