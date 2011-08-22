Return-Path: heiko.carstens@de.ibm.com
Date: Mon, 22 Aug 2011 14:06:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] new chcpu tool
Message-ID: <20110822120641.GA7549@osiris.boeblingen.de.ibm.com>
References: <20110815152453.052584040@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110815152453.052584040@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

here is an updated version of the chcpu tool that includes all the features
I described in my previous mail.
Do you think it would be ok to have it in util-linux? Or should it live
somewhere else?

The rationale why I think it should be within util-linux is simply that
lscpu is already there. Parts of the tool are architecture/hypervisor
dependent, but some things are useful for most architectures, I think.
At least for those architectures that support virtualization quite a few
features are (or will be) common.

Another reason for trying to add it to util-linux is that we want to avoid
doing the same mistake we did already with the "lsmem" and "chmem" tools
which can configure hotplug memory. These tools are completely architecture
independent, but we put them into our "s390-tools" package.
I think both of them should live in util-linux instead... But that's
something we could address later anyway :)

Anyway, what do you think?

Thanks,
Heiko

----

Subject: [PATCH] chcpu: new tool

From: Heiko Carstens <heiko.carstens@de.ibm.com>

chcpu can modify the logical state of CPUs. It can enable and disable CPUs,
scan for new CPUs, change the CPU dispatching mode of the underlying
hypervisor and request (configure) or give logical CPUs back (deconfigure)
to the the underlying hypervisor.

This is quite useful if you work a lot with virtual servers, since doing all
the configuration stuff directly via sysfs becomes a pain.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 sys-utils/.gitignore  |    1 
 sys-utils/Makefile.am |    3 
 sys-utils/chcpu.1     |   94 +++++++++++++
 sys-utils/chcpu.c     |  337 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.1     |    2 
 5 files changed, 437 insertions(+)

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
index 0000000..9417a72
--- /dev/null
+++ b/sys-utils/chcpu.1
@@ -0,0 +1,94 @@
+.TH CHCPU 1 "August 2011" Linux "User Manuals"
+.SH NAME
+chcpu \- CPU configuration utility
+.SH SYNOPSIS
+.B chcpu
+\fB-c\fP|\fB\-d\fP|\fB\-e\fP|\fB\-g\fP
+.IR cpu-list
+.br
+.B
+\fBchcpu \-p\fP \fImode\fP
+.br
+.B chcpu
+.RB [ \-rhV\ ]
+.br
+.SH DESCRIPTION
+.B chcpu
+can modify the logical state of CPUs. It can enable and disable CPUs, scan
+for new CPUs, change the CPU dispatching mode of the underlying hypervisor
+and request (configure) or give logical CPUs back (deconfigure) to the
+the underlying hypervisor.
+
+Some options have a \fIcpu-list\fP argument. A \fIcpu-list\fP may specify
+multiple CPUs, separated by comma, and ranges.  For example,
+.BR 0,5,7,9-11 .
+.SH OPTIONS
+The --configure, --deconfigure, --disable, --dispatch, --enable and --rescan
+options are mutually exclusive.
+.TP
+.BR \-c , " \-\-configure " <\fIcpu-list\fP>
+Configure all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to configure a CPU specified in the \fIcpu-list\fP it will skip that
+CPU and continue with the next one until all specified CPUs have been
+processed.
+.br
+Configuring a CPU means that the underlying hypervisor is informed that
+a logical CPU within a guest should be used. If the hypervisor has enough
+resources the request will succeed.
+.TP
+.BR \-d , " \-\-disable " <\fIcpu-list\fP>
+Disable all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to disable a CPU specified in the \fIcpu-list\fP it will skip that
+CPU and continue with the next one until all specified CPUs have been
+processed.
+.br
+When a CPU has been disabled its state is offline.
+.TP
+.BR \-e , " \-\-enable " <\fIcpu-list\fP>
+Enable all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to enable a CPU specified in the \fIcpu-list\fP it will skip that
+CPU and continue with the next one until all specified CPUs have been
+processed.
+.br
+When a CPU has been enabled its state is online.
+.TP
+.BR \-g , " \-\-deconfigure " <\fIcpu-list\fP>
+Deconfigure all CPUs specified with \fIcpu-list\fP. If
+.BR chcpu
+fails to deconfigure a CPU specified in the \fIcpu-list\fP it will skip
+that CPU and continue with the next one until all specified CPUs have been
+processed. Only disabled (offline) CPUs can be deconfigured.
+.br
+Deconfiguring a CPU means that the underlying hypervisor is informed that
+the CPU will not be used anymore and that the hypervisor can add the CPU
+back to its CPU pool.
+.TP
+.BR \-h , " \-\-help"
+Print a help text and exit.
+.TP
+.BR \-p , " \-\-dispatch " <\fImode\fP>
+Set the CPU dispatching \fImode\fP if the underlying hypervisor supports this.
+\fImode\fP may be horizontal or vertical.
+.TP
+.BR \-r , " \-\-rescan"
+Trigger a rescan of CPUs. If new CPUs have been attached to the system the
+kernel will detect them. On some systems no event will be generated if a
+CPU gets attached. In that case a CPU rescan must be manually triggered.
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
index 0000000..2d5725f
--- /dev/null
+++ b/sys-utils/chcpu.c
@@ -0,0 +1,337 @@
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
+#define _PATH_SYS_CPU		"/sys/devices/system/cpu"
+#define _PATH_SYS_CPU_RESCAN	_PATH_SYS_CPU "/rescan"
+#define _PATH_SYS_CPU_DISPATCH	_PATH_SYS_CPU "/dispatching"
+
+static char pathbuf[PATH_MAX];
+
+enum {
+	CMD_CPU_ENABLE	= 0,
+	CMD_CPU_DISABLE,
+	CMD_CPU_CONFIGURE,
+	CMD_CPU_DECONFIGURE,
+	CMD_CPU_RESCAN,
+	CMD_CPU_DISPATCH_HORIZONTAL,
+	CMD_CPU_DISPATCH_VERTICAL,
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
+			printf(_("CPU %d does not exist\n"), cpu);
+			continue;
+		}
+		if (!path_exist(_PATH_SYS_CPU "/cpu%d/online", cpu)) {
+			printf(_("CPU %d is not hot pluggable\n"), cpu);
+			continue;
+		}
+		fd = path_open(O_RDWR, _PATH_SYS_CPU "/cpu%d/online", cpu);
+		if (read(fd, &c, 1) == -1)
+			err(EXIT_FAILURE, "error: cannot read from %s", pathbuf);
+		if ((c == '1') && (enable == 1)) {
+			printf(_("CPU %d is already enabled\n"), cpu);
+			continue;
+		}
+		if ((c == '0') && (enable == 0)) {
+			printf(_("CPU %d is already disabled\n"), cpu);
+			continue;
+		}
+		if (enable) {
+			rc = write(fd, "1", 1);
+			if (rc == -1)
+				printf(_("CPU %d enable failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				printf(_("CPU %d enabled\n"), cpu);
+		} else {
+			rc = write(fd, "0", 1);
+			if (rc == -1)
+				printf(_("CPU %d disable failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				printf(_("CPU %d disabled\n"), cpu);
+		}
+		close(fd);
+	}
+	return EXIT_SUCCESS;
+}
+
+static int cpu_rescan(void)
+{
+	int fd;
+
+	if (!path_exist(_PATH_SYS_CPU_RESCAN))
+		errx(EXIT_FAILURE, _("This system does not support rescanning of CPUs"));
+	fd = path_open(O_WRONLY, _PATH_SYS_CPU_RESCAN);
+	if (write(fd, "1", 1) == -1)
+		err(EXIT_FAILURE, _("Failed to trigger rescan of CPUs"));
+	close(fd);
+	return EXIT_SUCCESS;
+}
+
+static int cpu_set_dispatch(int mode)
+{
+	int fd;
+
+	if (!path_exist(_PATH_SYS_CPU_DISPATCH))
+		errx(EXIT_FAILURE, _("This system does not support setting "
+				     "the dispatching mode of CPUs"));
+	fd = path_open(O_WRONLY, _PATH_SYS_CPU_DISPATCH);
+	if (mode == 0) {
+		if (write(fd, "0", 1) == -1)
+			err(EXIT_FAILURE, _("Failed to set horizontal dispatch mode"));
+		printf(_("Succesfully set horizontal dispatching mode\n"));
+	} else {
+		if (write(fd, "1", 1) == -1)
+			err(EXIT_FAILURE, _("Failed to set vertical dispatch mode"));
+		printf(_("Succesfully set vertical dispatching mode\n"));
+	}
+	close(fd);
+	return EXIT_SUCCESS;
+}
+
+static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
+{
+	unsigned int cpu;
+	int fd, rc;
+	char c;
+
+	for (cpu = 0; cpu < setsize; cpu++) {
+		if (!CPU_ISSET(cpu, cpu_set))
+			continue;
+		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
+			printf(_("CPU %d does not exist\n"), cpu);
+			continue;
+		}
+		if (!path_exist(_PATH_SYS_CPU "/cpu%d/configure", cpu)) {
+			printf(_("CPU %d is not configurable\n"), cpu);
+			continue;
+		}
+		fd = path_open(O_RDWR, _PATH_SYS_CPU "/cpu%d/configure", cpu);
+		if (read(fd, &c, 1) == -1)
+			err(EXIT_FAILURE, "error: cannot read from %s", pathbuf);
+		if ((c == '1') && (configure == 1)) {
+			printf(_("CPU %d is already configured\n"), cpu);
+			continue;
+		}
+		if ((c == '0') && (configure == 0)) {
+			printf(_("CPU %d is already deconfigured\n"), cpu);
+			continue;
+		}
+		if (configure) {
+			rc = write(fd, "1", 1);
+			if (rc == -1)
+				printf(_("CPU %d configure failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				printf(_("CPU %d configured\n"), cpu);
+		} else {
+			rc = write(fd, "0", 1);
+			if (rc == -1)
+				printf(_("CPU %d deconfigure failed (%s)\n"), cpu,
+					strerror(errno));
+			else
+				printf(_("CPU %d deconfigured\n"), cpu);
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
+		" %s [options]\n"), program_invocation_short_name);
+
+	puts(_(	"\nOptions:\n"
+		"  -h, --help                    print this help\n"
+		"  -e, --enable <cpu-list>       enable cpus\n"
+		"  -d, --disable <cpu-list>      disable cpus\n"
+		"  -c, --configure <cpu-list>    configure cpus\n"
+		"  -g, --deconfigure <cpu-list>  deconfigure cpus\n"
+		"  -p, --dispatch <mode>         set dispatching mode\n"
+		"  -r, --rescan                  trigger rescan of cpus\n"
+		"  -V, --version                 output version information and exit\n"));
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
+		{ "configure",	required_argument, 0, 'c' },
+		{ "deconfigure",required_argument, 0, 'g' },
+		{ "disable",	required_argument, 0, 'd' },
+		{ "dispatch",	required_argument, 0, 'p' },
+		{ "enable",	required_argument, 0, 'e' },
+		{ "help",	no_argument,       0, 'h' },
+		{ "rescan",	no_argument,       0, 'r' },
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
+	while ((c = getopt_long(argc, argv, "c:d:e:g:hp:rV", longopts, NULL)) != -1) {
+		if (cmd != -1 && strchr("cdegpr", c))
+			errx(EXIT_FAILURE,
+			     _("configure, deconfigure, disable, dispatch, enable "
+			       "and rescan are mutually exclusive"));
+		switch (c) {
+		case 'c':
+			cmd = CMD_CPU_CONFIGURE;
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
+		case 'e':
+			cmd = CMD_CPU_ENABLE;
+			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
+				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
+				     argv[optind -1 ]);
+			break;
+		case 'g':
+			cmd = CMD_CPU_DECONFIGURE;
+			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
+				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
+				     argv[optind -1 ]);
+			break;
+		case 'h':
+			usage(stdout);
+		case 'p':
+			if (strcmp("horizontal", argv[optind - 1]) == 0)
+				cmd = CMD_CPU_DISPATCH_HORIZONTAL;
+			else if (strcmp("vertical", argv[optind - 1]) == 0)
+				cmd = CMD_CPU_DISPATCH_VERTICAL;
+			else
+				errx(EXIT_FAILURE, _("unsupported argument: %s"),
+				     argv[optind -1 ]);
+			break;
+		case 'r':
+			cmd = CMD_CPU_RESCAN;
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
+	case CMD_CPU_CONFIGURE:
+		return cpu_configure(cpu_set, ncpus, 1);
+	case CMD_CPU_DECONFIGURE:
+		return cpu_configure(cpu_set, ncpus, 0);
+	case CMD_CPU_RESCAN:
+		return cpu_rescan();
+	case CMD_CPU_DISPATCH_HORIZONTAL:
+		return cpu_set_dispatch(0);
+	case CMD_CPU_DISPATCH_VERTICAL:
+		return cpu_set_dispatch(1);
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
