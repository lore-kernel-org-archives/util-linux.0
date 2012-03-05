Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58484 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab2CETji (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:38 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565228eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/17] include: add asprintf wrapper
Date: Mon,  5 Mar 2012 20:38:52 +0100
Message-Id: <1330976334-10751-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/xalloc.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/xalloc.h b/include/xalloc.h
index feeb114..8c22ff7 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -63,4 +63,15 @@ static inline char *xstrdup(const char *str)
         return ret;
 }
 
+static inline int xasprintf(char **strp, char *fmt, ...)
+{
+	int ret;
+	va_list args;
+	va_start(args, fmt);
+	ret = vasprintf(&(*strp), fmt, args);
+	va_end(args);
+	if (ret < 0)
+		err(XALLOC_EXIT_CODE, "cannot allocate string");
+	return ret;
+}
 #endif
-- 
1.7.9.2

