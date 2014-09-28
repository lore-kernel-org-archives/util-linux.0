Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:37653 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1Tws (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:48 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so3054406wes.31
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/23] include/debug: remove duplicate 'const' declaration warning
Date: Sun, 28 Sep 2014 20:51:47 +0100
Message-Id: <1411933916-30576-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

./include/debug.h:89:55: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/debug.h b/include/debug.h
index 25045aa..4dfc1eb 100644
--- a/include/debug.h
+++ b/include/debug.h
@@ -86,7 +86,7 @@ ul_debugobj(void *handler, const char *mesg, ...)
 	fputc('\n', stderr);
 }
 
-static inline int parse_envmask(const struct dbg_mask const flagnames[],
+static inline int parse_envmask(const struct dbg_mask flagnames[],
 				const char *mask)
 {
 	int res;
-- 
2.1.1

