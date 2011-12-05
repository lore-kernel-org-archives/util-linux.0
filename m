Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:59373 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334Ab1LEUMq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2011 15:12:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] partx: add BLKPG_RES_PARTITION support
Date: Mon,  5 Dec 2011 15:02:50 -0500
Message-Id: <1323115372-3983-2-git-send-email-psusi@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add new respart shell command and enhance partx update command to use
BLKPG_RES_PARTITION to resize an existing partition while it is in use.

Signed-off-by: Phillip Susi <psusi@cfl.rr.com>
---
 partx/Makefile.am |    4 ++--
 partx/partx.c     |    9 +++++++++
 partx/partx.h     |   19 +++++++++++++++++++
 partx/respart.8   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 partx/respart.c   |   31 +++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 partx/respart.8
 create mode 100644 partx/respart.c

diff --git a/partx/Makefile.am b/partx/Makefile.am
index 080bc47..ce6fd5a 100644
--- a/partx/Makefile.am
+++ b/partx/Makefile.am
@@ -1,7 +1,7 @@
 include $(top_srcdir)/config/include-Makefile.am
 
-usrsbin_exec_PROGRAMS = addpart delpart
-dist_man_MANS = addpart.8 delpart.8
+usrsbin_exec_PROGRAMS = addpart delpart respart
+dist_man_MANS = addpart.8 delpart.8 respart.8
 
 usrsbin_exec_PROGRAMS += partx
 partx_SOURCES = partx.c partx.h \
diff --git a/partx/partx.c b/partx/partx.c
index 87443c4..2510ffb 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -467,6 +467,15 @@ static int upd_parts(int fd, const char *device, dev_t devno,
 		{
 			if (i < nparts)
 				i++;
+			if (err == -1 && errno == EBUSY)
+			{
+				/* try to resize */
+				err = partx_res_partition(fd, n, start, size);
+				if (verbose)
+					printf(_("%s: partition #%d resized\n"), device, n);
+				if (err == 0)
+					continue;
+			}
 			if (err == 0 && partx_add_partition(fd, n, start, size) == 0) {
 				if (verbose)
 					printf(_("%s: partition #%d added\n"), device, n);
diff --git a/partx/partx.h b/partx/partx.h
index b40fa8f..f85f75b 100644
--- a/partx/partx.h
+++ b/partx/partx.h
@@ -41,4 +41,23 @@ static inline int partx_add_partition(int fd, int partno,
 	return ioctl(fd, BLKPG, &a);
 }
 
+static inline int partx_res_partition(int fd, int partno,
+			unsigned long start, unsigned long size)
+{
+	struct blkpg_ioctl_arg a;
+	struct blkpg_partition p;
+
+	p.pno = partno;
+	p.start = start << 9;
+	p.length = size << 9;
+	p.devname[0] = 0;
+	p.volname[0] = 0;
+	a.op = BLKPG_RES_PARTITION;
+	a.flags = 0;
+	a.datalen = sizeof(p);
+	a.data = &p;
+
+	return ioctl(fd, BLKPG, &a);
+}
+
 #endif /*  UTIL_LINUX_PARTX_H */
diff --git a/partx/respart.8 b/partx/respart.8
new file mode 100644
index 0000000..2bbda0b
--- /dev/null
+++ b/partx/respart.8
@@ -0,0 +1,46 @@
+.\" addpart.8 --
+.\" Copyright 2007 Karel Zak <kzak@redhat.com>
+.\" Copyright 2007 Red Hat, Inc.
+.\" May be distributed under the GNU General Public License
+.TH ADDPART 8 "January 2007" "util-linux" "System Administration"
+.SH NAME
+respart \-
+simple wrapper around the "resize partition" ioctl
+.SH SYNOPSIS
+.B respart
+.I device partition start length
+.SH DESCRIPTION
+.B respart
+is a program that updates the Linux kernel's idea of where a partition
+is.  Currently only the length can be changed; the start location must
+be the same as what the kernel already thinks.  This works even on
+partitions that are mounted.  Most filesystems ( including ext4 )
+can grow online ( see .BR resize2fs ), but not shrink.  Shrinking
+the size of the partition to be less than the filesystem inside it
+will cause data loss.
+
+This command doesn't manipulate partitions on hard drive.
+
+.SH PARAMETERS
+.TP
+.I device
+Specify the disk device.
+.TP
+.I partition
+Specify the partition number.
+.TP
+.I start
+Specify the begin of the partition (in 512-byte sectors).
+.TP
+.I length
+Specify the length of the partition (in 512-byte sectors).
+
+.SH SEE ALSO
+.BR delpart (8),
+.BR fdisk (8),
+.BR parted (8),
+.BR partprobe (8),
+.BR partx (8)
+.SH AVAILABILITY
+The addpart command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/partx/respart.c b/partx/respart.c
new file mode 100644
index 0000000..27060a8
--- /dev/null
+++ b/partx/respart.c
@@ -0,0 +1,31 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+
+#include "partx.h"
+
+int
+main(int argc, char **argv)
+{
+	int fd;
+
+	if (argc != 5) {
+		fprintf(stderr,
+			"usage: %s diskdevice partitionnr start length\n",
+			argv[0]);
+		exit(1);
+	}
+	if ((fd = open(argv[1], O_RDONLY)) < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	if (partx_res_partition(fd, atoi(argv[2]),
+				atoll(argv[3]),
+				atoll(argv[4]))) {
+		perror("BLKPG");
+		exit(1);
+	}
+
+	return 0;
+}
-- 
1.7.5.4

