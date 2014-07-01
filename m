Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:64179 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaGAUkL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 Jul 2014 16:40:11 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so10481757wes.12
        for <util-linux@vger.kernel.org>; Tue, 01 Jul 2014 13:40:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] swapon: share get_swap_prober() with swaplabel to print uuid and label
Date: Tue,  1 Jul 2014 21:40:04 +0100
Message-Id: <1404247204-1751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The swapon(8) listing was almost complete, apart from label and uuid.
This change moves the code from swaplabel(8) to shared scope to be used
for printouts in other swap commands, such as swapon.

Adding this feature to lsblk(8) was a consideration, but lsblk is not
interested of swapfiles, so the swapon seems like a better option to add
this information.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/Makemodule.am  |  6 +++---
 disk-utils/swaplabel.c    | 46 ----------------------------------------------
 sys-utils/Makemodule.am   | 14 ++++++++++----
 sys-utils/swapon-common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/swapon-common.h |  2 ++
 sys-utils/swapon.c        | 38 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 95 insertions(+), 55 deletions(-)

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index fb3b564..c6183f5 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -65,10 +65,10 @@ endif # BUILD_MKSWAP
 if BUILD_SWAPLABEL
 sbin_PROGRAMS += swaplabel
 dist_man_MANS += disk-utils/swaplabel.8
-swaplabel_SOURCES = disk-utils/swaplabel.c
+swaplabel_SOURCES = disk-utils/swaplabel.c sys-utils/swapon-common.c
 
-swaplabel_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
-swaplabel_LDADD = $(LDADD) libblkid.la libcommon.la
+swaplabel_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir) -I$(ul_libmount_incdir)
+swaplabel_LDADD = $(LDADD) libblkid.la libmount.la libcommon.la
 
 if BUILD_LIBUUID
 swaplabel_LDADD += libuuid.la
diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 8d5b260..809c365 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -35,52 +35,6 @@
 #define SWAP_UUID_OFFSET	(offsetof(struct swap_header_v1_2, uuid))
 #define SWAP_LABEL_OFFSET	(offsetof(struct swap_header_v1_2, volume_name))
 
-/*
- * Returns new libblkid prober. This function call exit() on error.
- */
-static blkid_probe get_swap_prober(const char *devname)
-{
-	blkid_probe pr;
-	int rc;
-	const char *version = NULL;
-	char *swap_filter[] = { "swap", NULL };
-
-	pr = blkid_new_probe_from_filename(devname);
-	if (!pr) {
-		warn(_("%s: unable to probe device"), devname);
-		return NULL;
-	}
-
-	blkid_probe_enable_superblocks(pr, TRUE);
-	blkid_probe_set_superblocks_flags(pr,
-			BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
-			BLKID_SUBLKS_VERSION);
-
-	blkid_probe_filter_superblocks_type(pr, BLKID_FLTR_ONLYIN, swap_filter);
-
-	rc = blkid_do_safeprobe(pr);
-	if (rc == -1)
-		warn(_("%s: unable to probe device"), devname);
-	else if (rc == -2)
-		warnx(_("%s: ambivalent probing result, use wipefs(8)"), devname);
-	else if (rc == 1)
-		warnx(_("%s: not a valid swap partition"), devname);
-
-	if (rc == 0) {
-		/* Only the SWAPSPACE2 is supported. */
-		if (blkid_probe_lookup_value(pr, "VERSION", &version, NULL) == 0
-		    && version
-		    && strcmp(version, stringify_value(SWAP_VERSION)))
-			warnx(_("%s: unsupported swap version '%s'"),
-						devname, version);
-		else
-			return pr;
-	}
-
-	blkid_free_probe(pr);
-	return NULL;
-}
-
 /* Print the swap partition information */
 static int print_info(blkid_probe pr)
 {
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 68fd030..4741fed 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -255,12 +255,18 @@ swapon_SOURCES = \
 	sys-utils/swapon.c \
 	sys-utils/swapon-common.c \
 	sys-utils/swapon-common.h
-
-swapon_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir) -I$(ul_libsmartcols_incdir)
-swapon_LDADD = $(LDADD) libcommon.la libmount.la libsmartcols.la
+swapon_CFLAGS = $(AM_CFLAGS) \
+	-I$(ul_libblkid_incdir) \
+	-I$(ul_libmount_incdir) \
+	-I$(ul_libsmartcols_incdir)
+swapon_LDADD = $(LDADD) \
+	libblkid.la \
+	libcommon.la \
+	libmount.la \
+	libsmartcols.la
 
 swapoff_SOURCES = sys-utils/swapoff.c sys-utils/swapon-common.c
-swapoff_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
+swapoff_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir) -I$(ul_libblkid_incdir)
 swapoff_LDADD = $(LDADD) libmount.la
 endif
 
diff --git a/sys-utils/swapon-common.c b/sys-utils/swapon-common.c
index 6dd7bac..203d5c4 100644
--- a/sys-utils/swapon-common.c
+++ b/sys-utils/swapon-common.c
@@ -1,6 +1,8 @@
+#include <blkid.h>
 
 #include "c.h"
 #include "nls.h"
+#include "swapheader.h"
 #include "swapon-common.h"
 #include "xalloc.h"
 
@@ -104,3 +106,45 @@ size_t numof_uuids(void)
 	return ulct;
 }
 
+blkid_probe get_swap_prober(const char *devname)
+{
+	blkid_probe pr;
+	int rc;
+	const char *version = NULL;
+	char *swap_filter[] = { "swap", NULL };
+
+	pr = blkid_new_probe_from_filename(devname);
+	if (!pr) {
+		warn(_("%s: unable to probe device"), devname);
+		return NULL;
+	}
+
+	blkid_probe_enable_superblocks(pr, TRUE);
+	blkid_probe_set_superblocks_flags(pr,
+			BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
+			BLKID_SUBLKS_VERSION);
+
+	blkid_probe_filter_superblocks_type(pr, BLKID_FLTR_ONLYIN, swap_filter);
+
+	rc = blkid_do_safeprobe(pr);
+	if (rc == -1)
+		warn(_("%s: unable to probe device"), devname);
+	else if (rc == -2)
+		warnx(_("%s: ambivalent probing result, use wipefs(8)"), devname);
+	else if (rc == 1)
+		warnx(_("%s: not a valid swap partition"), devname);
+
+	if (rc == 0) {
+		/* Only the SWAPSPACE2 is supported. */
+		if (blkid_probe_lookup_value(pr, "VERSION", &version, NULL) == 0
+		    && version
+		    && strcmp(version, stringify_value(SWAP_VERSION)))
+			warnx(_("%s: unsupported swap version '%s'"),
+						devname, version);
+		else
+			return pr;
+	}
+
+	blkid_free_probe(pr);
+	return NULL;
+}
diff --git a/sys-utils/swapon-common.h b/sys-utils/swapon-common.h
index 53ba15e..da58e19 100644
--- a/sys-utils/swapon-common.h
+++ b/sys-utils/swapon-common.h
@@ -1,6 +1,7 @@
 #ifndef UTIL_LINUX_SWAPON_COMMON_H
 #define UTIL_LINUX_SWAPON_COMMON_H
 
+#include <blkid.h>
 #include <libmount.h>
 
 extern struct libmnt_cache *mntcache;
@@ -22,5 +23,6 @@ extern void add_uuid(const char *uuid);
 extern const char *get_uuid(size_t i);
 extern size_t numof_uuids(void);
 
+blkid_probe get_swap_prober(const char *devname);
 
 #endif /* UTIL_LINUX_SWAPON_COMMON_H */
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 77af465..85273ab 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -12,6 +12,8 @@
 #include <stdint.h>
 #include <ctype.h>
 
+#include <blkid.h>
+
 #include <libmount.h>
 #include <libsmartcols.h>
 
@@ -97,13 +99,23 @@ struct colinfo {
 static int no_headings;
 static int raw;
 
-enum { COL_PATH, COL_TYPE, COL_SIZE, COL_USED, COL_PRIO };
+enum {
+	COL_PATH,
+	COL_TYPE,
+	COL_SIZE,
+	COL_USED,
+	COL_PRIO,
+	COL_UUID,
+	COL_LABEL
+};
 struct colinfo infos[] = {
 	[COL_PATH]     = { "NAME",	0.20, 0, N_("device file or partition path") },
 	[COL_TYPE]     = { "TYPE",	0.20, SCOLS_FL_TRUNC, N_("type of the device")},
 	[COL_SIZE]     = { "SIZE",	0.20, SCOLS_FL_RIGHT, N_("size of the swap area")},
 	[COL_USED]     = { "USED",	0.20, SCOLS_FL_RIGHT, N_("bytes in use")},
 	[COL_PRIO]     = { "PRIO",	0.20, SCOLS_FL_RIGHT, N_("swap priority")},
+	[COL_UUID]     = { "UUID",	0.20, 0, N_("swap uuid")},
+	[COL_LABEL]    = { "LABEL",	0.20, 0, N_("swap label")},
 };
 #define NCOLS ARRAY_SIZE(infos)
 static int columns[NCOLS], ncolumns;
@@ -142,6 +154,8 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 {
 	int i;
 	struct libscols_line *line;
+	blkid_probe pr = NULL;
+	const char *data;
 
 	assert(table);
 	assert(fs);
@@ -149,7 +163,9 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 	line = scols_table_new_line(table, NULL);
 	if (!line)
 		err(EXIT_FAILURE, _("failed to initialize output line"));
-
+	data = mnt_fs_get_source(fs);
+	if (access(data, R_OK) == 0)
+		pr = get_swap_prober(data);
 	for (i = 0; i < ncolumns; i++) {
 		char *str = NULL;
 		off_t size;
@@ -180,6 +196,22 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 		case COL_PRIO:
 			xasprintf(&str, "%d", mnt_fs_get_priority(fs));
 			break;
+		case COL_UUID:
+			if (pr && !blkid_probe_lookup_value(pr, "UUID", &data, NULL))
+				xasprintf(&str, "%s", data);
+			else if (pr)
+				xasprintf(&str, "");
+			else
+				xasprintf(&str, _("read failed"));
+			break;
+		case COL_LABEL:
+			if (pr && !blkid_probe_lookup_value(pr, "LABEL", &data, NULL))
+				xasprintf(&str, "%s", data);
+			else if (pr)
+				xasprintf(&str, "");
+			else
+				xasprintf(&str, _("read failed"));
+			break;
 		default:
 			break;
 		}
@@ -187,6 +219,8 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 		if (str)
 			scols_line_refer_data(line, i, str);
 	}
+	if (pr)
+		blkid_free_probe(pr);
 	return;
 }
 
-- 
2.0.1

