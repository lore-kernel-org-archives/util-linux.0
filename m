Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8371 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab2IRKs1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Sep 2012 06:48:27 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8IAmRbm009462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 18 Sep 2012 06:48:27 -0400
Received: from [10.34.4.243] (unused-4-243.brq.redhat.com [10.34.4.243])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q8IAmPql028195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Tue, 18 Sep 2012 06:48:27 -0400
Message-ID: <50585179.2040605@redhat.com>
Date: Tue, 18 Sep 2012 12:48:25 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: which vs. whereis
Content-Type: multipart/mixed;
 boundary="------------030607040807050908080001"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030607040807050908080001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, I've written a patch which should take care of this RFE:
https://bugzilla.redhat.com/show_bug.cgi?id=835211

The core of the patch is in make_list(), which should fill
a struct with 3 fields({bin,man,src}dirs) to be used instead of the 
originals. Here the original
hard-coded fields are processed and only real paths(no symlink paths)
are stored in the new fields. I've also taken the liberty of modifying 
fillpath
to return the length of the table it creates and changed the place it's 
called from
to make_list(). The pathdir pointer is merged with other real 
directories from bindirs,
since bindirs and $PATH were searched together anyway.

Have a nice day,
   Ondrej.

--------------030607040807050908080001
Content-Type: text/plain; charset=UTF-8;
 name="DIFF"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="DIFF"

>From b06f2ad847790f3575bd284dfbd6fbf94da77c57 Mon Sep 17 00:00:00 2001
From: Ondrej Oprala <ooprala@redhat.com>
Date: Tue, 18 Sep 2012 10:33:18 +0200
Subject: [PATCH] whereis: filter out duplicit directory entries from
 hardcoded arrays caused by symlinks

---
 misc-utils/whereis.c | 150 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 15 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index ae4cc03..f689880 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -45,10 +45,12 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <dirent.h>
+#include <search.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <glob.h>
 
 #include "xalloc.h"
 #include "nls.h"
@@ -130,8 +132,17 @@ static char *srcdirs[] = {
 	0
 };
 
+static struct dirs {
+	char **bindirs; //includes $PATH
+	char **mandirs;
+	char **srcdirs;
+	size_t b_len;
+	size_t m_len;
+	size_t s_len;
+} dirs;
+
 static char sflag = 1, bflag = 1, mflag = 1, uflag;
-static char **Sflag, **Bflag, **Mflag, **pathdir, **pathdir_p;
+static char **Sflag, **Bflag, **Mflag, **pathdir, **dir_list;
 static int Scnt, Bcnt, Mcnt, count, print;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -260,14 +271,14 @@ static int inpath(const char *str)
 	return 0;
 }
 
-static void fillpath(void)
+static int fillpath(void)
 {
 	char *key=NULL, *tok=NULL, *pathcp, *path = getenv("PATH");
 	int i = 0;
 
 
 	if (!path)
-		return;
+		return 0;
 	pathcp = xstrdup(path);
 
 	for (tok = strtok_r(pathcp, ":", &key); tok;
@@ -278,19 +289,127 @@ static void fillpath(void)
 			continue;
 
 		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
-		pathdir[i++] = xstrdup(tok);
+		pathdir[i++] = canonicalize_file_name(tok);
 	}
 
 	pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
 	pathdir[i] = NULL;
 
-	pathdir_p = pathdir;
 	free(pathcp);
+	return i;
+}
+
+static void
+free_b(void)
+{
+	char **bkp = dirs.bindirs;
+	while (*(dirs.bindirs))
+		free(*(dirs.bindirs++));
+	free(bkp);
+}
+
+static void
+free_m(void)
+{
+	char **bkp = dirs.mandirs;
+	while (*(dirs.mandirs))
+		free(*(dirs.mandirs++));
+	free(bkp);
+}
+
+static void
+free_s(void)
+{
+	char **bkp = dirs.srcdirs;
+
+	while (*(dirs.srcdirs))
+		free(*(dirs.srcdirs++));
+	free(bkp);
+}
+
+static void
+free_dirs(void)
+{
+	free_b();
+	free_m();
+	free_s();
+}
+
+static int
+key_cmp(char *key, char **target)
+{
+	return strcmp(key, *target);
 }
 
-static void freepath(void)
+static void
+entry_lookup(char *key, size_t *len, size_t ptr_size)
 {
-	free(pathdir);
+	errno = 0;
+	char *canon;
+  //return if dir in key doesn't exist
+	if (((canon = canonicalize_file_name(key)) == NULL) && errno == ENOENT)
+		return;
+
+	if (!(*len) || !lfind(canon, dir_list, len, ptr_size,
+		(__compar_fn_t) key_cmp)) {
+		dir_list = xrealloc(dir_list, (*len + 1) * ptr_size);
+		dir_list[(*len)++] = canon;
+	}
+	else
+		free(canon);
+}
+
+static void
+make_list(void)
+{
+	size_t len, ptr_size=sizeof(char *);
+	char **lists[4]={bindirs, mandirs, srcdirs, NULL};
+	glob_t glob_tree, glob_bkp;
+	int i = 0;
+
+	len = fillpath();
+	dir_list = pathdir;
+	if (len)
+		free(dir_list[len]); //free the last pathdir entry
+
+	while (lists[i]) {
+		while (*lists[i]) {
+			if (!strchr(*lists[i], '*'))
+				entry_lookup(*lists[i]++, &len, ptr_size);
+			else {
+				if (glob(*lists[i]++, GLOB_NOSORT,
+					NULL, &glob_tree) == GLOB_NOMATCH) {
+					globfree(&glob_tree);
+					continue;
+				}
+				glob_bkp = glob_tree;
+
+				while (*glob_tree.gl_pathv)
+					entry_lookup(*glob_tree.gl_pathv++,
+					             &len, ptr_size);
+				globfree(&glob_bkp);
+			}
+		}
+		dir_list = xrealloc(dir_list, (len + 1) * ptr_size);
+		dir_list[len] = NULL;
+
+		switch (i) {
+			case 0:
+				dirs.bindirs = dir_list;
+				dirs.b_len = len;
+				break;
+			case 1:
+				dirs.mandirs = dir_list;
+				dirs.m_len = len;
+				break;
+			case 2:
+				dirs.srcdirs = dir_list;
+				dirs.s_len = len;
+		}
+			len = 0;
+			dir_list = NULL;
+			++i;
+	}
 }
 
 static void
@@ -305,7 +424,7 @@ static void
 looksrc(char *cp)
 {
 	if (Sflag == 0)
-		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
+		findv(dirs.srcdirs, dirs.s_len, cp);
 	else
 		findv(Sflag, Scnt, cp);
 }
@@ -314,9 +433,7 @@ static void
 lookbin(char *cp)
 {
 	if (Bflag == 0) {
-		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
-		while (*pathdir_p)
-			findin(*pathdir_p++, cp);		/* look $PATH */
+		findv(dirs.bindirs, dirs.b_len, cp);
 	 } else
 		findv(Bflag, Bcnt, cp);
 }
@@ -325,7 +442,7 @@ static void
 lookman(char *cp)
 {
 	if (Mflag == 0)
-		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
+		findv(dirs.mandirs, dirs.m_len, cp);
 	else
 		findv(Mflag, Mcnt, cp);
 }
@@ -354,6 +471,7 @@ print_again(char *cp)
 {
 	if (print)
 		printf("%s:", cp);
+
 	if (sflag) {
 		looksrc(cp);
 		if (uflag && print == 0 && count != 1) {
@@ -475,12 +593,14 @@ main(int argc, char **argv)
 			}
 			argv++;
 		} else {
-			if (Bcnt == 0 && pathdir == NULL)
-				fillpath();
+			//fill struct dirs with real pathnames from *dirs[] and $PATH
+			if (!pathdir)
+				make_list();
 			lookup(*argv++);
 		}
 	while (--argc > 0);
 
-	freepath();
+	if (pathdir)
+		free_dirs();
 	return EXIT_SUCCESS;
 }
-- 
1.7.11.4


--------------030607040807050908080001--
