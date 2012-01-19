Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2ASEQW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Jan 2012 23:16:22 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0J4GMAL008855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 18 Jan 2012 23:16:22 -0500
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q0J4GLlL023928
	for <util-linux@vger.kernel.org>; Wed, 18 Jan 2012 23:16:21 -0500
Date: Thu, 19 Jan 2012 13:16:20 +0900 (JST)
Message-Id: <20120119.131620.263039002661323738.yamato@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] scandirat based mnt_table_parse_dir implementation
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In comment of `mnt_table_parse_dir' of libmount/src/tab_parse.c:

	/* TODO: it would be nice to have a scandir() implementation that
	 *       is able to use already opened directory */

Nowadays glibc provides `scandirat'. This patch implements `scandirat'
based `mnt_table_parse_dir'.


Signed-off-by: Masatake YAMATO <yamato@redhat.com>

---
 configure.ac             |    1 +
 libmount/src/tab_parse.c |   65 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8af42e4..d00edff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,6 +263,7 @@ AC_CHECK_FUNCS(
 	lchown \
 	llseek \
 	lseek64 \
+	scandirat \
 	strtoull \
 	sysconf \
 	getdtablesize \
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 6cd66af..dbedb27 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -5,6 +5,12 @@
  * GNU Lesser General Public License.
  */
 
+#ifdef HAVE_SCANDIRAT
+#ifndef __USE_GNU
+#define __USE_GNU
+#endif	/* !__USE_GNU */
+#endif	/* HAVE_SCANDIRAT */
+
 #include <ctype.h>
 #include <limits.h>
 #include <dirent.h>
@@ -429,14 +435,68 @@ int mnt_table_parse_file(struct libmnt_table *tb, const char *filename)
 	return rc;
 }
 
+#ifdef HAVE_SCANDIRAT
+static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
+{
+	int n = 0, i;
+	int dd;
+	struct dirent **namelist = NULL;
+
+	dd = open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
+	if (dd < 0)
+	        return -errno;
+	n = scandirat(dd, ".", &namelist, NULL, versionsort);
+	if (n <= 0) {
+	        close(dd);
+	        return 0;
+	}
+
+	for (i = 0; i < n; i++) {
+		struct dirent *d = namelist[i];
+		struct stat st;
+		size_t namesz;
+		FILE *f;
+
+#ifdef _DIRENT_HAVE_D_TYPE
+		if (d->d_type != DT_UNKNOWN && d->d_type != DT_REG &&
+		    d->d_type != DT_LNK)
+			continue;
+#endif
+		if (*d->d_name == '.')
+			continue;
+
+#define MNT_MNTTABDIR_EXTSIZ	(sizeof(MNT_MNTTABDIR_EXT) - 1)
+
+		namesz = strlen(d->d_name);
+		if (!namesz || namesz < MNT_MNTTABDIR_EXTSIZ + 1 ||
+		    strcmp(d->d_name + (namesz - MNT_MNTTABDIR_EXTSIZ),
+			    MNT_MNTTABDIR_EXT))
+				continue;
+
+		if (fstat_at(dd, ".", d->d_name, &st, 0) ||
+		    !S_ISREG(st.st_mode))
+			continue;
+
+		f = fopen_at(dd, ".", d->d_name, O_RDONLY, "r");
+		if (f) {
+			mnt_table_parse_stream(tb, f, d->d_name);
+			fclose(f);
+		}
+	}
+
+	for (i = 0; i < n; i++)
+		free(namelist[i]);
+	free(namelist);
+	close(dd);
+	return 0;
+}
+#else
 static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 {
 	int n = 0, i;
 	DIR *dir = NULL;
 	struct dirent **namelist = NULL;
 
-	/* TODO: it would be nice to have a scandir() implementation that
-	 *       is able to use already opened directory */
 	n = scandir(dirname, &namelist, NULL, versionsort);
 	if (n <= 0)
 		return 0;
@@ -487,6 +547,7 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 		closedir(dir);
 	return 0;
 }
+#endif
 
 struct libmnt_table *__mnt_new_table_from_file(const char *filename, int fmt)
 {
-- 
1.7.7.5


