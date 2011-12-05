Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:59374 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab1LEUMq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2011 15:12:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] partx: add update command
Date: Mon,  5 Dec 2011 15:02:49 -0500
Message-Id: <1323115372-3983-1-git-send-email-psusi@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Update the kernel partition table to match what is on disk.  Remove any
extra partitions and add any missing ones.

Signed-off-by: Phillip Susi <psusi@cfl.rr.com>
---
 partx/partx.8 |    6 ++-
 partx/partx.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/partx/partx.8 b/partx/partx.8
index 4129d78..e67737a 100644
--- a/partx/partx.8
+++ b/partx/partx.8
@@ -9,7 +9,7 @@ partx \-
 tell the Linux kernel about the presence and numbering of on-disk partitions
 .SH SYNOPSIS
 .B partx
-.RB [ \-a | \-d | \-s ]
+.RB [ \-a | \-d | \-s | \-u ]
 .RB [ \-t
 .IR TYPE ]
 .RB [ \-n
@@ -18,7 +18,7 @@ tell the Linux kernel about the presence and numbering of on-disk partitions
 .I disk
 
 .B partx
-.RB [ \-a | \-d | \-s ]
+.RB [ \-a | \-d | \-s | \-u ]
 .RB [ \-t
 .IR TYPE ]
 .I partition
@@ -72,6 +72,8 @@ columns can be rearranged with the \fB\-\-output\fP option.
 .IP "\fB\-t, \-\-type \fItype\fP"
 Specify the partition table type -- aix, bsd, dos, gpt, mac, minix, sgi, solaris_x86,
 sun, ultrix or unixware.
+.IP "\fB\-u, \-\-update\fP"
+Update the specified partitions, or read the disk and update all partitions.
 .IP "\fB\-n, \-\-nr \fIM:N\fP"
 Specify the range of partitions.  For backward compatibility also the format
 <M-N> is supported.  The range may contain negative
diff --git a/partx/partx.c b/partx/partx.c
index d2fde3f..87443c4 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -55,6 +55,7 @@ enum {
 	ACT_LIST = 1,
 	ACT_SHOW,
 	ACT_ADD,
+	ACT_UPD,
 	ACT_DELETE
 };
 
@@ -402,6 +403,96 @@ static int add_parts(int fd, const char *device,
 	return rc;
 }
 
+static void upd_parts_warnx(const char *device, int first, int last)
+{
+	if (first == last)
+		warnx(_("%s: error updating partition %d"), device, first);
+	else
+		warnx(_("%s: error updating partitions %d-%d"),
+				device, first, last);
+}
+
+static int upd_parts(int fd, const char *device, dev_t devno,
+		     blkid_partlist ls, int lower, int upper)
+{
+	int i, n, an, nparts, rc = 0, errfirst = 0, errlast = 0, err;
+	blkid_partition par;
+	uintmax_t start, size;
+
+	assert(fd >= 0);
+	assert(device);
+	assert(ls);
+
+	nparts = blkid_partlist_numof_partitions(ls);
+	if (!lower)
+		lower = 1;
+	if (!upper || lower < 0 || upper < 0) {
+		n = get_max_partno(device, devno);
+		if (!upper)
+			upper = n > nparts ? n : nparts;
+		else if (upper < 0)
+			upper = n + upper + 1;
+		if (lower < 0)
+			lower = n + lower + 1;
+	}
+	if (lower > upper) {
+		warnx(_("specified range <%d:%d> "
+			"does not make sense"), lower, upper);
+		return -1;
+	}
+
+	for (i = 0, n = lower; n <= upper; n++) {
+		par = blkid_partlist_get_partition(ls, i);
+		an = blkid_partition_get_partno(par);
+
+		if (lower && n < lower)
+			continue;
+		if (upper && n > upper)
+			continue;
+
+		start = blkid_partition_get_start(par);
+		size =  blkid_partition_get_size(par);
+
+		if (blkid_partition_is_extended(par))
+			/*
+			 * Let's follow the Linux kernel and reduce
+			 * DOS extended partition to 1 or 2 sectors.
+			 */
+			size = min(size, (uintmax_t) 2);
+
+		err = partx_del_partition(fd, n);
+		if (err == -1 && errno == ENXIO)
+			err = 0; /* good, it already doesn't exist */
+		if (an == n)
+		{
+			if (i < nparts)
+				i++;
+			if (err == 0 && partx_add_partition(fd, n, start, size) == 0) {
+				if (verbose)
+					printf(_("%s: partition #%d added\n"), device, n);
+				continue;
+			}
+		}
+		if (err == 0)
+			continue;
+		rc = -1;
+		if (verbose)
+			warn(_("%s: updating partition #%d failed"), device, n);
+		if (!errfirst)
+			errlast = errfirst = n;
+		else if (errlast + 1 == n)
+			errlast++;
+		else {
+			upd_parts_warnx(device, errfirst, errlast);
+			errlast = errfirst = n;
+		}
+	}
+
+	if (errfirst)
+		upd_parts_warnx(device, errfirst, errlast);
+	return rc;
+}
+
 static int list_parts(blkid_partlist ls, int lower, int upper)
 {
 	int i, nparts;
@@ -657,6 +748,7 @@ int main(int argc, char **argv)
 		{ "show",	no_argument,       NULL, 's' },
 		{ "add",	no_argument,       NULL, 'a' },
 		{ "delete",	no_argument,	   NULL, 'd' },
+		{ "update",     no_argument,       NULL, 'u' },
 		{ "type",	required_argument, NULL, 't' },
 		{ "nr",		required_argument, NULL, 'n' },
 		{ "output",	required_argument, NULL, 'o' },
@@ -670,7 +762,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 
 	while ((c = getopt_long(argc, argv,
-				"abdglrsvn:t:o:Ph", long_opts, NULL)) != -1) {
+				"abdglrsuvn:t:o:Ph", long_opts, NULL)) != -1) {
 
 		switch(c) {
 		case 'a':
@@ -725,6 +817,9 @@ int main(int argc, char **argv)
 		case 't':
 			type = optarg;
 			break;
+		case 'u':
+			what = ACT_UPD;
+			break;
 		case 'v':
 			verbose = 1;
 			break;
@@ -879,6 +974,8 @@ int main(int argc, char **argv)
 			case ACT_ADD:
 				rc = add_parts(fd, wholedisk, ls, lower, upper);
 				break;
+			case ACT_UPD:
+				rc = upd_parts(fd, wholedisk, disk_devno, ls, lower, upper);
 			}
 		}
 		blkid_free_probe(pr);
-- 
1.7.5.4

