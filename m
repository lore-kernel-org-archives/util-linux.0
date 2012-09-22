Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3-g21.free.fr ([212.27.42.3]:38964 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120Ab2IVHe5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 22 Sep 2012 03:34:57 -0400
From: Gilles Espinasse <g.esp@free.fr>
To: util-linux@vger.kernel.org
Cc: Gilles Espinasse <g.esp@free.fr>
Subject: [PATCH util-linux] Typo fixes
Date: Sat, 22 Sep 2012 09:59:19 +0200
Message-Id: <1348300759-3614-1-git-send-email-g.esp@free.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gilles Espinasse <g.esp@free.fr>
---
 libmount/src/context_mount.c  |    2 +-
 libmount/src/context_umount.c |    4 ++--
 misc-utils/blkid.8            |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index c665a05..6dc8e64 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -113,7 +113,7 @@ static int fix_optstr(struct libmnt_context *cxt)
 		 */
 		se_rem = get_linux_version() < KERNEL_VERSION(2, 6, 39);
 	else
-		/* For normal mount we have translate the contexts */
+		/* For normal mount, contexts are translated */
 		se_fix = 1;
 
 	if (!se_rem) {
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 17ec1f0..3c54902 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -112,7 +112,7 @@ try_loopdev:
 			} else if (count > 1)
 				DBG(CXT, mnt_debug_h(cxt,
 					"umount: warning: %s is associated "
-					"with more than one loodev", tgt));
+					"with more than one loopdev", tgt));
 		}
 	}
 
@@ -497,7 +497,7 @@ static int do_umount(struct libmnt_context *cxt)
 
 	if (cxt->restricted && !mnt_context_is_fake(cxt)) {
 		/*
-		 * extra paranoa for non-root users
+		 * extra paranoia for non-root users
 		 * -- chdir to the parent of the mountpoint and use NOFOLLOW
 		 *    flag to avoid races and symlink attacks.
 		 */
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 93f0367..9c45a0e 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -276,7 +276,7 @@ overridden by the environment variable BLKID_FILE. Default is
 .I /run/blkid/blkid.tab
 or
 .I /etc/blkid.tab
-on systems without /run direcotry
+on systems without /run directory
 .TP
 .I EVALUATE=<methods>
 Defines LABEL and UUID evaluation method(s). Currently, the libblkid library
-- 
1.7.2.5

