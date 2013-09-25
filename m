Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63271 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3IYPc3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Sep 2013 11:32:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so6663673pad.0
        for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 08:32:29 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] libmount: Get rid of an unnecessary check
Date: Thu, 26 Sep 2013 00:32:03 +0900
Message-Id: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount_debug_mask was OR'ed to MNT_DEBUG_INIT so it should be non-null.
Thus the check is pointless.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/init.c b/libmount/src/init.c
index 4e5f489..8d468d0 100644
--- a/libmount/src/init.c
+++ b/libmount/src/init.c
@@ -40,7 +40,7 @@ void mnt_init_debug(int mask)
 
 	libmount_debug_mask |= MNT_DEBUG_INIT;
 
-	if (libmount_debug_mask && libmount_debug_mask != MNT_DEBUG_INIT) {
+	if (libmount_debug_mask != MNT_DEBUG_INIT) {
 		const char *ver = NULL;
 		const char **features = NULL, **p;
 
-- 
1.7.9.2

