Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34198 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab1ISN3T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:19 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 057F58F54B
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:19 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/7] sfdisk: warn if partition exceeds partition table limits
Date: Mon, 19 Sep 2011 15:29:15 +0200
Message-Id: <1316438955-20790-8-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Warn the user if the partition to be created exceeds limits
imposed by the DOS partition table, which is:
* partition has to start on sector < 2^32
* partition size has to be < 2^32 sectors

For 512-byte logical sector size, these limits are ~2.2 TiB.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index d1ba9d6..db1a6d7 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -46,6 +46,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
+#include <limits.h>
 
 #include "c.h"
 #include "nls.h"
@@ -1195,7 +1196,7 @@ pnumber(struct part_desc *p, struct disk_desc *z) {
 }
 
 static int
-partitions_ok(struct disk_desc *z) {
+partitions_ok(int fd, struct disk_desc *z) {
     struct part_desc *partitions = &(z->partitions[0]), *p, *q;
     int partno = z->partno;
 
@@ -1282,6 +1283,43 @@ partitions_ok(struct disk_desc *z) {
 	    }
     }
 
+    int sector_size;
+    if (blkdev_get_sector_size(fd, &sector_size) == -1)
+	sector_size = DEFAULT_SECTOR_SIZE;
+
+    /* Is the size of partitions less than 2^32 sectors limit? */
+    for (p = partitions; p < partitions + partno; p++)
+	if (p->size > UINT_MAX) {
+	    unsigned long long bytes = p->size * sector_size;
+	    int giga = bytes / 1000000000;
+	    int hectogiga = (giga + 50) / 100;
+	    my_warn(_("Warning: partition %s has size %d.%d TB (%llu bytes),\n"
+		      "which is larger than the %llu bytes limit imposed\n"
+		      "by the DOS partition table for %d-byte sectors\n"),
+		    PNO(p), hectogiga / 10, hectogiga % 10,
+		    bytes,
+		    (unsigned long long) UINT_MAX * sector_size,
+		    sector_size);
+	    return 0;
+	}
+
+    /* Do the partitions start below the 2^32 sectors limit? */
+    for (p = partitions; p < partitions + partno; p++)
+	if (p->start > UINT_MAX) {
+	    unsigned long long bytes = p->start * sector_size;
+	    int giga = bytes / 1000000000;
+	    int hectogiga = (giga + 50) / 100;
+	    my_warn(_("Warning: partition %s starts at sector %llu (%d.%d TB for %d-byte sectors),\n"
+		      "which exceeds the DOS partition table limit of %llu sectors\n"),
+		    PNO(p),
+		    p->start,
+		    hectogiga / 10,
+		    hectogiga % 10,
+		    sector_size,
+		    (unsigned long long) UINT_MAX);
+	    return 0;
+	}
+
     /* At most one chain of DOS extended partitions ? */
     /* It seems that the OS/2 fdisk has the additional requirement
        that the extended partition must be the fourth one */
@@ -2875,7 +2913,7 @@ do_list(char *dev, int silent) {
 	out_partitions(dev, z);
 
     if (verify) {
-	if (partitions_ok(z))
+	if (partitions_ok(fd, z))
 	    my_warn(_("%s: OK\n"), dev);
 	else
 	    exit_status = 1;
@@ -3212,7 +3250,7 @@ do_fdisk(char *dev) {
 	printf(_("New situation:\n"));
 	out_partitions(dev, z);
 
-	if (!partitions_ok(z) && !force) {
+	if (!partitions_ok(fd, z) && !force) {
 	    if (!interactive)
 		fatal(_("I don't like these partitions - nothing changed.\n"
 			"(If you really want this, use the --force option.)\n"));
-- 
1.7.3.4

