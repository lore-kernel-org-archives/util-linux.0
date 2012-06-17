Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:48791 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab2FQPgL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jun 2012 11:36:11 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount/context: ignore fstab entries with fstype "ignore"
Date: Sun, 17 Jun 2012 11:36:09 -0400
Message-Id: <1339947369-17539-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is documented in fstab(5) as being a valid option for fstype, and
should be left alone when iterating via mount -a, similar to "noauto" in
the option string.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/context_mount.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 36dc414..04a34c0 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -831,7 +831,7 @@ int mnt_context_next_mount(struct libmnt_context *cxt,
 			   int *ignored)
 {
 	struct libmnt_table *fstab, *mtab;
-	const char *o, *tgt;
+	const char *o, *tgt, *fstype;
 	int rc, mounted = 0;
 
 	if (ignored)
@@ -857,6 +857,7 @@ int mnt_context_next_mount(struct libmnt_context *cxt,
 
 	o = mnt_fs_get_user_options(*fs);
 	tgt = mnt_fs_get_target(*fs);
+	fstype = mnt_fs_get_fstype(*fs);
 
 	DBG(CXT, mnt_debug_h(cxt, "next-mount: trying %s", tgt));
 
@@ -869,6 +870,9 @@ int mnt_context_next_mount(struct libmnt_context *cxt,
 	/* ignore noauto filesystems */
 	   (o && mnt_optstr_get_option(o, "noauto", NULL, NULL) == 0) ||
 
+	/* ignore filesystems declared with fstype "ignore" */
+	   (strcmp(fstype, "ignore") == 0) ||
+
 	/* ignore filesystems not match with options patterns */
 	   (cxt->fstype_pattern && !mnt_fs_match_fstype(*fs,
 					cxt->fstype_pattern)) ||
@@ -880,7 +884,7 @@ int mnt_context_next_mount(struct libmnt_context *cxt,
 			*ignored = 1;
 		DBG(CXT, mnt_debug_h(cxt, "next-mount: not-match "
 				"[fstype: %s, t-pattern: %s, options: %s, O-pattern: %s]",
-				mnt_fs_get_fstype(*fs),
+				fstype,
 				cxt->fstype_pattern,
 				mnt_fs_get_options(*fs),
 				cxt->optstr_pattern));
-- 
1.7.10.4

