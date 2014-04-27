Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:33167 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaD0UFv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:05:51 -0400
Received: by mail-we0-f174.google.com with SMTP id w62so4282046wes.19
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:05:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/12] include/xalloc: ensure arithmetics overflow cannot happen
Date: Sun, 27 Apr 2014 21:05:27 +0100
Message-Id: <1398629138-31718-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The xrealloc() changes has the greatest change.  It splits the size and
multiplier arguments so that arithmetics overflow can be detected.  This
change is propagated to use of the function in other files.

Additionally this change checks that size inputs for allocations are
never zero.  It is uncertain if in these cases abort() should be called
to get a core.

The xstrdup() is made to use memcpy(), which is exactly what the library
call does so one layer of absraction is saved here.

References: http://undeadly.org/cgi?action=article&sid=20060330071917
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.cramfs.c  |  2 +-
 include/xalloc.h          | 85 ++++++++++++++++++++++++++++-------------------
 login-utils/login.c       |  2 +-
 misc-utils/blkid.c        |  2 +-
 misc-utils/findmnt.c      |  2 +-
 misc-utils/getopt.c       |  4 +--
 misc-utils/logger.c       |  2 +-
 sys-utils/swapon-common.c |  4 +--
 text-utils/col.c          |  9 ++---
 text-utils/column.c       |  7 ++--
 text-utils/more.c         |  4 +--
 text-utils/rev.c          |  2 +-
 text-utils/ul.c           |  2 +-
 13 files changed, 69 insertions(+), 58 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index ebc8112..7e4ee2b 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -497,7 +497,7 @@ static unsigned int write_directory_structure(struct entry *entry, char *base, u
 			if (entry->child) {
 				if (stack_entries >= stack_size) {
 					stack_size *= 2;
-					entry_stack = xrealloc(entry_stack, stack_size * sizeof(struct entry *));
+					entry_stack = xrealloc(entry_stack, stack_size, sizeof(struct entry *));
 				}
 				entry_stack[stack_entries] = entry;
 				stack_entries++;
diff --git a/include/xalloc.h b/include/xalloc.h
index f012fb2..478ebef 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -12,6 +12,7 @@
 
 #include <stdlib.h>
 #include <string.h>
+#include <stdint.h>
 
 #include "c.h"
 
@@ -22,62 +23,77 @@
 static inline __ul_alloc_size(1)
 void *xmalloc(const size_t size)
 {
-        void *ret = malloc(size);
+	void *ret;
 
-        if (!ret && size)
-                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
-        return ret;
+	if (size == 0)
+		err(XALLOC_EXIT_CODE, "xmalloc: zero size");
+	ret = malloc(size);
+	if (!ret)
+		err(XALLOC_EXIT_CODE, "xmalloc: cannot allocate %zu bytes", size);
+	return ret;
 }
 
 static inline __ul_alloc_size(2)
-void *xrealloc(void *ptr, const size_t size)
+void *xrealloc(void *ptr, const size_t nmemb, const size_t size)
 {
-        void *ret = realloc(ptr, size);
-
-        if (!ret && size)
-                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
-        return ret;
+	void *ret;
+	size_t new_size = nmemb * size;
+
+	if (new_size == 0)
+		err(XALLOC_EXIT_CODE, "xrealloc: zero size");
+	if (SIZE_MAX / nmemb < size)
+		err(XALLOC_EXIT_CODE, "xrealloc: nmemb * size > SIZE_MAX");
+	if (ptr == NULL)
+		ret = malloc(new_size);
+	else
+		ret = realloc(ptr, new_size);
+	if (!ret)
+		err(XALLOC_EXIT_CODE, "xrealloc: cannot allocate %zu bytes", size);
+	return ret;
 }
 
 static inline __ul_calloc_size(1, 2)
 void *xcalloc(const size_t nelems, const size_t size)
 {
-        void *ret = calloc(nelems, size);
-
-        if (!ret && size && nelems)
-                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
-        return ret;
+	void *ret;
+
+	if (nelems == 0 || size == 0)
+		err(XALLOC_EXIT_CODE, "xcalloc: zero size");
+	if (SIZE_MAX / nelems < size)
+		err(XALLOC_EXIT_CODE, "xcalloc: nmemb * size > SIZE_MAX");
+	ret = calloc(nelems, size);
+	if (!ret)
+		err(XALLOC_EXIT_CODE, "xcalloc: cannot allocate %zu bytes", nelems * size);
+	return ret;
 }
 
 static inline char __attribute__((warn_unused_result)) *xstrdup(const char *str)
 {
-        char *ret;
-
-        if (!str)
-                return NULL;
-
-        ret = strdup(str);
+	size_t len;
+	char *ret;
 
-        if (!ret)
-                err(XALLOC_EXIT_CODE, "cannot duplicate string");
-        return ret;
+	if (!str)
+		return NULL;
+	len = strlen(str) + 1;
+	ret = xmalloc(len);
+	memcpy(ret, str, len);
+	return ret;
 }
 
 static inline char * __attribute__((warn_unused_result)) xstrndup(const char *str, size_t size)
 {
-        char *ret;
+	char *ret;
 
-        if (!str)
-                return NULL;
+	if (!str)
+		return NULL;
 
-        ret = strndup(str, size);
+	ret = strndup(str, size);
 
-        if (!ret)
-                err(XALLOC_EXIT_CODE, "cannot duplicate string");
-        return ret;
+	if (!ret)
+		err(XALLOC_EXIT_CODE, "xstrndup: cannot duplicate string");
+	return ret;
 }
 
-
 static inline int __attribute__ ((__format__(printf, 2, 3)))
     xasprintf(char **strp, const char *fmt, ...)
 {
@@ -87,7 +103,7 @@ static inline int __attribute__ ((__format__(printf, 2, 3)))
 	ret = vasprintf(&(*strp), fmt, args);
 	va_end(args);
 	if (ret < 0)
-		err(XALLOC_EXIT_CODE, "cannot allocate string");
+		err(XALLOC_EXIT_CODE, "xasprintf: cannot allocate string");
 	return ret;
 }
 
@@ -95,11 +111,10 @@ static inline int xvasprintf(char **strp, const char *fmt, va_list ap)
 {
 	int ret = vasprintf(&(*strp), fmt, ap);
 	if (ret < 0)
-		err(XALLOC_EXIT_CODE, "cannot allocate string");
+		err(XALLOC_EXIT_CODE, "xvasprintf: cannot allocate string");
 	return ret;
 }
 
-
 static inline char * __attribute__((warn_unused_result)) xgethostname(void)
 {
 	char *name;
diff --git a/login-utils/login.c b/login-utils/login.c
index 89df489..99de89e 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -674,7 +674,7 @@ static struct passwd *get_passwd_entry(const char *username,
 			sz = (size_t) xsz;
 	}
 #endif
-	*pwdbuf = xrealloc(*pwdbuf, sz);
+	*pwdbuf = xrealloc(*pwdbuf, 1, sz);
 
 	x = getpwnam_r(username, pwd, *pwdbuf, sz, &res);
 	if (!res) {
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index b3eade5..46b8f24 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -374,7 +374,7 @@ static int append_str(char **res, size_t *sz, const char *a, const char *b)
 	if (!len)
 		return -1;
 
-	*res = str = xrealloc(str, len + 1);
+	*res = str = xrealloc(str, 1, len);
 	str += *sz;
 
 	if (a) {
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 3386061..274db3f 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -770,7 +770,7 @@ static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
 
 static char **append_tabfile(char **files, int *nfiles, char *filename)
 {
-	files = xrealloc(files, sizeof(char *) * (*nfiles + 1));
+	files = xrealloc(files, (*nfiles + 1), sizeof(char *));
 	files[(*nfiles)++] = filename;
 	return files;
 }
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 7630173..1c737e8 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -242,8 +242,8 @@ static void add_longopt(const char *name, int has_arg)
 	if (long_options_nr == long_options_length) {
 		long_options_length += LONG_OPTIONS_INCR;
 		long_options = xrealloc(long_options,
-					sizeof(struct option) *
-					long_options_length);
+					long_options_length,
+					sizeof(struct option));
 	}
 
 	long_options[long_options_nr].name = NULL;
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index f3bdc90..cba7412 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -231,7 +231,7 @@ static int journald_entry(FILE *fp)
 		}
 		if (lines == vectors) {
 			vectors *= 2;
-			iovec = xrealloc(iovec, vectors * sizeof(struct iovec));
+			iovec = xrealloc(iovec, vectors, sizeof(struct iovec));
 		}
 		iovec[lines].iov_base = buf;
 		iovec[lines].iov_len = sz;
diff --git a/sys-utils/swapon-common.c b/sys-utils/swapon-common.c
index 6dd7bac..7f89c47 100644
--- a/sys-utils/swapon-common.c
+++ b/sys-utils/swapon-common.c
@@ -74,7 +74,7 @@ static size_t ulct;
 
 void add_label(const char *label)
 {
-	llist = (const char **) xrealloc(llist, (++llct) * sizeof(char *));
+	llist = (const char **) xrealloc(llist, sizeof(char *), (++llct));
 	llist[llct - 1] = label;
 }
 
@@ -90,7 +90,7 @@ size_t numof_labels(void)
 
 void add_uuid(const char *uuid)
 {
-	ulist = (const char **) xrealloc(ulist, (++ulct) * sizeof(char *));
+	ulist = (const char **) xrealloc(ulist, sizeof(char *), (++ulct));
 	ulist[ulct - 1] = uuid;
 }
 
diff --git a/text-utils/col.c b/text-utils/col.c
index 9aa6a41..39b1089 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -350,8 +350,7 @@ int main(int argc, char **argv)
 			int need;
 
 			need = l->l_lsize ? l->l_lsize * 2 : 90;
-			l->l_line = (CHAR *)xrealloc((void *) l->l_line,
-						    (unsigned) need * sizeof(CHAR));
+			l->l_line = xrealloc(l->l_line, need, sizeof(CHAR));
 			l->l_lsize = need;
 		}
 		c = &l->l_line[l->l_line_len++];
@@ -460,13 +459,11 @@ void flush_line(LINE *l)
 		 */
 		if (l->l_lsize > sorted_size) {
 			sorted_size = l->l_lsize;
-			sorted = (CHAR *)xrealloc((void *)sorted,
-						  (unsigned)sizeof(CHAR) * sorted_size);
+			sorted = xrealloc(sorted, sorted_size, sizeof(CHAR));
 		}
 		if (l->l_max_col >= count_size) {
 			count_size = l->l_max_col + 1;
-			count = (int *)xrealloc((void *)count,
-			    (unsigned)sizeof(int) * count_size);
+			count = xrealloc(count, count_size, sizeof(int));
 		}
 		memset(count, 0, sizeof(int) * l->l_max_col + 1);
 		for (i = nchars, c = l->l_line; --i >= 0; c++)
diff --git a/text-utils/column.c b/text-utils/column.c
index e34184e..938c09a 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -326,8 +326,8 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy,
 		while ((cols[coloff] = local_wcstok(p, separator, greedy, &wcstok_state)) != NULL) {
 			if (++coloff == maxcols) {
 				maxcols += DEFCOLS;
-				cols = xrealloc(cols, maxcols * sizeof(wchar_t *));
-				lens = xrealloc(lens, maxcols * sizeof(ssize_t));
+				cols = xrealloc(cols, maxcols, sizeof(wchar_t *));
+				lens = xrealloc(lens, maxcols, sizeof(ssize_t));
 				/* zero fill only new memory */
 				memset(lens + (maxcols - DEFCOLS), 0,
 				       DEFCOLS * sizeof(*lens));
@@ -398,8 +398,7 @@ static int input(FILE *fp, int *maxlength, wchar_t ***list, int *entries)
 			*maxlength = len;
 		if (local_entries == maxentry) {
 			maxentry += DEFNUM;
-			local_list = xrealloc(local_list,
-				(u_int)maxentry * sizeof(wchar_t *));
+			local_list = xrealloc(local_list, maxentry, sizeof(wchar_t *));
 		}
 		local_list[local_entries++] = wcsdup(buf);
 	}
diff --git a/text-utils/more.c b/text-utils/more.c
index d05e946..98ac72c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -837,7 +837,7 @@ void prepare_line_buffer(void)
 		nsz = LINSIZ;
 
 	/* alloc nsz and extra space for \n\0 */
-	nline = xrealloc(Line, nsz + 2);
+	nline = xrealloc(Line, 2, nsz);
 	Line = nline;
 	LineLen = nsz;
 }
@@ -2059,7 +2059,7 @@ int expand(char **outbuf, char *inbuf)
 		offset = outstr - temp;
 		if (tempsz - offset - 1 < xtra) {
 			tempsz += 200 + xtra;
-			temp = xrealloc(temp, tempsz);
+			temp = xrealloc(temp, 1, tempsz);
 			outstr = temp + offset;
 		}
 		switch (c) {
diff --git a/text-utils/rev.c b/text-utils/rev.c
index f1341cb..ed4c313 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 				/* So now we double the buffer size */
 				bufsiz *= 2;
 
-				buf = xrealloc(buf, bufsiz * sizeof(wchar_t));
+				buf = xrealloc(buf, bufsiz, sizeof(wchar_t));
 
 				/* And fill the rest of the buffer */
 				if (!fgetws(&buf[len], bufsiz/2, fp))
diff --git a/text-utils/ul.c b/text-utils/ul.c
index b3b3dc3..ead1d52 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -653,7 +653,7 @@ static void needcol(int acol) {
 			obuflen = INT_MAX;
 
 		/* Now we can try to expand obuf. */
-		obuf = xrealloc(obuf, sizeof(struct CHAR) * obuflen);
+		obuf = xrealloc(obuf, obuflen, sizeof(struct CHAR));
 	}
 }
 
-- 
1.9.2

