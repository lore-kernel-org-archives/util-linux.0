Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab2ILVtV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 17:49:21 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8CLnLpC001941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 17:49:21 -0400
From: Lukas Czerner <lczerner@redhat.com>
To: util-linux@vger.kernel.org, kzak@redhat.com
Cc: Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH] blkdiscard: add new command
Date: Wed, 12 Sep 2012 17:49:15 -0400
Message-Id: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

blkdiscard is used to discard device sectors. This is useful for
solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
fstrim this command is used directly on the block device.

blkkdiscard uses BLKDISCARD ioctl or BLKSECDISCARD ioctl for the secure
discard.

All data in the discarded region on the device will be lost!

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 .gitignore              |    1 +
 sys-utils/Makemodule.am |    5 ++
 sys-utils/blkdiscard.8  |   66 ++++++++++++++++++
 sys-utils/blkdiscard.c  |  173 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/blkdiscard.8
 create mode 100644 sys-utils/blkdiscard.c

diff --git a/.gitignore b/.gitignore
index 5be008f..a777d16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -96,6 +96,7 @@ tests/run.sh.trs
 /fsck.minix
 /fsfreeze
 /fstrim
+/blkdiscard
 /getopt
 /hexdump
 /hwclock
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index d376f04..a6e3c07 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -54,6 +54,11 @@ dist_man_MANS += sys-utils/fstrim.8
 fstrim_SOURCES = sys-utils/fstrim.c
 fstrim_LDADD = $(LDADD) libcommon.la
 
+sbin_PROGRAMS += blkdiscard
+dist_man_MANS += sys-utils/blkdiscard.8
+blkdiscard_SOURCES = sys-utils/blkdiscard.c
+blkdiscard_LDADD = $(LDADD) libcommon.la
+
 usrbin_exec_PROGRAMS += cytune
 dist_man_MANS += sys-utils/cytune.8
 cytune_SOURCES = sys-utils/cytune.c sys-utils/cyclades.h
diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
new file mode 100644
index 0000000..fcc38f6
--- /dev/null
+++ b/sys-utils/blkdiscard.8
@@ -0,0 +1,66 @@
+.\" -*- nroff -*-
+.TH BLKDISCARD 8 "September 2012" "util-linux" "System Administration"
+.SH NAME
+blkdiscard \- discard sectors on a device
+.SH SYNOPSIS
+.B blkdiscard
+.RB [ \-o
+.IR offset ]
+.RB [ \-l
+.IR length ]
+.RB [ \-s ]
+.RB [ \-v ]
+.I device
+
+.SH DESCRIPTION
+.B blkdiscard
+is used to discard device sectors. This is useful for solid-state
+drivers (SSDs) and thinly-provisioned storage. Unlike
+.BR fstrim (8)
+this command is used directly on the block device.
+.PP
+By default,
+.B blkdiscard
+will discard all blocks on the device. Options may be used to
+modify this behavior based on range or size, as explained below.
+.PP
+The
+.I device
+argument is the pathname of the block device.
+
+.B WARNING: All data in the discarded region on the device will be lost!
+
+.SH OPTIONS
+The \fIoffset\fR and \fIlength\fR arguments may be
+followed by the multiplicative suffixes KiB=1024, MiB=1024*1024, and so on for
+GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g. "K" has the same
+meaning as "KiB") or the suffixes KB=1000, MB=1000*1000, and so on for GB, PB,
+EB, ZB and YB.
+.IP "\fB\-h, \-\-help\fP"
+Print help and exit.
+.IP "\fB\-o, \-\-offset\fP \fIoffset\fP"
+Byte offset in the device from which to discard. Provided value will be
+aligned to the device sector size. Default value is zero.
+.IP "\fB\-l, \-\-length\fP \fIlength\fP"
+Number of bytes after starting point to discard. Provided value will be
+aligned to the device sector size. If the specified value extends past the
+end of the device,
+.B blkdiscard
+will stop at the device size boundary. Default value extends to the end
+of the device.
+.IP "\fB\-s, \-\-secure\fP"
+Perform secure discard. Secure discard is the same as regular discard except
+all copies of the discarded blocks possibly created by garbage collection must
+also be erased. It has to be supported by the device.
+.IP "\fB\-v, \-\-verbose\fP"
+Print aligned \fIoffset\fR and \fIlength\fR arguments.
+
+.SH AUTHOR
+.nf
+Lukas Czerner <lczerner@redhat.com>
+.fi
+.SH SEE ALSO
+.BR fstrim (8)
+.SH AVAILABILITY
+The blkdiscard command is part of the util-linux package and is available
+from ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
new file mode 100644
index 0000000..bdcd06e
--- /dev/null
+++ b/sys-utils/blkdiscard.c
@@ -0,0 +1,173 @@
+/*
+ * blkdiscard.c -- discard the part (or whole) of the block device.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All rights reserved.
+ * Written by Lukas Czerner <lczerner@redhat.com>
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
+ * This program uses BLKDISCARD ioctl to discard part or the whole block
+ * device if the device supports it. You can specify range (start and
+ * length) to be discarded, or simply discard the whole device.
+ */
+
+
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <getopt.h>
+
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <linux/fs.h>
+
+#include "nls.h"
+#include "strutils.h"
+#include "c.h"
+#include "closestream.h"
+
+#ifndef BLKDISCARD
+#define BLKDISCARD	_IO(0x12,119)
+#endif
+
+#ifndef BLKSECDISCARD
+#define BLKSECDISCARD	_IO(0x12,125)
+#endif
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <device>\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"
+		" -l, --length <num>  length of bytes to discard from the offset\n"
+		" -s, --secure        perform secure discard\n"
+		" -v, --verbose       print aligned length and offset\n"),
+		out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("blkdiscard(8)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	char *path;
+	int c, fd, verbose = 0, secure = 0;
+	uint64_t end, blksize, secsize, range[2];
+	struct stat sb;
+
+	static const struct option longopts[] = {
+	    { "help",      0, 0, 'h' },
+	    { "version",   0, 0, 'V' },
+	    { "offset",    1, 0, 'o' },
+	    { "length",    1, 0, 'l' },
+	    { "secure",    0, 0, 's' },
+	    { "verbose",   0, 0, 'v' },
+	    { NULL,        0, 0, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	range[0] = 0;
+	range[1] = ULLONG_MAX;
+
+	while ((c = getopt_long(argc, argv, "hVsvo:l:", longopts, NULL)) != -1) {
+		switch(c) {
+		case 'h':
+			usage(stdout);
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'l':
+			range[1] = strtosize_or_err(optarg,
+					_("failed to parse length"));
+			break;
+		case 'o':
+			range[0] = strtosize_or_err(optarg,
+					_("failed to parse offset"));
+			break;
+		case 's':
+			secure = 1;
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
+		errx(EXIT_FAILURE, _("no device specified."));
+
+	path = argv[optind++];
+
+	if (optind != argc) {
+		warnx(_("unexpected number of arguments"));
+		usage(stderr);
+	}
+
+	if (stat(path, &sb) == -1)
+		err(EXIT_FAILURE, _("stat failed %s"), path);
+	if (!S_ISBLK(sb.st_mode))
+		errx(EXIT_FAILURE, _("%s: not a block device"), path);
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), path);
+
+	if (ioctl(fd, BLKGETSIZE64, &blksize))
+		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
+
+	if (ioctl(fd, BLKSSZGET, &secsize))
+		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
+
+	/* align range to the sector size */
+	range[0] = (range[0] + secsize - 1) & ~(secsize - 1);
+	range[1] &= ~(secsize - 1);
+
+	/* is the range end behind the end of the device ?*/
+	end = range[0] + range[1];
+	if (end < range[0] || end > blksize)
+		range[1] = blksize - range[0];
+
+	if (secure) {
+		if (ioctl(fd, BLKSECDISCARD, &range))
+			err(EXIT_FAILURE, _("%s: BLKSECDISCARD ioctl failed"), path);
+	} else {
+		if (ioctl(fd, BLKDISCARD, &range))
+			err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
+	}
+
+	if (verbose)
+		/* TRANSLATORS: The standard value here is a very large number. */
+		printf(_("%s: Discarded %" PRIu64 " bytes from the "
+			 "offset %" PRIu64"\n"), path,
+			 (uint64_t) range[1], (uint64_t) range[0]);
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
-- 
1.7.7.6

