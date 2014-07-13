Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:61978 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:40 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so3260785wes.22
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/14] libsmartcols: avoid variable dereference after release
Date: Sun, 13 Jul 2014 21:24:52 +0100
Message-Id: <1405283093-28182-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libsmartcols/src/line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsmartcols/src/line.c b/libsmartcols/src/line.c
index ab2f191..6e83fb4 100644
--- a/libsmartcols/src/line.c
+++ b/libsmartcols/src/line.c
@@ -199,9 +199,9 @@ int scols_line_remove_child(struct libscols_line *ln, struct libscols_line *chil
 	DBG(LINE, ul_debugobj(ln, "remove child %p", child));
 
 	list_del_init(&child->ln_children);
+	child->parent = NULL;
 	scols_unref_line(child);
 
-	child->parent = NULL;
 	scols_unref_line(ln);
 	return 0;
 }
-- 
2.0.1

