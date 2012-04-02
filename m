Return-Path: dave@gnu.org
Subject: [PATCH 2/3] fibmap: new command
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Apr 2012 16:35:50 +0200
Message-ID: <1333377350.2552.20.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This program gets file/filesystem fragmentation information and block layout
by using the fibmap ioctl. This allows it to be fs and block size independent.

It provides per-file information about holes and can map block for files up to 4Tb.
Additionally, an overall view of how fragmented partitions are can also be obtained
with statistics.
---
 sys-utils/.gitignore  |    1 +
 sys-utils/Makefile.am |    6 +
 sys-utils/fibmap.c    |  603 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/fibmap.c

diff --git a/sys-utils/.gitignore b/sys-utils/.gitignore
index 38e8874..621fbcc 100644
--- a/sys-utils/.gitignore
+++ b/sys-utils/.gitignore
@@ -3,6 +3,7 @@ ctrlaltdel
 cytune
 dmesg
 fallocate
+fibmap
 flock
 fsfreeze
 fstrim
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 83f38cf..ca0a2e4 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -3,6 +3,7 @@ include $(top_srcdir)/config/include-Makefile.am
 bin_PROGRAMS =
 sbin_PROGRAMS =
 usrbin_exec_PROGRAMS = \
+	fibmap \
 	flock \
 	ipcmk \
 	ipcrm \
@@ -12,6 +13,7 @@ usrbin_exec_PROGRAMS = \
 usrsbin_exec_PROGRAMS = readprofile
 
 dist_man_MANS = \
+	fibmap.8 \
 	flock.1 \
 	ipcmk.1 \
 	ipcrm.1 \
@@ -166,6 +168,10 @@ ipcmk_SOURCES = ipcmk.c $(top_srcdir)/lib/strutils.c
 ipcrm_SOURCES = ipcrm.c  $(top_srcdir)/lib/strutils.c
 flock_SOURCES = flock.c $(top_srcdir)/lib/strutils.c
 ldattach_SOURCES = ldattach.c $(top_srcdir)/lib/strutils.c
+fibmap_SOURCES = fibmap.c $(top_srcdir)/lib/strutils.c \
+			$(top_srcdir)/lib/mbsalign.c \
+			$(top_srcdir)/lib/tt.c \
+			$(top_srcdir)/lib/pager.c
 
 if BUILD_MOUNTPOINT
 bin_PROGRAMS += mountpoint
diff --git a/sys-utils/fibmap.c b/sys-utils/fibmap.c
new file mode 100644
index 0000000..ab74d82
--- /dev/null
+++ b/sys-utils/fibmap.c
@@ -0,0 +1,603 @@
+/*
+ *  fibmap - get file/filesystem block layout and fragmentation info
+ *
+ *  Copyright (C) 2012 Davidlohr Bueso <dave@gnu.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <ftw.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <assert.h>
+#include <getopt.h>
+#include <sys/time.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+
+#include "c.h"
+#include "tt.h"
+#include "nls.h"
+#include "list.h"
+#include "pager.h"
+#include "xalloc.h"
+#include "strutils.h"
+
+#define INVBLK -1 /* block nums are always unsigned */
+
+/* column IDs for general (list) output */
+enum {
+	COL_PATH,
+	COL_SIZE,
+	COL_NBLKS,
+	COL_FRAGED,
+};
+
+/* program flags (options) */
+enum {
+	FL_STATS	= (1 << 1), /* show fs/dir statistics */
+	FL_MAP          = (1 << 2), /* show a file's block map */
+	FL_FRAGONLY	= (1 << 3), /* show only fragemented files */
+};
+
+/*
+ * Each file can be represented with a map of the blocks
+ * that compose it; if no fragmentation is present, then
+ * there will only 1 element in the list and len = __file->nblocks
+*/
+struct fmap {
+	int len;
+	unsigned long blknum;
+	struct list_head l;
+};
+
+struct __file {
+	int nblks;     /* amount of blocks */
+	int noncont;   /* number of non-contiguous blocks */
+	size_t blksz;  /* block size (bytes) */
+	size_t size;
+	double fragpercent;
+	char *path;
+	struct fmap *map;
+	struct list_head list;
+};
+
+/* column names */
+struct colinfo {
+	const char	*name;	/* header */
+	double		whint;	/* width hint (N < 1 is in percent of termwidth) */
+	int		flags;	/* TT_FL_* */
+	const char      *help;
+};
+
+/* columns descriptions */
+struct colinfo infos[] = {
+	[COL_PATH]  = { "PATH",    0.25, TT_FL_TRUNC, N_("file name") },
+	[COL_SIZE]  = { "SIZE",    0.10, TT_FL_RIGHT,                   N_("file size") },
+	[COL_NBLKS] = { "NBLKS",   0.10, TT_FL_RIGHT,                   N_("file's amount of blocks") },
+	[COL_FRAGED] = { "FRAGED", 0.10, TT_FL_RIGHT,                   N_("file's fragmentation percentage") },
+};
+
+#define NCOLS ARRAY_SIZE(infos)
+
+/* array with IDs of enabled columns */
+static int columns[NCOLS], ncolumns;
+static struct list_head files;
+static int flags = 0;
+static struct timeval start_time, end_time;
+
+static int column_name_to_id(const char *name, size_t namesz)
+{
+	size_t i;
+
+	assert(name);
+
+	for (i = 0; i < NCOLS; i++) {
+		const char *cn = infos[i].name;
+
+		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
+			return i;
+	}
+	warnx(_("unknown column: %s"), name);
+	return -1;
+}
+
+static inline int get_column_id(int num)
+{
+	assert(ARRAY_SIZE(columns) == NCOLS);
+	assert(num < ncolumns);
+	assert(columns[num] < (int) NCOLS);
+
+	return columns[num];
+}
+
+static inline struct colinfo *get_column_info(unsigned num)
+{
+	return &infos[ get_column_id(num) ];
+}
+
+static void add_tt_line(struct tt *tt, struct __file *f)
+{
+	int i;
+	struct tt_line *line;
+
+	assert(tt);
+	assert(f);
+
+	line = tt_add_line(tt, NULL);
+	if (!line) {
+		warn(_("failed to add line to output"));
+		return;
+	}
+
+	for (i = 0; i < ncolumns; i++) {
+		char *str = NULL;
+		int rc = 0;
+
+		switch (get_column_id(i)) {
+		case COL_PATH:
+			rc = asprintf(&str, "%s", f->path);
+			break;
+		case COL_SIZE:
+			rc = asprintf(&str, "%s", size_to_human_string(SIZE_SUFFIX_1LETTER, f->size));
+			break;
+		case COL_NBLKS:
+			rc = asprintf(&str, "%d", f->nblks);
+			break;
+		case COL_FRAGED:
+			rc = asprintf(&str, "%.2f%%", f->fragpercent);
+			break;
+		default:
+			break;
+		}
+
+		if (rc || str)
+			tt_line_set_data(line, i, str);
+	}
+}
+
+static int add_block(unsigned long blknum, int len, struct list_head *head)
+{
+	struct fmap *map = xcalloc(1, sizeof(*map));
+	INIT_LIST_HEAD(&map->l);
+
+	map->len = len;
+	map->blknum = blknum;
+	list_add_tail(&map->l, head);
+
+	return 0;
+}
+
+/*
+ * Returns the file's block map and the amount of non-contiguous
+ * blocks in noncont (as a shortcut).
+ */
+static int get_fibmap(int fd, int nblocks, int *noncont, struct list_head *head)
+{
+	int i, ret = 0, len = 0, _noncont = 0;
+	unsigned int blk, prev_blk, first_blk;
+
+	blk = prev_blk = first_blk = INVBLK;
+	struct list_head list;
+
+	for (i = 0; i < nblocks; i++) {
+		blk = i; /* fibmap needs the block index as input */
+
+		/*
+		 * Note that this ioctl returns a 32-bit value, so we might
+		 * have problems with large files/filesystems with more than
+		 * 4 billion blocks (~16TB).
+		 */
+		if ((ret = ioctl(fd, FIBMAP, &blk)) < 0)
+			goto out;
+		/* printf("%10d\n", blk); */
+
+		if (i == 0)
+			first_blk = blk;
+
+		/* started a new block sequence */
+		if (prev_blk != -1 && blk != prev_blk + 1) {
+			/*
+			 * Found a non-contiguous block, add the previous
+			 * block info to the list and reset to continue.
+			 */
+			add_block(first_blk, len, head);
+			first_blk = blk;
+
+			len = 0;
+			prev_blk = INVBLK;
+			_noncont++;
+		}
+		len++;
+		prev_blk = blk;
+
+		/* at least add one non-contiguous set of blocks to the list */
+		if (i == nblocks - 1)
+			add_block(first_blk, len, head);
+	}
+out:
+	*noncont = _noncont;
+	return ret;
+}
+
+static int get_noncont(int fd, int nblocks)
+{
+	int i, ret, noncont = 0;
+	unsigned int blk, prev_blk;
+
+	for (i = 0; i < nblocks; i++) {
+		blk = i;
+		if ((ret = ioctl(fd, FIBMAP, &blk)) < 0)
+			goto out;
+
+		if (i == 0) {
+			prev_blk = blk;
+			continue;
+		}
+		if (blk != prev_blk + 1) {
+			noncont++;
+		}
+		prev_blk = blk;
+	}
+out:
+	return noncont;
+}
+
+static int add_file(const char *path, const struct stat *sb, int dummy)
+{
+	int fd, ret;
+	struct __file *f;
+
+	f = xcalloc(1, sizeof(*f));
+	INIT_LIST_HEAD(&f->list);
+
+	/*
+	 * FIXME: we shouldn't open the file twice as ftw(3) already does it!
+	 */
+	if ((fd = open(path, O_RDONLY)) < 0)
+		goto err1;
+	if ((ret = ioctl(fd, FIGETBSZ, &f->blksz)) < 0)
+		goto err0;
+
+	f->size = sb->st_size;
+	f->nblks = (sb->st_size + f->blksz - 1) / f->blksz;
+	if (!f->nblks)
+		/* the file is empty (0 blocks), ignore. */
+		goto err0;
+
+	f->path = xstrdup(path);
+	if (flags & FL_MAP) {
+		f->map = xcalloc(1, sizeof(*f->map));
+		INIT_LIST_HEAD(&f->map->l);
+		get_fibmap(fd, f->nblks, &f->noncont, &f->map->l);
+	}
+	else
+		/*
+		 * We don't want the actual map, just the amount of
+		 * non-contiguous blocks in the file.
+		 */
+		f->noncont = get_noncont(fd, f->nblks);
+
+	/* we get this here because we sort this element by default */
+	f->fragpercent = (double) f->noncont/f->nblks * 100;
+	list_add_tail(&f->list, &files);
+
+	close(fd);
+	return 0;
+err0:
+	close(fd);
+err1:
+	free(f);
+	/* we cannot return a nonzero value otherwise the treewalk will stop */
+	return 0;
+}
+
+static void del_file(struct __file *f)
+{
+	if (f) {
+		list_del(&f->list);
+		free(f->path);
+		free(f);
+	}
+}
+
+static void del_files(struct list_head *files)
+{
+	struct list_head *p, *pnext;
+
+	list_for_each_safe(p, pnext, files) {
+		struct __file *f = list_entry(p, struct __file, list);
+		del_file(f);
+	}
+}
+
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	size_t i;
+
+	fputs(USAGE_HEADER, out);
+
+	fprintf(out, _(" %s [options] file\n"), program_invocation_short_name);
+	fputs(_("\nOptions:\n"), out);
+	fputs(_(" -s, --stat  <dir>     get fragmentation statistics for a given directory\n"
+		" -m, --map   <file>    show block map for a given file\n"
+		" -f, --fragonly        work only with fragemented files\n"
+		" -o, --output <list>    define which output columns to use\n"
+		"     --noheadings       don't print headings\n"
+		"     --raw              use the raw output format\n"
+		"     --verbose          verbose output\n"
+		" -h, --help             display this help and exit\n"
+		" -V, --version          output version information and exit\n"), out);
+
+	fputs(_("\nAvailable columns (for --output):\n"), out);
+
+	for (i = 0; i < NCOLS; i++)
+		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
+
+	fprintf(out, USAGE_MAN_TAIL("fibmap(8)"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static int show_files(struct list_head *files, int tt_flags)
+{
+	int i;
+	struct stat sb;
+	struct tt *tt;
+	struct list_head *p, *pnext;
+
+	tt = tt_new_table(tt_flags);
+	if (!tt) {
+		warn(_("failed to initialize output table"));
+		return -1;
+	}
+
+	for (i = 0; i < ncolumns; i++) {
+		struct colinfo *col = get_column_info(i);
+
+		if (!tt_define_column(tt, col->name, col->whint, col->flags)) {
+			warnx(_("failed to initialize output column"));
+			goto done;
+		}
+	}
+
+	setup_pager();
+
+	list_for_each_safe(p, pnext, files) {
+		struct __file *f = list_entry(p, struct __file, list);
+
+		if (flags & FL_FRAGONLY && !f->noncont)
+			continue; /* only show fragmented files */
+		add_tt_line(tt, f);
+	}
+
+	tt_print_table(tt);
+done:
+	tt_free_table(tt);
+	return 0;
+}
+
+/* stolen from e2fsprogs */
+static int int_log10(unsigned long long arg)
+{
+	int l = 0;
+
+	arg = arg / 10;
+	while (arg) {
+		l++;
+		arg = arg / 10;
+	}
+	return l;
+}
+
+static int show_map(struct list_head *files)
+{
+	struct list_head *p, *pnext;
+	struct list_head *p2, *pnext2;
+	int blk_width = 14;
+
+	setup_pager();
+
+	list_for_each_safe(p, pnext, files) {
+		struct __file *f = list_entry(p, struct __file, list);
+		if (flags & FL_FRAGONLY && !f->noncont)
+			continue; /* only show fragmented files */
+
+		printf("Block map for '%s' (%s block-size)\n", f->path,
+		       size_to_human_string(SIZE_SUFFIX_1LETTER, f->blksz));
+
+		blk_width = int_log10(f->nblks);
+		if (blk_width < 8)
+			blk_width = 8;
+
+		printf(" %*s length\n", blk_width, "block");
+
+		list_for_each(p2, &f->map->l) {
+			struct fmap *m = list_entry(p2, struct fmap, l);
+			printf(" %*lu %d\n", blk_width, m->blknum, m->len);
+		}
+		printf("\n");
+	}
+
+	return 0;
+}
+
+/*
+ * Display fs/dir statistics, doesn't make sense for single files.
+ */
+static int show_stats(struct list_head *files)
+{
+	struct list_head *p, *pnext;
+	struct __file *fraged = NULL;
+	int nfiles = 0, nblks = 0, noncont = 0, fragfiles = 0;
+	double time_diff;
+
+	list_for_each_safe(p, pnext, files) {
+		struct __file *f = list_entry(p, struct __file, list);
+
+		nfiles++;
+		nblks += f->nblks;
+		noncont += f->noncont;
+
+		/*
+		 * Because the list is ordered by fragmentation
+		 * percentage (descending), we just get the need
+		 * to get the first element.
+		 */
+		if (!fraged)
+			fraged = f;
+		if (f->noncont)
+			fragfiles++;
+	}
+	gettimeofday(&end_time, NULL);
+	time_diff = (end_time.tv_sec  - start_time.tv_sec)
+		+ (end_time.tv_usec - start_time.tv_usec) / 1e6;
+
+	printf("\n  Fragmentation statistics - runtime in %.4f seconds\n",
+		time_diff);
+	printf("\tTotal files checked:            %d\n", nfiles);
+	printf("\tTotal files with fragmentation: %d\n", fragfiles);
+	if (fragfiles)
+		printf("\tFile/directory fragementation:  %.2f%%\n",
+		       (double) noncont/nblks * 100);
+	if (fraged->fragpercent)
+		printf("\tMost fragemented file %s with %.2f%%\n", fraged->path,
+		       fraged->fragpercent);
+	printf("\n");
+
+	return 0;
+}
+
+static int cmp(struct list_head *a, struct list_head *b)
+{
+	struct __file *f1, *f2;
+
+	f1 = container_of(a, struct __file, list);
+	f2 = container_of(b, struct __file, list);
+
+	return f1->fragpercent < f2->fragpercent;
+}
+
+static void __attribute__((__noreturn__))
+errx_mutually_exclusive(const char *opts)
+{
+	errx(EXIT_FAILURE, _("the options %s are mutually exclusive"), opts);
+}
+
+int main(int argc, char **argv)
+{
+	int i, opt, tt_flags = 0;
+
+	static const struct option longopts[] = {
+		{ "map",        required_argument, NULL, 'm' },
+		{ "stats",      required_argument, NULL, 's' },
+		{ "fragonly",   required_argument, NULL, 'f' },
+		{ "version",    no_argument,       NULL, 'V' },
+		{ "help",       no_argument,       NULL, 'h' },
+		{ "noheadings", no_argument,       NULL, 'n' },
+		{ "raw",        no_argument,       NULL, 'r' },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	if (geteuid())
+		/*
+		 * the fibmap ioctl is root-only
+		 * https://lkml.org/lkml/2007/11/22/77
+		 */
+		errx(EXIT_FAILURE, _("must run as root (superuser) to run this program"));
+
+	while((opt = getopt_long(argc, argv, "f::m::s::o:nrVh", longopts, NULL)) != -1) {
+		switch(opt) {
+		case 's':
+			flags |= FL_STATS;
+			gettimeofday(&start_time, NULL);
+			break;
+		case 'm':
+			flags |= FL_MAP;
+			break;
+		case 'f':
+			flags |= FL_FRAGONLY;
+			break;
+		case 'h':
+			usage(stdout);
+			break;
+		case 'o':
+			ncolumns = string_to_idarray(optarg, columns,
+							ARRAY_SIZE(columns),
+							column_name_to_id);
+			if (ncolumns < 0)
+				return EXIT_FAILURE;
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'n':
+			tt_flags |= TT_FL_NOHEADINGS;
+			break;
+		case 'r':
+			tt_flags |= TT_FL_RAW;
+			break;
+		default:
+			usage(stderr);
+			break;
+		}
+	}
+
+	if (argc == 1)
+		usage(stderr);
+
+	if (!ncolumns) {
+		/* default columns */
+		columns[ncolumns++] = COL_PATH;
+		columns[ncolumns++] = COL_SIZE;
+		columns[ncolumns++] = COL_NBLKS;
+		columns[ncolumns++] = COL_FRAGED;
+	}
+
+	INIT_LIST_HEAD(&files);
+
+       	for (i = 1; i < argc; i++) {
+		if (argv[i][0] == '-')
+			continue;
+		if (ftw(argv[i], add_file, 20) < 0) {
+			warn(_("cannot walk %s"), argv[i]);
+			continue;
+		}
+	}
+
+	if (list_empty(&files))
+		usage(stderr);
+
+	if (flags & FL_MAP)
+		show_map(&files);
+	else {
+		list_sort(&files, cmp);
+		if (flags & FL_STATS)
+			show_stats(&files);
+		else
+			show_files(&files, tt_flags);
+	}
+
+	del_files(&files);
+
+	return EXIT_SUCCESS;
+}
-- 
1.7.4.1
