Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f49.google.com ([209.85.128.49]:38746 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaAMUcy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 13 Jan 2014 15:32:54 -0500
Received: by mail-qe0-f49.google.com with SMTP id w4so4707014qeb.22
        for <util-linux@vger.kernel.org>; Mon, 13 Jan 2014 12:32:54 -0800 (PST)
Date: Mon, 13 Jan 2014 15:32:49 -0500 (EST)
From: Scott Moser <smoser@ubuntu.com>
To: util-linux@vger.kernel.org
cc: Philip Susi <psusi@ubuntu.com>
Subject: [PATCH] fix partx --update ranges and out of order tables
Message-ID: <alpine.DEB.2.02.1401131526340.5329@brickies>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

partx --update DEVICE NUMBER
was broken in 2 cases:
 * if NUMBER != 1
 * if the partition table was "out of order".
   Ie, where sda2 came after sda3.

fixes http://pad.lv/1244662.
See bug for example recreates.

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 880d779..df03e59 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -412,10 +412,41 @@ static void upd_parts_warnx(const char *device, int first, int last)
 				device, first, last);
 }

+/**
+ * get_partition_by_partno:
+ * @ls: partitions list
+ * @n: the partition number (e.g. 'N' from sda'N')
+ *
+ * This does not assume any order of the input blkid_partlist.
+ * And correctly handles "out of order" partition tables.
+ * partition N is located after partition N+1 on the disk.
+ *
+ * Returns: partition object or NULL in case or error.
+ */
+blkid_partition get_partition_by_partno(blkid_partlist ls, int n)
+{
+	int i, nparts;
+	blkid_partition par;
+	if (!ls)
+		return NULL;
+
+	nparts = blkid_partlist_numof_partitions(ls);
+	if (nparts < 0)
+		return NULL;
+
+	for (i = 0; i < nparts; i++) {
+		par = blkid_partlist_get_partition(ls, i);
+		if (n == blkid_partition_get_partno(par)) {
+			return par;
+		}
+	}
+	return NULL;
+}
+
 static int upd_parts(int fd, const char *device, dev_t devno,
 		     blkid_partlist ls, int lower, int upper)
 {
-	int i, n, an, nparts, rc = 0, errfirst = 0, errlast = 0, err;
+	int n, nparts, rc = 0, errfirst = 0, errlast = 0, err;
 	blkid_partition par;
 	uintmax_t start, size;

@@ -441,18 +472,16 @@ static int upd_parts(int fd, const char *device, dev_t devno,
 		return -1;
 	}

-	for (i = 0, n = lower; n <= upper; n++) {
-		par = blkid_partlist_get_partition(ls, i);
-		an = blkid_partition_get_partno(par);
-
-		if (lower && n < lower)
-			continue;
-		if (upper && n > upper)
+	for (n = lower; n <= upper; n++) {
+		par = get_partition_by_partno(ls, n);
+		if (!par) {
+			if (verbose)
+				warn(_("%s: no partition #%d"), device, n);
 			continue;
+		}

 		start = blkid_partition_get_start(par);
 		size =  blkid_partition_get_size(par);
-
 		if (blkid_partition_is_extended(par))
 			/*
 			 * Let's follow the Linux kernel and reduce
@@ -463,25 +492,21 @@ static int upd_parts(int fd, const char *device, dev_t devno,
 		err = partx_del_partition(fd, n);
 		if (err == -1 && errno == ENXIO)
 			err = 0; /* good, it already doesn't exist */
-		if (an == n)
+		if (err == -1 && errno == EBUSY)
 		{
-			if (i < nparts)
-				i++;
-			if (err == -1 && errno == EBUSY)
-			{
-				/* try to resize */
-				err = partx_resize_partition(fd, n, start, size);
-				if (verbose)
-					printf(_("%s: partition #%d resized\n"), device, n);
-				if (err == 0)
-					continue;
-			}
-			if (err == 0 && partx_add_partition(fd, n, start, size) == 0) {
-				if (verbose)
-					printf(_("%s: partition #%d added\n"), device, n);
+			/* try to resize */
+			err = partx_resize_partition(fd, n, start, size);
+			if (verbose)
+				printf(_("%s: partition #%d resized\n"), device, n);
+			if (err == 0)
 				continue;
-			}
 		}
+		if (err == 0 && partx_add_partition(fd, n, start, size) == 0) {
+			if (verbose)
+				printf(_("%s: partition #%d added\n"), device, n);
+			continue;
+		}
+
 		if (err == 0)
 			continue;
 		rc = -1;
