Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:37752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdBWSoW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Feb 2017 13:44:22 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE288ACBB
        for <util-linux@vger.kernel.org>; Thu, 23 Feb 2017 18:25:35 +0000 (UTC)
From: Petr Vorel <pvorel@suse.cz>
To: util-linux@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 1/1] libmount: return tab entry for default node
Date: Thu, 23 Feb 2017 19:25:13 +0100
Message-Id: <20170223182513.13634-1-pvorel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is useful for lsblk.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libmount/src/tab.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 8cf11814f..c86ff7951 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -936,6 +936,8 @@ struct libmnt_fs *mnt_table_find_target(struct libmnt_table *tb, const char *pat
  * The 2nd, 3rd and 4th iterations are not performed when the @tb cache is not
  * set (see mnt_table_set_cache()).
  *
+ * For btrfs returns tab entry for default id.
+ *
  * Note that NULL is a valid source path; it will be replaced with "none". The
  * "none" is used in /proc/{mounts,self/mountinfo} for pseudo filesystems.
  *
@@ -958,9 +960,34 @@ struct libmnt_fs *mnt_table_find_srcpath(struct libmnt_table *tb, const char *pa
 
 	/* native paths */
 	mnt_reset_iter(&itr, direction);
+
 	while(mnt_table_next_fs(tb, &itr, &fs) == 0) {
-		if (mnt_fs_streq_srcpath(fs, path))
+
+		if (mnt_fs_streq_srcpath(fs, path)) {
+#ifdef HAVE_BTRFS_SUPPORT
+			if (!strcmp(fs->fstype, "btrfs")) {
+				uint64_t default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
+				uint64_t subvol_id;
+				char *val;
+				size_t len;
+
+				if (default_id == UINT64_MAX) {
+					DBG(TAB, ul_debug("not found btrfs volume setting"));
+					return fs;
+				}
+
+				if (mnt_fs_get_option(fs, "subvolid", &val, &len) == 0) {
+					if (mnt_parse_offset(val, len, &subvol_id)) {
+						DBG(TAB, ul_debugobj(tb, "failed to parse subvolid="));
+						continue;
+					}
+					if (subvol_id != default_id)
+						continue;
+				}
+			}
+#endif /* HAVE_BTRFS_SUPPORT */
 			return fs;
+		}
 		if (mnt_fs_get_tag(fs, NULL, NULL) == 0)
 			ntags++;
 	}
-- 
2.11.0

