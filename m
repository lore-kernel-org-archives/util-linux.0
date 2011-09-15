Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44503 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933814Ab1IOOSI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Sep 2011 10:18:08 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2710487wyh.19
        for <util-linux@vger.kernel.org>; Thu, 15 Sep 2011 07:18:07 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/2] libmount: fix use of logical '&&' with constant operand
Date: Thu, 15 Sep 2011 16:17:46 +0200
Message-Id: <1316096266-14692-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1316096266-14692-1-git-send-email-cosoleto@gmail.com>
References: <1316096266-14692-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found by clang.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 libmount/src/context_loopdev.c |    2 +-
 libmount/src/context_mount.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 6ed0df1..992472e 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -52,7 +52,7 @@ int mnt_context_is_loopdev(struct libmnt_context *cxt)
 	type = mnt_fs_get_fstype(cxt->fs);
 	fl = __mnt_fs_get_flags(cxt->fs);
 
-	if (!(fl && (MNT_FS_PSEUDO | MNT_FS_NET | MNT_FS_SWAP)) &&
+	if (!(fl & (MNT_FS_PSEUDO | MNT_FS_NET | MNT_FS_SWAP)) &&
 	    (!type || strcmp(type, "auto") == 0 || blkid_known_fstype(type))) {
 		struct stat st;
 
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 7e75ad7..bcc4cdd 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -125,7 +125,7 @@ static int fix_optstr(struct libmnt_context *cxt)
 			goto done;
 	}
 
-	if (!rc && cxt->user_mountflags && MNT_MS_USER)
+	if (!rc && cxt->user_mountflags & MNT_MS_USER)
 		rc = mnt_optstr_fix_user(&fs->user_optstr);
 
 	/* refresh merged optstr */
-- 
1.7.3.4

