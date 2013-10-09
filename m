Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41106 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab3JIPRg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Oct 2013 11:17:36 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so1039653pbc.39
        for <util-linux@vger.kernel.org>; Wed, 09 Oct 2013 08:17:35 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] libmount: Fix typo in comment
Date: Thu, 10 Oct 2013 00:17:08 +0900
Message-Id: <1381331829-9791-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

s/MNT_OMASK_/MNT_OMODE_/

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/context.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 0f8f112..04eb286 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -229,7 +229,7 @@ int mnt_context_is_restricted(struct libmnt_context *cxt)
 /**
  * mnt_context_set_optsmode
  * @cxt: mount context
- * @mode: MNT_OMASK_* flags
+ * @mode: MNT_OMODE_* flags
  *
  * Controls how to use mount optionssource and target paths from fstab/mtab.
  *
@@ -276,7 +276,7 @@ int mnt_context_set_optsmode(struct libmnt_context *cxt, int mode)
  * mnt_context_get_optsmode
  * @cxt: mount context
  *
- * Returns: MNT_OMASK_* mask or zero.
+ * Returns: MNT_OMODE_* mask or zero.
  */
 
 int mnt_context_get_optsmode(struct libmnt_context *cxt)
-- 
1.7.9.2

