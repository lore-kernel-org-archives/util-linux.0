Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:43298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935953AbcA0Uhb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Jan 2016 15:37:31 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B93FDAC06
	for <util-linux@vger.kernel.org>; Wed, 27 Jan 2016 20:37:28 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/2] libmount: code re-indentation
Message-ID: <56A92A89.1050005@suse.cz>
Date: Wed, 27 Jan 2016 21:37:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For easier review, the fix of libmount comes in two patches:
PATCH 1/2: libmount: run btrfs subvol checks for "subvolid" option
PATCH 2/2: code re-indentation

No code change is present in this patch.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab.c | 87 +++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 71dfbf5..845ec6c 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1326,50 +1326,51 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 		DBG(BTRFS, ul_debug("lookup for FS root"));
 
 		if (mnt_fs_get_option(fs, "subvolid", &vol, &volsz)) {
-		if (mnt_fs_get_option(fs, "subvol", &vol, &volsz)) {
-			/* If fstab entry does not contain "subvol", we have to
-			 * check, whether btrfs has default subvolume defined.
-			 */
-			uint64_t default_id;
-			char *target;
-			struct libmnt_fs *f;
-			char default_id_str[sizeof(stringify_value(UINT64_MAX))];
-
-			default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
-			if (default_id == UINT64_MAX)
-				goto dflt;
-
-			/* Volume has default subvolume. Check if it matches to
-			 * the one in mountinfo.
-			 *
-			 * Only kernel >= 4.2 reports subvolid. On older
-			 * kernels, there is no reasonable way to detect which
-			 * subvolume was mounted.
-			 */
-			target = mnt_resolve_spec(mnt_fs_get_target(fs), tb->cache);
-			if (!target)
-				goto err;
-
-			snprintf(default_id_str, sizeof(default_id_str), "%llu",
-					(unsigned long long int) default_id);
-
-			DBG(BTRFS, ul_debug("target=%s default subvolid=%s", target, default_id_str));
-			f = mnt_table_find_target_with_option(tb, target,
-						"subvolid", default_id_str,
-						MNT_ITER_BACKWARD);
-			if (!tb->cache)
-				free(target);
-			if (!f)
-				goto dflt;
+			if (mnt_fs_get_option(fs, "subvol", &vol, &volsz)) {
+				/* If fstab entry does not contain "subvol", we
+				 * have to check, whether btrfs has default
+				 * subvolume defined.
+				 */
+				uint64_t default_id;
+				char *target;
+				struct libmnt_fs *f;
+				char default_id_str[sizeof(stringify_value(UINT64_MAX))];
+
+				default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
+				if (default_id == UINT64_MAX)
+					goto dflt;
+
+				/* Volume has default subvolume. Check if it
+				 * matches to the one in mountinfo.
+				 *
+				 * Only kernel >= 4.2 reports subvolid. On older
+				 * kernels, there is no reasonable way to detect
+				 * which subvolume was mounted.
+				 */
+				target = mnt_resolve_spec(mnt_fs_get_target(fs), tb->cache);
+				if (!target)
+					goto err;
 
-			/* Instead of set of BACKREF queries constructing
-			 * subvol path, use the one in mountinfo. Kernel does
-			 * the evaluation for us. */
-			DBG(BTRFS, ul_debug("setting FS root: btrfs default subvolid = %s", default_id_str));
-			if (mnt_fs_get_option(f, "subvol", &vol, &volsz))
-				goto dflt;
-		} else
-			DBG(BTRFS, ul_debug("setting FS root: btrfs subvol"));
+				snprintf(default_id_str, sizeof(default_id_str), "%llu",
+						(unsigned long long int) default_id);
+
+				DBG(BTRFS, ul_debug("target=%s default subvolid=%s", target, default_id_str));
+				f = mnt_table_find_target_with_option(tb, target,
+							"subvolid", default_id_str,
+							MNT_ITER_BACKWARD);
+				if (!tb->cache)
+					free(target);
+				if (!f)
+					goto dflt;
+
+				/* Instead of set of BACKREF queries constructing
+				 * subvol path, use the one in mountinfo. Kernel
+				 * does the evaluation for us. */
+				DBG(BTRFS, ul_debug("setting FS root: btrfs default subvolid = %s", default_id_str));
+				if (mnt_fs_get_option(f, "subvol", &vol, &volsz))
+					goto dflt;
+			} else
+				DBG(BTRFS, ul_debug("setting FS root: btrfs subvol"));
 		} else {
 			char *target;
 			struct libmnt_fs *f;
-- 
2.7.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
