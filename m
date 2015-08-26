Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.outflux.net ([198.145.64.163]:36106 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbbHZWtZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Aug 2015 18:49:25 -0400
Date: Wed, 26 Aug 2015 15:49:23 -0700
From: Kees Cook <keescook@chromium.org>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150826224923.GA11884@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The kernel's maximum path length is PATH_MAX (4096). The use of BUFSIZ
(8192) would seem sufficient for reading mountinfo files, but it's
not. Paths may contain escaped characters (requiring 4x as many bytes
to read), and filesystem options are of unknown length. To avoid mounts
being either intentionally or unintentionally hidden from libmount and
its users, we must accept arbitrary length lines when parsing.

Long valid entries are currently ignored, with warnings like this:
mount: /proc/self/mountinfo: parse error: ignore entry at line 11.
mount: /proc/self/mountinfo: parse error: ignore entry at line 12.

Instead of using a malloc on every line parsed from mount files, do it
once per mount file context, growing it as needed. The general case will
never grow it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- use getline, duh. thanks vapier!
---
 libmount/src/mountP.h    |  2 ++
 libmount/src/tab.c       |  1 +
 libmount/src/tab_parse.c | 19 +++++++++----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index 660e0ad..cd02785 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -212,6 +212,8 @@ struct libmnt_table {
 	int		comms;		/* enable/disable comment parsing */
 	char		*comm_intro;	/* First comment in file */
 	char		*comm_tail;	/* Last comment in file */
+	char		*buf;		/* Memory for reading lines */
+	size_t		buf_size;	/* Size of line-reading buffer */
 
 	struct libmnt_cache *cache;		/* canonicalized paths/tags cache */
 
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 0df8d49..5e3069d 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -166,6 +166,7 @@ void mnt_free_table(struct libmnt_table *tb)
 	mnt_unref_cache(tb->cache);
 	free(tb->comm_intro);
 	free(tb->comm_tail);
+	free(tb->buf);
 	free(tb);
 }
 
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index ca8a618..1af8e6a 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -424,7 +424,6 @@ static int mnt_table_parse_next(struct libmnt_table *tb, FILE *f,
 				struct libmnt_fs *fs,
 				const char *filename, int *nlines)
 {
-	char buf[BUFSIZ];
 	char *s;
 	int rc;
 
@@ -435,17 +434,17 @@ static int mnt_table_parse_next(struct libmnt_table *tb, FILE *f,
 	/* read the next non-blank non-comment line */
 next_line:
 	do {
-		if (fgets(buf, sizeof(buf), f) == NULL)
+		if (getline(&tb->buf, &tb->buf_size, f) < 0)
 			return -EINVAL;
 		++*nlines;
-		s = strchr (buf, '\n');
+		s = strchr(tb->buf, '\n');
 		if (!s) {
 			/* Missing final newline?  Otherwise an extremely */
 			/* long line - assume file was corrupted */
 			if (feof(f)) {
 				DBG(TAB, ul_debugobj(tb,
 					"%s: no final newline",	filename));
-				s = strchr (buf, '\0');
+				s = strchr(tb->buf, '\0');
 			} else {
 				DBG(TAB, ul_debugobj(tb,
 					"%s:%d: missing newline at line",
@@ -457,12 +456,12 @@ next_line:
 		/* comments parser */
 		if (tb->comms
 		    && (tb->fmt == MNT_FMT_GUESS || tb->fmt == MNT_FMT_FSTAB)
-		    && is_comment_line(buf)) {
+		    && is_comment_line(tb->buf)) {
 			do {
-				rc = append_comment(tb, fs, buf, feof(f));
+				rc = append_comment(tb, fs, tb->buf, feof(f));
 				if (!rc)
-					rc = next_comment_line(buf,
-							sizeof(buf),
+					rc = next_comment_line(tb->buf,
+							tb->buf_size,
 							f, &s, nlines);
 			} while (rc == 0);
 
@@ -474,9 +473,9 @@ next_line:
 		}
 
 		*s = '\0';
-		if (--s >= buf && *s == '\r')
+		if (--s >= tb->buf && *s == '\r')
 			*s = '\0';
-		s = (char *) skip_blank(buf);
+		s = (char *) skip_blank(tb->buf);
 	} while (*s == '\0' || *s == '#');
 
 	if (tb->fmt == MNT_FMT_GUESS) {
-- 
1.9.1


-- 
Kees Cook
Chrome OS Security
