Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 06/13] sfdisk: remove declaraion of 'partname()'
Date: Tue, 22 Jul 2014 16:44:50 -0700
Message-Id: <1406072697-20912-7-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 84 +++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index af90c54..96f4d82 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -62,8 +62,6 @@ static struct systypes i386_sys_types[] = {
 #include "pt-mbr-partnames.h"
 };
 
-static char *partname(char *dev, int pno, int lth);
-
 /*
  * Table of contents:
  *  A. About seeking
@@ -95,6 +93,46 @@ char *save_sector_file = NULL;
 char *restore_sector_file = NULL;
 
 /*
+ * return partition name - uses static storage unless buf is supplied
+ */
+static char *partname(char *dev, int pno, int lth)
+{
+	static char bufp[PATH_MAX];
+	char *p;
+	int w, wp;
+
+	w = strlen(dev);
+	p = "";
+
+	if (isdigit(dev[w-1]))
+		p = "p";
+
+	/* devfs kludge - note: fdisk partition names are not supposed
+	   to equal kernel names, so there is no reason to do this */
+	if (strcmp (dev + w - 4, "disc") == 0) {
+		w -= 4;
+		p = "part";
+	}
+
+	/* udev names partitions by appending -partN
+	   e.g. ata-SAMSUNG_SV8004H_0357J1FT712448-part1 */
+	if ((strncmp(dev, _PATH_DEV_BYID, strlen(_PATH_DEV_BYID)) == 0) ||
+	    strncmp(dev, _PATH_DEV_BYPATH, strlen(_PATH_DEV_BYPATH)) == 0) {
+		p = "-part";
+	}
+
+	wp = strlen(p);
+
+	if (lth) {
+		snprintf(bufp, sizeof(bufp), "%*.*s%s%-2u",
+			 lth-wp-2, w, dev, p, pno);
+	} else {
+		snprintf(bufp, sizeof(bufp), "%.*s%s%-2u", w, dev, p, pno);
+	}
+	return bufp;
+}
+
+/*
  *  A. About seeking
  */
 
@@ -3094,45 +3132,3 @@ do_fdisk(char *dev) {
 
 	sync();			/* superstition */
 }
-
-
-/*
- * return partition name - uses static storage unless buf is supplied
- */
-static char *partname(char *dev, int pno, int lth)
-{
-	static char bufp[PATH_MAX];
-	char *p;
-	int w, wp;
-
-	w = strlen(dev);
-	p = "";
-
-	if (isdigit(dev[w-1]))
-		p = "p";
-
-	/* devfs kludge - note: fdisk partition names are not supposed
-	   to equal kernel names, so there is no reason to do this */
-	if (strcmp (dev + w - 4, "disc") == 0) {
-		w -= 4;
-		p = "part";
-	}
-
-	/* udev names partitions by appending -partN
-	   e.g. ata-SAMSUNG_SV8004H_0357J1FT712448-part1 */
-	if ((strncmp(dev, _PATH_DEV_BYID, strlen(_PATH_DEV_BYID)) == 0) ||
-	    strncmp(dev, _PATH_DEV_BYPATH, strlen(_PATH_DEV_BYPATH)) == 0) {
-		p = "-part";
-	}
-
-	wp = strlen(p);
-
-	if (lth) {
-		snprintf(bufp, sizeof(bufp), "%*.*s%s%-2u",
-			 lth-wp-2, w, dev, p, pno);
-	} else {
-		snprintf(bufp, sizeof(bufp), "%.*s%s%-2u", w, dev, p, pno);
-	}
-	return bufp;
-}
-
-- 
1.8.1.4
