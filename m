Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 3/4] chmem: new tool
Date: Wed, 12 Oct 2016 14:00:46 +0200
In-Reply-To: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
Message-Id: <20161012120047.60732-4-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Move the s390 specific chmem tool to util-linux.

The chmem tool was originally written in perl and is part of the
s390-tools package which can be found here:
https://www.ibm.com/developerworks/linux/linux390/s390-tools.html

Given that the tool is architecture independent, there is no reason to
keep it in an s390 specific repository. It seems to be useful for
other architectures as well.

This patch converts the tool to C and adds it to util-linux, while the
command line options stay compatible. The only exception is the option
"-v" which used to be the short form of "--version". That got changed
to "-V" so it behaves like most other tools contained within
util-linux.

The chmem tool can be used to set memory online or offline. This can
be achieved by specifying a memory range:

Memory Block 19 (0x0000000130000000-0x000000013fffffff) disabled

or by specifying a size where chmem will automatically select memory
blocks:

Memory Block 21 (0x0000000150000000-0x000000015fffffff) disable failed
Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled
Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled

or by specifying memory block numbers instead of address ranges:

Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) disabled
Memory Block 16 (0x0000000100000000-0x000000010fffffff) disabled
Memory Block 17 (0x0000000110000000-0x000000011fffffff) disabled
Memory Block 18 (0x0000000120000000-0x000000012fffffff) disabled

This is based on a patch from Clemens von Mann.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 .gitignore              |   1 +
 configure.ac            |   7 ++
 sys-utils/Makemodule.am |   7 ++
 sys-utils/chmem.8       |  95 ++++++++++++++
 sys-utils/chmem.c       | 325 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 sys-utils/chmem.8
 create mode 100644 sys-utils/chmem.c

diff --git a/.gitignore b/.gitignore
index 6ead2f1dddc2..2658dcdd1d68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,7 @@ update.log
 /cfdisk
 /chcpu
 /chfn
+/chmem
 /chrt
 /chsh
 /col
diff --git a/configure.ac b/configure.ac
index 78dc24564140..1ba40d528656 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1484,6 +1484,13 @@ AC_ARG_ENABLE([lsmem],
 UL_BUILD_INIT([lsmem])
 AM_CONDITIONAL([BUILD_LSMEM], [test "x$build_lsmem" = xyes])
 
+AC_ARG_ENABLE([chmem],
+  AS_HELP_STRING([--disable-chmem], [do not build chmem]),
+  [], [UL_DEFAULT_ENABLE([chmem], [yes])]
+)
+UL_BUILD_INIT([chmem])
+AM_CONDITIONAL([BUILD_CHMEM], [test "x$build_chmem" = xyes])
+
 UL_BUILD_INIT([ipcmk], [yes])
 AM_CONDITIONAL([BUILD_IPCMK], [test "x$build_ipcmk" = xyes])
 
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 5de02e1fb108..be643c965c36 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -6,6 +6,13 @@ lsmem_LDADD = $(LDADD) libcommon.la libsmartcols.la
 lsmem_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
 endif
 
+if BUILD_CHMEM
+usrbin_exec_PROGRAMS += chmem
+dist_man_MANS += sys-utils/chmem.8
+chmem_SOURCES = sys-utils/chmem.c
+chmem_LDADD = $(LDADD) libcommon.la
+endif
+
 if BUILD_FLOCK
 usrbin_exec_PROGRAMS += flock
 dist_man_MANS += sys-utils/flock.1
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
new file mode 100644
index 000000000000..99f9079351a6
--- /dev/null
+++ b/sys-utils/chmem.8
@@ -0,0 +1,95 @@
+.TH CHMEM 8 "October 2016" "util-linux" "System Administration"
+.SH NAME
+chmem \- configure memory
+.SH SYNOPSIS
+.B chmem
+.RB [ \-h "] [" \-V "] [" \-v "] [" \-e | \-d "]"
+[\fISIZE\fP|\fIRANGE\fP|\fB\-b\fP \fIBLOCKRANGE\fP]
+.SH DESCRIPTION
+The chmem command sets a particular size or range of memory online or offline.
+.
+.IP "\(hy" 2
+Specify \fISIZE\fP as <size>[m|M|g|G]. With m or M, <size> specifies the memory
+size in MiB (1024 x 1024 bytes). With g or G, <size> specifies the memory size
+in GiB (1024 x 1024 x 1024 bytes). The default unit is MiB.
+.
+.IP "\(hy" 2
+Specify \fIRANGE\fP in the form 0x<start>-0x<end> as shown in the output of the
+\fBlsmem\fP command. <start> is the hexadecimal address of the first byte and <end>
+is the hexadecimal address of the last byte in the memory range.
+.
+.IP "\(hy" 2
+Specify \fIBLOCKRANGE\fP in the form <first>-<last> or <block> as shown in the
+output of the \fBlsmem\fP command. <first> is the number of the first memory block
+and <last> is the number of the last memory block in the memory
+range. Alternatively a single block can be specified. \fIBLOCKRANGE\fP requires
+the \fB--blocks\fP option.
+.
+.PP
+\fISIZE\fP and \fIRANGE\fP must be aligned to the Linux memory block size, as
+shown in the output of the \fBlsmem\fP command.
+
+Setting memory online can fail for various reasons. On virtualized systems it
+can fail if the hypervisor does not have enough memory left, for example
+because memory was overcommitted. Setting memory offline can fail if Linux
+cannot free the memory. If only part of the requested memory can be set online
+or offline, a message tells you how much memory was set online or offline
+instead of the requested amount.
+
+When setting memory online \fBchmem\fP starts with the lowest memory block
+numbers. When setting memory offline \fBchmem\fP starts with the highest memory
+block numbers.
+.SH OPTIONS
+.TP
+.BR \-b ", " \-\-blocks
+Use a \fIBLOCKRANGE\fP parameter instead of \fIRANGE\fP or \fISIZE\fP for the
+\fB--enable\fP and \fB--disable\fP options.
+.TP
+.BR \-d ", " \-\-disable
+Set the specified \fIRANGE\fP, \fISIZE\fP, or \fIBLOCKRANGE\fP of memory offline.
+.TP
+.BR \-e ", " \-\-enable
+Set the specified \fIRANGE\fP, \fISIZE\fP, or \fIBLOCKRANGE\fP of memory online.
+.TP
+.BR \-h ", " \-\-help
+Print a short help text, then exit.
+.TP
+.BR \-v ", " \-\-verbose
+Verbose mode. Causes \fBchmem\fP to print debugging messages about it's
+progress.
+.TP
+.BR \-V ", " \-\-version
+Print the version number, then exit.
+.SH RETURN CODES
+.B chmem
+has the following return codes:
+.TP
+.BR 0
+success
+.TP
+.BR 1
+failure
+.TP
+.BR 64
+partial success
+.SH EXAMPLES
+.TP
+.B chmem --enable 1024
+This command requests 1024 MiB of memory to be set online.
+.TP
+.B chmem -e 2g
+This command requests 2 GiB of memory to be set online.
+.TP
+.B chmem --disable 0x00000000e4000000-0x00000000f3ffffff
+This command requests the memory range starting with 0x00000000e4000000
+and ending with 0x00000000f3ffffff to be set offline.
+.TP
+.B chmem -b -d 10
+This command requests the memory block number 10 to be set offline.
+.SH SEE ALSO
+.BR lsmem (1)
+.SH AVAILABILITY
+The \fBchmem\fP command is part of the util-linux package and is available from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
new file mode 100644
index 000000000000..cc681b84c4c5
--- /dev/null
+++ b/sys-utils/chmem.c
@@ -0,0 +1,325 @@
+/*
+ * chmem - Memory configuration tool
+ *
+ * Copyright IBM Corp. 2016
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <assert.h>
+#include <dirent.h>
+
+#include <c.h>
+#include <nls.h>
+#include <path.h>
+#include <strutils.h>
+#include <strv.h>
+#include <optutils.h>
+#include <closestream.h>
+#include <xalloc.h>
+
+/* partial success, otherwise we return regular EXIT_{SUCCESS,FAILURE} */
+#define CHMEM_EXIT_SOMEOK		64
+
+#define _PATH_SYS_MEMORY		"/sys/devices/system/memory"
+#define _PATH_SYS_MEMORY_BLOCK_SIZE	_PATH_SYS_MEMORY "/block_size_bytes"
+
+struct chmem_desc {
+	struct dirent	**dirs;
+	int		ndirs;
+	uint64_t	block_size;
+	uint64_t	start;
+	uint64_t	end;
+	uint64_t	size;
+	unsigned int	use_blocks : 1;
+	unsigned int	is_size	   : 1;
+	unsigned int	verbose	   : 1;
+};
+
+enum {
+	CMD_MEMORY_ENABLE = 0,
+	CMD_MEMORY_DISABLE,
+	CMD_NONE
+};
+
+static void idxtostr(struct chmem_desc *desc, uint64_t idx, char *buf, size_t bufsz)
+{
+	uint64_t start, end;
+
+	start = idx * desc->block_size;
+	end = start + desc->block_size - 1;
+	snprintf(buf, bufsz,
+		 _("Memory Block %"SCNu64" (0x%016"PRIx64"-0x%016"PRIx64")"),
+		 idx, start, end);
+}
+
+static int chmem_size(struct chmem_desc *desc, int enable)
+{
+	char *name, *onoff, line[BUFSIZ], str[BUFSIZ];
+	uint64_t size, index;
+	int i, rc;
+
+	size = desc->size;
+	onoff = enable ? "online" : "offline";
+	i = enable ? 0 : desc->ndirs - 1;
+	for (; i >= 0 && i < desc->ndirs && size; i += enable ? 1 : -1) {
+		name = desc->dirs[i]->d_name;
+		index = strtou64_or_err(name + 6, _("Failed to parse index"));
+		path_read_str(line, sizeof(line), _PATH_SYS_MEMORY "/%s/state", name);
+		if (strcmp(onoff, line) == 0)
+			continue;
+		idxtostr(desc, index, str, sizeof(str));
+		rc = path_write_str(onoff, _PATH_SYS_MEMORY"/%s/state", name);
+		if (rc == -1 && desc->verbose) {
+			if (enable)
+				fprintf(stdout, _("%s enable failed\n"), str);
+			else
+				fprintf(stdout, _("%s disable failed\n"), str);
+		} else if (rc == 0 && desc->verbose) {
+			if (enable)
+				fprintf(stdout, _("%s enabled\n"), str);
+			else
+				fprintf(stdout, _("%s disabled\n"), str);
+		}
+		if (rc == 0)
+			size--;
+	}
+	if (size) {
+		uint64_t bytes;
+		char *sizestr;
+
+		bytes = (desc->size - size) * desc->block_size;
+		sizestr = size_to_human_string(SIZE_SUFFIX_1LETTER, bytes);
+		if (enable)
+			warnx(_("Could only enable %s of memory"), sizestr);
+		else
+			warnx(_("Could only disable %s of memory"), sizestr);
+		free(sizestr);
+	}
+	return size == 0 ? 0 : size == desc->size ? -1 : 1;
+}
+
+static int chmem_range(struct chmem_desc *desc, int enable)
+{
+	char *name, *onoff, line[BUFSIZ], str[BUFSIZ];
+	uint64_t index, todo;
+	int i, rc;
+
+	todo = desc->end - desc->start + 1;
+	onoff = enable ? "online" : "offline";
+	for (i = 0; i < desc->ndirs; i++) {
+		name = desc->dirs[i]->d_name;
+		index = strtou64_or_err(name + 6, _("Failed to parse index"));
+		if (index < desc->start)
+			continue;
+		if (index > desc->end)
+			break;
+		idxtostr(desc, index, str, sizeof(str));
+		path_read_str(line, sizeof(line), _PATH_SYS_MEMORY "/%s/state", name);
+		if (strcmp(onoff, line) == 0) {
+			if (desc->verbose && enable)
+				fprintf(stdout, _("%s already enabled\n"), str);
+			else if (desc->verbose && !enable)
+				fprintf(stdout, _("%s already disabled\n"), str);
+			todo--;
+			continue;
+		}
+		rc = path_write_str(onoff, _PATH_SYS_MEMORY"/%s/state", name);
+		if (rc == -1) {
+			if (enable)
+				warn(_("%s enable failed"), str);
+			else
+				warn(_("%s disable failed"), str);
+		} else if (desc->verbose) {
+			if (enable)
+				fprintf(stdout, _("%s enabled\n"), str);
+			else
+				fprintf(stdout, _("%s disabled\n"), str);
+		}
+		if (rc == 0)
+			todo--;
+	}
+	return todo == 0 ? 0 : todo == desc->end - desc->start + 1 ? -1 : 1;
+}
+
+static int filter(const struct dirent *de)
+{
+	if (strncmp("memory", de->d_name, 6))
+		return 0;
+	return isdigit_string(de->d_name + 6);
+}
+
+static void read_info(struct chmem_desc *desc)
+{
+	char line[BUFSIZ];
+
+	desc->ndirs = scandir(_PATH_SYS_MEMORY, &desc->dirs, filter, versionsort);
+	if (desc->ndirs <= 0)
+		err(EXIT_FAILURE, _("Failed to read %s"), _PATH_SYS_MEMORY);
+	path_read_str(line, sizeof(line), _PATH_SYS_MEMORY_BLOCK_SIZE);
+	desc->block_size = strtoumax(line, NULL, 16);
+}
+
+static void parse_single_param(struct chmem_desc *desc, char *str)
+{
+	if (desc->use_blocks) {
+		desc->start = strtou64_or_err(str, _("Failed to parse block number"));
+		desc->end = desc->start;
+		return;
+	}
+	desc->is_size = 1;
+	desc->size = strtosize_or_err(str, _("Failed to parse size"));
+	if (isdigit(str[strlen(str) - 1]))
+		desc->size *= 1024*1024;
+	if (desc->size % desc->block_size) {
+		errx(EXIT_FAILURE, _("Size must be aligned to memory block size (%s)"),
+		     size_to_human_string(SIZE_SUFFIX_1LETTER, desc->block_size));
+	}
+	desc->size /= desc->block_size;
+}
+
+static void parse_range_param(struct chmem_desc *desc, char *start, char *end)
+{
+	if (desc->use_blocks) {
+		desc->start = strtou64_or_err(start, _("Failed to parse start"));
+		desc->end = strtou64_or_err(end, _("Failed to parse end"));
+		return;
+	}
+	if (strlen(start) < 2 || start[1] != 'x')
+		errx(EXIT_FAILURE, _("Invalid start address format: %s"), start);
+	if (strlen(end) < 2 || end[1] != 'x')
+		errx(EXIT_FAILURE, _("Invalid end address format: %s"), end);
+	desc->start = strtox64_or_err(start, _("Failed to parse start address"));
+	desc->end = strtox64_or_err(end, _("Failed to parse end address"));
+	if (desc->start % desc->block_size || (desc->end + 1) % desc->block_size) {
+		errx(EXIT_FAILURE,
+		     _("Start address and (end address + 1) must be aligned to "
+		       "memory block size (%s)"),
+		     size_to_human_string(SIZE_SUFFIX_1LETTER, desc->block_size));
+	}
+	desc->start /= desc->block_size;
+	desc->end /= desc->block_size;
+}
+
+static void parse_parameter(struct chmem_desc *desc, char *param)
+{
+	char **split;
+
+	split = strv_split(param, "-");
+	if (strv_length(split) > 2)
+		errx(EXIT_FAILURE, _("Invalid parameter: %s"), param);
+	if (strv_length(split) == 1)
+		parse_single_param(desc, split[0]);
+	else
+		parse_range_param(desc, split[0], split[1]);
+	strv_free(split);
+	if (desc->start > desc->end)
+		errx(EXIT_FAILURE, _("Invalid range: %s"), param);
+}
+
+static void __attribute__((__noreturn__)) chmem_usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [SIZE|RANGE|BLOCKRANGE]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Set a particular size or range of memory online or offline.\n"), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -e, --enable   enable memory\n"), out);
+	fputs(_(" -d, --disable  disable memory\n"), out);
+	fputs(_(" -b, --blocks   use memory blocks\n"), out);
+	fputs(_(" -v, --verbose  verbose output\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+
+	fprintf(out, USAGE_MAN_TAIL("chmem(8)"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	struct chmem_desc _desc = { }, *desc = &_desc;
+	int cmd = CMD_NONE;
+	int c, rc;
+
+	static const struct option longopts[] = {
+		{"block",	no_argument,		NULL, 'b'},
+		{"disable",	no_argument,		NULL, 'd'},
+		{"enable",	no_argument,		NULL, 'e'},
+		{"help",	no_argument,		NULL, 'h'},
+		{"verbose",	no_argument,		NULL, 'v'},
+		{"version",	no_argument,		NULL, 'V'},
+		{NULL,		0,			NULL, 0}
+	};
+
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
+		{ 'd','e' },
+		{ 0 }
+	};
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	read_info(desc);
+
+	while ((c = getopt_long(argc, argv, "bdehvV", longopts, NULL)) != -1) {
+
+		err_exclusive_options(c, longopts, excl, excl_st);
+
+		switch (c) {
+		case 'd':
+			cmd = CMD_MEMORY_DISABLE;
+			break;
+		case 'e':
+			cmd = CMD_MEMORY_ENABLE;
+			break;
+		case 'b':
+			desc->use_blocks = 1;
+			break;
+		case 'h':
+			chmem_usage(stdout);
+			break;
+		case 'v':
+			desc->verbose = 1;
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		}
+	}
+
+	if ((argc == 1) || (argc != optind + 1) || (cmd == CMD_NONE))
+		chmem_usage(stderr);
+
+	parse_parameter(desc, argv[optind]);
+
+	if (desc->is_size)
+		rc = chmem_size(desc, cmd == CMD_MEMORY_ENABLE ? 1 : 0);
+	else
+		rc = chmem_range(desc, cmd == CMD_MEMORY_ENABLE ? 1 : 0);
+
+	return rc == 0 ? EXIT_SUCCESS :
+		rc < 0 ? EXIT_FAILURE : CHMEM_EXIT_SOMEOK;
+}
-- 
2.8.4
