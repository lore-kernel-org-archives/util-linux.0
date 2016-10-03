Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:51784 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbcJCUDy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Oct 2016 16:03:54 -0400
Received: from localhost ([79.234.34.66]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0LfY1R-1b71wM2IIb-00p3kU for
 <util-linux@vger.kernel.org>; Mon, 03 Oct 2016 22:03:51 +0200
Date: Mon, 3 Oct 2016 22:05:03 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] libblkid: Avoid strlen if only first char is checked
Message-ID: <20161003200503.GA2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A strlen() call can lead to out of boundary read access if the
superblock in question has no nul-bytes after the string. This
could be avoided by using strnlen() but the calls in question
merely existed to check if the string length is not 0.

By changing the calls as proposed with this diff, these files are
in sync with other superblock files, which do exactly the same.
---
 libblkid/src/superblocks/befs.c  | 2 +-
 libblkid/src/superblocks/ext.c   | 2 +-
 libblkid/src/superblocks/jfs.c   | 2 +-
 libblkid/src/superblocks/nilfs.c | 2 +-
 libblkid/src/superblocks/romfs.c | 2 +-
 libblkid/src/superblocks/xfs.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/superblocks/befs.c b/libblkid/src/superblocks/befs.c
index 7e9eaf6..36e079f 100644
--- a/libblkid/src/superblocks/befs.c
+++ b/libblkid/src/superblocks/befs.c
@@ -451,7 +451,7 @@ static int probe_befs(blkid_probe pr, const struct blkid_idmag *mag)
 	/*
 	 * all checks pass, set LABEL, VERSION and UUID
 	 */
-	if (strlen(bs->name))
+	if (*bs->name != '\0')
 		blkid_probe_set_label(pr, (unsigned char *) bs->name,
 							sizeof(bs->name));
 	if (version)
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index 5b1d179..caf82c1 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -170,7 +170,7 @@ static void ext_get_info(blkid_probe pr, int ver, struct ext2_super_block *es)
 		   le32_to_cpu(es->s_feature_incompat),
 		   le32_to_cpu(es->s_feature_ro_compat)));
 
-	if (strlen(es->s_volume_name))
+	if (*es->s_volume_name != '\0')
 		blkid_probe_set_label(pr, (unsigned char *) es->s_volume_name,
 					sizeof(es->s_volume_name));
 	blkid_probe_set_uuid(pr, es->s_uuid);
diff --git a/libblkid/src/superblocks/jfs.c b/libblkid/src/superblocks/jfs.c
index ac684d8..0f956ef 100644
--- a/libblkid/src/superblocks/jfs.c
+++ b/libblkid/src/superblocks/jfs.c
@@ -49,7 +49,7 @@ static int probe_jfs(blkid_probe pr, const struct blkid_idmag *mag)
 	    le16_to_cpu(js->js_l2bfactor))
 		return 1;
 
-	if (strlen((char *) js->js_label))
+	if (*((char *) js->js_label) != '\0')
 		blkid_probe_set_label(pr, js->js_label, sizeof(js->js_label));
 	blkid_probe_set_uuid(pr, js->js_uuid);
 	return 0;
diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index ab0f74c..ee5c5f9 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -143,7 +143,7 @@ static int probe_nilfs2(blkid_probe pr,
 	DBG(LOWPROBE, ul_debug("nilfs2: primary=%d, backup=%d, swap=%d",
 				valid[0], valid[1], swp));
 
-	if (strlen(sb->s_volume_name))
+	if (*(sb->s_volume_name) != '\0')
 		blkid_probe_set_label(pr, (unsigned char *) sb->s_volume_name,
 				      sizeof(sb->s_volume_name));
 
diff --git a/libblkid/src/superblocks/romfs.c b/libblkid/src/superblocks/romfs.c
index 8e63c10..f3e9f8b 100644
--- a/libblkid/src/superblocks/romfs.c
+++ b/libblkid/src/superblocks/romfs.c
@@ -31,7 +31,7 @@ static int probe_romfs(blkid_probe pr, const struct blkid_idmag *mag)
 	if (!ros)
 		return errno ? -errno : 1;
 
-	if (strlen((char *) ros->ros_volume))
+	if (*((char *) ros->ros_volume) != '\0')
 		blkid_probe_set_label(pr, ros->ros_volume,
 				sizeof(ros->ros_volume));
 	return 0;
diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
index 01e9cda..99848f9 100644
--- a/libblkid/src/superblocks/xfs.c
+++ b/libblkid/src/superblocks/xfs.c
@@ -169,7 +169,7 @@ static int probe_xfs(blkid_probe pr, const struct blkid_idmag *mag)
 	if (!xfs_verify_sb(xs))
 		return 1;
 
-	if (strlen(xs->sb_fname))
+	if (*xs->sb_fname != '\0')
 		blkid_probe_set_label(pr, (unsigned char *) xs->sb_fname,
 				sizeof(xs->sb_fname));
 	blkid_probe_set_uuid(pr, xs->sb_uuid);
-- 
2.10.0

