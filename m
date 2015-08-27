Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbbH0J0s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Aug 2015 05:26:48 -0400
Date: Thu, 27 Aug 2015 11:26:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150827092646.GF2410@ws.net.home>
References: <20150826224923.GA11884@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150826224923.GA11884@www.outflux.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 03:49:23PM -0700, Kees Cook wrote:
>  libmount/src/mountP.h    |  2 ++
>  libmount/src/tab.c       |  1 +
>  libmount/src/tab_parse.c | 19 +++++++++----------
>  3 files changed, 12 insertions(+), 10 deletions(-)

I have applied a different version of the patch. See below. Thanks!

It would be possible to use the new libmnt_parser on more places in
the code, but we are in -rc2, so I don't want to be so invasive now.

    Karel


>From d92b8c3ba138f07a7432b367feb599141ce76121 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 27 Aug 2015 10:49:39 +0200
Subject: [PATCH] libmount: handle arbitrary line length for mounts

Based on patch from Kees Cook, he wrote:
> The kernel's maximum path length is PATH_MAX (4096). The use of BUFSIZ
> (8192) would seem sufficient for reading mountinfo files, but it's
> not. Paths may contain escaped characters (requiring 4x as many bytes
> to read), and filesystem options are of unknown length. To avoid
> mounts being either intentionally or unintentionally hidden from
> libmount and its users, we must accept arbitrary length lines when
> parsing.
>
> Long valid entries are currently ignored, with warnings like this:
> mount: /proc/self/mountinfo: parse error: ignore entry at line 11.
> mount: /proc/self/mountinfo: parse error: ignore entry at line 12.
>
> Instead of using a malloc on every line parsed from mount files, do it
> once per mount file context, growing it as needed. The general case
> will never grow it.

I have moved the parser stuff to the new struct libmnt_parser, maybe
we can move more things (e.g. libmnt_table->fmt) to this struct later.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 libmount/src/tab_parse.c | 81 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index ca8a618..2e55500 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -22,6 +22,22 @@
 #include "pathnames.h"
 #include "strutils.h"
 
+struct libmnt_parser {
+	FILE	*f;		/* fstab, mtab, swaps or mountinfo ... */
+	char	*filename;	/* file name or NULL */
+	char	*buf;		/* buffer (the current line content) */
+	size_t	bufsiz;		/* size of the buffer */
+	size_t	line;		/* current line */
+};
+
+static void parser_cleanup(struct libmnt_parser *pa)
+{
+	if (!pa)
+		return;
+	free(pa->buf);
+	memset(pa, 0, sizeof(*pa));
+}
+
 static int next_number(char **s, int *num)
 {
 	char *end = NULL;
@@ -378,16 +394,15 @@ static int is_terminated_by_blank(const char *str)
  *         1 if the line is not a comment
  *        <0 on error
  */
-static int next_comment_line(char *buf, size_t bufsz,
-			     FILE *f, char **last, int *nlines)
+static int next_comment_line(struct libmnt_parser *pa, char **last)
 {
-	if (fgets(buf, bufsz, f) == NULL)
-		return feof(f) ? 1 : -EINVAL;
+	if (getline(&pa->buf, &pa->bufsiz, pa->f) < 0)
+		return feof(pa->f) ? 1 : -errno;
 
-	++*nlines;
-	*last = strchr(buf, '\n');
+	pa->line++;
+	*last = strchr(pa->buf, '\n');
 
-	return is_comment_line(buf) ? 0 : 1;
+	return is_comment_line(pa->buf) ? 0 : 1;
 }
 
 static int append_comment(struct libmnt_table *tb,
@@ -420,36 +435,35 @@ static int append_comment(struct libmnt_table *tb,
 /*
  * Read and parse the next line from {fs,m}tab or mountinfo
  */
-static int mnt_table_parse_next(struct libmnt_table *tb, FILE *f,
-				struct libmnt_fs *fs,
-				const char *filename, int *nlines)
+static int mnt_table_parse_next(struct libmnt_parser *pa,
+				struct libmnt_table *tb,
+				struct libmnt_fs *fs)
 {
-	char buf[BUFSIZ];
 	char *s;
 	int rc;
 
 	assert(tb);
-	assert(f);
+	assert(pa);
 	assert(fs);
 
 	/* read the next non-blank non-comment line */
 next_line:
 	do {
-		if (fgets(buf, sizeof(buf), f) == NULL)
+		if (getline(&pa->buf, &pa->bufsiz, pa->f) < 0)
 			return -EINVAL;
-		++*nlines;
-		s = strchr (buf, '\n');
+		pa->line++;
+		s = strchr(pa->buf, '\n');
 		if (!s) {
 			/* Missing final newline?  Otherwise an extremely */
 			/* long line - assume file was corrupted */
-			if (feof(f)) {
+			if (feof(pa->f)) {
 				DBG(TAB, ul_debugobj(tb,
-					"%s: no final newline",	filename));
-				s = strchr (buf, '\0');
+					"%s: no final newline",	pa->filename));
+				s = strchr(pa->buf, '\0');
 			} else {
 				DBG(TAB, ul_debugobj(tb,
-					"%s:%d: missing newline at line",
-					filename, *nlines));
+					"%s:%zu: missing newline at line",
+					pa->filename, pa->line));
 				goto err;
 			}
 		}
@@ -457,16 +471,14 @@ next_line:
 		/* comments parser */
 		if (tb->comms
 		    && (tb->fmt == MNT_FMT_GUESS || tb->fmt == MNT_FMT_FSTAB)
-		    && is_comment_line(buf)) {
+		    && is_comment_line(pa->buf)) {
 			do {
-				rc = append_comment(tb, fs, buf, feof(f));
+				rc = append_comment(tb, fs, pa->buf, feof(pa->f));
 				if (!rc)
-					rc = next_comment_line(buf,
-							sizeof(buf),
-							f, &s, nlines);
+					rc = next_comment_line(pa, &s);
 			} while (rc == 0);
 
-			if (rc == 1 && feof(f))
+			if (rc == 1 && feof(pa->f))
 				rc = append_comment(tb, fs, NULL, 1);
 			if (rc < 0)
 				return rc;
@@ -474,9 +486,9 @@ next_line:
 		}
 
 		*s = '\0';
-		if (--s >= buf && *s == '\r')
+		if (--s >= pa->buf && *s == '\r')
 			*s = '\0';
-		s = (char *) skip_blank(buf);
+		s = (char *) skip_blank(pa->buf);
 	} while (*s == '\0' || *s == '#');
 
 	if (tb->fmt == MNT_FMT_GUESS) {
@@ -508,7 +520,7 @@ next_line:
 	if (rc == 0)
 		return 0;
 err:
-	DBG(TAB, ul_debugobj(tb, "%s:%d: %s parse error", filename, *nlines,
+	DBG(TAB, ul_debugobj(tb, "%s:%zu: %s parse error", pa->filename, pa->line,
 				tb->fmt == MNT_FMT_MOUNTINFO ? "mountinfo" :
 				tb->fmt == MNT_FMT_SWAPS ? "swaps" :
 				tb->fmt == MNT_FMT_FSTAB ? "tab" : "utab"));
@@ -516,7 +528,7 @@ err:
 	/* by default all errors are recoverable, otherwise behavior depends on
 	 * the errcb() function. See mnt_table_set_parser_errcb().
 	 */
-	return tb->errcb ? tb->errcb(tb, filename, *nlines) : 1;
+	return tb->errcb ? tb->errcb(tb, pa->filename, pa->line) : 1;
 }
 
 static pid_t path_to_tid(const char *filename)
@@ -595,11 +607,11 @@ static int kernel_fs_postparse(struct libmnt_table *tb,
  */
 int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filename)
 {
-	int nlines = 0;
 	int rc = -1;
 	int flags = 0;
 	pid_t tid = -1;
 	struct libmnt_fs *fs = NULL;
+	struct libmnt_parser pa = { .line = 0 };
 
 	assert(tb);
 	assert(f);
@@ -609,6 +621,9 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
 				filename, mnt_table_get_nents(tb),
 				tb->fltrcb ? "yes" : "not"));
 
+	pa.filename = filename;
+	pa.f = f;
+
 	/* necessary for /proc/mounts only, the /proc/self/mountinfo
 	 * parser sets the flag properly
 	 */
@@ -622,7 +637,7 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
 				goto err;
 		}
 
-		rc = mnt_table_parse_next(tb, f, fs, filename, &nlines);
+		rc = mnt_table_parse_next(&pa, tb, fs);
 
 		if (!rc && tb->fltrcb && tb->fltrcb(fs, tb->fltrcb_data))
 			rc = 1;	/* filtered out by callback... */
@@ -653,9 +668,11 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
 
 	DBG(TAB, ul_debugobj(tb, "%s: stop parsing (%d entries)",
 				filename, mnt_table_get_nents(tb)));
+	parser_cleanup(&pa);
 	return 0;
 err:
 	DBG(TAB, ul_debugobj(tb, "%s: parse error (rc=%d)", filename, rc));
+	parser_cleanup(&pa);
 	return rc;
 }
 
-- 
2.4.3



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
