Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56200 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab1I2S6i (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Sep 2011 14:58:38 -0400
Received: by vcbfk10 with SMTP id fk10so729636vcb.19
        for <util-linux@vger.kernel.org>; Thu, 29 Sep 2011 11:58:37 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] xalloc: check for NULL before calling strdup
Date: Thu, 29 Sep 2011 14:56:41 -0400
Message-Id: <1317322602-24884-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes a segfault in mount (and possibly elsewhere) when invoked
without a -t parameter.

Broken in 7ef9fd7 when the common xalloc.h libs were introduced.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 include/xalloc.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/xalloc.h b/include/xalloc.h
index 8c505be..bea7e31 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -51,9 +51,14 @@ void *xcalloc(const size_t nelems, const size_t size)
 
 static inline char *xstrdup(const char *str)
 {
-	char *ret = strdup(str);
+	char *ret;
 
-	if (!ret && str)
+	if (!str)
+		return NULL;
+
+	ret = strdup(str);
+
+	if (!ret)
 		err(XALLOC_EXIT_CODE, "cannot duplicate string");
 	return ret;
 }
-- 
1.7.6.4

