Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbdF1QlQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:16 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MFAaV-1dW2me04fz-00GDxr for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] lsmem: fix, using freed memory
Date: Wed, 28 Jun 2017 18:40:52 +0200
Message-Id: <1498668057-8256-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Simply avoiding strdup(). Error handling improved.

This was the Clang Analyzer warning:

    Memory Error, Use-after-free
    sys-utils/lsmem.c:259:3: warning: Use of memory after it is freed
                    err(EXIT_FAILURE, _("Failed to open %s"), path);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/path.h    |  5 ++++-
 lib/path.c        |  6 +++---
 sys-utils/lscpu.c |  6 +++---
 sys-utils/lsmem.c | 19 ++++++++++---------
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/path.h b/include/path.h
index 11c3367..ae36d7f 100644
--- a/include/path.h
+++ b/include/path.h
@@ -4,8 +4,11 @@
 #include <stdio.h>
 #include <stdint.h>
 
-extern char *path_strdup(const char *path, ...)
+/* Returns a pointer to a static buffer which may be destroyed by any later
+path_* function call. NULL means error and errno will be set. */
+extern const char *path_get(const char *path, ...)
 			__attribute__ ((__format__ (__printf__, 1, 2)));
+
 extern FILE *path_fopen(const char *mode, int exit_on_err, const char *path, ...)
 			__attribute__ ((__format__ (__printf__, 3, 4)));
 extern void path_read_str(char *result, size_t len, const char *path, ...)
diff --git a/lib/path.c b/lib/path.c
index 48ffe17..280b597 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -56,8 +56,8 @@ path_vcreate(const char *path, va_list ap)
 	return pathbuf;
 }
 
-char *
-path_strdup(const char *path, ...)
+const char *
+path_get(const char *path, ...)
 {
 	const char *p;
 	va_list ap;
@@ -66,7 +66,7 @@ path_strdup(const char *path, ...)
 	p = path_vcreate(path, ap);
 	va_end(ap);
 
-	return p ? strdup(p) : NULL;
+	return p;
 }
 
 static FILE *
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index f6e4727..83f3a7d 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1430,12 +1430,12 @@ read_nodes(struct lscpu_desc *desc)
 	int i = 0;
 	DIR *dir;
 	struct dirent *d;
-	char *path;
+	const char *path;
 
 	/* number of NUMA node */
-	path = path_strdup(_PATH_SYS_NODE);
+	if (!(path = path_get(_PATH_SYS_NODE)))
+		return;
 	dir = opendir(path);
-	free(path);
 
 	while (dir && (d = readdir(dir))) {
 		if (is_node_dirent(d))
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index e1ee5a5..4db6789 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -248,15 +248,14 @@ static void print_summary(struct lsmem *lsmem)
 static int memory_block_get_node(char *name)
 {
 	struct dirent *de;
-	char *path;
+	const char *path;
 	DIR *dir;
 	int node;
 
-	path = path_strdup(_PATH_SYS_MEMORY"/%s", name);
-	dir = opendir(path);
-	free(path);
-	if (!dir)
-		err(EXIT_FAILURE, _("Failed to open %s"), path);
+	path = path_get(_PATH_SYS_MEMORY"/%s", name);
+	if (!path || !(dir= opendir(path)))
+		err(EXIT_FAILURE, _("Failed to open %s"), path ? path : name);
+
 	node = -1;
 	while ((de = readdir(dir)) != NULL) {
 		if (strncmp("node", de->d_name, 4))
@@ -348,14 +347,16 @@ static int memory_block_filter(const struct dirent *de)
 
 static void read_basic_info(struct lsmem *lsmem)
 {
-	char *dir;
+	const char *dir;
 
 	if (!path_exist(_PATH_SYS_MEMORY_BLOCK_SIZE))
 		errx(EXIT_FAILURE, _("This system does not support memory blocks"));
 
-	dir = path_strdup(_PATH_SYS_MEMORY);
+	dir = path_get(_PATH_SYS_MEMORY);
+	if (!dir)
+		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
+
 	lsmem->ndirs = scandir(dir, &lsmem->dirs, memory_block_filter, versionsort);
-	free(dir);
 	if (lsmem->ndirs <= 0)
 		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
 
-- 
1.8.5.6

