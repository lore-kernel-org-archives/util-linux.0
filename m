Return-Path: dave@gnu.org
Subject: [PATCH v2 2/4] lslocks: new command
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Feb 2012 16:33:01 +0100
Message-ID: <1330356781.2540.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The new lslocks(8) program is meant to replace the deprecated lslk(8). It is designed for simplicity
and removes unnecessary Unix legacy outputs and options:

- Don't output inode number, whence and maj:min device numbers.
- Don't provide nonblocking syscall options stat(2) and readlink(2)
- Remove lslk's alternate default kernel name list file path (-k)

The option to use nonblocking calls was previously intended for NFS partitions; however this should
be transparent to utility programs considering that timeouts can occur generically (fuse - sshfs, NFS, netdevs, etc).

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/lslocks.c |  545 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 545 insertions(+), 0 deletions(-)
 create mode 100644 misc-utils/lslocks.c

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
new file mode 100644
index 0000000..d343b51
--- /dev/null
+++ b/misc-utils/lslocks.c
@@ -0,0 +1,545 @@
+/*
+ * lslocks(8) - list local system locks
+ *
+ * Copyright (C) 2012 Davidlohr Bueso <dave@gnu.org>
+ *
+ * Very generally based on lslk(8) by Victor A. Abell <abe@purdue.edu>
+ * Since it stopped being maingained over a decade ago, this
+ * program should be considered its replacement.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "pathnames.h"
+#include "canonicalize.h"
+#include "nls.h"
+#include "tt.h"
+#include "xalloc.h"
+#include "at.h"
+#include "strutils.h"
+#include "c.h"
+
+/* column IDs */
+enum {
+	COL_SRC = 0,
+	COL_PID,
+	COL_SIZE,
+	COL_ACCESS,
+	COL_M,
+	COL_START,
+	COL_END,
+	COL_PATH,
+};
+
+/* column names */
+struct colinfo {
+	const char *name; /* header */
+	double	   whint; /* width hint (N < 1 is in percent of termwidth) */
+	int	   flags; /* TT_FL_* */
+	const char *help;
+};
+
+/* columns descriptions */
+struct colinfo infos[] = {
+	[COL_SRC]     = { "COMMAND", 0.30, TT_FL_TRUNC, N_("command of the process holding the lock") },
+	[COL_PID]     = { "PID",     0.30, TT_FL_TRUNC, N_("PID of the process holding the lock") },
+	[COL_SIZE]    = { "SIZE",    0.30, TT_FL_TRUNC, N_("size of the lock") },
+	[COL_ACCESS]  = { "ACCESS",  0.30, TT_FL_TRUNC, N_("lock access type") },
+	[COL_M]       = { "M",       0.30, TT_FL_TRUNC, N_("mandatory state of the lock: 0 (none), 1 (set)")},
+	[COL_START]   = { "START",   0.30, TT_FL_TRUNC, N_("relative byte offset of the lock")},
+	[COL_END]     = { "END",     0.30, TT_FL_TRUNC, N_("ending offset of the lock")},
+	[COL_PATH]    = { "PATH",    0.30, TT_FL_TRUNC, N_("path of the locked file")},
+};
+#define NCOLS ARRAY_SIZE(infos)
+static int columns[NCOLS], ncolumns;
+static pid_t pid = 0;
+/* array with IDs of enabled columns */
+static int columns[NCOLS], ncolumns;
+
+struct lock {
+	struct list_head locks;
+
+	char *cmdname;
+	pid_t pid;
+	char *path;
+	char *type;
+	off_t start;
+	off_t end;
+	int mandatory;
+	char *size;
+};
+
+/*
+ * Return a PID's command name
+ */
+static char *get_cmdname(pid_t pid)
+{
+	FILE *fp;
+	char path[PATH_MAX];
+
+	sprintf(path, "/proc/%d/comm", pid);
+	if (!(fp = fopen(path, "r")))
+		return NULL;
+
+	/* just need the first line */
+	if (!fgets(path, sizeof(path), fp))
+		goto out;
+out:
+	fclose(fp);
+	path[strlen(path) - 1] = '\0';
+	return xstrdup(path);
+}
+
+/*
+ * Associate the device's mountpoint for a filename
+ */
+static char *get_fallback_filename(dev_t dev)
+{
+	char buf[PATH_MAX], root[PATH_MAX], target[PATH_MAX], *ret = NULL;
+	int maj, min, id, parent;
+	struct stat sb;
+	FILE *fp;
+
+	if (!(fp = fopen(_PATH_PROC_MOUNTINFO, "r")))
+		return NULL;
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		sscanf(buf, "%u %u %u:%u %s %s",
+			    &id, &parent, &maj, &min, root, target);
+
+		if (dev == makedev(maj, min)) {
+			ret = xstrdup(target);
+			goto out;
+
+		}
+	}
+out:
+	fclose(fp);
+	return ret;
+}
+
+/*
+ * Return the absolute path of a file from
+ * a given inode number (and its size)
+ */
+static char *get_filename_sz(long inode, pid_t pid, size_t *size)
+{
+	struct stat sb;
+	struct dirent *dp;
+	DIR *dirp;
+	size_t len;
+	int fd;
+	char path[PATH_MAX], sym[PATH_MAX], *ret = NULL;
+
+	*size = 0;
+	memset(path, 0, sizeof(path));
+	memset(sym, 0, sizeof(sym));
+
+	/*
+	 * We know the pid so we don't have to
+	 * iterate the *entire* filesystem searching
+	 * for the damn file.
+	 */
+	sprintf(path, "/proc/%d/fd/", pid);
+	if (!(dirp = opendir(path)))
+		return NULL;
+
+	if ((len = strlen(path)) >= (sizeof(path) - 2))
+		goto out;
+
+	if ((fd = dirfd(dirp)) < 0 )
+		goto out;
+
+	while ((dp = readdir(dirp))) {
+		if (!strcmp(dp->d_name, ".") ||
+		    !strcmp(dp->d_name, ".."))
+			continue;
+
+		/* care only for numerical descriptors */
+		if (!strtol(dp->d_name, (char **) NULL, 10))
+			continue;
+
+		if (!fstat_at(fd, path, dp->d_name, &sb, 0)
+		    && inode != sb.st_ino)
+			continue;
+
+		if ((len = readlink_at(fd, path, dp->d_name,
+				       sym, sizeof(path))) < 1)
+			goto out;
+
+		*size = sb.st_size;
+		sym[len] = '\0';
+
+		ret = xstrdup(sym);
+		break;
+}
+out:
+	closedir(dirp);
+	return ret;
+}
+
+/*
+ * Return the inode number from a string
+ */
+static long get_dev_inode(char *str, dev_t *dev)
+{
+	int maj = 0, min = 0;
+	long inum = 0;
+
+	sscanf(str, "%02x:%02x:%lu", &maj, &min, &inum);
+
+	*dev = (dev_t) makedev(maj, min);
+	return inum;
+}
+
+static int get_local_locks(struct list_head *locks)
+{
+	int i;
+	long inode = 0;
+	FILE *fp;
+	char buf[PATH_MAX], *szstr = NULL, *tok = NULL;
+	size_t sz;
+	struct lock *l;
+	dev_t dev = 0;
+
+	if (!(fp = fopen(_PATH_PROC_LOCKS, "r")))
+		return -1;
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		l = xcalloc(1, sizeof(*l));
+		INIT_LIST_HEAD(&l->locks);
+
+		for (i = 1, tok = strtok(buf, " ");
+		     tok = strtok(NULL, " "); i++) {
+
+			/*
+			 * /proc/locks as *exactly* 8 "blocks" of text
+			 * separated by ' ' - check <kernel>/fs/locks.c
+			 */
+			switch (i) {
+			case 1: /* not intereted! */
+				break;
+
+			case 2: /* is this a mandatory lock? other values are advisory or noinode */
+				l->mandatory = *tok == 'M' ? TRUE : FALSE;
+				break;
+			case 3: /* lock type */
+				l->type = xstrdup(tok);
+				break;
+
+			case 4: /* PID */
+				/*
+				 * If user passed a pid we filter it later when adding
+				 * to the list, no need to worry now.
+				 */
+				l->pid = strtol_or_err(tok, _("failed to parse pid"));
+				l->cmdname = get_cmdname(l->pid);
+				break;
+
+			case 5: /* device major:minor and inode number */
+				inode = get_dev_inode(tok, &dev);
+				break;
+
+			case 6: /* start */
+				l->start = !strcmp(tok, "EOF") ? 0 :
+					   strtol_or_err(tok, _("failed to parse start"));
+				break;
+
+			case 7: /* end */
+				/* replace '\n' character */
+				tok[strlen(tok)-1] = '\0';
+				l->end = !strcmp(tok, "EOF") ? 0 :
+					 strtol_or_err(tok, _("failed to parse end"));
+				break;
+			default:
+				break;
+			}
+
+			l->path = get_filename_sz(inode, l->pid, &sz);
+			/* probably no permission to peek into l->pid's path */
+			if (!l->path)
+				l->path = get_fallback_filename(dev);
+
+			/* avoid leaking */
+			szstr = size_to_human_string(SIZE_SUFFIX_1LETTER, sz);
+			l->size = xstrdup(szstr);
+			free(szstr);
+		}
+
+		if (pid && pid != l->pid) {
+			/*
+			 * It's easier to just parse the file then decide if
+			 * it should be added to the list - otherwise just
+			 * get rid of stored data
+			 */
+			free(l->path);
+			free(l->size);
+			free(l->type);
+			free(l->cmdname);
+			free(l);
+
+			continue;
+		}
+
+		list_add(&l->locks, locks);
+	}
+
+	fclose(fp);
+	return 0;
+}
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
+
+static inline struct colinfo *get_column_info(unsigned num)
+{
+	return &infos[ get_column_id(num) ];
+}
+
+static void rem_lock(struct lock *lock)
+{
+	if (!lock)
+		return;
+
+	free(lock->path);
+	free(lock->size);
+	free(lock->type);
+	free(lock->cmdname);
+	list_del(&lock->locks);
+	free(lock);
+}
+
+static void add_tt_line(struct tt *tt, struct lock *l)
+{
+	int i;
+	struct tt_line *line;
+	/*
+	 * Whenever cmdname or filename is NULL it is most
+	 * likely  because there's no read permissions
+	 * for the specified process.
+	 */
+	const char *notfnd = "";
+
+	assert(l);
+	assert(tt);
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
+		case COL_SRC:
+			rc = asprintf(&str, "%s", l->cmdname ? l->cmdname : notfnd);
+			break;
+		case COL_PID:
+			rc = asprintf(&str, "%d", l->pid);
+			break;
+		case COL_SIZE:
+			rc = asprintf(&str, "%s", l->size);
+			break;
+		case COL_ACCESS:
+			rc = asprintf(&str, "%s", l->type);
+			break;
+		case COL_M:
+			rc = asprintf(&str, "%d", l->mandatory);
+			break;
+		case COL_START:
+			rc = asprintf(&str, "%ld", l->start);
+			break;
+		case COL_END:
+			rc = asprintf(&str, "%ld", l->end);
+			break;
+		case COL_PATH:
+			rc = asprintf(&str, "%s", l->path ? l->path : notfnd);
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
+static int show_locks(struct list_head *locks, int tt_flags)
+{
+	int i, rc = 0;
+	struct list_head *p, *pnext;
+	struct tt *tt;
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
+			rc = -1;
+			goto done;
+		}
+	}
+
+	list_for_each_safe(p, pnext, locks) {
+		struct lock *lock = list_entry(p, struct lock, locks);
+		add_tt_line(tt, lock);
+		rem_lock(lock);
+	}
+
+	tt_print_table(tt);
+done:
+	tt_free_table(tt);
+	return rc;
+}
+
+
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	size_t i;
+
+	fputs(USAGE_HEADER, out);
+
+	fprintf(out,
+		_(" %s [options]\n"), program_invocation_short_name);
+
+	fputs(_("\nGeneral Options:\n"), out);
+	fputs(_(" -p, --pid <pid>        process id\n"
+		" -o, --output <list>    define which output columns to use\n"
+		" -n, --noheadings       don't print headings\n"
+		" -r  --raw              use the raw output format\n"
+		" -h, --help             display this help and exit\n"
+		" -V, --version          output version information and exit\n"), out);
+
+	fputs(_("\nAvailable columns (for --output):\n"), out);
+
+	for (i = 0; i < NCOLS; i++)
+		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
+
+	fprintf(out, USAGE_MAN_TAIL("lslocks(8)"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char *argv[])
+{
+	int c, tt_flags = 0, rc = 0;
+	struct list_head locks;
+	static const struct option long_opts[] = {
+		{ "pid",	required_argument, NULL, 'p' },
+		{ "help",	no_argument,       NULL, 'h' },
+		{ "version",    no_argument,       NULL, 'V' },
+		{ "noheadings", no_argument,       NULL, 'n' },
+		{ "raw",        no_argument,       NULL, 'r' },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	while ((c = getopt_long(argc, argv,
+				"p:o:hV", long_opts, NULL)) != -1) {
+
+		switch(c) {
+		case 'p':
+			pid = strtol_or_err(optarg, _("cannot parse PID"));
+			break;
+		case 'o':
+			ncolumns = string_to_idarray(optarg,
+						     columns, ARRAY_SIZE(columns),
+						     column_name_to_id);
+			if (ncolumns < 0)
+				return EXIT_FAILURE;
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		case 'n':
+			tt_flags |= TT_FL_NOHEADINGS;
+			break;
+		case 'r':
+			tt_flags |= TT_FL_RAW;
+			break;
+		case '?':
+		default:
+			usage(stderr);
+		}
+	}
+
+	INIT_LIST_HEAD(&locks);
+
+	if (!ncolumns) {
+		/* default columns */
+		columns[ncolumns++] = COL_SRC;
+		columns[ncolumns++] = COL_PID;
+		columns[ncolumns++] = COL_SIZE;
+		columns[ncolumns++] = COL_ACCESS;
+		columns[ncolumns++] = COL_M;
+		columns[ncolumns++] = COL_START;
+		columns[ncolumns++] = COL_END;
+		columns[ncolumns++] = COL_PATH;
+	}
+
+	rc = get_local_locks(&locks);
+
+	if (!rc && !list_empty(&locks))
+		rc = show_locks(&locks, tt_flags);
+
+	return rc;
+}
-- 
1.7.4.1
