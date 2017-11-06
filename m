Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f194.google.com ([209.85.223.194]:43049 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdKFWZk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Nov 2017 17:25:40 -0500
Received: by mail-io0-f194.google.com with SMTP id 134so77513ioo.0
        for <util-linux@vger.kernel.org>; Mon, 06 Nov 2017 14:25:39 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
To: util-linux@vger.kernel.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] libmount: Allow MNT_FORCE and MNT_DETACH at umount
Date: Mon,  6 Nov 2017 16:25:36 -0600
Message-Id: <20171106222536.9806-1-JPEWhacker@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

MNT_FORCE and MNT_DETACH are orthogonal in the Linux kernel, so both may
be specified without any problems. Even if there were a problem with
this combination, it should be up to the kernel to take the correct
action or report an error.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 libmount/src/context_umount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index f6b4ba737..45651b58e 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -704,7 +704,7 @@ static int do_umount(struct libmnt_context *cxt)
 	if (mnt_context_is_lazy(cxt))
 		flags |= MNT_DETACH;
 
-	else if (mnt_context_is_force(cxt))
+	if (mnt_context_is_force(cxt))
 		flags |= MNT_FORCE;
 
 	DBG(CXT, ul_debugobj(cxt, "umount(2) [target='%s', flags=0x%08x]%s",
-- 
2.13.6

