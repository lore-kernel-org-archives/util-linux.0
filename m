Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932991AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LoEPJ-1Zxh1w0BIH-00gDjT for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:05 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/12] misc: never cast void* from malloc(3) and friends
Date: Tue,  8 Mar 2016 00:11:56 +0100
Message-Id: <1457392322-4974-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Such cast could hide serious compiler warnings in case we are
missing includes (e.g. <stdlib.h> or "xalloc.h").

See
http://stackoverflow.com/questions/605845/do-i-cast-the-result-of-malloc

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/mkswap.c       | 2 +-
 lib/setproctitle.c        | 2 +-
 lib/strutils.c            | 2 +-
 libblkid/src/cache.c      | 2 +-
 libblkid/src/config.c     | 2 +-
 libblkid/src/dev.c        | 2 +-
 libblkid/src/tag.c        | 2 +-
 login-utils/login.c       | 2 +-
 misc-utils/test_uuidd.c   | 4 ++--
 sys-utils/swapon-common.c | 4 ++--
 term-utils/agetty.c       | 2 +-
 text-utils/col.c          | 4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 52ee8c6..a7c6a70 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -87,7 +87,7 @@ static void init_signature_page(struct mkswap_control *ctl)
 	} else
 		ctl->pagesize = kernel_pagesize;
 
-	ctl->signature_page = (unsigned long *) xcalloc(1, ctl->pagesize);
+	ctl->signature_page = xcalloc(1, ctl->pagesize);
 	ctl->hdr = (struct swap_header_v1_2 *) ctl->signature_page;
 }
 
diff --git a/lib/setproctitle.c b/lib/setproctitle.c
index 4bcf8c8..93bc82e 100644
--- a/lib/setproctitle.c
+++ b/lib/setproctitle.c
@@ -33,7 +33,7 @@ void initproctitle (int argc, char **argv)
 	for (i = 0; envp[i] != NULL; i++)
 		continue;
 
-	environ = (char **) malloc(sizeof(char *) * (i + 1));
+	environ = malloc(sizeof(char *) * (i + 1));
 	if (environ == NULL)
 		return;
 
diff --git a/lib/strutils.c b/lib/strutils.c
index 64a6b99..2d7cb59 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -247,7 +247,7 @@ char *strnchr(const char *s, size_t maxlen, int c)
 char *strndup(const char *s, size_t n)
 {
 	size_t len = strnlen(s, n);
-	char *new = (char *) malloc((len + 1) * sizeof(char));
+	char *new = malloc((len + 1) * sizeof(char));
 	if (!new)
 		return NULL;
 	new[len] = '\0';
diff --git a/libblkid/src/cache.c b/libblkid/src/cache.c
index b576df8..c6d02a4 100644
--- a/libblkid/src/cache.c
+++ b/libblkid/src/cache.c
@@ -102,7 +102,7 @@ int blkid_get_cache(blkid_cache *ret_cache, const char *filename)
 	DBG(CACHE, ul_debug("creating blkid cache (using %s)",
 				filename ? filename : "default cache"));
 
-	if (!(cache = (blkid_cache) calloc(1, sizeof(struct blkid_struct_cache))))
+	if (!(cache = calloc(1, sizeof(struct blkid_struct_cache))))
 		return -BLKID_ERR_MEM;
 
 	INIT_LIST_HEAD(&cache->bic_devs);
diff --git a/libblkid/src/config.c b/libblkid/src/config.c
index 3c7f312..1822f1c 100644
--- a/libblkid/src/config.c
+++ b/libblkid/src/config.c
@@ -120,7 +120,7 @@ struct blkid_config *blkid_read_config(const char *filename)
 	if (!filename)
 		filename = BLKID_CONFIG_FILE;
 
-	conf = (struct blkid_config *) calloc(1, sizeof(*conf));
+	conf = calloc(1, sizeof(*conf));
 	if (!conf)
 		return NULL;
 	conf->uevent = -1;
diff --git a/libblkid/src/dev.c b/libblkid/src/dev.c
index 99b70b6..8e5516b 100644
--- a/libblkid/src/dev.c
+++ b/libblkid/src/dev.c
@@ -34,7 +34,7 @@ blkid_dev blkid_new_dev(void)
 {
 	blkid_dev dev;
 
-	if (!(dev = (blkid_dev) calloc(1, sizeof(struct blkid_struct_dev))))
+	if (!(dev = calloc(1, sizeof(struct blkid_struct_dev))))
 		return NULL;
 
 	INIT_LIST_HEAD(&dev->bid_devs);
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index bfc7bb7..4dc7da1 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -21,7 +21,7 @@ static blkid_tag blkid_new_tag(void)
 {
 	blkid_tag tag;
 
-	if (!(tag = (blkid_tag) calloc(1, sizeof(struct blkid_struct_tag))))
+	if (!(tag = calloc(1, sizeof(struct blkid_struct_tag))))
 		return NULL;
 
 	INIT_LIST_HEAD(&tag->bit_tags);
diff --git a/login-utils/login.c b/login-utils/login.c
index ac76f65..236da9b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1039,7 +1039,7 @@ static void init_environ(struct login_context *cxt)
 
 	/* destroy environment unless user has requested preservation (-p) */
 	if (!cxt->keep_env) {
-		environ = (char **) xmalloc(sizeof(char *));
+		environ = xmalloc(sizeof(char *));
 		memset(environ, 0, sizeof(char *));
 	}
 
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 78399b9..36f3b3d 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -161,7 +161,7 @@ static void create_nthreads(process_t *proc, size_t index)
 	size_t i, ncreated = 0;
 	int rc;
 
-	threads = (thread_t *) xcalloc(nthreads, sizeof(thread_t));
+	threads = xcalloc(nthreads, sizeof(thread_t));
 
 	for (i = 0; i < nthreads; i++) {
 		thread_t *th = &threads[i];
@@ -209,7 +209,7 @@ static void create_nprocesses(void)
 	process_t *process;
 	size_t i;
 
-	process = (process_t *) xcalloc(nprocesses, sizeof(process_t));
+	process = xcalloc(nprocesses, sizeof(process_t));
 
 	for (i = 0; i < nprocesses; i++) {
 		process_t *proc = &process[i];
diff --git a/sys-utils/swapon-common.c b/sys-utils/swapon-common.c
index 75466a0..8b686c0 100644
--- a/sys-utils/swapon-common.c
+++ b/sys-utils/swapon-common.c
@@ -86,7 +86,7 @@ static size_t ulct;
 
 void add_label(const char *label)
 {
-	llist = (const char **) xrealloc(llist, (++llct) * sizeof(char *));
+	llist = xrealloc(llist, (++llct) * sizeof(char *));
 	llist[llct - 1] = label;
 }
 
@@ -102,7 +102,7 @@ size_t numof_labels(void)
 
 void add_uuid(const char *uuid)
 {
-	ulist = (const char **) xrealloc(ulist, (++ulct) * sizeof(char *));
+	ulist = xrealloc(ulist, (++ulct) * sizeof(char *));
 	ulist[ulct - 1] = uuid;
 }
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 55a00e1..1df1bc8 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1970,7 +1970,7 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 		if (len < 0)
 			log_err(_("%s: invalid character conversion for login name"), op->tty);
 
-		wcs = (wchar_t *) malloc((len + 1) * sizeof(wchar_t));
+		wcs = malloc((len + 1) * sizeof(wchar_t));
 		if (!wcs)
 			log_err(_("failed to allocate memory: %m"));
 
diff --git a/text-utils/col.c b/text-utils/col.c
index 53f0556..0823573 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -362,7 +362,7 @@ int main(int argc, char **argv)
 			int need;
 
 			need = l->l_lsize ? l->l_lsize * 2 : 90;
-			l->l_line = (CHAR *)xrealloc((void *) l->l_line,
+			l->l_line = xrealloc((void *) l->l_line,
 						    (unsigned) need * sizeof(CHAR));
 			l->l_lsize = need;
 		}
@@ -472,7 +472,7 @@ void flush_line(LINE *l)
 		 */
 		if (l->l_lsize > sorted_size) {
 			sorted_size = l->l_lsize;
-			sorted = (CHAR *)xrealloc((void *)sorted,
+			sorted = xrealloc((void *)sorted,
 						  (unsigned)sizeof(CHAR) * sorted_size);
 		}
 		if (l->l_max_col >= count_size) {
-- 
1.9.1

