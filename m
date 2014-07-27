Return-Path: nefelim4ag@gmail.com
Message-ID: <53D54D4D.5010905@gmail.com>
Date: Sun, 27 Jul 2014 22:04:45 +0300
From: Timofey Titovets <nefelim4ag@gmail.com>
MIME-Version: 1.0
To: Timofey Titovets <nefelim4ag@gmail.com>
CC: util-linux@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Karel Zak <kzak@redhat.com>
Subject: [RFC] [Patch v2] Created zramctl
References: <53CAAAB6.6020607@gmail.com>
In-Reply-To: <53CAAAB6.6020607@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Good time of day,
I spend some time and rewrite zramctl for util-linux.

Please review code and man pages.
If you have any suggestion, say it out.

Can be pulled from:
https://github.com/Nefelim4ag/util-linux.git

For detail see man pages zramctl.8

v1 -> v2:
Use function from ./include directory
Better error handling
Implemented flexible table for status command, thanks Karel Zak for 
libsmartcols
Some fixes, thanks: Dave Reisner, Karel Zak, Benno Schulenberg


Note:
sysfs.h powerful, but i can't understand how working sysfs.h and how i 
can implement it(?), and i think what my helper function is easier now, 
than sysfs.h realization

----
  configure.ac            |   8 ++
  sys-utils/Makemodule.am |   8 ++
  sys-utils/zramctl.8     |  98 ++++++++++++++++
  sys-utils/zramctl.c     | 302 
++++++++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 416 insertions(+)


diff --git a/configure.ac b/configure.ac
index aae2456..f3204d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -859,6 +859,14 @@ UL_REQUIRES_LINUX([losetup])
  UL_REQUIRES_BUILD([losetup], [libsmartcols])
  AM_CONDITIONAL([BUILD_LOSETUP], [test "x$build_losetup" = xyes])

+AC_ARG_ENABLE([zramctl],
+  AS_HELP_STRING([--disable-zramctl], [do not build zramctl]),
+  [], [UL_DEFAULT_ENABLE([zramctl], [check])]
+)
+UL_BUILD_INIT([zramctl])
+UL_REQUIRES_LINUX([zramctl])
+UL_REQUIRES_BUILD([zramctl], [libsmartcols])
+AM_CONDITIONAL([BUILD_ZRAMCTL], [test "x$build_zramctl" = xyes])

  AC_ARG_ENABLE([fsck],
    AS_HELP_STRING([--disable-fsck], [do not build fsck]),
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 4741fed..c6a2c5a 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -362,3 +362,11 @@ dist_man_MANS += sys-utils/setpriv.1
  setpriv_SOURCES = sys-utils/setpriv.c
  setpriv_LDADD = $(LDADD) -lcap-ng libcommon.la
  endif
+
+if BUILD_ZRAMCTL
+sbin_PROGRAMS += zramctl
+dist_man_MANS += sys-utils/zramctl.8
+zramctl_SOURCES = sys-utils/zramctl.c
+zramctl_LDADD = $(LDADD) libcommon.la libsmartcols.la
+zramctl_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
+endif
\ No newline at end of file
diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
new file mode 100644
index 0000000..158c391
--- /dev/null
+++ b/sys-utils/zramctl.8
@@ -0,0 +1,98 @@
+.TH ZRAMCTL 8 "July 2014" "util-linux" "System Administration"
+.SH NAME
+zramctl \- set up and control zram devices
+.SH SYNOPSIS
+.ad l
+Get info:
+.sp
+.in +5
+.B zramctl
+.sp
+.in -5
+Reset zram:
+.sp
+.in +5
+.B "zramctl \-r"
+.IR zramdev
+.sp
+.in -5
+Print name of first unused zram device:
+.sp
+.in +5
+.B "zramctl \-f"
+.sp
+.in -5
+Setup zram device:
+.sp
+.in +5
+.B zramctl
+.RB [ \-f " | " \-d\ \fIzramdev\fP ]
+.RB [ \-s
+.IR size ]
+.RB \ [ \-t
+.IR number ]
+.in +8
+.RB [ \-a
+.IR algorithm ]
+.sp
+.in -13
+.ad b
+.SH DESCRIPTION
+.B zramctl
+Is used to quickly set up zram device parameters, to reset zram devices,
+and to query the status of used zram devices.
+If no option is given, all zram devices are shown.
+
+
+.SH OPTIONS
+
+.IP "\fB\-s, \-\-size\fP \fIsize\fP
+Force zram driver to reread size of the file associated with the 
specified zram device
++The \fIsize\fR arguments may be followed by the multiplicative
++suffixes K, M, G... Example: 512M.
+.IP "\fB\-r, \-\-reset\fP \fIzramdev\fP"
+Reset options specified zram device(s). Zram device setting can be 
changed only
+after reset.
+.IP "\fB\-d, \-\-device \fIzramdev\fP"
+if only \-d \fIzramdev\fP specified - show status for specified device. 
if additional
+\-s \fIsize\fR specified, setup specified device.
+.IP "\fB\-f, \-\-find\fP"
+find the first unused zram device. If a
+.R \-s \fIsize\fR
+argument is present, use this device.
+.IP "\fB\-h, \-\-help\fP"
+print help
+.IP "\fB\-t, \-\-threads \fInumber\fP"
+Set number of maximum compress streams what used for device.
+.IP "\fB\-a, \-\-alg \fI{lzo|lz4}\fP""
+Set compress algorithm used for compress data in zram device.
+.B "\fB\-V, \-\-version\fP"
+Display version information and exit.
+
+.SH RETURN VALUE
+.B zramctl
+returns 0 on success, nonzero on failure.
+
+.SH FILES
+.TP
+.I /dev/zram[0..N]
+zram block devices
+
+.SH EXAMPLE
+The following commands can be used for setup the zram device with 
gigabyte size
+ and using as swap device.
+.nf
+.IP
+# zramctl --find --size 1024M
+/dev/zram0
+# mkswap /dev/zram0
+# swapon /dev/zram0
+ ...
+# swapoff /dev/zram0
+# zramctl --reset /dev/zram0
+.fi
+.SH AUTHORS
+Timofey Titovets <nefelim4ag@gmail.com>
+.SH AVAILABILITY
+The zramctl command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
new file mode 100644
index 0000000..e1ad4eb
--- /dev/null
+++ b/sys-utils/zramctl.c
@@ -0,0 +1,302 @@
+/*
+ * zramctl - purpose of it
+ *
+ * Copyright (c) 2014 Timofey Titovets <Nefelim4ag@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
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
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdarg.h>
+#include "errno.h"
+#include "path.h"
+#include "pathnames.h"
+#include "exitcodes.h"
+#include "optutils.h"
+#include "ismounted.h"
+#include "strutils.h"
+#include "ismounted.h"
+#include "strutils.h"
+#include "sysfs.h"
+#include <libsmartcols.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+
+static inline int zram_exist(char *name)
+{
+	char path[16] = "/dev/";
+
+	strncat(path, name, 8);
+
+	if (!strcmp(name, "zram0")) {
+		if (path_exist(path))
+			return 1;
+		else
+			errx(EXIT_FAILURE,_("zram module not loaded"));
+	}
+
+	return path_exist(path);
+}
+
+static inline void get_value(char *name, char *data, char *filename)
+{
+	char path[64] = "/sys/block/";
+	strncat(path, name, 8);
+	strncat(path,"/", 2);
+	strncat(path, filename, 64);
+	path_read_str(data, 32, path);
+}
+
+static inline int used(char *name)
+{
+	char disksize[64]="";
+	get_value(name, disksize, "disksize");
+	if (disksize[0] == '0')
+		return 0;
+	return 1;
+}
+
+static inline void value2devparm(char *name, char *data, char *filename)
+{
+	char path[64] = "/sys/block/";
+	strncat(path, name, 8);
+	strncat(path,"/", 2);
+	strncat(path, filename, 32);
+	path_write_str(data, path);
+}
+
+static inline void fill_table_row(struct libscols_table *tb, char *name)
+{
+	char disksize[32]="";
+	char orig_data_size[32]="";
+	char compr_data_size[32]="";
+	char comp_algorithm[16]="";
+	char max_comp_streams[32]="";
+	static struct libscols_line *ln;
+
+	enum {
+		COL_NAME,
+		COL_DISKSIZE,
+		COL_ORIG_DATA_SIZE,
+		COMPR_DATA_SIZE,
+		COMP_ALGORITHM,
+		MAX_COMP_STREAMS
+	};
+
+	get_value(name, disksize, "disksize");
+	get_value(name, orig_data_size, "orig_data_size");
+	get_value(name, compr_data_size, "compr_data_size");
+	get_value(name, comp_algorithm, "comp_algorithm");
+
+	if (strstr(comp_algorithm, "[lzo]") == NULL) {
+		if (strstr(comp_algorithm, "[lz4]") == NULL)
+			strncpy(comp_algorithm,"-", 2);
+		else
+			strncpy(comp_algorithm, "lz4", 4);
+	} else
+		strncpy(comp_algorithm, "lzo", 4);
+
+	get_value(name, max_comp_streams, "max_comp_streams");
+
+	ln = scols_table_new_line(tb, NULL);
+	scols_line_set_data(ln, COL_NAME, name);
+	scols_line_set_data(ln, COL_DISKSIZE, disksize);
+	scols_line_set_data(ln, COL_ORIG_DATA_SIZE, orig_data_size);
+	scols_line_set_data(ln, COMPR_DATA_SIZE, compr_data_size);
+	scols_line_set_data(ln, COMP_ALGORITHM, comp_algorithm);
+	scols_line_set_data(ln, MAX_COMP_STREAMS, max_comp_streams);
+}
+
+static inline void status(char *dev)
+{
+	struct libscols_table *tb;
+
+	tb = scols_new_table();
+	scols_table_new_column(tb, "NAME", 0, SCOLS_FL_RIGHT);
+	scols_table_new_column(tb, "DISKSIZE", 1, SCOLS_FL_RIGHT);
+	scols_table_new_column(tb, "ORIG", 2, SCOLS_FL_RIGHT);
+	scols_table_new_column(tb, "COMPRESS", 3, SCOLS_FL_RIGHT);
+	scols_table_new_column(tb, "ALG", 4, SCOLS_FL_RIGHT);
+	scols_table_new_column(tb, "THR", 5, SCOLS_FL_RIGHT);
+
+	if (dev != NULL) {
+		fill_table_row(tb, dev);
+	} else {
+		for (int i=0;;i++) {
+			char name[8] = "zram";
+			char num[4];
+
+			sprintf(num,"%i",i);
+			strncat(name, num, 8);
+
+			if(!zram_exist(name))
+				break;
+
+			if(!used(name))
+				continue;
+			fill_table_row(tb, name);
+		}
+	}
+
+	scols_print_table(tb);
+	scols_unref_table(tb);
+	EXIT_SUCCESS;
+}
+
+static inline char *find_free_zram(void)
+{
+	char *ret;
+	for (unsigned i=0;;i++) {
+		char name[8] = "zram";
+		char num[4];
+
+		sprintf(num,"%i",i);
+		strncat(name, num, 4);
+		if (!zram_exist(name))
+			break;
+
+		// Avoid warning: return adress of local variable
+		ret = name;
+
+		if (used(ret) == 0)
+			return ret;
+	}
+	errx(EXIT_FAILURE, _("All device already in use"));
+}
+
+
+
+static inline void usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [-d zram<N>|-f] -s <size> -a lz4|lzo -t 
<number>\n"), "zramctl");
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -f, --find             find free device\n"), out);
+	fputs(_(" -d, --device <name>    specify device: zramX\n"), out);
+	fputs(_(" -r, --reset  <name>    reset specified device\n"), out);
+	fputs(_(" -s, --size <size>      device size: 131072, 1024M...\n"), out);
+	fputs(_(" -a, --alg lzo|lz4      compress algorithm\n"), out);
+	fputs(_(" -t, --threads <number> number of compress streams\n\n"), out);
+	fputs(_(" <no args>              return status of used devices\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("zramctl(8)"));
+	exit(out == stderr ? 1 : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	int c = 0;
+	char *dev = NULL;
+	char *size = NULL; // zram disk size
+	char *alg = NULL;  // compress algorithm lzo || lz4
+	char *threads = NULL;
+	unsigned f = 0;
+
+	static const struct option longopts[] = {
+		{"find", no_argument, NULL, 'f'},
+		{"device", required_argument, NULL, 'd'},
+		{"size", required_argument, NULL, 's'},
+		{"alg", required_argument, NULL, 'a'},
+		{"threads", required_argument, NULL, 't'},
+		{"reset", required_argument, NULL, 'r'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	static const ul_excl_t excl[] = {
+	{ 'd', 'f' },
+	{ 0 }
+	};
+
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, "fd:s:a:t:r:Vh", longopts, NULL)) 
!= -1) {
+
+		err_exclusive_options(c, longopts, excl, excl_st);
+
+		switch (c) {
+		case 'f':
+			f = 1;
+			dev = find_free_zram();
+			break;
+		case 'd':
+			dev = optarg;
+			break;
+		case 's':
+			size = optarg;
+			break;
+		case 'a':
+			if (!strcmp(optarg,"lzo") || !strcmp(optarg,"lz4"))
+				alg = optarg;
+			else
+				errx(EXIT_FAILURE,
+				     _("%s: supported lzo or lz4 only"),
+				     optarg);
+			break;
+		case 't':
+			threads = optarg;
+			if (strtos64_or_err(threads, "-t <integer>") < 1) {
+				errx(EXIT_FAILURE,
+				     _("-t %s <- must be greater than zero"),
+				     threads);
+			}
+			break;
+		case 'r':
+			dev = optarg;
+			value2devparm(dev, "1", "reset");
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+	}
+
+	if (argc == 1)
+		status(dev);
+
+	if (argc == 3 && dev != NULL)
+		status(dev);
+
+	if (dev != NULL && size != NULL) {
+		value2devparm(dev, "1", "reset");
+		if (threads != NULL && strtos64_or_err(threads, "-t <integer>") > 1)
+			value2devparm(dev, threads, "max_comp_streams");
+
+		if (alg != NULL)
+			value2devparm(dev, alg, "comp_algorithm");
+
+		value2devparm(dev, size, "disksize");
+	}
+
+	if (dev != NULL && f > 0)
+		fprintf(stdout,_("%s\n"), dev);
+
+	return EXIT_SUCCESS;
+}
\ No newline at end of file
