Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f53.google.com ([209.85.160.53]:59590 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab3JIPRi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Oct 2013 11:17:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so1050520pbc.26
        for <util-linux@vger.kernel.org>; Wed, 09 Oct 2013 08:17:38 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] libmount: Fix mnt_context_is_child()
Date: Thu, 10 Oct 2013 00:17:09 +0900
Message-Id: <1381331829-9791-2-git-send-email-namhyung@gmail.com>
In-Reply-To: <1381331829-9791-1-git-send-email-namhyung@gmail.com>
References: <1381331829-9791-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It should check if fork (mount -F) is enabled.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 04eb286..a4d9824 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -387,7 +387,7 @@ int mnt_context_is_parent(struct libmnt_context *cxt)
  */
 int mnt_context_is_child(struct libmnt_context *cxt)
 {
-	return !mnt_context_is_fork(cxt) && cxt->pid;
+	return mnt_context_is_fork(cxt) && cxt->pid;
 }
 
 /**
-- 
1.7.9.2

