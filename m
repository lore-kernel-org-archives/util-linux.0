Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56200 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab1I2S6j (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Sep 2011 14:58:39 -0400
Received: by mail-vx0-f174.google.com with SMTP id fk10so729636vcb.19
        for <util-linux@vger.kernel.org>; Thu, 29 Sep 2011 11:58:39 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] xalloc: fix whitespace to be consistent
Date: Thu, 29 Sep 2011 14:56:42 -0400
Message-Id: <1317322602-24884-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1317322602-24884-1-git-send-email-dreisner@archlinux.org>
References: <1317322602-24884-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We use spaces for the rest of this file, so the random tabs within
xstrdup stand out.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 include/xalloc.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/xalloc.h b/include/xalloc.h
index bea7e31..feeb114 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -51,16 +51,16 @@ void *xcalloc(const size_t nelems, const size_t size)
 
 static inline char *xstrdup(const char *str)
 {
-	char *ret;
+        char *ret;
 
-	if (!str)
-		return NULL;
+        if (!str)
+                return NULL;
 
-	ret = strdup(str);
+        ret = strdup(str);
 
-	if (!ret)
-		err(XALLOC_EXIT_CODE, "cannot duplicate string");
-	return ret;
+        if (!ret)
+                err(XALLOC_EXIT_CODE, "cannot duplicate string");
+        return ret;
 }
 
 #endif
-- 
1.7.6.4

