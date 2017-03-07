Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754350AbdCGDQD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Mar 2017 22:16:03 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 1/4] fincore: new command for counting pages of file contents in core
Date: Tue,  7 Mar 2017 11:33:49 +0900
Message-Id: <20170307023352.7340-2-yamato@redhat.com>
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
References: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 configure.ac              |   4 +
 misc-utils/Makemodule.am  |   5 +
 misc-utils/fincore.c      | 209 +++++++++++++++++++++++++++++++++++++++++
 misc-utils/fincore_orig.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 misc-utils/fincore.c
 create mode 100644 misc-utils/fincore_orig.c

diff --git a/configure.ac b/configure.ac
index 8933afa..8ea4f0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1589,6 +1589,10 @@ dnl earlier than 2.x.
 UL_REQUIRES_HAVE([ctrlaltdel], [reboot], [reboot function])
 AM_CONDITIONAL([BUILD_CTRLALTDEL], [test "x$build_ctrlaltdel" = xyes])
 
+UL_BUILD_INIT([fincore], [check])
+UL_REQUIRES_LINUX([fincore])
+AM_CONDITIONAL([BUILD_FINCORE], [test "x$build_fincore" = xyes])
+
 UL_BUILD_INIT([fsfreeze], [check])
 UL_REQUIRES_LINUX([fsfreeze])
 AM_CONDITIONAL([BUILD_FSFREEZE], [test "x$build_fsfreeze" = xyes])
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index ce9df2c..6c7fab6 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -180,3 +180,8 @@ dist_getoptexample_SCRIPTS = \
 	misc-utils/getopt-parse.bash \
 	misc-utils/getopt-parse.tcsh
 endif
+
+if BUILD_FINCORE
+usrbin_exec_PROGRAMS += fincore
+fincore_SOURCES = misc-utils/fincore.c
+endif
diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
new file mode 100644
index 0000000..d9345ca
--- /dev/null
+++ b/misc-utils/fincore.c
@@ -0,0 +1,209 @@
+/*
+ * fincore - count pages of file contents in core
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All rights reserved.
+ * Written by Masatake YAMATO <yamato@redhat.com>
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
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "c.h"
+#include "nls.h"
+#include "closestream.h"
+
+/* For large files, mmap is called in iterative way.
+   Window is the unit of vma prepared in each mmap
+   calling.
+
+   Window size depends on page size.
+   e.g. 128MB on x86_64. ( = N_PAGES_IN_WINDOW * 4096 ). */
+#define N_PAGES_IN_WINDOW (32 * 1024)
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	const char *p = program_invocation_short_name;
+
+	if (!*p)
+		p = "fincore";
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("fincore(1)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static void report_count (const char *name, off_t file_size, off_t count_incore)
+{
+	printf ("%-10lu %-10lu %s\n", count_incore, file_size, name);
+}
+
+static void report_failure (const char *name)
+{
+	printf ("%-10s %-10ld %s\n", "failed", -1L, name);
+}
+
+static int do_mincore (void *window, const size_t len,
+		       const char *name, const int pagesize,
+		       off_t *count_incore)
+{
+	static unsigned char vec[N_PAGES_IN_WINDOW];
+	int n = (len / pagesize) + ((len % pagesize)? 1: 0);
+
+	if (mincore (window, len, vec) < 0) {
+		warn(_("failed to do mincore: %s"), name);
+		return EXIT_FAILURE;
+	}
+
+	while (n > 0)
+	{
+		if (vec[--n] & 0x1)
+		{
+			vec[n] = 0;
+			(*count_incore)++;
+		}
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static int fincore_fd (int fd,
+		       const char *name, const int pagesize,
+		       off_t file_size,
+		       off_t *count_incore)
+{
+	size_t window_size = N_PAGES_IN_WINDOW * pagesize;
+	off_t  file_offset;
+	void  *window = NULL;
+	int r = EXIT_SUCCESS;
+	int warned_once = 0;
+
+	for (file_offset = 0; file_offset < file_size; file_offset += window_size) {
+		size_t len;
+
+		len = file_size - file_offset;
+		if (len >= window_size)
+			len = window_size;
+
+		window = mmap(window, len, PROT_NONE, MAP_PRIVATE, fd, file_offset);
+		if (window == MAP_FAILED) {
+			if (!warned_once) {
+				r = EXIT_FAILURE;
+				warn(_("failed to do mmap: %s"), name);
+				warned_once = 1;
+			}
+			break;
+		}
+
+		if (do_mincore (window, len, name, pagesize, count_incore) != EXIT_SUCCESS)
+			r = EXIT_FAILURE;
+
+		munmap (window, len);
+	}
+
+	return r;
+}
+
+static int fincore_name (const char *name,
+			 const int pagesize, struct stat *sb,
+			 off_t *count_incore)
+{
+	int fd;
+	int r;
+
+	if ((fd = open (name, O_RDONLY)) < 0) {
+		warn(_("failed to open: %s"), name);
+		return EXIT_FAILURE;
+	}
+
+	if (fstat (fd, sb) < 0) {
+		warn(_("failed to do fstat: %s"), name);
+		return EXIT_FAILURE;
+	}
+
+	if (sb->st_size)
+		r = fincore_fd (fd, name, pagesize, sb->st_size, count_incore);
+	else
+		/* If the file is empty,
+		   we just report this file as "successful". */
+		r = EXIT_SUCCESS;
+
+	close (fd);
+
+	return r;
+}
+
+int main(int argc, char ** argv)
+{
+	int c;
+	int pagesize;
+	int r;
+
+	static const struct option longopts[] = {
+		{ "version",    no_argument, NULL, 'V' },
+		{ "help",	no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 },
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long (argc, argv, "Vh", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	if (optind == argc) {
+		warnx(_("file argument is missing"));
+		usage(stderr);
+	}
+
+
+	pagesize = getpagesize();
+	r = EXIT_SUCCESS;
+	for(; optind < argc; optind++) {
+		char *name = argv[optind];
+		struct stat sb;
+		off_t count_incore = 0;
+
+		if (fincore_name (name, pagesize, &sb, &count_incore) == EXIT_SUCCESS)
+			report_count (name, sb.st_size, count_incore);
+		else {
+			report_failure (name);
+			r = EXIT_FAILURE;
+		}
+	}
+
+	return r;
+}
diff --git a/misc-utils/fincore_orig.c b/misc-utils/fincore_orig.c
new file mode 100644
index 0000000..ade52b4
--- /dev/null
+++ b/misc-utils/fincore_orig.c
@@ -0,0 +1,235 @@
+/*
+ * fincore - ...
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All rights reserved.
+ * Written by Masatake YAMATO <yamato@redhat.com>
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
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <getopt.h>
+// #include <err.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "c.h"
+#include "nls.h"
+#include "closestream.h"
+
+
+static const struct option longopts[] =
+{
+	{ "help",	0, 0, 'h' },
+	{ "version",    0, 0, 'V' },
+	{ NULL,		0, 0, 0 },
+};
+
+static void print_count (const char *name, int pagesize, struct stat *sb, off_t count)
+{
+	printf ("%-10u %-10u %s\n", (count * pagesize)/1024, sb->st_size, name);
+}
+static void print_fincore (unsigned int count, unsigned int total_count, int pagesize)
+{
+	printf ("%u %u\n", count * pagesize, total_count * pagesize);
+}
+
+static void usage(int rc)
+{
+	const char *p = program_invocation_short_name;
+	FILE *out = rc == EXIT_FAILURE ? stderr : stdout;
+
+	if (!*p)
+		p = "fincore";
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <pathname>...\n"), p);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Print the size of file contents incore.\n"), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -h, --help          displays this help text\n"
+		" -V, --version       output version information and exit\n"
+	       ), out);
+
+	fprintf(out, USAGE_MAN_TAIL("fincore(1)"));
+	exit(rc);
+}
+
+enum fincore_err_bit {
+	/* Critical error is occured. Therefore the returned value COUNT,
+	   doesn't make sense. */
+	FINCORE_ERR_NOCOUNT    = 1UL << 0;
+	/* Some areas are failed to count. */	
+	FINCORE_ERR_SOMECOUNTS = 1UL << 1;	
+};
+
+ /* 128MB on x86_64 */
+#define N_PAGES_IN_WINDOW (32 * 1024)
+
+static unsigned int fincore_vma (const void *window, const size_t len,
+				 const char *name, const int pagesize,
+				 off_t *count)
+{
+	unsigned char vec[N_PAGES_IN_WINDOW];
+	int n = (len / pagesize) + (len % pagesize)? 1: 0;
+	int i;
+
+	if (mincore (window, len, vec) < 0)
+		return FINCORE_ERR_NOCOUNT;
+
+	for (i = 0; i < n; i++)
+		if (vec[i] == 1)
+			*count++;
+	return 0;
+}
+
+static unsigned int fincore_fd (int fd, const char *name, const int pagesize,
+				struct stat *sb,
+				off_t *count)
+{
+	size_t window_size = N_PAGES_IN_WINDOW * pagesize;
+	off_t  file_size = sb->st_size;
+	off_t  current_offset;
+	void  *window;
+	int r = 0;
+	
+	int n_trials = 0;
+	int n_map_failed = 0;
+	int n_count_failed = 0;
+	
+	memset(&current_offset, 0, sizeof(current_offset));
+	for (; current_offset < file_size; current_offset += window_size) {
+		size_t len = file_size - current_offset;
+		int r0;
+
+		n_trials++;
+
+		if ( len >= window_size )
+			len = window_size;
+		window = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, current_offset);
+		if (window == MAP_FAILED) {
+			n_map_failed++;
+			r |= FINCORE_ERR_SOMECOUNTS;
+			warnx(_("failed to do mmap: %s"), name);
+			continue;
+		}
+
+		r0 = fincore_vma (window, len, name, pagesize, &count);
+		if (r0 & FINCORE_ERR_NOCOUNT)
+			n_count_failed++;
+		if (r0 & FINCORE_ERR_SOMECOUNTS)
+			r |= FINCORE_ERR_SOMECOUNTS;
+
+		munmap (window, len);
+	}
+
+	if ((n_trials - n_map_failed - n_count_failed) == 0)
+		r |= FINCORE_ERR_NOCOUNT;
+
+	return r;
+}
+
+static unsigned int fincore_name (const char *name, const int pagesize,
+				  struct stat *sb,
+				  off_t *count)
+{
+	int fd;
+	unsigned int r;
+
+	fd = open (name, O_RDONLY);
+	if (fd == -1) {
+		warnx(_("failed to open: %s"), name);
+		return FINCORE_ERR_NOCOUNT;
+	}
+
+	if (fstat (fd, sb) < 0) {
+		warnx(_("failed to do fstat: %s"), name);
+		return FINCORE_ERR_NOCOUNT;
+	}
+
+	r = fincore_fd (fd, name, pagesize, sb, count);
+
+	close (fd);
+	return r;
+}
+
+int main(int argc, char ** argv)
+{
+	int c;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long (argc, argv, "hV", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			usage(EXIT_SUCCESS);
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	if (optind == argc) {
+		warnx(_("pathname argument is missing"));
+		usage(EXIT_FAILURE);
+	}
+
+	int pagesize = getpagesize();
+	int n_trials = 0;
+	int n_count_failed = 0;
+	int r = 0;
+	for(; optind < argc; optind++) {
+		char *name = argv[optind];
+		struct stat sb;
+		off_t count;
+		memset(&count, 0, sizeof(count));
+		unsigned int r0;
+
+		n_trials++;
+		r0 = fincore_name (name, pagesize, &sb, &count);
+
+		if (r0 & FINCORE_ERR_NOCOUNT)
+			n_count_failed++;
+
+		print_count (name, pagesize, &sb, count);
+		if (r0 & FINCORE_ERR_SOMECOUNTS)
+			r |= FINCORE_ERR_SOMECOUNTS;
+	}
+
+	if ((n_trials - n_count_failed) == 0)
+		r |= FINCORE_ERR_NOCOUNT;
+
+	if (r == 0)
+		return EXIT_SUCCESS;
+	else if (r & FINCORE_ERR_NOCOUNT)
+		return EXIT_FAILURE;
+	else
+		return 2;
+
+}
-- 
2.9.3

