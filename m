Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57856 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753621AbdGCLxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lkjuq-1e2RBr1HU4-00aV6a for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] path: never create path with prefix
Date: Mon,  3 Jul 2017 13:52:58 +0200
Message-Id: <1499082781-16968-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/path.c        | 20 ++------------------
 sys-utils/lscpu.c |  5 +----
 sys-utils/lsmem.c | 11 +++--------
 3 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/lib/path.c b/lib/path.c
index c286709..ca18a7c 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -77,22 +77,6 @@ err:
 	return NULL;
 }
 
-static const char *
-path_vcreate_with_prefix(const char *path, va_list ap)
-{
-	strcpy(pathbuf, pathbuf_prefix);
-	int rc = vsnprintf(
-		pathbuf + prefixlen, sizeof(pathbuf) - prefixlen, path, ap);
-
-	if (rc < 0)
-		return NULL;
-	if ((size_t)rc >= sizeof(pathbuf)) {
-		errno = ENAMETOOLONG;
-		return NULL;
-	}
-	return pathbuf;
-}
-
 const char *
 path_get(const char *path, ...)
 {
@@ -101,13 +85,13 @@ path_get(const char *path, ...)
 	static char userbuf[sizeof(pathbuf)];
 
 	va_start(ap, path);
-	p = path_vcreate_with_prefix(path, ap);
+	p = path_vcreate(path, ap);
 	va_end(ap);
 
 	if (p) {
 		/* do not hand out our global buffer to the user to avoid overlapping
 		 * problems in case we get this string back from the user */
-		p = strcpy(userbuf, p);
+		p = strcpy(userbuf, pathbuf);
 	}
 
 	return p;
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8b4fe0b..fa901fe 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1430,14 +1430,11 @@ read_nodes(struct lscpu_desc *desc)
 	int i = 0;
 	DIR *dir;
 	struct dirent *d;
-	const char *path;
 
 	desc->nnodes = 0;
 
 	/* number of NUMA node */
-	if (!(path = path_get(_PATH_SYS_NODE)))
-		return;
-	if (!(dir = opendir(path)))
+	if (!(dir = path_opendir(_PATH_SYS_NODE)))
 		return;
 	while ((d = readdir(dir))) {
 		if (is_node_dirent(d))
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index aeffd29..b8d827d 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -253,7 +253,7 @@ static int memory_block_get_node(char *name)
 	int node;
 
 	path = path_get(_PATH_SYS_MEMORY"/%s", name);
-	if (!path || !(dir= opendir(path)))
+	if (!path || !(dir = path_opendir(path)))
 		err(EXIT_FAILURE, _("Failed to open %s"), path ? path : name);
 
 	node = -1;
@@ -347,16 +347,11 @@ static int memory_block_filter(const struct dirent *de)
 
 static void read_basic_info(struct lsmem *lsmem)
 {
-	const char *dir;
-
 	if (!path_exist(_PATH_SYS_MEMORY_BLOCK_SIZE))
 		errx(EXIT_FAILURE, _("This system does not support memory blocks"));
 
-	dir = path_get(_PATH_SYS_MEMORY);
-	if (!dir)
-		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
-
-	lsmem->ndirs = scandir(dir, &lsmem->dirs, memory_block_filter, versionsort);
+	lsmem->ndirs = path_scandir(_PATH_SYS_MEMORY,
+			&lsmem->dirs, memory_block_filter, versionsort);
 	if (lsmem->ndirs <= 0)
 		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
 
-- 
1.8.5.6

