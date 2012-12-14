Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:51352 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab2LNUE4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Dec 2012 15:04:56 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] partx: add update command
Date: Fri, 14 Dec 2012 14:57:25 -0500
Message-Id: <1355515045-29814-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Update the kernel partition table to match what is on disk.  Remove any
extra partitions and add any missing ones.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 disk-utils/partx.8 |    6 ++-
 disk-utils/partx.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 6142bd0..6d945f0 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -8,9 +8,9 @@
 partx \- tell the Linux kernel about the presence and numbering of
 on-disk partitions
 .SH SYNOPSIS
-partx [\-a|\-d|\-s] [\-t TYPE] [\-n M:N] [\-] disk
+partx [\-a|\-d|\-s|\-u] [\-t TYPE] [\-n M:N] [\-] disk
 .br
-partx [\-a|\-d|\-s] [\-t TYPE] partition [disk]
+partx [\-a|\-d|\-s|\-u] [\-t TYPE] partition [disk]
 .SH DESCRIPTION
 Given a device or disk-image,
 .B partx
@@ -43,6 +43,8 @@ Add the specified partitions, or read the disk and add all partitions.
 Print the SIZE column in bytes rather than in human-readable format.
 .IP "\fB\-d\fR, \fB\-\-delete\fP"
 Delete the specified partitions or all partitions.
+.IP "\fB\-u\fR, \fB\-\-update\fP"
+Update the specified partitions.
 .IP "\fB\-g\fR, \fB\-\-noheadings\fP"
 Do not print a header line.
 .IP "\fB\-h\fR, \fB\-\-help\fP"
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 9091579..45bf773 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -59,6 +59,7 @@ enum {
 	ACT_LIST,
 	ACT_SHOW,
 	ACT_ADD,
+	ACT_UPD,
 	ACT_DELETE
 };
 
@@ -402,6 +403,105 @@ static int add_parts(int fd, const char *device,
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
+			if (err == -1 && errno == EBUSY)
+			{
+				/* try to resize */
+				err = partx_resize_partition(fd, n, start, size);
+				if (verbose)
+					printf(_("%s: partition #%d resized\n"), device, n);
+				if (err == 0)
+					continue;
+			}
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
@@ -600,7 +700,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [-a|-d|-s] [--nr <n:m> | <partition>] <disk>\n"),
+	      _(" %s [-a|-d|-s|-u] [--nr <n:m> | <partition>] <disk>\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
@@ -608,7 +708,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" -d, --delete         delete specified partitions or all of them\n"
 		" -l, --list           list partitions (DEPRECATED)\n"
 		" -s, --show           list partitions\n\n"
-
+		" -u, --update         update specified partitions or all of them\n"
 		" -b, --bytes          print SIZE in bytes rather than in human readable format\n"
 		" -g, --noheadings     don't print headings for --show\n"
 		" -n, --nr <n:m>       specify the range of partitions (e.g. --nr 2:4)\n"
@@ -650,6 +750,7 @@ int main(int argc, char **argv)
 		{ "show",	no_argument,       NULL, 's' },
 		{ "add",	no_argument,       NULL, 'a' },
 		{ "delete",	no_argument,	   NULL, 'd' },
+		{ "update",     no_argument,       NULL, 'u' },
 		{ "type",	required_argument, NULL, 't' },
 		{ "nr",		required_argument, NULL, 'n' },
 		{ "output",	required_argument, NULL, 'o' },
@@ -672,7 +773,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"abdglrsvn:t:o:PhV", long_opts, NULL)) != -1) {
+				"abdglrsuvn:t:o:PhV", long_opts, NULL)) != -1) {
 
 		err_exclusive_options(c, long_opts, excl, excl_st);
 
@@ -713,6 +814,9 @@ int main(int argc, char **argv)
 		case 't':
 			type = optarg;
 			break;
+		case 'u':
+			what = ACT_UPD;
+			break;
 		case 'v':
 			verbose = 1;
 			break;
@@ -870,6 +974,8 @@ int main(int argc, char **argv)
 			case ACT_ADD:
 				rc = add_parts(fd, wholedisk, ls, lower, upper);
 				break;
+			case ACT_UPD:
+				rc = upd_parts(fd, wholedisk, disk_devno, ls, lower, upper);
 			case ACT_NONE:
 				break;
 			default:
-- 
1.7.9.5

