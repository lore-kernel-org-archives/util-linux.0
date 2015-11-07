Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36613 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbKGAkj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 6 Nov 2015 19:40:39 -0500
Received: by igdg1 with SMTP id g1so49575533igd.1
        for <util-linux@vger.kernel.org>; Fri, 06 Nov 2015 16:40:38 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: util-linux@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 2/2] losetup: support list direct io
Date: Sat,  7 Nov 2015 08:40:18 +0800
Message-Id: <1446856818-26532-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So that user can see if DIO is set for current loop device.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/loopdev.h   |  2 ++
 lib/loopdev.c       | 22 ++++++++++++++++++++++
 sys-utils/losetup.c |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/include/loopdev.h b/include/loopdev.h
index 9a7f6ba..18ca41f 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -40,6 +40,7 @@ enum {
 	LO_FLAGS_USE_AOPS   = 2,
 	LO_FLAGS_AUTOCLEAR  = 4,	/* kernel >= 2.6.25 */
 	LO_FLAGS_PARTSCAN   = 8,	/* kernel >= 3.2 */
+	LO_FLAGS_DIRECT_IO  = 16,	/* kernel >= 4.2 */
 };
 
 #define LO_NAME_SIZE	64
@@ -181,6 +182,7 @@ extern int loopcxt_get_encrypt_type(struct loopdev_cxt *lc, uint32_t *type);
 extern const char *loopcxt_get_crypt_name(struct loopdev_cxt *lc);
 extern int loopcxt_is_autoclear(struct loopdev_cxt *lc);
 extern int loopcxt_is_readonly(struct loopdev_cxt *lc);
+extern int loopcxt_is_dio(struct loopdev_cxt *lc);
 extern int loopcxt_is_partscan(struct loopdev_cxt *lc);
 extern int loopcxt_find_by_backing_file(struct loopdev_cxt *lc,
 				const char *filename,
diff --git a/lib/loopdev.c b/lib/loopdev.c
index ff99dd4..54c6200 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -955,6 +955,28 @@ int loopcxt_is_readonly(struct loopdev_cxt *lc)
 
 /*
  * @lc: context
+ *
+ * Returns: 1 if the dio flags is set.
+ */
+int loopcxt_is_dio(struct loopdev_cxt *lc)
+{
+	struct sysfs_cxt *sysfs = loopcxt_get_sysfs(lc);
+
+	if (sysfs) {
+		int fl;
+		if (sysfs_read_int(sysfs, "loop/dio", &fl) == 0)
+			return fl;
+	}
+	if (loopcxt_ioctl_enabled(lc)) {
+		struct loop_info64 *lo = loopcxt_get_info(lc);
+		if (lo)
+			return lo->lo_flags & LO_FLAGS_DIRECT_IO;
+	}
+	return 0;
+}
+
+/*
+ * @lc: context
  * @st: backing file stat or NULL
  * @backing_file: filename
  * @offset: offset
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 8403621..f4c9213 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -49,6 +49,7 @@ enum {
 	COL_PARTSCAN,
 	COL_RO,
 	COL_SIZELIMIT,
+	COL_DIO,
 };
 
 /* basic output flags */
@@ -74,6 +75,7 @@ static struct colinfo infos[] = {
 	[COL_RO]          = { "RO",           1, SCOLS_FL_RIGHT, N_("read-only device")},
 	[COL_SIZELIMIT]   = { "SIZELIMIT",    5, SCOLS_FL_RIGHT, N_("size limit of the file in bytes")},
 	[COL_MAJMIN]      = { "MAJ:MIN",      3, 0, N_("loop device major:minor number")},
+	[COL_DIO]         = { "DIO",          1, SCOLS_FL_RIGHT, N_("access backing file with direct-io")},
 };
 
 static int columns[ARRAY_SIZE(infos) * 2] = {-1};
@@ -271,6 +273,9 @@ static int set_scols_data(struct loopdev_cxt *lc, struct libscols_line *ln)
 		case COL_RO:
 			p = loopcxt_is_readonly(lc) ? "1" : "0";
 			break;
+		case COL_DIO:
+			p = loopcxt_is_dio(lc) ? "1" : "0";
+			break;
 		case COL_PARTSCAN:
 			p = loopcxt_is_partscan(lc) ? "1" : "0";
 			break;
@@ -599,6 +604,7 @@ int main(int argc, char **argv)
 		columns[ncolumns++] = COL_AUTOCLR;
 		columns[ncolumns++] = COL_RO;
 		columns[ncolumns++] = COL_BACK_FILE;
+		columns[ncolumns++] = COL_DIO;
 	}
 
 	if (act == A_FIND_FREE && optind < argc) {
-- 
1.9.1

