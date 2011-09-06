Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010158.665129979@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 06/11] [PATCH] lscpu: add human readable extended cpu table output
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

lscpu currently only supports a parsable output which contains a row for
each cpu and its attributes. This output contains only comas as separators
and is hard to read for humans.
Therefore add a new option "-e | --extended" which outputs the rows in a
much more readable (and non-parsable) form. Just like for the -p option a
list of columns can be specified that shall be included in the output.
By default this option will print all columns that contain data.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/Makefile.am |    5 +-
 sys-utils/lscpu.1     |   29 +++++--
 sys-utils/lscpu.c     |  239 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 206 insertions(+), 67 deletions(-)

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index feb5888..ce50702 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -19,7 +19,10 @@ dist_man_MANS += dmesg.1 ctrlaltdel.8 cytune.8 setarch.8 \
 
 if HAVE_CPU_SET_T
 usrbin_exec_PROGRAMS += lscpu
-lscpu_SOURCES = lscpu.c $(top_srcdir)/lib/cpuset.c $(top_srcdir)/lib/strutils.c
+lscpu_SOURCES = lscpu.c $(top_srcdir)/lib/cpuset.c \
+			$(top_srcdir)/lib/strutils.c \
+			$(top_srcdir)/lib/mbsalign.c \
+			$(top_srcdir)/lib/tt.c
 dist_man_MANS += lscpu.1
 endif
 
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 2dc31b7..db7fe72 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -6,7 +6,7 @@
 lscpu \- CPU architecture information helper
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-hpxV ]
+.RB [ \-ehpxV ]
 .RB [ \-s
 .IR directory ]
 .SH DESCRIPTION
@@ -18,24 +18,37 @@ a human-readable format.  It supports both online and offline CPUs.
 It can also print out in a parsable format,
 including how different caches are shared by different CPUs,
 which can be fed to other programs.
+
+Some options have a \fIlist\fP argument. The \fIlist\fP argument is a comma
+delimited list of the columns. Currently supported are CPU, Core, Node, Socket,
+Book, Cache, Polarization and Address columns.
+If the \fIlist\fP argument is given then all requested columns are printed in
+the defined order.
+
 .SH OPTIONS
 .TP
+.TP
+.BR \-e , " \-\-extended " \fI[=list]\fP
+Print CPU list out in human-readable format.
+
+If the \fIlist\fP argument is not given then all columns where data is
+available will be printed.
+
+Note that the optional \fIlist\fP argument cannot be separated from the
+option by a space, the correct form is for example '\fB-e=cpu,node\fP' or '\fB--extended=cpu,node\fP'.
+.TP
 .BR \-h , " \-\-help"
 Print a help message.
 .TP
 .BR \-p , " \-\-parse " \fI[=list]\fP
-Print out in parsable instead of human-readable format.
+Print out in parsable format.
 
 If the \fIlist\fP argument is not given then the default backwardly compatible
 output is printed.  The backwardly compatible format uses two commas to
 separate CPU cache columns. If no CPU caches are identified, then the cache
 columns are not printed at all.
-
-The \fIlist\fP argument is comma delimited list of the columns. Currently
-supported are CPU, Core, Node, Socket, Book, Cache, Polarization and Address
-columns.
-If the \fIlist\fP argument is given then always all requested columns are printed in
-the defined order. The Cache columns are separated by ':'.
+.br
+If the \fIlist\fP argument is given then the cache columns are separated by ':'.
 
 Note that the optional \fIlist\fP argument cannot be separated from the
 option by a space, the correct form is for example '\fB-p=cpu,node\fP' or '\fB--parse=cpu,node\fP'.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 841beae..bb0201b 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -39,6 +39,7 @@
 #include "c.h"
 #include "strutils.h"
 #include "bitops.h"
+#include "tt.h"
 
 
 #define CACHE_MAX 100
@@ -117,12 +118,17 @@ enum {
 	POLAR_HORIZONTAL
 };
 
-const char *polar_modes[] = {
-	[POLAR_UNKNOWN]		= "U",
-	[POLAR_VLOW]		= "VL",
-	[POLAR_VMEDIUM]		= "VM",
-	[POLAR_VHIGH]		= "VH",
-	[POLAR_HORIZONTAL]	= "H"
+struct polarization_modes {
+	char *parsable;
+	char *readable;
+};
+
+struct polarization_modes pmodes[] = {
+	[POLAR_UNKNOWN]	   = {"U",  "-"},
+	[POLAR_VLOW]	   = {"VL", "vert-low"},
+	[POLAR_VMEDIUM]	   = {"VM", "vert-medium"},
+	[POLAR_VHIGH]	   = {"VH", "vert-high"},
+	[POLAR_HORIZONTAL] = {"H",  "horizontal"},
 };
 
 /* global description */
@@ -171,6 +177,12 @@ struct lscpu_desc {
 	int		*addresses;	/* physical cpu addresses */
 };
 
+struct lscpu_modifier {
+	int compat;
+	int formatted;
+	int hex;
+};
+
 static size_t sysrootlen;
 static char pathbuf[PATH_MAX];
 static int maxcpus;		/* size in bits of kernel cpu mask */
@@ -869,20 +881,45 @@ read_nodes(struct lscpu_desc *desc)
 					i);
 }
 
+/* asprintf version which appends the result to the given string */
 static void
-print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
+asprintfc(char **str, const char *fmt, ...)
+{
+	char *buffer, *new;
+	va_list ap;
+	int rc;
+
+	va_start(ap, fmt);
+	rc = vasprintf(&new, fmt, ap);
+	va_end(ap);
+	if (rc < 0)
+		goto error;
+	rc = asprintf(&buffer, "%s%s", *str, new);
+	free(new);
+	if (rc < 0)
+		goto error;
+	*str = buffer;
+	return;
+error:
+	errx(EXIT_FAILURE, _("failed to allocate memory"));
+}
+
+static void
+print_cell(struct lscpu_desc *desc, int i, int col, int c,
+	   struct lscpu_modifier *mod, struct tt_line *line)
 {
-	int j;
 	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
+	char *buffer = "\0";
+	int j;
 
 	switch (col) {
 	case COL_CPU:
-		printf("%d", i);
+		asprintfc(&buffer, "%d", i);
 		break;
 	case COL_CORE:
 		for (j = 0; j < desc->ncores; j++) {
 			if (CPU_ISSET_S(i, setsize, desc->coremaps[j])) {
-				printf("%d", j);
+				asprintfc(&buffer, "%d", j);
 				break;
 			}
 		}
@@ -890,7 +927,7 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 	case COL_SOCKET:
 		for (j = 0; j < desc->nsockets; j++) {
 			if (CPU_ISSET_S(i, setsize, desc->socketmaps[j])) {
-				printf("%d", j);
+				asprintfc(&buffer, "%d", j);
 				break;
 			}
 		}
@@ -898,7 +935,7 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 	case COL_NODE:
 		for (j = 0; j < desc->nnodes; j++) {
 			if (CPU_ISSET_S(i, setsize, desc->nodemaps[j])) {
-				printf("%d", j);
+				asprintfc(&buffer, "%d", j);
 				break;
 			}
 		}
@@ -906,7 +943,7 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 	case COL_BOOK:
 		for (j = 0; j < desc->nbooks; j++) {
 			if (CPU_ISSET_S(i, setsize, desc->bookmaps[j])) {
-				printf("%d", j);
+				asprintfc(&buffer, "%d", j);
 				break;
 			}
 		}
@@ -918,27 +955,44 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 
 			for (x = 0; x < ca->nsharedmaps; x++) {
 				if (CPU_ISSET_S(i, setsize, ca->sharedmaps[x])) {
-					printf("%d", x);
+					asprintfc(&buffer, "%d", x);
 					break;
 				}
 			}
+			if (x == ca->nsharedmaps && mod->formatted)
+				asprintfc(&buffer, "-");
 			if (j != 0)
-				putchar(compatible ? ',' : ':');
+				asprintfc(&buffer, mod->compat ? "," : ":");
 		}
 		break;
 	case COL_POLARIZATION:
-		if (desc->polarization)
-			printf("%s", polar_modes[desc->polarization[i]]);
+		if (!desc->polarization)
+			break;
+		if (mod->formatted)
+			asprintfc(&buffer, pmodes[desc->polarization[i]].readable);
+		else
+			asprintfc(&buffer, pmodes[desc->polarization[i]].parsable);
 		break;
 	case COL_ADDRESS:
 		if (desc->addresses)
-			printf("%d", desc->addresses[i]);
+			asprintfc(&buffer, "%d", desc->addresses[i]);
 		break;
 	}
+	if (mod->formatted) {
+		if (strlen(buffer) == 0)
+			buffer = "-";
+		tt_line_set_data(line, c, buffer);
+	} else
+		printf(buffer);
 }
 
+#define printf_cond(condition, ...) do {	\
+	if (condition)				\
+		printf(__VA_ARGS__);		\
+} while (0)
+
 /*
- * We support two formats:
+ * We support three formats:
  *
  * 1) "compatible" -- this format is compatible with the original lscpu(1)
  * output and it contains fixed set of the columns. The CACHE columns are at
@@ -959,57 +1013,85 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
  *	# CPU,Core,Socket,Node,L1d:L1i:L2
  *	0,0,0,0,0:0:0
  *	1,1,0,0,1:1:0
+ *
+ * 3) "user defined formatted" -- this format is the same as "user defined
+ * output" except that each column is separated by spaces and has a fixed size
+ * over all rows.
+ *
+ *	$ lscpu --extended=CPU,CORE,SOCKET
+ *      CPU CORE SOCKET
+ *        0    0      0
+ *        1    1      0
  */
 static void
-print_parsable(struct lscpu_desc *desc, int cols[], int ncols, int compatible)
+print_table(struct lscpu_desc *desc, int cols[], int ncols, struct lscpu_modifier *mod)
 {
+	struct tt *tt;
+	int count = 0;
 	int i, c;
 
-	printf(_(
-	"# The following is the parsable format, which can be fed to other\n"
-	"# programs. Each different item in every column has an unique ID\n"
-	"# starting from zero.\n"));
+	if (!mod->formatted) {
+		printf(_("# The following is the parsable format, which can be fed to other\n"
+			 "# programs. Each different item in every column has an unique ID\n"
+			 "# starting from zero.\n"));
+		fputs("# ", stdout);
+	} else {
+		tt = tt_new_table(0);
+	}
 
-	fputs("# ", stdout);
 	for (i = 0; i < ncols; i++) {
+		char *buffer = "\0";
+
 		if (cols[i] == COL_CACHE) {
-			if (compatible && !desc->ncaches)
+			if (mod->compat && !desc->ncaches)
 				continue;
-			if (i > 0)
-				putchar(',');
-			if (compatible && i != 0)
-				putchar(',');
+			if (mod->compat && i != 0)
+				asprintfc(&buffer, ",");
 			for (c = desc->ncaches - 1; c >= 0; c--) {
-				printf("%s", desc->caches[c].name);
+				asprintfc(&buffer, desc->caches[c].name);
 				if (c > 0)
-					putchar(compatible ? ',' : ':');
+					asprintfc(&buffer, mod->compat ? "," : ":");
 			}
 			if (!desc->ncaches)
-				fputs(colnames[cols[i]], stdout);
+				asprintfc(&buffer, colnames[cols[i]]);
+		} else {
+			asprintfc(&buffer, colnames[cols[i]]);
+		}
+		if (mod->formatted) {
+			char *c = buffer;
+
+			while (*c != '\0')
+				*c++ = toupper(*c);
+			tt_define_column(tt, buffer, 0, 0);
 		} else {
 			if (i > 0)
 				putchar(',');
-			fputs(colnames[cols[i]], stdout);
+			printf(buffer);
 		}
 	}
-	putchar('\n');
-
+	printf_cond(!mod->formatted, "\n");
 	for (i = 0; i < desc->ncpus; i++) {
+		struct tt_line *line;
+
 		if (desc->online && !is_cpu_online(desc, i))
 			continue;
+		if (mod->formatted)
+			line = tt_add_line(tt, NULL);
 		for (c = 0; c < ncols; c++) {
-			if (compatible && cols[c] == COL_CACHE) {
+			if (mod->compat && cols[c] == COL_CACHE) {
 				if (!desc->ncaches)
 					continue;
 				if (c > 0)
-					putchar(',');
+					printf_cond(!mod->formatted, ",");
 			}
 			if (c > 0)
-				putchar(',');
-			print_parsable_cell(desc, i, cols[c], compatible);
+				printf_cond(!mod->formatted, ",");
+			print_cell(desc, i, cols[c], c, mod, line);
 		}
-		putchar('\n');
+		printf_cond(!mod->formatted, "\n");
 	}
+	if (mod->formatted)
+		tt_print_table(tt);
 }
 
 
@@ -1035,7 +1117,7 @@ print_cpuset(const char *key, cpu_set_t *set, int hex)
 }
 
 static void
-print_readable(struct lscpu_desc *desc, int hex)
+print_readable(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
 	char buf[512];
 	int i;
@@ -1065,9 +1147,9 @@ print_readable(struct lscpu_desc *desc, int hex)
 	print_n(_("CPU(s):"), desc->ncpus);
 
 	if (desc->online)
-		print_cpuset(hex ? _("On-line CPU(s) mask:") :
-				   _("On-line CPU(s) list:"),
-				desc->online, hex);
+		print_cpuset(mod->hex ? _("On-line CPU(s) mask:") :
+					_("On-line CPU(s) list:"),
+			     desc->online, mod->hex);
 
 	if (desc->online && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
 		cpu_set_t *set;
@@ -1084,9 +1166,9 @@ print_readable(struct lscpu_desc *desc, int hex)
 			if (!is_cpu_online(desc, i))
 				CPU_SET_S(i, setsize, set);
 		}
-		print_cpuset(hex ? _("Off-line CPU(s) mask:") :
-				   _("Off-line CPU(s) list:"),
-			     set, hex);
+		print_cpuset(mod->hex ? _("Off-line CPU(s) mask:") :
+					_("Off-line CPU(s) list:"),
+			     set, mod->hex);
 		cpuset_free(set);
 	}
 
@@ -1164,7 +1246,7 @@ print_readable(struct lscpu_desc *desc, int hex)
 
 	for (i = 0; i < desc->nnodes; i++) {
 		snprintf(buf, sizeof(buf), _("NUMA node%d CPU(s):"), i);
-		print_cpuset(buf, desc->nodemaps[i], hex);
+		print_cpuset(buf, desc->nodemaps[i], mod->hex);
 	}
 }
 
@@ -1177,6 +1259,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	puts(_(	"\nOptions:\n"
 		"  -h, --help         print this help\n"
 		"  -p, --parse[=LIST] print out a parsable instead of a readable format\n"
+		"  -e, --table[=LIST] print out a readable format\n"
 		"  -s, --sysroot DIR  use directory DIR as system root\n"
 		"  -x, --hex          print hexadecimal masks rather than lists of CPUs\n"
 		"  -V, --version      output version information and exit\n"));
@@ -1186,12 +1269,14 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char *argv[])
 {
+	struct lscpu_modifier _mod, *mod = &_mod;
 	struct lscpu_desc _desc, *desc = &_desc;
-	int parsable = 0, c, i, hex = 0;
+	int c, i;
 	int columns[ARRAY_SIZE(colnames)], ncolumns = 0;
-	int compatible = 0;
+	int print_cpu_table = 0;
 
 	static const struct option longopts[] = {
+		{ "extended",	optional_argument, 0, 'e' },
 		{ "help",	no_argument,       0, 'h' },
 		{ "parse",	optional_argument, 0, 'p' },
 		{ "sysroot",	required_argument, 0, 's' },
@@ -1204,12 +1289,30 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt_long(argc, argv, "hp::s:xV", longopts, NULL)) != -1) {
+	memset(mod, 0, sizeof(*mod));
+	while ((c = getopt_long(argc, argv, "e::hp::s:xV", longopts, NULL)) != -1) {
+		if (print_cpu_table && strchr("ep", c))
+			errx(EXIT_FAILURE,
+			     _("extended and parsable are mutually exclusive"));
 		switch (c) {
 		case 'h':
 			usage(stdout);
+		case 'e':
+			print_cpu_table = 1;
+			mod->formatted = 1;
+			ncolumns = -1;
+			if (optarg) {
+				if (*optarg == '=')
+					optarg++;
+				ncolumns = string_to_idarray(optarg,
+						columns, ARRAY_SIZE(columns),
+						column_name_to_id);
+				if (ncolumns < 0)
+					return EXIT_FAILURE;
+			}
+			break;
 		case 'p':
-			parsable = 1;
+			print_cpu_table = 1;
 			if (optarg) {
 				if (*optarg == '=')
 					optarg++;
@@ -1224,7 +1327,7 @@ int main(int argc, char *argv[])
 				columns[ncolumns++] = COL_SOCKET;
 				columns[ncolumns++] = COL_NODE;
 				columns[ncolumns++] = COL_CACHE;
-				compatible = 1;
+				mod->compat = 1;
 			}
 			break;
 		case 's':
@@ -1233,7 +1336,7 @@ int main(int argc, char *argv[])
 			pathbuf[sizeof(pathbuf) - 1] = '\0';
 			break;
 		case 'x':
-			hex = 1;
+			mod->hex = 1;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
@@ -1263,11 +1366,31 @@ int main(int argc, char *argv[])
 
 	read_hypervisor(desc);
 
+	if (print_cpu_table && ncolumns == -1) {
+		/* No list was given. Just print whatever is there. */
+		ncolumns = 0;
+		columns[ncolumns++] = COL_CPU;
+		if (desc->nodemaps)
+			columns[ncolumns++] = COL_NODE;
+		if (desc->bookmaps)
+			columns[ncolumns++] = COL_BOOK;
+		if (desc->socketmaps)
+			columns[ncolumns++] = COL_SOCKET;
+		if (desc->coremaps)
+			columns[ncolumns++] = COL_CORE;
+		if (desc->caches)
+			columns[ncolumns++] = COL_CACHE;
+		if (desc->polarization)
+			columns[ncolumns++] = COL_POLARIZATION;
+		if (desc->addresses)
+			columns[ncolumns++] = COL_ADDRESS;
+	}
+
 	/* Show time! */
-	if (parsable)
-		print_parsable(desc, columns, ncolumns, compatible);
+	if (print_cpu_table)
+		print_table(desc, columns, ncolumns, mod);
 	else
-		print_readable(desc, hex);
+		print_readable(desc, mod);
 
 	return EXIT_SUCCESS;
 }
-- 
1.7.5.4
