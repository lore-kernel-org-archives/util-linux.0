Return-Path: shaun.tancheff@gmail.com
Sender: Shaun Tancheff <shaun.tancheff@gmail.com>
From: Shaun Tancheff <shaun@tancheff.com>
To: Karel Zak <kzak@redhat.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, util-linux@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Date: Mon, 23 Jan 2017 20:32:42 +0700
Message-Id: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
List-ID: <util-linux.vger.kernel.org>

This patch adds:
 - blkreset to issue Reset (Write Pointer) zone commands
 - blkreport to retrieve drive zone information

Signed-off-by: Shaun Tancheff <shaun@tancheff.com>
---
Changes for v3:
  - Renamed get_zone_size -> blkdev_chunk_sectors
  - Use blkdev_get_sectors instead of open coded BLKGETSIZE64 (fixes broken
    byte to sector shift).

Changes for v2:
  - Configure changes to require linux/blkzoned.h [Linux v4.10]
  - Cleanup of man pages
  - Removed redundant fall-back for missing linux/blkzoned.h
  - Removed unused report option (not yet implemented by Linux kernel.
  - Change report length to be (maximum) number of zones returned.
---
 .gitignore              |   2 +
 configure.ac            |  11 +++
 include/strutils.h      |   2 +
 lib/strutils.c          |   7 +-
 sys-utils/Makemodule.am |  17 ++++
 sys-utils/blkreport.8   |  68 ++++++++++++++
 sys-utils/blkreport.c   | 245 ++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/blkreset.8    |  61 ++++++++++++
 sys-utils/blkreset.c    | 190 +++++++++++++++++++++++++++++++++++++
 9 files changed, 598 insertions(+), 5 deletions(-)
 create mode 100644 sys-utils/blkreport.8
 create mode 100644 sys-utils/blkreport.c
 create mode 100644 sys-utils/blkreset.8
 create mode 100644 sys-utils/blkreset.c

diff --git a/.gitignore b/.gitignore
index 2658dcd..c1e983b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,8 @@ update.log
 /addpart
 /agetty
 /blkdiscard
+/blkreport
+/blkreset
 /blkid
 /blockdev
 /cal
diff --git a/configure.ac b/configure.ac
index fa3e6c8..da721e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -276,6 +276,8 @@ AC_CHECK_HEADERS([security/pam_misc.h],
 #endif
 ])
 
+AC_CHECK_HEADERS([linux/blkzoned.h])
+
 AC_CHECK_HEADERS([security/openpam.h], [], [], [
 #ifdef HAVE_SECURITY_PAM_APPL_H
 #include <security/pam_appl.h>
@@ -288,6 +290,7 @@ AC_CHECK_HEADERS([langinfo.h],
 
 dnl Convert some ac_cv_header_* variables to have_*
 dnl
+have_linux_blkzoned_h=$ac_cv_header_linux_blkzoned_h
 have_linux_btrfs_h=$ac_cv_header_linux_btrfs_h
 have_linux_raw_h=$ac_cv_header_linux_raw_h
 have_linux_securebits_h=$ac_cv_header_linux_securebits_h
@@ -1564,6 +1567,14 @@ UL_BUILD_INIT([blkdiscard], [check])
 UL_REQUIRES_LINUX([blkdiscard])
 AM_CONDITIONAL([BUILD_BLKDISCARD], [test "x$build_blkdiscard" = xyes])
 
+UL_BUILD_INIT([blkreport], [check])
+UL_REQUIRES_HAVE([blkreport], [linux_blkzoned_h], [linux/blkzoned.h header])
+AM_CONDITIONAL([BUILD_BLKREPORT], [test "x$build_blkreport" = xyes])
+
+UL_BUILD_INIT([blkreset], [check])
+UL_REQUIRES_HAVE([blkreset], [linux_blkzoned_h], [linux/blkzoned.h header])
+AM_CONDITIONAL([BUILD_BLKRESET], [test "x$build_blkreset" = xyes])
+
 UL_BUILD_INIT([ldattach], [check])
 UL_REQUIRES_LINUX([ldattach])
 AM_CONDITIONAL([BUILD_LDATTACH], [test "x$build_ldattach" = xyes])
diff --git a/include/strutils.h b/include/strutils.h
index aa31fc9..9e13b2b 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -26,10 +26,12 @@ extern uint16_t strtox16_or_err(const char *str, const char *errmesg);
 extern int32_t strtos32_or_err(const char *str, const char *errmesg);
 extern uint32_t strtou32_or_err(const char *str, const char *errmesg);
 extern uint32_t strtox32_or_err(const char *str, const char *errmesg);
+extern uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base);
 
 extern int64_t strtos64_or_err(const char *str, const char *errmesg);
 extern uint64_t strtou64_or_err(const char *str, const char *errmesg);
 extern uint64_t strtox64_or_err(const char *str, const char *errmesg);
+extern uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base);
 
 extern double strtod_or_err(const char *str, const char *errmesg);
 
diff --git a/lib/strutils.c b/lib/strutils.c
index d3daa36..2f6285d 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -264,9 +264,6 @@ char *strndup(const char *s, size_t n)
 }
 #endif
 
-static uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base);
-static uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base);
-
 int16_t strtos16_or_err(const char *str, const char *errmesg)
 {
 	int32_t num = strtos32_or_err(str, errmesg);
@@ -310,7 +307,7 @@ int32_t strtos32_or_err(const char *str, const char *errmesg)
 	return num;
 }
 
-static uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base)
+uint32_t _strtou32_or_err(const char *str, const char *errmesg, int base)
 {
 	uint64_t num = _strtou64_or_err(str, errmesg, base);
 
@@ -352,7 +349,7 @@ err:
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 }
 
-static uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base)
+uint64_t _strtou64_or_err(const char *str, const char *errmesg, int base)
 {
 	uintmax_t num;
 	char *end = NULL;
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 88be83e..2d3fdb0 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -126,6 +126,23 @@ blkdiscard_SOURCES = sys-utils/blkdiscard.c lib/monotonic.c
 blkdiscard_LDADD = $(LDADD) libcommon.la $(REALTIME_LIBS)
 endif
 
+if BUILD_BLKREPORT
+sbin_PROGRAMS += blkreport
+dist_man_MANS += sys-utils/blkreport.8
+blkreport_SOURCES = sys-utils/blkreport.c
+blkreport_LDADD = $(LDADD) libcommon.la $(REALTIME_LIBS)
+endif
+
+if BUILD_BLKRESET
+sbin_PROGRAMS += blkreset
+dist_man_MANS += sys-utils/blkreset.8
+blkreset_SOURCES = sys-utils/blkreset.c
+blkreset_LDADD = $(LDADD) libcommon.la $(REALTIME_LIBS)
+if HAVE_UDEV
+blkreset_LDADD += -ludev
+endif
+endif
+
 if BUILD_LDATTACH
 usrsbin_exec_PROGRAMS += ldattach
 dist_man_MANS += sys-utils/ldattach.8
diff --git a/sys-utils/blkreport.8 b/sys-utils/blkreport.8
new file mode 100644
index 0000000..2e65e39
--- /dev/null
+++ b/sys-utils/blkreport.8
@@ -0,0 +1,68 @@
+.TH BLKREPORT 5 "March 2016" "util-linux" "System Administration"
+.SH NAME
+blkreport \- report zones on a device
+.SH SYNOPSIS
+.B blkreport
+[options]
+.RB [ \-z
+.IR zone ]
+.RB [ \-c
+.IR count ]
+.I device
+.SH DESCRIPTION
+.B blkreport
+is used to report device zone information.  This is useful for
+zoned devices that support the ZAC or ZBC command set.
+.PP
+By default,
+.B blkreport
+will report on up to 4k zones from the start of the block device.
+Options may be used to modify this behavior based on the starting zone or
+size of the report, as explained below.
+.PP
+The
+.I device
+argument is the pathname of the block device.
+.PP
+.SH OPTIONS
+The
+.I zone
+and
+.I count
+arguments may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+Additionally the common 0x prefix can be used to specify zone and length in hex.
+.TP
+.BR \-z , " \-\-zone \fIoffset", " \-\-offset \fIoffset"
+The starting zone of the report specified as a sector offset.
+The provided offset in sector units (512 bytes) should match the start of a zone.
+The default value is zero.
+.TP
+.BR \-c , " \-\-count \fIcount", " \-\-length \fIcount"
+The maximum number of zones to be returned by the report from the block device.
+Default is 4006, max is 65536
+.TP
+.BR \-v , " \-\-verbose"
+Display the number of zones returned in the report.
+.I offset
+and
+.IR length .
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
+.SH AUTHOR
+.MT shaun@tancheff.com
+Shaun Tancheff
+.ME
+.SH SEE ALSO
+.BR sg_rep_zones (8)
+.SH AVAILABILITY
+The blkreport command is part of the util-linux package and is available
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/sys-utils/blkreport.c b/sys-utils/blkreport.c
new file mode 100644
index 0000000..46c0377
--- /dev/null
+++ b/sys-utils/blkreport.c
@@ -0,0 +1,245 @@
+/*
+ * blkreport.c -- request a zone report on part (or all) of the block device.
+ *
+ * Copyright (C) 2015,2016 Seagate Technology PLC
+ * Written by Shaun Tancheff <shaun.tancheff@seagate.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This program uses BLKREPORT ioctl to query zone information about part of
+ * or a whole block device, if the device supports it.
+ * You can specify range (start and length) to be queried.
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <getopt.h>
+#include <time.h>
+
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <linux/fs.h>
+#include <linux/blkzoned.h>
+
+#include "nls.h"
+#include "strutils.h"
+#include "xalloc.h"
+#include "c.h"
+#include "closestream.h"
+#include "monotonic.h"
+
+static const char * type_text[] = {
+	"RESERVED",
+	"CONVENTIONAL",
+	"SEQ_WRITE_REQUIRED",
+	"SEQ_WRITE_PREFERRED",
+};
+
+#define ARRAY_COUNT(x) (sizeof((x))/sizeof((*x)))
+
+const char * condition_str[] = {
+	"cv", /* conventional zone */
+	"e0", /* empty */
+	"Oi", /* open implicit */
+	"Oe", /* open explicit */
+	"Cl", /* closed */
+	"x5", "x6", "x7", "x8", "x9", "xA", "xB", /* xN: reserved */
+	"ro", /* read only */
+	"fu", /* full */
+	"OL"  /* offline */
+	};
+
+static const char * zone_condition_str(uint8_t cond)
+{
+	return condition_str[cond & 0x0f];
+}
+
+static void print_zones(struct blk_zone *info, uint32_t count)
+{
+	uint32_t iter;
+
+	printf(_("Zones returned: %u\n"), count);
+
+	for (iter = 0; iter < count; iter++ ) {
+		struct blk_zone * entry = &info[iter];
+		unsigned int type  = entry->type;
+		uint64_t start = entry->start;
+		uint64_t wp = entry->wp;
+		uint8_t cond = entry->cond;
+		uint64_t len = entry->len;
+
+		if (!len)
+			break;
+
+		printf(_("  start: %9lx, len %6lx, wptr %6lx"
+			 " reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
+			start, len, wp - start,
+			entry->reset, entry->non_seq,
+			cond, zone_condition_str(cond),
+			type, type_text[type]);
+	}
+}
+
+static int do_report(int fd, uint64_t lba, uint32_t len, int verbose)
+{
+	int rc = -4;
+	struct blk_zone_report *zi;
+
+	zi = xmalloc(sizeof(struct blk_zone_report) + (len * sizeof(struct blk_zone)));
+	zi->nr_zones = len;
+	zi->sector = lba; /* maybe shift 4Kn -> 512e */
+	rc = ioctl(fd, BLKREPORTZONE, zi);
+	if (rc != -1) {
+		if (verbose)
+			printf(_("Found %d zones\n"), zi->nr_zones);
+		print_zones(zi->zones, zi->nr_zones);
+	} else {
+		warn(_("ERR: %d -> %s"), errno, strerror(errno));
+	}
+	free(zi);
+
+	return rc;
+}
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Discard the content of sectors on a device.\n"), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -z, --zone <num>    zone lba in 512 byte sectors\n"
+		"     --offset <num>  zone lba in 512 byte sectors\n"
+		" -c, --count <num>   maximum number of zones in report\n"
+		"     --length <num>  maximum number of zones in report\n"
+		" -v, --verbose       print aligned length and offset"),
+		out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("blkreport(8)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+#define DEF_REPORT_LEN		(1 << 12) /* 4k zones (256k kzalloc) */
+#define MAX_REPORT_LEN		(1 << 16) /* 64k zones */
+
+int main(int argc, char **argv)
+{
+	char *path;
+	int c;
+	int fd;
+	int secsize;
+	uint64_t blksize;
+	struct stat sb;
+	int verbose = 0;
+	uint64_t offset = 0ul;
+	uint32_t length = DEF_REPORT_LEN;
+	static const struct option longopts[] = {
+	    { "help",      0, 0, 'h' },
+	    { "version",   0, 0, 'V' },
+	    { "zone",      1, 0, 'z' }, /* starting LBA */
+	    { "offset",    1, 0, 'z' }, /* alias for zone */
+	    { "count",     1, 0, 'c' }, /* max #of zones (entries) for result */
+	    { "length",    1, 0, 'c' }, /* max #of zones (entries) for result */
+	    { "verbose",   0, 0, 'v' },
+	    { NULL,        0, 0, 0 }
+	};
+	const char *options = "hVc:z:v";
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, options, longopts, NULL)) != -1) {
+		switch(c) {
+		case 'h':
+			usage(stdout);
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'c':
+			length = _strtou32_or_err(optarg,
+					_("failed to parse report count"), 0);
+			break;
+		case 'z':
+			offset = _strtou64_or_err(optarg,
+					_("failed to parse zone offset"), 0);
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		default:
+			usage(stderr);
+			break;
+		}
+	}
+
+	if (optind == argc)
+		errx(EXIT_FAILURE, _("no device specified"));
+
+	path = argv[optind++];
+
+	if (optind != argc) {
+		warnx(_("unexpected number of arguments"));
+		usage(stderr);
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), path);
+
+	if (fstat(fd, &sb) == -1)
+		err(EXIT_FAILURE, _("stat of %s failed"), path);
+	if (!S_ISBLK(sb.st_mode))
+		errx(EXIT_FAILURE, _("%s: not a block device"), path);
+
+	if (ioctl(fd, BLKGETSIZE64, &blksize))
+		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
+	if (ioctl(fd, BLKSSZGET, &secsize))
+		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
+
+	/* check offset alignment to the sector size */
+	if (offset % secsize)
+		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned "
+			 "to sector size %i"), path, offset, secsize);
+
+	/* is the range end behind the end of the device ?*/
+	if (offset > blksize)
+		errx(EXIT_FAILURE, _("%s: offset is greater than device size"), path);
+
+	if (length < 1)
+		length = 1;
+	if (length > MAX_REPORT_LEN) {
+		length = MAX_REPORT_LEN;
+		warnx(_("limiting report to %u entries"), length);
+	}
+
+	if (do_report(fd, offset, length, verbose))
+		 err(EXIT_FAILURE, _("%s: BLKREPORTZONE ioctl failed"), path);
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/sys-utils/blkreset.8 b/sys-utils/blkreset.8
new file mode 100644
index 0000000..2c6c0a6
--- /dev/null
+++ b/sys-utils/blkreset.8
@@ -0,0 +1,61 @@
+.TH BLKRESET 5 "October 2016" "util-linux" "System Administration"
+.SH NAME
+blkreset \- Reset a range of zones
+.SH SYNOPSIS
+.B blkreset
+[options]
+.RB [ \-z
+.IR zone ]
+.RB [ \-c
+.IR count ]
+.SH DESCRIPTION
+.B blkreset
+is used to reset one or more zones.  This is useful for
+zoned devices that support the ZAC or ZBC command set.
+Unlike
+.BR sg_reset_wp (8) ,
+this command operates from the block layer and can reset a range of zones.
+.PP
+By default,
+.B blkreset
+will operate on the zone at device logical sector 0. Options may be used to
+modify this behavior as well as specify the operation to be performed on
+the zone, as explained below.
+.PP
+The
+.I device
+argument is the pathname of the block device.
+.PP
+.SH OPTIONS
+The
+.I zone
+argument may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+Additionally the common 0x prefix can be used to specify zone and length in hex.
+.TP
+.BR \-z , " \-\-zone \fIoffset" , " \-\-offset \fIoffset"
+The starting zone to be operated upon specified as a sector offset.
+The provided offset in sector units (512 bytes) should match the start of a zone.
+The default value is zero.
+.TP
+.BR \-c , " \-\-count \fIcount" , " \-\-length \fIcount"
+The number of zones to be reset starting from offset. Default is 1 zone.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
+.SH AUTHOR
+.MT shaun@tancheff.com
+Shaun Tancheff
+.ME
+.SH SEE ALSO
+.BR sg_reset_wp (8)
+.SH AVAILABILITY
+The blkreset command is part of the util-linux package and is available
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/sys-utils/blkreset.c b/sys-utils/blkreset.c
new file mode 100644
index 0000000..073d482
--- /dev/null
+++ b/sys-utils/blkreset.c
@@ -0,0 +1,190 @@
+/*
+ * blkreset.c -- Reset the WP on a range of zones.
+ *
+ * Copyright (C) 2015,2016 Seagate Technology PLC
+ * Written by Shaun Tancheff <shaun.tancheff@seagate.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This program uses BLKREPORT ioctl to query zone information about part of
+ * or a whole block device, if the device supports it.
+ * You can specify range (start and length) to be queried.
+ */
+
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <getopt.h>
+#include <time.h>
+#include <ctype.h>
+
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <linux/fs.h>
+#include <linux/major.h>
+#include <linux/blkzoned.h>
+
+#include "sysfs.h"
+#include "nls.h"
+#include "strutils.h"
+#include "c.h"
+#include "closestream.h"
+#include "monotonic.h"
+
+static unsigned long blkdev_chunk_sectors(const char *dname)
+{
+	struct sysfs_cxt cxt = UL_SYSFSCXT_EMPTY;
+	dev_t devno = sysfs_devname_to_devno(dname, NULL);
+	int major_no = major(devno);
+	int block_no = minor(devno) & ~0x0f;
+	uint64_t sz;
+
+	/*
+	 * Mapping /dev/sdXn -> /sys/block/sdX to read the chunk_size entry.
+	 * This method masks off the partition specified by the minor device
+	 * component.
+	 */
+	devno = makedev(major_no, block_no);
+	if (sysfs_init(&cxt, devno, NULL))
+		return 0;
+
+	if (sysfs_read_u64(&cxt, "queue/chunk_sectors", &sz) != 0)
+		warnx(_("%s: failed to read chunk size"), dname);
+
+	sysfs_deinit(&cxt);
+	return sz;
+}
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Discard the content of sectors on a device.\n"), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -z, --zone <num>  lba of start of zone to act upon\n"
+		" -c, --count       number of zones to reset (default = 1)"),
+		out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("blkreset(8)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+
+int main(int argc, char **argv)
+{
+	char *path;
+	int c, fd;
+	uint64_t blksize;
+	uint64_t blksectors;
+	struct stat sb;
+	struct blk_zone_range za;
+	uint64_t zsector = 0ul;
+	uint64_t zlen = 0;
+	uint64_t zcount = 1;
+	unsigned long zsize;
+	int rc = 0;
+
+	static const struct option longopts[] = {
+	    { "help",      0, 0, 'h' },
+	    { "version",   0, 0, 'V' },
+	    { "zone",      1, 0, 'z' },
+	    { "count",     1, 0, 'c' },
+	    { NULL,        0, 0, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, "hVz:c:", longopts, NULL)) != -1) {
+		switch(c) {
+		case 'h':
+			usage(stdout);
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'z':
+			zsector = _strtou64_or_err(optarg,
+					_("failed to parse zone offset"), 0);
+			break;
+		case 'c':
+			zcount = _strtou64_or_err(optarg,
+					_("failed to parse number of zones"), 0);
+			break;
+		default:
+			usage(stderr);
+			break;
+		}
+	}
+
+	if (optind == argc)
+		errx(EXIT_FAILURE, _("no device specified"));
+
+	path = argv[optind++];
+
+	if (optind != argc) {
+		warnx(_("unexpected number of arguments"));
+		usage(stderr);
+	}
+
+	zsize = blkdev_chunk_sectors(path);
+	if (zsize == 0)
+		err(EXIT_FAILURE, _("%s: Unable to determine zone size"), path);
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), path);
+
+	if (fstat(fd, &sb) == -1)
+		err(EXIT_FAILURE, _("stat of %s failed"), path);
+	if (!S_ISBLK(sb.st_mode))
+		errx(EXIT_FAILURE, _("%s: not a block device"), path);
+
+	if (blkdev_get_sectors(fd, &blksize))
+		err(EXIT_FAILURE, _("%s: blkdev_get_sectors ioctl failed"), path);
+
+	/* check offset alignment to the chunk size */
+	if (zsector & (zsize - 1))
+		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is not aligned "
+			 "to zone size %" PRIu64), path, zsector, zsize);
+	if (zsector > blksectors)
+		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is too large "
+			 "for device %" PRIu64), path, zsector, blksectors);
+
+	zlen = zcount * zsize;
+	if (zsector + zlen > blksectors)
+		zlen = blksectors - zsector;
+
+	za.sector = zsector;
+	za.nr_sectors = zlen;
+	rc = ioctl(fd, BLKRESETZONE, &za);
+	if (rc == -1)
+		err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), path);
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
-- 
2.7.4
