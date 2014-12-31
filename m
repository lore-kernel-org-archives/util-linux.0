Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:62648 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaLaXGt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 31 Dec 2014 18:06:49 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so22453158wgg.25
        for <util-linux@vger.kernel.org>; Wed, 31 Dec 2014 15:06:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] maint: fix shadow declaration
Date: Wed, 31 Dec 2014 23:01:21 +0000
Message-Id: <1420066881-16797-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change fixes all shadow declarations.  The worth while to mention
fix is with libfdisk sun geometry.  It comes from bitops.h cpu_to_be16
macro that further expands from include/bits/byteswap.h that has the
shadowing.

libfdisk/src/sun.c:961:173: warning: declaration of '__v' shadows a previous local [-Wshadow]
libfdisk/src/sun.c:961:69: warning: shadowed declaration is here [-Wshadow]
libfdisk/src/sun.c:961:178: warning: declaration of '__x' shadows a previous local [-Wshadow]
libfdisk/src/sun.c:961:74: warning: shadowed declaration is here [-Wshadow]

That could have caused earlier some unexpected results.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c            |  6 +++---
 disk-utils/fsck.cramfs.c       | 40 ++++++++++++++++++++--------------------
 libfdisk/src/sun.c             |  8 +++++---
 libfdisk/src/table.c           |  6 +++---
 libmount/src/tab_parse.c       |  6 +++---
 libsmartcols/src/table_print.c |  6 +++---
 login-utils/lslogins.c         | 32 ++++++++++++++++----------------
 misc-utils/findmnt.c           |  4 ++--
 misc-utils/lslocks.c           |  4 ++--
 sys-utils/swapon.c             | 14 +++++++-------
 sys-utils/zramctl.c            |  2 +-
 11 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 14a75c5..75674ce 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -504,7 +504,7 @@ static int ask_menu(struct fdisk_ask *ask, struct cfdisk *cf)
 
 	/* wait for keys */
 	do {
-		int key = getch();
+		key = getch();
 
 		if (ui_resize)
 			ui_menu_resize(cf);
@@ -2000,7 +2000,6 @@ static int main_menu_action(struct cfdisk *cf, int key)
 	case 'W': /* Write */
 	{
 		char buf[64] = { 0 };
-		int rc;
 
 		if (fdisk_is_readonly(cf->cxt)) {
 			warn = _("Device open in read-only mode");
@@ -2091,8 +2090,9 @@ static int ui_run(struct cfdisk *cf)
 		ui_warnx(_("Device open in read-only mode."));
 
 	do {
-		int rc = 0, key = getch();
+		int key = getch();
 
+		rc = 0;
 		if (ui_resize)
 			/* Note that ncurses getch() returns ERR when interrupted
 			 * by signal, but SLang does not interrupt at all. */
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 0a1c6f2..1f15741 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -101,21 +101,21 @@ static size_t blksize = 0;
 /* Input status of 0 to print help and exit without an error. */
 static void __attribute__((__noreturn__)) usage(int status)
 {
-	FILE *stream = status ? stderr : stdout;
+	FILE *out = status ? stderr : stdout;
 
-	fputs(USAGE_HEADER, stream);
-	fprintf(stream,
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
 		_(" %s [options] <file>\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, stream);
-	fputs(_(" -a                       for compatibility only, ignored\n"), stream);
-	fputs(_(" -v, --verbose            be more verbose\n"), stream);
-	fputs(_(" -y                       for compatibility only, ignored\n"), stream);
-	fputs(_(" -b, --blocksize <size>   use this blocksize, defaults to page size\n"), stream);
-	fputs(_("     --extract[=<dir>]    test uncompression, optionally extract into <dir>\n"), stream);
-	fputs(USAGE_SEPARATOR, stream);
-	fputs(USAGE_HELP, stream);
-	fputs(USAGE_VERSION, stream);
-	fputs(USAGE_SEPARATOR, stream);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -a                       for compatibility only, ignored\n"), out);
+	fputs(_(" -v, --verbose            be more verbose\n"), out);
+	fputs(_(" -y                       for compatibility only, ignored\n"), out);
+	fputs(_(" -b, --blocksize <size>   use this blocksize, defaults to page size\n"), out);
+	fputs(_("     --extract[=<dir>]    test uncompression, optionally extract into <dir>\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fputs(USAGE_SEPARATOR, out);
 	exit(status);
 }
 
@@ -360,7 +360,7 @@ static int uncompress_block(void *src, size_t len)
 #define lchown chown
 #endif
 
-static void do_uncompress(char *path, int fd, unsigned long offset,
+static void do_uncompress(char *path, int outfd, unsigned long offset,
 			  unsigned long size)
 {
 	unsigned long curr = offset + 4 * ((size + blksize - 1) / blksize);
@@ -400,7 +400,7 @@ static void do_uncompress(char *path, int fd, unsigned long offset,
 		}
 		size -= out;
 		if (*extract_dir != '\0')
-			if (write(fd, outbuffer, out) < 0)
+			if (write(outfd, outbuffer, out) < 0)
 				err(FSCK_EX_ERROR, _("write failed: %s"),
 				    path);
 		curr = next;
@@ -484,7 +484,7 @@ static void do_directory(char *path, struct cramfs_inode *i)
 static void do_file(char *path, struct cramfs_inode *i)
 {
 	unsigned long offset = i->offset << 2;
-	int fd = 0;
+	int outfd = 0;
 
 	if (offset == 0 && i->size != 0)
 		errx(FSCK_EX_UNCORRECTED,
@@ -497,14 +497,14 @@ static void do_file(char *path, struct cramfs_inode *i)
 	if (opt_verbose)
 		print_node('f', i, path);
 	if (*extract_dir != '\0') {
-		fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, i->mode);
-		if (fd < 0)
+		outfd = open(path, O_WRONLY | O_CREAT | O_TRUNC, i->mode);
+		if (outfd < 0)
 			err(FSCK_EX_ERROR, _("cannot open %s"), path);
 	}
 	if (i->size)
-		do_uncompress(path, fd, offset, i->size);
+		do_uncompress(path, outfd, offset, i->size);
 	if ( *extract_dir != '\0') {
-		if (close_fd(fd) != 0)
+		if (close_fd(outfd) != 0)
 			err(FSCK_EX_ERROR, _("write failed: %s"), path);
 		change_file_status(path, i);
 	}
diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index babff62..d99c39f 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -957,9 +957,11 @@ static int sun_write_disklabel(struct fdisk_context *cxt)
 	sunlabel->nhead = cpu_to_be16(cxt->geom.heads);
 	sunlabel->nsect = cpu_to_be16(cxt->geom.sectors);
 
-	if (cxt->geom.cylinders != be16_to_cpu(sunlabel->ncyl))
-		sunlabel->ncyl = cpu_to_be16( cxt->geom.cylinders
-				      - be16_to_cpu(sunlabel->acyl) );
+	if (cxt->geom.cylinders != be16_to_cpu(sunlabel->ncyl)) {
+		int a = cpu_to_be16(cxt->geom.cylinders);
+		int b = be16_to_cpu(sunlabel->acyl);
+		sunlabel->ncyl = a - b;
+	}
 
 	ush = (unsigned short *) sunlabel;
 
diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
index 1add09f..9234814 100644
--- a/libfdisk/src/table.c
+++ b/libfdisk/src/table.c
@@ -437,16 +437,16 @@ static int table_add_freespace(
 	}
 
 	while (fdisk_table_next_partition(tb, &itr, &x) == 0) {
-		fdisk_sector_t end, best_end = 0;
+		fdisk_sector_t the_end, best_end = 0;
 
 		if (!fdisk_partition_has_end(x))
 			continue;
 
-		end = fdisk_partition_get_end(x);
+		the_end = fdisk_partition_get_end(x);
 		if (best)
 			best_end = fdisk_partition_get_end(best);
 
-		if (end < pa->start && (!best || best_end < end))
+		if (the_end < pa->start && (!best || best_end < the_end))
 			best = x;
 	}
 
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 58b71ca..05496f7 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -173,10 +173,10 @@ static int mnt_parse_mountinfo_line(struct libmnt_fs *fs, char *s)
 		/* remove "(deleted)" suffix */
 		sz = strlen(fs->target);
 		if (sz > PATH_DELETED_SUFFIX_SZ) {
-			char *p = fs->target + (sz - PATH_DELETED_SUFFIX_SZ);
+			char *ptr = fs->target + (sz - PATH_DELETED_SUFFIX_SZ);
 
-			if (strcmp(p, PATH_DELETED_SUFFIX) == 0)
-				*p = '\0';
+			if (strcmp(ptr, PATH_DELETED_SUFFIX) == 0)
+				*ptr = '\0';
 		}
 
 		unmangle_string(fs->root);
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 4191515..542d8a2 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -660,13 +660,13 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
 			}
 		} else if (width < tb->termwidth) {
 			/* enlarge the last column */
-			struct libscols_column *cl = list_entry(
+			struct libscols_column *col = list_entry(
 				tb->tb_columns.prev, struct libscols_column, cl_columns);
 
 			DBG(TAB, ul_debugobj(tb, "   enlarge width (last column)"));
 
-			if (!scols_column_is_right(cl) && tb->termwidth - width > 0) {
-				cl->width += tb->termwidth - width;
+			if (!scols_column_is_right(col) && tb->termwidth - width > 0) {
+				col->width += tb->termwidth - width;
 				width = tb->termwidth;
 			}
 		}
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 0e99529..df4f451 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -892,33 +892,33 @@ static int create_usertree(struct lslogins_control *ctl)
 
 static struct libscols_table *setup_table(struct lslogins_control *ctl)
 {
-	struct libscols_table *tb = scols_new_table();
+	struct libscols_table *table = scols_new_table();
 	int n = 0;
 
-	if (!tb)
+	if (!table)
 		errx(EXIT_FAILURE, _("failed to initialize output table"));
 	if (ctl->noheadings)
-		scols_table_enable_noheadings(tb, 1);
+		scols_table_enable_noheadings(table, 1);
 
 	switch(outmode) {
 	case OUT_COLON:
-		scols_table_enable_raw(tb, 1);
-		scols_table_set_column_separator(tb, ":");
+		scols_table_enable_raw(table, 1);
+		scols_table_set_column_separator(table, ":");
 		break;
 	case OUT_NEWLINE:
-		scols_table_set_column_separator(tb, "\n");
+		scols_table_set_column_separator(table, "\n");
 		/* fallthrough */
 	case OUT_EXPORT:
-		scols_table_enable_export(tb, 1);
+		scols_table_enable_export(table, 1);
 		break;
 	case OUT_NUL:
-		scols_table_set_line_separator(tb, "\0");
+		scols_table_set_line_separator(table, "\0");
 		/* fallthrough */
 	case OUT_RAW:
-		scols_table_enable_raw(tb, 1);
+		scols_table_enable_raw(table, 1);
 		break;
 	case OUT_PRETTY:
-		scols_table_enable_noheadings(tb, 1);
+		scols_table_enable_noheadings(table, 1);
 	default:
 		break;
 	}
@@ -929,7 +929,7 @@ static struct libscols_table *setup_table(struct lslogins_control *ctl)
 		if (ctl->notrunc)
 			flags &= ~SCOLS_FL_TRUNC;
 
-		if (!scols_table_new_column(tb,
+		if (!scols_table_new_column(table,
 				coldescs[columns[n]].name,
 				coldescs[columns[n]].whint,
 				flags))
@@ -937,9 +937,9 @@ static struct libscols_table *setup_table(struct lslogins_control *ctl)
 		++n;
 	}
 
-	return tb;
+	return table;
 fail:
-	scols_unref_table(tb);
+	scols_unref_table(table);
 	return NULL;
 }
 
@@ -1106,7 +1106,7 @@ done:
 }
 #endif
 
-static int print_pretty(struct libscols_table *tb)
+static int print_pretty(struct libscols_table *table)
 {
 	struct libscols_iter *itr = scols_new_iter(SCOLS_ITER_FORWARD);
 	struct libscols_column *col;
@@ -1115,8 +1115,8 @@ static int print_pretty(struct libscols_table *tb)
 	const char *hstr, *dstr;
 	int n = 0;
 
-	ln = scols_table_get_line(tb, 0);
-	while (!scols_table_next_column(tb, itr, &col)) {
+	ln = scols_table_get_line(table, 0);
+	while (!scols_table_next_column(table, itr, &col)) {
 
 		data = scols_line_get_cell(ln, n);
 
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 75099d9..16308f8 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -856,7 +856,7 @@ static struct libmnt_table *parse_tabfiles(char **files,
  * Parses mountinfo and calls mnt_cache_set_targets(cache, mtab). Only
  * necessary if @tb in main() was read from a non-kernel source.
  */
-static void cache_set_targets(struct libmnt_cache *cache)
+static void cache_set_targets(struct libmnt_cache *tmp)
 {
 	struct libmnt_table *tb;
 	const char *path;
@@ -870,7 +870,7 @@ static void cache_set_targets(struct libmnt_cache *cache)
 		_PATH_PROC_MOUNTS;
 
 	if (mnt_table_parse_file(tb, path) == 0)
-		mnt_cache_set_targets(cache, tb);
+		mnt_cache_set_targets(tmp, tb);
 
 	mnt_unref_table(tb);
 }
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 83d7b90..abc6a16 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -162,7 +162,7 @@ static char *get_fallback_filename(dev_t dev)
  * Return the absolute path of a file from
  * a given inode number (and its size)
  */
-static char *get_filename_sz(ino_t inode, pid_t pid, size_t *size)
+static char *get_filename_sz(ino_t inode, pid_t lock_pid, size_t *size)
 {
 	struct stat sb;
 	struct dirent *dp;
@@ -180,7 +180,7 @@ static char *get_filename_sz(ino_t inode, pid_t pid, size_t *size)
 	 * iterate the *entire* filesystem searching
 	 * for the damn file.
 	 */
-	sprintf(path, "/proc/%d/fd/", pid);
+	sprintf(path, "/proc/%d/fd/", lock_pid);
 	if (!(dirp = opendir(path)))
 		return NULL;
 
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index a457607..3df1dd2 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -643,35 +643,35 @@ static int swapon_by_uuid(const char *uuid, int prio, int dsc)
 
 /* -o <options> or fstab */
 static int parse_options(const char *optstr,
-			 int *priority, int *discard, int *nofail)
+			 int *prio, int *disc, int *nofail)
 {
 	char *arg = NULL;
 
 	assert(optstr);
-	assert(priority);
-	assert(discard);
+	assert(prio);
+	assert(disc);
 	assert(nofail);
 
 	if (mnt_optstr_get_option(optstr, "nofail", NULL, 0) == 0)
 		*nofail = 1;
 
 	if (mnt_optstr_get_option(optstr, "discard", &arg, NULL) == 0) {
-		*discard |= SWAP_FLAG_DISCARD;
+		*disc |= SWAP_FLAG_DISCARD;
 
 		if (arg) {
 			/* only single-time discards are wanted */
 			if (strcmp(arg, "once") == 0)
-				*discard |= SWAP_FLAG_DISCARD_ONCE;
+				*disc |= SWAP_FLAG_DISCARD_ONCE;
 
 			/* do discard for every released swap page */
 			if (strcmp(arg, "pages") == 0)
-				*discard |= SWAP_FLAG_DISCARD_PAGES;
+				*disc |= SWAP_FLAG_DISCARD_PAGES;
 			}
 	}
 
 	arg = NULL;
 	if (mnt_optstr_get_option(optstr, "pri", &arg, NULL) == 0 && arg)
-		*priority = atoi(arg);
+		*prio = atoi(arg);
 
 	return 0;
 }
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 786be06..779987f 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -351,7 +351,7 @@ static void status(struct zram *z)
 	if (z)
 		fill_table_row(tb, z);		/* just one device specified */
 	else {
-		size_t i;			/* list all used devices */
+		/* list all used devices */
 		z = new_zram(NULL);
 
 		for (i = 0; ; i++) {
-- 
2.2.1

