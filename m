Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39232 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTdo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:44 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so6033247wgh.1
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/14] various: fix shadow declarations [smatch scan]
Date: Mon,  8 Apr 2013 20:32:50 +0100
Message-Id: <1365449579-13238-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount/src/tab.c:990:34: warning: symbol 'fs' shadows an earlier one
libmount/src/tab.c:970:26: originally declared here
misc-utils/findmnt.c:492:30: warning: symbol 'tmp' shadows an earlier one
misc-utils/findmnt.c:473:14: originally declared here
fdisks/fdiskdoslabel.c:211:36: warning: symbol 'pe' shadows an earlier one
fdisks/fdiskdoslabel.c:180:20: originally declared here
fdisks/fdiskdoslabel.c:639:34: warning: symbol 'i' shadows an earlier one
fdisks/fdiskdoslabel.c:578:16: originally declared here
fdisks/fdiskdoslabel.c:947:21: warning: symbol 'i' shadows an earlier one
fdisks/fdiskdoslabel.c:924:16: originally declared here
fdisks/fdiskdoslabel.c:976:29: warning: symbol 'i' shadows an earlier one
fdisks/fdiskdoslabel.c:924:16: originally declared here
fdisks/fdiskdoslabel.c:984:29: warning: symbol 'i' shadows an earlier one
fdisks/fdiskdoslabel.c:924:16: originally declared here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/fdiskdoslabel.c | 38 +++++++++++++++++++-------------------
 libmount/src/tab.c     |  8 ++++----
 misc-utils/findmnt.c   |  6 +++---
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index e2ec0d3..fe04ac7 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -208,14 +208,14 @@ static int dos_delete_partition(struct fdisk_context *cxt, size_t partnum)
 			ptes[partnum-1].changed = 1;
 		} else if (cxt->label->nparts_max > 5) {    /* 5 will be moved to 4 */
 			/* the first logical in a longer chain */
-			struct pte *pe = &ptes[5];
+			struct pte *pete = &ptes[5];
 
-			if (pe->part_table) /* prevent SEGFAULT */
-				set_start_sect(pe->part_table,
-					       get_partition_start(pe) -
+			if (pete->part_table) /* prevent SEGFAULT */
+				set_start_sect(pete->part_table,
+					       get_partition_start(pete) -
 					       extended_offset);
-			pe->offset = extended_offset;
-			pe->changed = 1;
+			pete->offset = extended_offset;
+			pete->changed = 1;
 		}
 
 		if (cxt->label->nparts_max > 5) {
@@ -636,14 +636,14 @@ static int add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttype
 			read = 0;
 		}
 		if (!read && start == temp) {
-			sector_t i = start;
+			sector_t j = start;
 
-			start = read_int(cxt, cround(cxt, i), cround(cxt, dflt),
+			start = read_int(cxt, cround(cxt, j), cround(cxt, dflt),
 					cround(cxt, limit),
 					 0, mesg);
 			if (fdisk_context_use_cylinders(cxt)) {
 				start = (start - 1) * fdisk_context_get_units_per_sector(cxt);
-				if (start < i) start = i;
+				if (start < j) start = j;
 			}
 			read = 1;
 		}
@@ -944,14 +944,14 @@ static int dos_add_partition(
 			printf(_("If you want to create more than four partitions, you must replace a\n"
 				 "primary partition with an extended partition first.\n"));
 	} else if (cxt->label->nparts_max >= MAXIMUM_PARTS) {
-		int i;
+		int j;
 
 		printf(_("All logical partitions are in use\n"));
 		printf(_("Adding a primary partition\n"));
 
-		i = get_partition_unused_primary(cxt);
-		if (i >= 0)
-			rc = add_partition(cxt, i, t);
+		j = get_partition_unused_primary(cxt);
+		if (j >= 0)
+			rc = add_partition(cxt, j, t);
 	} else {
 		char c, line[LINE_LENGTH];
 		int dflt;
@@ -973,18 +973,18 @@ static int dos_add_partition(
 			printf(_("Using default response %c\n"), c);
 		}
 		if (c == 'p') {
-			int i = get_partition_unused_primary(cxt);
-			if (i >= 0)
-				rc = add_partition(cxt, i, t);
+			int j = get_partition_unused_primary(cxt);
+			if (j >= 0)
+				rc = add_partition(cxt, j, t);
 			goto done;
 		} else if (c == 'l' && extended_offset) {
 			rc = add_logical(cxt);
 			goto done;
 		} else if (c == 'e' && !extended_offset) {
-			int i = get_partition_unused_primary(cxt);
-			if (i >= 0) {
+			int j = get_partition_unused_primary(cxt);
+			if (j >= 0) {
 				t = fdisk_get_parttype_from_code(cxt, EXTENDED);
-				rc = add_partition(cxt, i, t);
+				rc = add_partition(cxt, j, t);
 			}
 			goto done;
 		} else
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 9d524c1..11a2978 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -987,15 +987,15 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, struct libmnt_fs *fstab_fs)
 
 	if (is_mountinfo(tb)) {
 		/* @tb is mountinfo, so we can try to use fs-roots */
-		struct libmnt_fs *fs;
+		struct libmnt_fs *rootfs;
 		int flags = 0;
 
 		if (mnt_fs_get_option(fstab_fs, "bind", NULL, NULL) == 0)
 			flags = MS_BIND;
 
-		fs = mnt_table_get_fs_root(tb, fstab_fs, flags, &root);
-		if (fs)
-			src = mnt_fs_get_srcpath(fs);
+		rootfs = mnt_table_get_fs_root(tb, fstab_fs, flags, &root);
+		if (rootfs)
+			src = mnt_fs_get_srcpath(rootfs);
 	}
 
 	if (!src)
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 2491799..8f74449 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -489,9 +489,9 @@ static const char *get_data(struct libmnt_fs *fs, int num)
 				str = mnt_resolve_spec(str, cache);
 		}
 		if (root && str && !(flags & FL_NOFSROOT) && strcmp(root, "/")) {
-			char *tmp;
-			xasprintf(&tmp, "%s[%s]", str, root);
-			str = tmp;
+			char *temp;
+			xasprintf(&temp, "%s[%s]", str, root);
+			str = temp;
 		}
 		break;
 	}
-- 
1.8.2.1

