Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbeCES4M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Mar 2018 13:56:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B6FC72760
        for <util-linux@vger.kernel.org>; Mon,  5 Mar 2018 18:56:12 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-116-54.phx2.redhat.com [10.3.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB1C45D9CA
        for <util-linux@vger.kernel.org>; Mon,  5 Mar 2018 18:56:11 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/1] libblkid: ignore private Stratis devices
Date: Mon,  5 Mar 2018 12:56:11 -0600
Message-Id: <20180305185611.16667-2-tasleson@redhat.com>
In-Reply-To: <20180305185611.16667-1-tasleson@redhat.com>
References: <20180305185611.16667-1-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ref. 20e1c3dc03399d6988ef35dedc1364cfc12e9263

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 disk-utils/fdisk-list.c |  2 +-
 include/sysfs.h         |  2 +-
 lib/sysfs.c             | 39 +++++++++++++++++++++++++++++----------
 libblkid/src/probe.c    |  4 ++--
 libblkid/src/verify.c   |  2 +-
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/disk-utils/fdisk-list.c b/disk-utils/fdisk-list.c
index a46883d18..dd498a37f 100644
--- a/disk-utils/fdisk-list.c
+++ b/disk-utils/fdisk-list.c
@@ -334,7 +334,7 @@ char *next_proc_partition(FILE **f)
 		if (devno <= 0)
 			continue;
 
-		if (sysfs_devno_is_lvm_private(devno, NULL) ||
+		if (sysfs_devno_is_dm_private(devno, NULL) ||
 		    sysfs_devno_is_wholedisk(devno) <= 0)
 			continue;
 
diff --git a/include/sysfs.h b/include/sysfs.h
index 7e715ee85..9a72a2009 100644
--- a/include/sysfs.h
+++ b/include/sysfs.h
@@ -81,7 +81,7 @@ extern int sysfs_is_partition_dirent(DIR *dir, struct dirent *d,
 extern int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
             size_t len, dev_t *diskdevno);
 
-extern int sysfs_devno_is_lvm_private(dev_t devno, char **uuid);
+extern int sysfs_devno_is_dm_private(dev_t devno, char **uuid);
 extern int sysfs_devno_is_wholedisk(dev_t devno);
 
 extern int sysfs_scsi_get_hctl(struct sysfs_cxt *cxt, int *h,
diff --git a/lib/sysfs.c b/lib/sysfs.c
index b1b67c59f..099507881 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <regex.h>
 
 #include "c.h"
 #include "pathnames.h"
@@ -844,28 +845,46 @@ err:
 }
 
 /*
- * Returns 1 if the device is private LVM device. The @uuid (if not NULL)
+ * Returns 1 if the device is private device mapper device. The @uuid
+ * (if not NULL)
  * returns DM device UUID, use free() to deallocate.
  */
-int sysfs_devno_is_lvm_private(dev_t devno, char **uuid)
+int sysfs_devno_is_dm_private(dev_t devno, char **uuid)
 {
 	struct sysfs_cxt cxt = UL_SYSFSCXT_EMPTY;
 	char *id = NULL;
 	int rc = 0;
+	regex_t re;
 
 	if (sysfs_init(&cxt, devno, NULL) != 0)
 		return 0;
 
 	id = sysfs_strdup(&cxt, "dm/uuid");
 
-	/* Private LVM devices use "LVM-<uuid>-<name>" uuid format (important
-	 * is the "LVM" prefix and "-<name>" postfix).
-	 */
-	if (id && strncmp(id, "LVM-", 4) == 0) {
-		char *p = strrchr(id + 4, '-');
-
-		if (p && *(p + 1))
-			rc = 1;
+	if (id) {
+		/* Private LVM devices use "LVM-<uuid>-<name>" uuid format (important
+		 * is the "LVM" prefix and "-<name>" postfix).
+		 */
+		if (strncmp(id, "LVM-", 4) == 0) {
+			char *p = strrchr(id + 4, '-');
+
+			if (p && *(p + 1))
+				rc = 1;
+
+		} else if (strncmp(id, "stratis-", 8) == 0) {
+			/* Private Stratis devices will be those that start with "stratis-"
+			 * and that do not match the expected pattern for a thinly
+			 * provisioned device.
+			 */
+			if (!regcomp(&re,
+						"^stratis-1-[0-9a-f]{32}-thin-fs-[0-9a-f]{32}$",
+						REG_EXTENDED)) {
+				if (REG_NOMATCH == regexec(&re, id, 0, NULL, 0))
+					rc = 1;
+
+				regfree(&re);
+			}
+		}
 	}
 
 	sysfs_deinit(&cxt);
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 74eaffd2b..647ae416a 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -923,8 +923,8 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 		pr->flags |= BLKID_FL_TINY_DEV;
 
 	if (S_ISBLK(sb.st_mode) &&
-	    sysfs_devno_is_lvm_private(sb.st_rdev, &dm_uuid)) {
-		DBG(LOWPROBE, ul_debug("ignore private LVM device"));
+	    sysfs_devno_is_dm_private(sb.st_rdev, &dm_uuid)) {
+		DBG(LOWPROBE, ul_debug("ignore private device mapper device"));
 		pr->flags |= BLKID_FL_NOSCAN_DEV;
 	}
 
diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index d84894b10..7f44f5497 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -114,7 +114,7 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 		   (unsigned long)diff));
 #endif
 
-	if (sysfs_devno_is_lvm_private(st.st_rdev, NULL)) {
+	if (sysfs_devno_is_dm_private(st.st_rdev, NULL)) {
 		blkid_free_dev(dev);
 		return NULL;
 	}
-- 
2.13.6

