Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:61523 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaHCORt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:17:49 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so6390235wgh.11
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:17:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/7] zramctl: print all devices as a default action
Date: Sun,  3 Aug 2014 15:17:37 +0100
Message-Id: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit makes the command to display information about all zram
devices when the command is ran without any arguments.  Listing includes
the devices that are unused, which in this context means devices that
does not have --size specified, making them to be zero size.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index a26cd8e..04744fd 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -193,18 +193,18 @@ static int zram_set_strparm(struct zram *z, const char *attr, const char *str)
 }
 
 
-static int zram_used(struct zram *z)
+static int zram_used(struct zram *z, int find_unused)
 {
 	uint64_t size;
 	struct sysfs_cxt *sysfs = zram_get_sysfs(z);
 
-	if (sysfs &&
-	    sysfs_read_u64(sysfs, "disksize", &size) == 0 &&
-	    size > 0) {
-
+	if (sysfs && sysfs_read_u64(sysfs, "disksize", &size) == 0) {
+		if (find_unused && size == 0)
+			goto unused;
 		DBG(fprintf(stderr, "%s used", z->devname));
 		return 1;
 	}
+ unused:
 	DBG(fprintf(stderr, "%s unused", z->devname));
 	return 0;
 }
@@ -220,7 +220,7 @@ static struct zram *find_free_zram(void)
 		zram_set_devname(z, NULL, i);
 		if (!zram_exist(z))
 			break;
-		isfree = !zram_used(z);
+		isfree = !zram_used(z, 1);
 	}
 	if (!isfree) {
 		free_zram(z);
@@ -344,12 +344,11 @@ static void status(struct zram *z)
 	else {
 		size_t i;			/* list all used devices */
 		z = new_zram(NULL);
-
 		for (i = 0; ; i++) {
 			zram_set_devname(z, NULL, i);
 			if (!zram_exist(z))
 				break;
-			if (zram_used(z))
+			if (zram_used(z, 0))
 				fill_table_row(tb, z);
 		}
 		free_zram(z);
@@ -511,10 +510,12 @@ int main(int argc, char **argv)
 			columns[ncolumns++] = COL_STREAMS;
 			columns[ncolumns++] = COL_MOUNTPOINT;
 		}
-		if (optind < argc)
+		if (optind < argc) {
 			zram = new_zram(argv[optind++]);
-		status(zram);
-		free_zram(zram);
+			status(zram);
+			free_zram(zram);
+		} else
+			status(NULL);
 		break;
 	case A_RESET:
 		if (optind == argc)
-- 
2.0.3

