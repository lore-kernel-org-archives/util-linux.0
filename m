Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35930 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2CRDgm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Mar 2012 23:36:42 -0400
Received: by mail-qc0-f174.google.com with SMTP id w6so680053qcq.19
        for <util-linux@vger.kernel.org>; Sat, 17 Mar 2012 20:36:42 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 4/5] findmnt: add FS size, avail, used, and use% columns
Date: Sat, 17 Mar 2012 23:36:32 -0400
Message-Id: <1332041793-7919-4-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Provide display of filesystem attributes from statvfs(3). These are all
displayed in human readable format.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.8 |    4 ++++
 misc-utils/findmnt.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index b6d80f0..c1734ca 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -103,6 +103,10 @@ Define output columns.  Currently supported are
 .BR OLD-OPTIONS,
 .BR VFS-OPTIONS ,
 .BR FS-OPTIONS ,
+.BR SIZE ,
+.BR AVAIL ,
+.BR USED ,
+.BR USE% ,
 .BR LABEL
 and
 .BR UUID .
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 77897d3..547be66 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -30,6 +30,8 @@
 #endif
 #include <assert.h>
 #include <poll.h>
+#include <sys/statvfs.h>
+#include <sys/types.h>
 
 #include <libmount.h>
 
@@ -65,6 +67,10 @@ enum {
 	COL_ACTION,
 	COL_OLD_TARGET,
 	COL_OLD_OPTIONS,
+	COL_SIZE,
+	COL_AVAIL,
+	COL_USED,
+	COL_USEPERC,
 
 	FINDMNT_NCOLUMNS
 };
@@ -98,6 +104,10 @@ static struct colinfo infos[FINDMNT_NCOLUMNS] = {
 	[COL_ACTION]       = { "ACTION",         10, TT_FL_STRICTWIDTH, N_("action detected by --poll") },
 	[COL_OLD_OPTIONS]  = { "OLD-OPTIONS",  0.10, TT_FL_TRUNC, N_("old mount options saved by --poll") },
 	[COL_OLD_TARGET]   = { "OLD-TARGET",   0.30, 0, N_("old mountpoint saved by --poll") },
+	[COL_SIZE]         = { "SIZE",            8, TT_FL_RIGHT, N_("filesystem size") },
+	[COL_AVAIL]        = { "AVAIL",           8, TT_FL_RIGHT, N_("filesystem size available") },
+	[COL_USED]         = { "USED",            8, TT_FL_RIGHT, N_("filesystem size used") },
+	[COL_USEPERC]      = { "USE%",            8, TT_FL_RIGHT, N_("filesystem use percentage") },
 };
 
 /* global flags */
@@ -280,14 +290,49 @@ static const char *get_tag(struct libmnt_fs *fs, const char *tagname)
 	return res;
 }
 
+static const char *get_vfs_attr(struct libmnt_fs *fs, int sizetype)
+{
+	struct statvfs buf;
+	uint64_t vfs_attr;
+	char *sizestr;
+
+	if (statvfs(mnt_fs_get_target(fs), &buf) != 0)
+		return NULL;
+
+	switch(sizetype) {
+	case COL_SIZE:
+		vfs_attr = buf.f_frsize * buf.f_blocks;
+		break;
+	case COL_AVAIL:
+		vfs_attr = buf.f_frsize * buf.f_bfree;
+		break;
+	case COL_USED:
+		vfs_attr = buf.f_frsize * (buf.f_blocks - buf.f_bfree);
+		break;
+	case COL_USEPERC:
+		if (buf.f_blocks == 0)
+			return "-";
+
+		if (asprintf(&sizestr, "%.0f%%",
+					(double)(buf.f_blocks - buf.f_bfree) /
+					buf.f_blocks * 100) == -1)
+			err(EXIT_FAILURE, "failed to allocate string");
+		return sizestr;
+	}
+
+	return vfs_attr == 0 ? "0" :
+		size_to_human_string(SIZE_SUFFIX_1LETTER, vfs_attr);
+}
+
 /* reads FS data from libmount
  * TODO: add function that will deallocate data allocated by get_data()
  */
 static const char *get_data(struct libmnt_fs *fs, int num)
 {
 	const char *str = NULL;
+	int col_id = get_column_id(num);
 
-	switch(get_column_id(num)) {
+	switch (col_id) {
 	case COL_SOURCE:
 	{
 		const char *root = mnt_fs_get_root(fs);
@@ -346,7 +391,14 @@ static const char *get_data(struct libmnt_fs *fs, int num)
 			if (rc)
 				str = tmp;
 		}
+		break;
 	}
+	case COL_SIZE:
+	case COL_AVAIL:
+	case COL_USED:
+	case COL_USEPERC:
+		str = get_vfs_attr(fs, col_id);
+		break;
 	default:
 		break;
 	}
-- 
1.7.9.4

