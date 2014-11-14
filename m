Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f173.google.com ([209.85.217.173]:54402 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaKNFYQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Nov 2014 00:24:16 -0500
Received: by mail-lb0-f173.google.com with SMTP id n15so12342902lbi.32
        for <util-linux@vger.kernel.org>; Thu, 13 Nov 2014 21:24:14 -0800 (PST)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH] libfdisk: fix get_partition_unused_primary()
Date: Fri, 14 Nov 2014 11:27:16 +0600
Message-Id: <1415942836-1248-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Was:
Mentioned function returns -1 if adding of primary partition is
impossible. Caller treats this value as size_t (res variable) and then
compares it for negative values, totally ignoring errors.

Becomes:
Now function takes address to variable and fills it with partition
number. Caller treats return value as int and use it appropriately.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 libfdisk/src/dos.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index b4456a9..0edb5fd 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -186,24 +186,28 @@ static int is_cleared_partition(struct dos_partition *p)
 }
 
 static int get_partition_unused_primary(struct fdisk_context *cxt,
-					struct fdisk_partition *pa)
+					struct fdisk_partition *pa,
+					size_t *partno)
 {
-	size_t org = cxt->label->nparts_max, n;
+	size_t org, n;
 	int rc;
 
+	assert(cxt);
+	assert(cxt->label);
+	assert(partno);
+
+	org = cxt->label->nparts_max;
+
 	cxt->label->nparts_max = 4;
 	rc = fdisk_partition_next_partno(pa, cxt, &n);
 	cxt->label->nparts_max = org;
 
-	switch (rc) {
-	case 1:
+	if (rc == 1) {
 		fdisk_info(cxt, _("All primary partitions have been defined already."));
 		return -1;
-	case 0:
-		return n;
-	default:
-		return rc;
 	}
+	*partno = rc == 0 ? n : rc;
+	return 0;
 }
 
 static int seek_sector(struct fdisk_context *cxt, sector_t secno)
@@ -1464,8 +1468,8 @@ static int dos_add_partition(struct fdisk_context *cxt,
 			fdisk_warnx(cxt, _("Extended partition already exists."));
 			return -EINVAL;
 		}
-		res = get_partition_unused_primary(cxt, pa);
-		if (res >= 0) {
+		rc = get_partition_unused_primary(cxt, pa, &res);
+		if (rc == 0) {
 			rc = add_partition(cxt, res, pa);
 			goto done;
 		}
@@ -1473,8 +1477,8 @@ static int dos_add_partition(struct fdisk_context *cxt,
 	/* pa specifies start, but outside extended partition */
 	} else if (pa && fdisk_partition_has_start(pa) && l->ext_offset) {
 		DBG(LABEL, ul_debug("DOS: pa template %p: add primary", pa));
-		res = get_partition_unused_primary(cxt, pa);
-		if (res >= 0) {
+		rc = get_partition_unused_primary(cxt, pa, &res);
+		if (rc == 0) {
 			rc = add_partition(cxt, res, pa);
 			goto done;
 		}
@@ -1531,8 +1535,8 @@ static int dos_add_partition(struct fdisk_context *cxt,
 	} else if (cxt->label->nparts_max >= MAXIMUM_PARTS) {
 		fdisk_info(cxt, _("All logical partitions are in use. "
 				  "Adding a primary partition."));
-		res = get_partition_unused_primary(cxt, pa);
-		if (res >= 0)
+		rc = get_partition_unused_primary(cxt, pa, &res);
+		if (rc == 0)
 			rc = add_partition(cxt, res, pa);
 	} else {
 		char hint[BUFSIZ];
@@ -1541,8 +1545,8 @@ static int dos_add_partition(struct fdisk_context *cxt,
 
 		/* the default layout for scripts is to create primary partitions */
 		if (cxt->script) {
-			res = get_partition_unused_primary(cxt, pa);
-			if (res >= 0)
+			rc = get_partition_unused_primary(cxt, pa, &res);
+			if (rc == 0)
 				rc = add_partition(cxt, res, pa);
 			goto done;
 		}
@@ -1573,16 +1577,16 @@ static int dos_add_partition(struct fdisk_context *cxt,
 		fdisk_free_ask(ask);
 
 		if (c == 'p') {
-			res = get_partition_unused_primary(cxt, pa);
-			if (res >= 0)
+			rc = get_partition_unused_primary(cxt, pa, &res);
+			if (rc == 0)
 				rc = add_partition(cxt, res, pa);
 			goto done;
 		} else if (c == 'l' && l->ext_offset) {
 			rc = add_logical(cxt, pa, &res);
 			goto done;
 		} else if (c == 'e' && !l->ext_offset) {
-			res = get_partition_unused_primary(cxt, pa);
-			if (res >= 0) {
+			rc = get_partition_unused_primary(cxt, pa, &res);
+			if (rc == 0) {
 				struct fdisk_partition *xpa = NULL;
 				struct fdisk_parttype *t;
 
@@ -1607,7 +1611,7 @@ static int dos_add_partition(struct fdisk_context *cxt,
 done:
 	if (rc == 0) {
 		cxt->label->nparts_cur++;
-		if (partno && res >= 0)
+		if (partno)
 			*partno = res;
 	}
 	return rc;
-- 
2.1.1

