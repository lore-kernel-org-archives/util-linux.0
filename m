Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110815153925.969554416@de.ibm.com>
Date: Mon, 15 Aug 2011 17:24:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 2/2] chcpu: new tool
References: <20110815152453.052584040@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The chcpu lets a user configure CPUs. In this first version all that
is possible is to enable or disable CPUs (set them online of offline).
This is quite useful if you work a lot with virtual servers, since
enabling and disabling cpus via sysfs becomes tiring.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/.gitignore  |    1 +
 sys-utils/Makefile.am |    3 +
 sys-utils/chcpu.1     |   56 ++++++++++++
 sys-utils/chcpu.c     |  222 +++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.1     |    2 +
 5 files changed, 284 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/chcpu.1
 create mode 100644 sys-utils/chcpu.c

diff --git a/sys-utils/.gitignore b/sys-utils/.gitignore
index 3ae7e4a..febeb38 100644
--- a/sys-utils/.gitignore
+++ b/sys-utils/.gitignore
@@ -41,3 +41,4 @@ switch_root
 tunelp
 unshare
 x86_64.8
+chcpu
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index feb5888..da05dac 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -21,6 +21,9 @@ if HAVE_CPU_SET_T
 usrbin_exec_PROGRAMS += lscpu
 lscpu_SOURCES = lscpu.c $(top_srcdir)/lib/cpuset.c $(top_srcdir)/lib/strutils.c
 dist_man_MANS += lscpu.1
+sbin_PROGRAMS += chcpu
+chcpu_SOURCES = chcpu.c $(top_srcdir)/lib/cpuset.c
+dist_man_MANS += chcpu.1
 endif
 
 endif
diff --git a/sys-utils/chcpu.1 b/sys-utils/chcpu.1
new file mode 100644
index 0000000..0b9e98a
--- /dev/null
+++ b/sys-utils/chcpu.1
@@ -0,0 +1,56 @@
+.TH CHCPU 1 "August 2011" Linux "User Manuals"
+.SH NAME
+chcpu \- CPU configuration utility
+.SH SYNOPSIS
+.B chcpu
+.RB [ \-hvV ]
+.RB [ \-d
+.IR cpulist ]
+.RB [ \-e
+.IR cpulist ]
+.SH DESCRIPTION
+.B chcpu
+is used to configure CPUs. It can enable and disable CPUs by writing to the
+per CPU sysfs file attributes.
+Some options have a \fIcpu-list\fP argument. A \fIcpu-list\fP may specify
+multiple CPUs, separated by comma, and ranges.  For example,
+.BR 0,5,7,9-11 .
+.SH OPTIONS
+The --disable and --enable options are mutually exclusive.
+.TP
+.BR \-d , " \-\-disable " \fIcpu-list\fP
+disable all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to disable a CPU specified in the \fIcpu-list\fP it will skip that
+CPU and continue with the next one until all specified CPUs have been
+processed.
+.TP
+.BR \-e , " \-\-enable " \fIcpu-list\fP
+enable all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to enable a CPU specified in the \fIcpu-list\fP it will skip that
+CPU and continue with the next one until all specified CPUs have been
+processed.
+.TP
+.BR \-h , " \-\-help"
+Print a help text and exit.
+.TP
+.BR \-v , " \-\-verbose"
+Verbose execution. When specified
+.B chcpu
+will output the result of the configuration changes for each CPU.
+.TP
+.BR \-V , " \-\-version"
+Output version information and exit.
+.SH AUTHOR
+.nf
+Heiko Carstens <heiko.carstens@de.ibm.com>
+.fi
+.SH COPYRIGHT
+Copyright IBM Corp. 2011
+.br
+.SH "SEE ALSO"
+.BR lscpu (1)
+.SH AVAILABILITY
+The chcpu command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
new file mode 100644
index 0000000..6e4392d
--- /dev/null
+++ b/sys-utils/chcpu.c
@@ -0,0 +1,222 @@
+/*
+ * chcpu - CPU configuration tool
+ *
+ * Copyright IBM Corp. 2011
+ * Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
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
+#include <ctype.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/utsname.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "cpuset.h"
+#include "nls.h"
+#include "xalloc.h"
+#include "c.h"
+#include "strutils.h"
+#include "bitops.h"
+
+#define _PATH_SYS_CPU	"/sys/devices/system/cpu"
+
+static char pathbuf[PATH_MAX];
+static int verbose;
+
+enum {
+	CMD_CPU_ENABLE	= 0,
+	CMD_CPU_DISABLE,
+};
+
+static int path_open(mode_t mode, const char *path, ...)
+{
+	va_list ap;
+	int fd;
+
+	va_start(ap, path);
+	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	va_end(ap);
+	fd = open(pathbuf, mode);
+	if (fd == -1)
+		err(EXIT_FAILURE, "error: cannot open %s", pathbuf);
+	return fd;
+}
+
+static int path_exist(const char *path, ...)
+{
+	va_list ap;
+
+	va_start(ap, path);
+	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	va_end(ap);
+	return access(pathbuf, F_OK) == 0;
+}
+
+static void print_v(const char *str, ...)
+{
+	va_list ap;
+
+	if (!verbose)
+		return;
+	va_start(ap, str);
+	vprintf(str, ap);
+	va_end(ap);
+}
+
+static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
+{
+	unsigned int cpu;
+	int fd, rc;
+	char c;
+
+	for (cpu = 0; cpu < setsize; cpu++) {
+		if (!CPU_ISSET(cpu, cpu_set))
+			continue;
+		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
+			print_v(_("CPU %d does not exist\n"), cpu);
+			continue;
+		}
+		if (!path_exist(_PATH_SYS_CPU "/cpu%d/online", cpu)) {
+			print_v(_("CPU %d is not hot pluggable\n"), cpu);
+			continue;
+		}
+		fd = path_open(O_RDWR, _PATH_SYS_CPU "/cpu%d/online", cpu);
+		if (read(fd, &c, 1) == -1)
+			err(EXIT_FAILURE, "error: cannot read from %s", pathbuf);
+		if ((c == '1') && (enable == 1)) {
+			print_v(_("CPU %d already enabled\n"), cpu);
+			continue;
+		}
+		if ((c == '0') && (enable == 0)) {
+			print_v(_("CPU %d already disabled\n"), cpu);
+			continue;
+		}
+		if (enable) {
+			rc = write(fd, "1", 1);
+			if (rc == -1)
+				print_v(_("CPU %d enable failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				print_v(_("CPU %d enabled\n"), cpu);
+		} else {
+			rc = write(fd, "0", 1);
+			if (rc == -1)
+				print_v(_("CPU %d disable failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				print_v(_("CPU %d disabled\n"), cpu);
+		}
+		close(fd);
+	}
+	return EXIT_SUCCESS;
+}
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fprintf(out, _(
+		"\nUsage:\n"
+		" %s [options] [cpu-list]\n"), program_invocation_short_name);
+
+	puts(_(	"\nOptions:\n"
+		"  -h, --help         print this help\n"
+		"  -e, --enable       enable cpus\n"
+		"  -d, --disable      disable cpus\n"
+		"  -v, --verbose      explain what is being done\n"
+		"  -V, --version      output version information and exit\n"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char *argv[])
+{
+	cpu_set_t *cpu_set;
+	unsigned int ncpus;
+	size_t setsize;
+	int cmd = -1;
+	int c;
+
+	static const struct option longopts[] = {
+		{ "disable",	required_argument, 0, 'd' },
+		{ "enable",	required_argument, 0, 'e' },
+		{ "help",	no_argument,       0, 'h' },
+		{ "verbose",	no_argument,       0, 'v' },
+		{ "version",	no_argument,       0, 'V' },
+		{ NULL,		0, 0, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	ncpus = get_max_number_of_cpus();
+	if (ncpus <= 0)
+		errx(EXIT_FAILURE, _("cannot determine NR_CPUS; aborting"));
+	setsize = CPU_ALLOC_SIZE(ncpus);
+	cpu_set = CPU_ALLOC(ncpus);
+	if (!cpu_set)
+		err(EXIT_FAILURE, _("cpuset_alloc failed"));
+
+	while ((c = getopt_long(argc, argv, "he:d:vV", longopts, NULL)) != -1) {
+		if (cmd != -1 && strchr("de", c))
+			errx(EXIT_FAILURE,
+			     _("disable and enable are mutually exclusive"));
+		switch (c) {
+		case 'h':
+			usage(stdout);
+		case 'e':
+			cmd = CMD_CPU_ENABLE;
+			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
+				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
+				     argv[optind -1 ]);
+			break;
+		case 'd':
+			cmd = CMD_CPU_DISABLE;
+			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
+				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
+				     argv[optind -1 ]);
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'V':
+			printf(_("%s from %s\n"), program_invocation_short_name,
+			       PACKAGE_STRING);
+			return EXIT_SUCCESS;
+		default:
+			usage(stderr);
+		}
+	}
+
+	if ((argc == 1) || (argc != optind))
+		usage(stderr);
+
+	switch (cmd) {
+	case CMD_CPU_ENABLE:
+		return cpu_enable(cpu_set, ncpus, 1);
+	case CMD_CPU_DISABLE:
+		return cpu_enable(cpu_set, ncpus, 0);
+	}
+	return EXIT_SUCCESS;
+}
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 4795e91..39246c9 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -56,6 +56,8 @@ Sometimes in Xen Dom0 the kernel reports wrong data.
 Cai Qian <qcai@redhat.com>
 Karel Zak <kzak@redhat.com>
 .fi
+.SH "SEE ALSO"
+.BR chcpu (1)
 .SH AVAILABILITY
 The lscpu command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.5.4
