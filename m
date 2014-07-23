Return-Path: nefelim4ag@gmail.com
Message-ID: <53CFF0CC.4000608@gmail.com>
Date: Wed, 23 Jul 2014 20:28:44 +0300
From: Timofey Titovets <nefelim4ag@gmail.com>
MIME-Version: 1.0
To: Timofey Titovets <nefelim4ag@gmail.com>
CC: util-linux@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Karel Zak <kzak@redhat.com>
Subject: [RFC] [Patch] Created zramctl
References: <53CAAAB6.6020607@gmail.com>
In-Reply-To: <53CAAAB6.6020607@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Good time of day,
I spend some time and rewrite zramctl for util-linux.

Please review code and man pages, i think what i can do it better.
If you have any suggestion, say it out.

Can be pulled from:
https://github.com/Nefelim4ag/util-linux

For detail see man pages zramctl.8

----
  sys-utils/Makemodule.am |   5 +
  sys-utils/zramctl.8     |  92 ++++++++++++++
  sys-utils/zramctl.c     | 319 
++++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 416 insertions(+)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 68fd030..5d70c51 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -172,6 +172,11 @@ eject_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
  dist_man_MANS += sys-utils/eject.1
  endif

+sbin_PROGRAMS += zramctl
+dist_man_MANS += sys-utils/zramctl.8
+zramctl_SOURCES = sys-utils/zramctl.c
+zramctl_LDADD = $(LDADD) libcommon.la libsmartcols.la
+zramctl_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)

  if BUILD_LOSETUP
  sbin_PROGRAMS += losetup
diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
new file mode 100644
index 0000000..4da209d
--- /dev/null
+++ b/sys-utils/zramctl.8
@@ -0,0 +1,92 @@
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
+.RB { \-f\ [ \-d\ \fIzramdev\fP] }
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
+is used to fast setup zram devices parametrs, to reset zram devices and to
+query the status of a used zram devices.
+If no option is given, all zram devices are shown.
+
+
+.SH OPTIONS
+
+.IP "\fB\-s, \-\-size\fP \fIsize\fP
+force zram driver to reread size of the file associated with the 
specified zram device
++The \fIsize\fR arguments may be followed by the multiplicative
++suffixes 128K 512M, 1G.
+.IP "\fB\-r, \-\-reset\fP \fIzramdev\fP"
+Reset options specified zram device(s). Zram device setting can be 
changed only
+after reset.
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
+The following commands can be used as an example of using the zram device.
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
index 0000000..6ddee9b
--- /dev/null
+++ b/sys-utils/zramctl.c
@@ -0,0 +1,319 @@
+/*
+ * zramctl - purpose of it
+ *
+ * Copyright (c) 20nn  Example Commercial, Inc
+ * Written by Timofey Titovets <Nefelim4ag@gmail.com>
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+
+static inline int zram_exist(char *name)
+{
+	struct stat info;
+	char path[16] = "/dev/";
+	strncat(path, name, 8);
+	if(stat(path, &info) != 0 )
+		return 0;
+	if (info.st_mode&S_IFBLK)
+		return 1;
+	return 0;
+}
+
+static inline int read_file(char *path, char *data)
+{
+	FILE *file;
+	unsigned i = 0;
+	char ch = EOF;
+	char *p;
+	p = path; // hack for work fopen
+	file = fopen(p, "r");
+	if (file == NULL) {
+		fprintf(stderr,_("can't open !%s!\n"), path);
+		return -1;
+	}
+
+	while (1) {
+		ch = fgetc(file);
+		if (ch == EOF || ch == '\n')
+			break;
+		else
+			data[i]=ch;
+		i++;
+	}
+	fclose(file);
+
+	return 0;
+}
+
+static inline int used(char *name)
+{
+	char path_to_disksize[32] = "/sys/block/";
+	char disksize[32]="";
+	strncat(path_to_disksize, name, 8);
+	strncat(path_to_disksize, "/disksize", 9);
+	if(read_file(path_to_disksize, disksize) < 0)
+		return -1;
+
+	if (disksize[0] == '0')
+		return 0;
+
+	return 1;
+}
+
+static inline int get_value(char *name, char *data, char *filename)
+{
+	char path[48] = "/sys/block/";
+	strncat(path, name, 8);
+	strncat(path,"/", 2);
+	strncat(path, filename, 32);
+	return read_file(path, data);
+}
+
+static inline int write_file(char *path, char *data)
+{
+	FILE *file;
+	char *p = path;
+	file = fopen(p, "w");
+	if (file == NULL) {
+		fprintf(stderr,_("can't write to %s\n"), path);
+		return -1;
+	}
+	fwrite(data, strlen(data), 1, file);
+	if (fclose(file) != 0)
+		return -1;
+	return 1;
+}
+
+static inline int value2devparm(char *name, char *data, char *filename)
+{
+	char path[48] = "/sys/block/";
+	strncat(path, name, 8);
+	strncat(path,"/", 2);
+	strncat(path, filename, 32);
+	return write_file(path, data);
+}
+
+static inline int status(void)
+{
+	char disksize[32]="";
+	char orig_data_size[32]="";
+	char compr_data_size[32]="";
+	char comp_algorithm[6]="";
+	char max_comp_streams[12]="";
+	unsigned i;
+	char *table = "%6s %12s %10s %10s %4s %4s \n";
+	printf(table, "NAME","DISKSIZE","ORIG","COMPRES","ALG","THR");
+	for (i=0;;i++) {
+		char name[8] = "zram";
+		char num[4];
+		char *pos;
+		sprintf(num,"%i",i);
+		strncat(name, num, 8);
+		if(!zram_exist(name))
+			break;
+		if(!used(name))
+			continue;
+		get_value(name, disksize, "disksize");
+		get_value(name, orig_data_size, "orig_data_size");
+		get_value(name, compr_data_size, "compr_data_size");
+		get_value(name, comp_algorithm, "comp_algorithm");
+		pos = strstr(comp_algorithm, "[lzo]");
+		if (pos == NULL) {
+			pos = strstr(comp_algorithm, "[lz4]");
+			if (pos == NULL)
+				strncpy(comp_algorithm,"-", 2);
+			else
+				strncpy(comp_algorithm, "lz4", 4);
+		} else
+			strncpy(comp_algorithm, "lzo", 4);
+		get_value(name, max_comp_streams, "max_comp_streams");
+		printf(table,
+			name,
+			disksize,
+			orig_data_size,
+			compr_data_size,
+			comp_algorithm,
+			max_comp_streams
+		      );
+	}
+
+	return 0;
+	goto fail;
+fail:
+	printf("Zram module not loaded");
+	return -1;
+}
+
+static inline char *find(void)
+{
+	char *ret = NULL;
+	for (unsigned i=0;;i++) {
+		char name[8] = "zram";
+		char num[4];
+
+		sprintf(num,"%i",i);
+		strncat(name, num, 4);
+		if (!zram_exist(name))
+			break;
+		else	//if enough one dir founded -> module loaded
+			ret = "USED";
+
+		if (used(name) == 0) {
+			ret = name;
+			break;
+		}
+	}
+
+		return ret;
+}
+
+
+
+static inline void usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [-d zramX|-f] -s 64M -a lz4 -t 16\n"), "zramctl");
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" <no args>             return status of used devices\n"), out);
+	fputs(_(" -f, --find            find free device\n"), out);
+	fputs(_(" -d, --device [name]   specify device: zramX\n"), out);
+	fputs(_(" -r, --reset  [name]   reset specified device\n"), out);
+	fputs(_(" -s, --size [size]     device size: 131072, 1024M...\n"), out);
+	fputs(_(" -a, --alg [lzo|lz4]   compress algorithm\n"), out);
+	fputs(_(" -t, --threads [0<num] number of compress streams\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("zramctl(8)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	int c = 0;
+	char *dev = NULL;
+	char *size = NULL;
+	char *alg = NULL;
+	char threads[5] = "1";
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
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, "fd:s:a:t:r:Vh", longopts, NULL)) 
!= -1) {
+		switch (c) {
+		case 'f':
+			if (dev != NULL) {
+				fprintf(stderr,_("-f || -d <name>\n"));
+				return 1;
+			}
+			f = 1;
+			dev = find();
+			break;
+		case 'd':
+			if (dev != NULL) {
+				fprintf(stderr,_("-f || -d <name>\n"));
+				return 1;
+			}
+			dev = optarg;
+			break;
+		case 's':
+			size = optarg;
+			break;
+		case 'a':
+			if (!strcmp(optarg,"lzo") || !strcmp(optarg,"lz4"))
+				alg = optarg;
+			else {
+				fprintf(stderr,_("%s != lzo|lz4\n"),alg );
+				return 1;
+			}
+			break;
+		case 't':
+			strncpy(threads, optarg, 5);
+			if (atoi(threads) < 1) {
+				usage(stderr);
+				return 1;
+			}
+			break;
+		case 'r':
+			dev = optarg;
+			if (value2devparm(dev, "1", "reset") < 0)
+				return 1;
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
+	if (argc == 1) {
+		status();
+		return EXIT_SUCCESS;
+	}
+
+	if (!strcmp(dev, "USED")) {
+		fprintf(stderr,_("all device already used\n") );
+		return 1;
+	}
+
+	if (dev != NULL && size != NULL) {
+		if (value2devparm(dev, "1", "reset") < 0)
+			return 1;
+		if (atoi(threads) > 1)
+
+			if (value2devparm(dev, threads, "max_comp_streams") < 0)
+				return 1;
+		if (alg != NULL)
+			if (value2devparm(dev, alg, "comp_algorithm") < 0)
+				return 1;
+
+		if (value2devparm(dev, size, "disksize") < 0)
+			return 1;
+	} else {
+	}
+
+	if (dev != NULL && f > 0)
+		fprintf(stdout,_("%s\n"), dev);
+
+	return EXIT_SUCCESS;
+}
\ No newline at end of file
