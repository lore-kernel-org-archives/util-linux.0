Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:62985 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2HNHCv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Aug 2012 03:02:51 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] lib/sysfs: make sysfs_partno_to_devno better readable
Date: Tue, 14 Aug 2012 09:01:45 +0200
Message-Id: <1344927705-5866-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 lib/sysfs.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index b468e88..7b2c5f7 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -321,8 +321,8 @@ int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_nam
 }
 
 /*
- * Copnverts @partno (partition number) to devno of the partition. The @cxt
- * handles wholedisk device.
+ * Converts @partno (partition number) to devno of the partition.
+ * The @cxt handles wholedisk device.
  *
  * Note that this code does not expect any special format of the
  * partitions devnames.
@@ -345,13 +345,15 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
 			continue;
 
 		snprintf(path, sizeof(path), "%s/partition", d->d_name);
-		if (sysfs_read_int(cxt, path, &n) || n != partno)
+		if (sysfs_read_int(cxt, path, &n))
 			continue;
 
-		snprintf(path, sizeof(path), "%s/dev", d->d_name);
-		if (sysfs_scanf(cxt, path, "%d:%d", &maj, &min) == 2)
-			devno = makedev(maj, min);
-		break;
+		if (n == partno) {
+			snprintf(path, sizeof(path), "%s/dev", d->d_name);
+			if (sysfs_scanf(cxt, path, "%d:%d", &maj, &min) == 2)
+				devno = makedev(maj, min);
+			break;
+		}
 	}
 
 	closedir(dir);
-- 
1.7.7

