Return-Path: dave@gnu.org
Date: Mon, 17 Oct 2011 19:23:09 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 2/3] prlimit: new program
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318893789.5289.10.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This program uses the prlimit() system call to get and/or set resource limits for a given process.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |  454 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 454 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/prlimit.c

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
new file mode 100644
index 0000000..33b47a4
--- /dev/null
+++ b/sys-utils/prlimit.c
@@ -0,0 +1,454 @@
+/*
+ *  prlimit - get/set process resource limits.
+ *
+ *  Copyright (C) 2011 Davidlohr Bueso <dave@gnu.org>
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
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <assert.h>
+#include <unistd.h>
+#include <sys/resource.h>
+
+#include "c.h"
+#include "nls.h"
+#include "tt.h"
+#include "xalloc.h"
+#include "strutils.h"
+
+struct prlimit {
+	char *name;
+	char *help;
+	int modify;          /* are we changing the limit? */
+	int resource;        /* RLIMIT_* id */
+	struct rlimit rlim;  /* soft,hard limits */
+} default_lims[] = { /* when no --{resource_name} is passed */
+	{"AS", "address space limit", 0, RLIMIT_AS, {0, 0}},
+	{"CORE", "max core file size", 0, RLIMIT_CORE, {0, 0}},
+	{"CPU", "CPU time in secs", 0, RLIMIT_CPU, {0, 0}},
+	{"DATA", "max data size", 0, RLIMIT_DATA, {0, 0}},
+	{"FSIZE", "max file size", 0, RLIMIT_FSIZE, {0, 0}},
+	{"LOCKS", "max amount of file locks held", 0, RLIMIT_LOCKS, {0, 0}},
+	{"MEMLOCK", "max locked-in-memory address space", 0, RLIMIT_MEMLOCK, {0, 0}},
+	{"MSGQUEUE", "max bytes in POSIX mqueues", 0, RLIMIT_MSGQUEUE, {0, 0}},
+	{"NICE", "max nice prio allowed to raise", 0, RLIMIT_NICE, {0, 0}},
+	{"NOFILE", "max amount of open files", 0, RLIMIT_NOFILE, {0, 0}},
+	{"NPROC", "max number of processes", 0, RLIMIT_NPROC, {0, 0}},
+	{"RSS", "max resident set size", 0, RLIMIT_RSS, {0, 0}},
+	{"RTPRIO", "max real-time priority", 0, RLIMIT_RTPRIO, {0, 0}},
+	{"RTTIME", "timeout for real-time tasks", 0, RLIMIT_RTTIME, {0, 0}},
+	{"SIGPENDING", "max amount of pending signals", 0, RLIMIT_SIGPENDING, {0, 0}},
+	{"STACK", "max stack size", 0, RLIMIT_STACK, {0, 0}}
+};
+
+#define MAX_RESOURCES ARRAY_SIZE(default_lims)
+
+/* to reuse data, maintain the same order used in default_lims[] */
+enum {
+	AS,
+	CORE,
+	CPU,
+	DATA,
+	FSIZE,
+	LOCKS,
+	MEMLOCK,
+	MSGQUEUE,
+	NICE,
+	NOFILE,
+	NPROC,
+	RSS,
+	RTPRIO,
+	RTTIME,
+	SIGPENDING,
+	STACK
+};
+
+enum {
+	COL_HELP,
+	COL_RES,
+	COL_SOFT,
+	COL_HARD,
+	__NCOLUMNS
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
+struct colinfo infos[__NCOLUMNS] = {
+	[COL_RES]     = { "RESOURCE",    0.25, TT_FL_RIGHT, N_("resource name") },
+	[COL_HELP]    = { "DESCRIPTION", 0.1,  TT_FL_TRUNC, N_("resource description")},
+	[COL_SOFT]    = { "SOFT",        0.1,  TT_FL_TRUNC, N_("soft limit")},
+	[COL_HARD]    = { "HARD",        1,    TT_FL_RIGHT, N_("hard limit (ceiling)")},
+};
+
+/* array with IDs of enabled columns */
+static int columns[__NCOLUMNS], ncolumns;
+
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	size_t i;
+
+	fputs(_("\nUsage:\n"), out);
+	fprintf(out,
+		_(" %s [options]\n"), program_invocation_short_name);
+
+	fputs(_("\nGeneral Options:\n"), out);
+	fputs(_(" -p, --pid <pid>        process id\n"
+		" -o, --output <type>    define which output columns to use\n"
+		" -h, --help             display this help and exit\n"
+		" -V, --version          output version information and exit\n"), out);
+
+	fputs(_("\nResources Options:\n"), out);
+	fputs(_(" -a, --as               address space limit\n"
+		" -c, --core             max core file size\n"
+		" -C, --cpu              CPU time in secs\n"
+		" -d, --data             max data size\n"
+		" -f, --fsize            max file size\n"
+		" -l, --locks            max amount of file locks held\n"
+		" -m, --memlock          max locked-in-memory address space\n"
+		" -M, --msgqueue         max bytes in POSIX mqueues\n"
+		" -n, --nice             max nice priority allowed to raise\n"
+		" -N, --nofile           max amount of open files\n"
+		" -P, --nproc            max number of processes\n"
+		" -r, --rss              max resident set size\n"
+		" -R, --rtprio           max real-time priority\n"
+		" -t, --rttime           timeout for real-time teasks\n"
+		" -s, --sigpending       max amount of pending signals\n"
+		" -S, --stack            max stack size\n"), out);
+
+	fputs(_("\nAvailable columns (for --output):\n"), out);
+
+	for (i = 0; i < __NCOLUMNS; i++)
+		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
+
+
+	fprintf(out, _("\nFor more information see prlimit(1).\n\n"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static inline int get_column_id(int num)
+{
+	assert(ARRAY_SIZE(columns) == __NCOLUMNS);
+	assert(num < ncolumns);
+	assert(columns[num] < __NCOLUMNS);
+
+	return columns[num];
+}
+
+static inline struct colinfo *get_column_info(int num)
+{
+	return &infos[ get_column_id(num) ];
+}
+
+static void add_tt_line(struct tt *tt, struct prlimit l)
+{
+	int i;
+	struct tt_line *line;
+
+	assert(tt);
+	assert(&l);
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
+		case COL_RES:
+			rc = asprintf(&str, "%s", l.name);
+			break;
+		case COL_HELP:
+			rc = asprintf(&str, "%s", l.help);
+			break;
+		case COL_SOFT:
+			rc = l.rlim.rlim_cur == -1 ? asprintf(&str, "%s", "unlimited") :
+						     asprintf(&str, "%lld", l.rlim.rlim_cur);
+			break;
+		case COL_HARD:
+			rc = l.rlim.rlim_max == -1 ? asprintf(&str, "%s", "unlimited") :
+						     asprintf(&str, "%lld", l.rlim.rlim_max);
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
+static int column_name_to_id(const char *name, size_t namesz)
+{
+	int i;
+
+	assert(name);
+
+	for (i = 0; i < __NCOLUMNS; i++) {
+		const char *cn = infos[i].name;
+
+		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
+			return i;
+	}
+	warnx(_("unknown column: %s"), name);
+	return -1;
+}
+
+static int show_limits(struct prlimit lims[], int tt_flags, int n)
+{
+	int i;
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
+			goto done;
+		}
+	}
+
+	for (i = 0; i < n; i++)
+		if (!lims[i].modify) /* only display old limits */
+			add_tt_line(tt, lims[i]);
+
+	tt_print_table(tt);
+done:
+	tt_free_table(tt);
+	return 0;
+}
+
+/*
+ * Obtain the soft and hard limits, from arguments in the form <soft>:<hard>
+ */
+static int parse_prlim(pid_t pid, struct rlimit *lim, int res, const char *ops, const char *errmsg)
+{
+	int soft, hard;
+
+	if (parse_range(ops, &soft, &hard, -3))
+		errx(EXIT_FAILURE, "%s", errmsg);
+
+	/*
+	 * If one of the limits is -3 (default value for not being passed), we need
+	 * to get the current limit and use it.
+	 */
+	if (soft == -3 || hard == -3) {
+		struct rlimit old;
+
+		if (prlimit(pid, res, NULL, &old) == -1)
+			errx(EXIT_FAILURE, _("failed to get old limit"));
+
+		if (soft == -3)
+			soft = old.rlim_cur;
+		else if (hard == -3)
+			hard = old.rlim_max;
+	}
+
+	if (soft > hard)
+		errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling value"));
+
+	lim->rlim_cur = (rlim_t) soft;
+	lim->rlim_max = (rlim_t) hard;
+
+	return 0;
+}
+
+static void do_prlimit(pid_t pid, struct prlimit lims[], const int n)
+{
+	int i;
+	struct rlimit *new;
+
+	for (i = 0; i < n; i++) {
+		new = lims[i].modify ? &lims[i].rlim : NULL;
+
+		if (prlimit(pid, lims[i].resource, new, &lims[i].rlim) == -1)
+			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+	}
+
+	show_limits(lims, 0, n);
+}
+
+/*
+ * Add a resource limit to the limits array
+ */
+static int add_prlimit(pid_t pid, struct prlimit lims[], const char *ops,
+		       int n, int id, const char *errmsg)
+{
+	/* setup basic data */
+	lims[n].name = default_lims[id].name;
+	lims[n].help = default_lims[id].help;
+	lims[n].resource = default_lims[id].resource;
+
+	if (ops) { /* planning on modifying a limit? */
+		lims[n].modify = 1;
+		parse_prlim(pid, &lims[n].rlim, lims[n].resource, ops, errmsg);
+	} else
+		lims[n].modify = 0;
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, n = 0;
+	pid_t pid = 0; /* calling process (default) */
+	struct prlimit lims[MAX_RESOURCES];
+	static const struct option longopts[] = {
+		{"pid", required_argument, NULL, 'p'},
+		{"output", required_argument, NULL, 'o'},
+		{"as", optional_argument, NULL, 'a'},
+		{"core", optional_argument, NULL, 'c'},
+		{"cpu", optional_argument, NULL, 'C'},
+		{"data", optional_argument, NULL, 'd'},
+		{"fsize", optional_argument, NULL, 'f'},
+		{"locks", optional_argument, NULL, 'l'},
+		{"memlock", optional_argument, NULL, 'm'},
+		{"msgqueue", optional_argument, NULL, 'M'},
+		{"nice", optional_argument, NULL, 'n'},
+		{"nofile", optional_argument, NULL, 'N'},
+		{"nproc", optional_argument, NULL, 'P'},
+		{"rss", optional_argument, NULL, 'r'},
+		{"rtprio", optional_argument, NULL, 'R'},
+		{"rttime", optional_argument, NULL, 't'},
+		{"sigpending", optional_argument, NULL, 's'},
+		{"stack", optional_argument, NULL, 'S'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	memset(lims, 0, sizeof(lims));
+
+	/*
+	 * Something is very wrong if this doesn't succeed,
+	 * assuming STACK is the last resource, of course.
+	 */
+	assert(MAX_RESOURCES == STACK + 1);
+
+	while((opt = getopt_long(argc, argv,
+				 "a::c::C::d::f::l::m::M::n::N::P::r::R::t::s::S::p:o:vVh",
+				 longopts, NULL)) != -1) {
+		switch(opt) {
+		case 'p':
+			pid = strtol_or_err(optarg, _("cannot parse PID"));
+			break;
+		case 'a':
+			add_prlimit(pid, lims, optarg, n++, AS, "failed to parse AS limit");
+			break;
+		case 'c':
+			add_prlimit(pid, lims, optarg, n++, CORE, "failed to parse CORE limit");
+			break;
+		case 'C':
+			add_prlimit(pid, lims, optarg, n++, CPU, "failed to parse CPU limit");
+			break;
+		case 'd':
+			add_prlimit(pid, lims, optarg, n++, DATA, "failed to parse DATA limit");
+			break;
+		case 'f':
+			add_prlimit(pid, lims, optarg, n++, FSIZE, "failed to parse FSIZE limit");
+			break;
+		case 'l':
+			add_prlimit(pid, lims, optarg, n++, LOCKS, "failed to parse LOCKS limit");
+			break;
+		case 'm':
+			add_prlimit(pid, lims, optarg, n++, MEMLOCK, "failed to parse MEMLOCK limit");
+			break;
+		case 'M':
+			add_prlimit(pid, lims, optarg, n++, MSGQUEUE, "failed to parse MSGQUEUE limit");
+			break;
+		case 'n':
+			add_prlimit(pid, lims, optarg, n++, NICE, "failed to parse NICE limit");
+			break;
+		case 'N':
+			add_prlimit(pid, lims, optarg, n++, NOFILE, "failed to parse NOFILE limit");
+			break;
+		case 'P':
+			add_prlimit(pid, lims, optarg, n++, NPROC, "failed to parse NPROC limit");
+			break;
+		case 'r':
+			add_prlimit(pid, lims, optarg, n++, RSS, "failed to parse RSS limit");
+			break;
+		case 'R':
+			add_prlimit(pid, lims, optarg, n++, RTPRIO, "failed to parse RTPRIO limit");
+			break;
+		case 't':
+			add_prlimit(pid, lims, optarg, n++, RTTIME, "failed to parse RTTIME limit");
+			break;
+		case 's':
+			add_prlimit(pid, lims, optarg, n++, SIGPENDING, "failed to parse SIGPENDING limit");
+			break;
+		case 'S':
+			add_prlimit(pid, lims, optarg, n++, STACK, "failed to parse STACK limit");
+			break;
+		case 'h':
+			usage(stdout);
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
+		columns[ncolumns++] = COL_RES;
+		columns[ncolumns++] = COL_HELP;
+		columns[ncolumns++] = COL_SOFT;
+		columns[ncolumns++] = COL_HARD;
+	}
+
+	n == 0 ? do_prlimit(pid, default_lims, MAX_RESOURCES) :
+		 do_prlimit(pid, lims, n);
+
+	return EXIT_SUCCESS;
+}
-- 
1.7.7
