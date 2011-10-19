Return-Path: dave@gnu.org
Date: Wed, 19 Oct 2011 16:02:35 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 2/3] prlimit: new program
In-reply-to: <20111017150804.GA9767@nb.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319054555.2170.3.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1318893789.5289.10.camel@offworld>
 <20111017150804.GA9767@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-10-17 at 17:08 +0200, Karel Zak wrote:
> On Mon, Oct 17, 2011 at 07:23:09PM -0400, Davidlohr Bueso wrote:
> > +struct prlimit {
> > +	char *name;
> > +	char *help;
> > +	int modify;          /* are we changing the limit? */
> > +	int resource;        /* RLIMIT_* id */
> > +	struct rlimit rlim;  /* soft,hard limits */
> > +} default_lims[] = { /* when no --{resource_name} is passed */
> > +	{"AS", "address space limit", 0, RLIMIT_AS, {0, 0}},
> 
>  N_("address space limit")
> 
> > +	{"CORE", "max core file size", 0, RLIMIT_CORE, {0, 0}},
> > +	{"CPU", "CPU time in secs", 0, RLIMIT_CPU, {0, 0}},
> > +	{"DATA", "max data size", 0, RLIMIT_DATA, {0, 0}},
> > +	{"FSIZE", "max file size", 0, RLIMIT_FSIZE, {0, 0}},
> > +	{"LOCKS", "max amount of file locks held", 0, RLIMIT_LOCKS, {0, 0}},
> > +	{"MEMLOCK", "max locked-in-memory address space", 0, RLIMIT_MEMLOCK, {0, 0}},
> > +	{"MSGQUEUE", "max bytes in POSIX mqueues", 0, RLIMIT_MSGQUEUE, {0, 0}},
> > +	{"NICE", "max nice prio allowed to raise", 0, RLIMIT_NICE, {0, 0}},
> > +	{"NOFILE", "max amount of open files", 0, RLIMIT_NOFILE, {0, 0}},
> > +	{"NPROC", "max number of processes", 0, RLIMIT_NPROC, {0, 0}},
> > +	{"RSS", "max resident set size", 0, RLIMIT_RSS, {0, 0}},
> > +	{"RTPRIO", "max real-time priority", 0, RLIMIT_RTPRIO, {0, 0}},
> > +	{"RTTIME", "timeout for real-time tasks", 0, RLIMIT_RTTIME, {0, 0}},
> > +	{"SIGPENDING", "max amount of pending signals", 0, RLIMIT_SIGPENDING, {0, 0}},
> > +	{"STACK", "max stack size", 0, RLIMIT_STACK, {0, 0}}
> > +};
> > +
> > +#define MAX_RESOURCES ARRAY_SIZE(default_lims)
> > +
> > +/* to reuse data, maintain the same order used in default_lims[] */
> 
>  Please, define this enum before default_lims[] and use
> 
>    { 
>      [enum] = { },
>    }
> 
>  convention for the default_lims array. Anyway, see my note about
>  default_lims below.
> 
> > +enum {
> > +	AS,
> > +	CORE,
> > +	CPU,
> > +	DATA,
> > +	FSIZE,
> > +	LOCKS,
> > +	MEMLOCK,
> > +	MSGQUEUE,
> > +	NICE,
> > +	NOFILE,
> > +	NPROC,
> > +	RSS,
> > +	RTPRIO,
> > +	RTTIME,
> > +	SIGPENDING,
> > +	STACK
> > +};
> > +
> > +enum {
> > +	COL_HELP,
> > +	COL_RES,
> > +	COL_SOFT,
> > +	COL_HARD,
> > +	__NCOLUMNS
> > +};
> 
>  It would be better to use ARRAY_SIZE everywhere than __NCOLUMNS (yes,
>  patch for lsblk is wanted :-)

And partx too.

> > +/* column names */
> > +struct colinfo {
> > +	const char	*name;	/* header */
> > +	double		whint;	/* width hint (N < 1 is in percent of termwidth) */
> > +	int		flags;	/* TT_FL_* */
> > +	const char      *help;
> > +};
> > +
> > +/* columns descriptions */
> > +struct colinfo infos[__NCOLUMNS] = {
> 
>   struct colinfo infos[] =
> 
> is enough.
> 
> > +	[COL_RES]     = { "RESOURCE",    0.25, TT_FL_RIGHT, N_("resource name") },
> > +	[COL_HELP]    = { "DESCRIPTION", 0.1,  TT_FL_TRUNC, N_("resource description")},
> > +	[COL_SOFT]    = { "SOFT",        0.1,  TT_FL_TRUNC, N_("soft limit")},
> 
>  Please, always use TT_FL_RIGHT for numbers.
> 

Yes, much nicer output.

> > +	[COL_HARD]    = { "HARD",        1,    TT_FL_RIGHT, N_("hard limit (ceiling)")},
> > +};
> > +
> > +/* array with IDs of enabled columns */
> > +static int columns[__NCOLUMNS], ncolumns;
> > +
> > +static void __attribute__ ((__noreturn__)) usage(FILE * out)
> > +{
> > +	size_t i;
> > +
> > +	fputs(_("\nUsage:\n"), out);
> 
>  fputs(HELP_USAGE, out);  See c.h for HELP_* macros.
> 
> > +	fprintf(out,
> > +		_(" %s [options]\n"), program_invocation_short_name);
> > +
> > +	fputs(_("\nGeneral Options:\n"), out);
> > +	fputs(_(" -p, --pid <pid>        process id\n"
> > +		" -o, --output <type>    define which output columns to use\n"
> > +		" -h, --help             display this help and exit\n"
> > +		" -V, --version          output version information and exit\n"), out);
> > +
> > +	fputs(_("\nResources Options:\n"), out);
> > +	fputs(_(" -a, --as               address space limit\n"
> > +		" -c, --core             max core file size\n"
> > +		" -C, --cpu              CPU time in secs\n"
> > +		" -d, --data             max data size\n"
> > +		" -f, --fsize            max file size\n"
> > +		" -l, --locks            max amount of file locks held\n"
> > +		" -m, --memlock          max locked-in-memory address space\n"
> > +		" -M, --msgqueue         max bytes in POSIX mqueues\n"
> > +		" -n, --nice             max nice priority allowed to raise\n"
> > +		" -N, --nofile           max amount of open files\n"
> > +		" -P, --nproc            max number of processes\n"
> > +		" -r, --rss              max resident set size\n"
> > +		" -R, --rtprio           max real-time priority\n"
> > +		" -t, --rttime           timeout for real-time teasks\n"
> > +		" -s, --sigpending       max amount of pending signals\n"
> > +		" -S, --stack            max stack size\n"), out);
> > +
> > +	fputs(_("\nAvailable columns (for --output):\n"), out);
> > +
> > +	for (i = 0; i < __NCOLUMNS; i++)
> > +		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
> > +
> > +
> > +	fprintf(out, _("\nFor more information see prlimit(1).\n\n"));
> 
>   fprintf(out, USAGE_MAN_TAIL("prlimit(1)");
> 
>  [...]
> 
> > +/*
> > + * Obtain the soft and hard limits, from arguments in the form <soft>:<hard>
> > + */
> > +static int parse_prlim(pid_t pid, struct rlimit *lim, int res, const char *ops, const char *errmsg)
> > +{
> > +	int soft, hard;
> > +
> > +	if (parse_range(ops, &soft, &hard, -3))
> 
> please, don't use magic constants, use:
> 
>     if (parse_range(ops, &soft, &hard, PRLIMIT_UNKNOWN))
> 
> or so...
> 
> > +		errx(EXIT_FAILURE, "%s", errmsg);
> 
> It would be nice to support RLIM_INFINITY, something like:
> 
>    --core=unlimited or --core=10000:unlimited
> 
> btw it would be better to use RLIM_INFINITY macro rather than -1 in the code.
> 
> > +static void do_prlimit(pid_t pid, struct prlimit lims[], const int n)
> > +{
> > +	int i;
> > +	struct rlimit *new;
> 
> int nshows = 0;
> 
> > +	for (i = 0; i < n; i++) {
> > +		new = lims[i].modify ? &lims[i].rlim : NULL;
> 
>         struct rlimit *new = NULL;
> 
>         if (lims[i].modify)
>             new = &lims[i].rlim;
>         else
>             nshows++;
> 
> > +		if (prlimit(pid, lims[i].resource, new, &lims[i].rlim) == -1)
> > +			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
> > +	}
> > +
> > +	show_limits(lims, 0, n);
> 
>  if (nshows)
>     show_limits(lims, 0, n);
> 
>  .. so don't waste time with show_limits() for commands like
> 
>     prlimit --pid $$ --core=10000
> 
>  where nothing is expected on stdout ;-)
> 
> > +}
> > +
> > +/*
> > + * Add a resource limit to the limits array
> > + */
> > +static int add_prlimit(pid_t pid, struct prlimit lims[], const char *ops,
> > +		       int n, int id, const char *errmsg)
> > +{
> > +	/* setup basic data */
> > +	lims[n].name = default_lims[id].name;
> > +	lims[n].help = default_lims[id].help;
> > +	lims[n].resource = default_lims[id].resource;
> 
>  Hmmm... this is poor design, the data structs are core of the well
>  designed programs.
>  
>  What about:
> 
>  struct prlimit_desc {
>     const char *name,
>                *help;
>     int        resource;
>  };
> 
>  struct prlimit {
>    struct prlimit_desc *desc;
> 
>    int           modify;
>    struct rlimit rlim;
>  };
> 
> I think it would be better to split resources description and the
> limits.
> 
> > +	if (ops) { /* planning on modifying a limit? */
> > +		lims[n].modify = 1;
> > +		parse_prlim(pid, &lims[n].rlim, lims[n].resource, ops, errmsg);
> > +	} else
> > +		lims[n].modify = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, n = 0;
> > +	pid_t pid = 0; /* calling process (default) */
> > +	struct prlimit lims[MAX_RESOURCES];
> > +	static const struct option longopts[] = {
> > +		{"pid", required_argument, NULL, 'p'},
> > +		{"output", required_argument, NULL, 'o'},
> > +		{"as", optional_argument, NULL, 'a'},
> > +		{"core", optional_argument, NULL, 'c'},
> > +		{"cpu", optional_argument, NULL, 'C'},
> > +		{"data", optional_argument, NULL, 'd'},
> > +		{"fsize", optional_argument, NULL, 'f'},
> > +		{"locks", optional_argument, NULL, 'l'},
> > +		{"memlock", optional_argument, NULL, 'm'},
> > +		{"msgqueue", optional_argument, NULL, 'M'},
> > +		{"nice", optional_argument, NULL, 'n'},
> > +		{"nofile", optional_argument, NULL, 'N'},
> > +		{"nproc", optional_argument, NULL, 'P'},
> > +		{"rss", optional_argument, NULL, 'r'},
> > +		{"rtprio", optional_argument, NULL, 'R'},
> > +		{"rttime", optional_argument, NULL, 't'},
> > +		{"sigpending", optional_argument, NULL, 's'},
> > +		{"stack", optional_argument, NULL, 'S'},
> > +		{"version", no_argument, NULL, 'V'},
> > +		{"help", no_argument, NULL, 'h'},
> > +		{NULL, 0, NULL, 0}
> > +	};
> > +
> > +	setlocale(LC_ALL, "");
> > +	bindtextdomain(PACKAGE, LOCALEDIR);
> > +	textdomain(PACKAGE);
> > +
> > +	memset(lims, 0, sizeof(lims));
> > +
> > +	/*
> > +	 * Something is very wrong if this doesn't succeed,
> > +	 * assuming STACK is the last resource, of course.
> > +	 */
> > +	assert(MAX_RESOURCES == STACK + 1);
> > +
> > +	while((opt = getopt_long(argc, argv,
> > +				 "a::c::C::d::f::l::m::M::n::N::P::r::R::t::s::S::p:o:vVh",
> > +				 longopts, NULL)) != -1) {
> > +		switch(opt) {
> > +		case 'p':
> > +			pid = strtol_or_err(optarg, _("cannot parse PID"));
> > +			break;
> 
>  What will happen if:
> 
>     prlimit --pid 123 --code=10000 --pid 456 --cpu=1

I set a restriction in the getopt loop to just allow 1 use of --pid, I
don't want prlimit to be used for several pids at once.

>     
> > +		case 'a':
> > +			add_prlimit(pid, lims, optarg, n++, AS, "failed to parse AS limit");
> 
>  The error message is unnecessary here. You can compose the message in
>  the parse_prlim() function from resource ID. 
> 
>  It would be also better to use pointer to the prlimit struct in your
>  parse_* function that use two options 'struct rlimit *lim' and 'int res'.
> 
>  So:
> 
>        case 'a':
>            add_prlimit(pid, optarg, &lims[n++], AS);
> 
>  and in add_prlimit() you can initialize the pointer to desc:
> 
>     lims->desc = prlimit_desc[id];
> 
>  [...]
> 
> > +	n == 0 ? do_prlimit(pid, default_lims, MAX_RESOURCES) :
> > +		 do_prlimit(pid, lims, n);
> 
>  or if you replace default_lims with prlimit_desc:
> 
>   if (!n) {
>     for (n = 0; n < MAX_RESOURCES; n++)
>         add_prlimit(pid, NULL, &lims[n], n);
>   }
> 
>   do_prlimit(pid, lims, n);
> 
>  ;-)
> 
>     Karel
> 


Below is a v2 version with the requested corrections, thanks for
reviewing.

- Davidlohr

>From 87b6c242fdf12a261aa86ccc7eb022bd2780290c Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 19 Oct 2011 15:58:42 -0400
Subject: [PATCH 1/2] prlimit: new command

This program uses the prlimit() system call to get and/or set resource limits for a given process.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |  537 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 537 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/prlimit.c

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
new file mode 100644
index 0000000..4d4fd91
--- /dev/null
+++ b/sys-utils/prlimit.c
@@ -0,0 +1,537 @@
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
+struct prlimit_desc {
+	const char *name;
+	const char *help;
+	const int resource;
+};
+
+static struct prlimit_desc prlimit_desc[] =
+{
+	[AS]         = { "AS",         N_("address space limit"),                RLIMIT_AS },
+	[CORE]       = { "CORE",       N_("max core file size"),                 RLIMIT_CORE },
+	[CPU]        = { "CPU",        N_("CPU time in secs"),                   RLIMIT_CPU },
+	[DATA]       = { "DATA",       N_("max data size"),                      RLIMIT_DATA },
+	[FSIZE]      = { "FSIZE",      N_("max file size"),                      RLIMIT_FSIZE },
+	[LOCKS]      = { "LOCKS",      N_("max amount of file locks held"),      RLIMIT_LOCKS },
+	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), RLIMIT_MEMLOCK },
+	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         RLIMIT_MSGQUEUE },
+	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     RLIMIT_NICE },
+	[NOFILE]     = { "NOFILE",     N_("max amount of open files"),           RLIMIT_NOFILE },
+	[NPROC]      = { "NPROC",      N_("max number of processes"),            RLIMIT_NPROC },
+	[RSS]        = { "RSS",        N_("max resident set size"),              RLIMIT_RSS },
+	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             RLIMIT_RTPRIO },
+	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        RLIMIT_RTTIME },
+	[SIGPENDING] = { "SIGPENDING", N_("max amount of pending signals"),      RLIMIT_SIGPENDING },
+	[STACK]      = { "STACK",      N_("max stack size"),                     RLIMIT_STACK }
+
+
+};
+
+struct prlimit {
+	struct rlimit rlim;
+	struct prlimit_desc *desc;
+	int modify;
+};
+
+enum {
+	COL_HELP,
+	COL_RES,
+	COL_SOFT,
+	COL_HARD,
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
+	[COL_RES]     = { "RESOURCE",    0.25, TT_FL_TRUNC, N_("resource name") },
+	[COL_HELP]    = { "DESCRIPTION", 0.1,  TT_FL_TRUNC, N_("resource description")},
+	[COL_SOFT]    = { "SOFT",        0.1,  TT_FL_RIGHT, N_("soft limit")},
+	[COL_HARD]    = { "HARD",        1,    TT_FL_RIGHT, N_("hard limit (ceiling)")},
+};
+
+#define NCOLS ARRAY_SIZE(infos)
+
+#define MAX_RESOURCES ARRAY_SIZE(prlimit_desc)
+
+/* when soft or hard limits isn't specified */
+#define PRLIMIT_UNKNOWN    -3
+
+/* array with IDs of enabled columns */
+static int columns[NCOLS], ncolumns = 0;
+static pid_t pid = 0; /* calling process (default) */
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
+	for (i = 0; i < NCOLS; i++)
+		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
+
+	fprintf(out, USAGE_MAN_TAIL("prlimit(1)"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static inline int get_column_id(int num)
+{
+	assert(ARRAY_SIZE(columns) == NCOLS);
+	assert(num < ncolumns);
+	assert(columns[num] < NCOLS);
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
+			rc = asprintf(&str, "%s", l.desc->name);
+			break;
+		case COL_HELP:
+			rc = asprintf(&str, "%s", l.desc->help);
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
+
+static void do_prlimit(struct prlimit lims[], const int n)
+{
+	int i, nshows = 0;
+
+	for (i = 0; i < n; i++) {
+		struct rlimit *new = NULL;
+
+		if (lims[i].modify)
+			new = &lims[i].rlim;
+		else
+			nshows++;
+
+		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1)
+			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+	}
+
+	if (nshows)
+		show_limits(lims, 0, n);
+}
+
+static int get_range(char *str, rlim_t *lower, rlim_t *upper)
+{
+	char *end = NULL;
+	const char *ulimit = "unlimited";
+	const size_t len = strlen(ulimit);
+
+	if (!str)
+		return 0;
+
+	*upper = *lower = PRLIMIT_UNKNOWN;
+	errno = 0;
+
+	if (!strcmp(str, ulimit)) {
+		*upper = *lower = RLIM_INFINITY;
+		goto out;
+	}
+
+	else if (*str == ':') {				/* <:N> */
+		str++;
+
+		if (!strcmp(str, ulimit)) {
+			*upper =  RLIM_INFINITY;
+			goto out;
+		}
+		else {
+			*upper = strtol(str, &end, 10);
+
+			if (errno || !end || *end || end == str)
+				goto err;
+		}
+
+	} else {
+		if (!strncmp(str, ulimit, len)) {
+			*lower =  RLIM_INFINITY;
+			/* we can be sure this won't overflow */
+			end = str + len;
+		}
+		else {
+			*upper = *lower = strtol(str, &end, 10);
+			if (errno || !end || end == str)
+				goto err;
+		}
+
+		if (*end == ':' && !*(end + 1)) 	/* <M:> */
+			*upper = PRLIMIT_UNKNOWN;
+		
+		else if (*end == ':') {	/* <M:N> */
+			str = end + 1;
+			
+			if (!strcmp(str, ulimit))
+				*upper =  RLIM_INFINITY;
+			else {
+				end = NULL;
+				errno = 0;
+				*upper = strtol(str, &end, 10);
+
+				if (errno || !end || *end || end == str)
+					goto err;
+			}
+		}
+	}
+
+out:
+	return 0;
+err:
+	return -1;
+}
+
+
+static int parse_prlim(struct rlimit *lim, char *ops, const int id)
+{
+	rlim_t soft = 0, hard = 0;
+
+	if (get_range(ops, &soft, &hard))
+ 		errx(EXIT_FAILURE, _("failed to parse %s limit"), prlimit_desc[id].name);
+
+	/*
+	 * If one of the limits is unknown (default value for not being passed), we need
+	 * to get the current limit and use it.
+	 * I see no other way other than using prlimit(2).
+	 */
+	if (soft == PRLIMIT_UNKNOWN || hard == PRLIMIT_UNKNOWN) {
+		struct rlimit old;
+
+		if (prlimit(pid, prlimit_desc[id].resource, NULL, &old) == -1)
+			errx(EXIT_FAILURE, _("failed to get old %s limit"),
+			     prlimit_desc[id].name);
+
+		if (soft == PRLIMIT_UNKNOWN)
+			soft = old.rlim_cur;
+		else if (hard == PRLIMIT_UNKNOWN)
+			hard = old.rlim_max;
+	}
+
+	if (soft > hard && (soft != RLIM_INFINITY || hard != RLIM_INFINITY))
+		errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling value"));
+
+	lim->rlim_cur = soft;
+	lim->rlim_max = hard;
+
+	return 0;
+}
+
+/*
+ * Add a resource limit to the limits array
+ */
+static int add_prlim(char *ops, struct prlimit *lim, const int id)
+{
+	lim->desc = &prlimit_desc[id];
+
+	if (ops) { /* planning on modifying a limit? */
+		lim->modify = 1;
+		parse_prlim(&lim->rlim, ops, id);
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, n = 0;
+	struct prlimit lims[MAX_RESOURCES] = {0};
+
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
+			if (pid) /* we only work one pid at a time */
+				errx(EXIT_FAILURE, _("only use one PID at a time"));
+			
+			pid = strtol_or_err(optarg, _("cannot parse PID"));
+			break;
+		case 'a':
+			add_prlim(optarg, &lims[n++], AS);
+			break;
+		case 'c':
+			add_prlim(optarg, &lims[n++], CORE);
+			break;
+		case 'C':
+			add_prlim(optarg, &lims[n++], CPU);
+			break;
+		case 'd':
+			add_prlim(optarg, &lims[n++], DATA);
+			break;
+		case 'f':
+			add_prlim(optarg, &lims[n++], FSIZE);
+			break;
+		case 'l':
+			add_prlim(optarg, &lims[n++], LOCKS);
+			break;
+		case 'm':
+			add_prlim(optarg, &lims[n++], MEMLOCK);
+			break;
+		case 'M':
+			add_prlim(optarg, &lims[n++], MSGQUEUE);
+			break;
+		case 'n':
+			add_prlim(optarg, &lims[n++], NICE);
+			break;
+		case 'N':
+			add_prlim(optarg, &lims[n++], NOFILE);
+			break;
+		case 'P':
+			add_prlim(optarg, &lims[n++], NPROC);
+			break;
+		case 'r':
+			add_prlim(optarg, &lims[n++], RSS);
+			break;
+		case 't':
+			add_prlim(optarg, &lims[n++], NOFILE);
+			break;
+		case 's':
+			add_prlim(optarg, &lims[n++], SIGPENDING);
+			break;
+		case 'S':
+			add_prlim(optarg, &lims[n++], STACK);
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
+	if (!n)
+		for (; n < MAX_RESOURCES; n++)
+			add_prlim(NULL, &lims[n], n);
+
+	do_prlimit(lims, n);
+
+	return EXIT_SUCCESS;
+}
-- 
1.7.7
