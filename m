Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:49034 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:18 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so5454579wes.6
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/12] libsmartcols: remove ununsed assignment
Date: Sun, 27 Apr 2014 21:05:36 +0100
Message-Id: <1398629138-31718-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Value stored to 'rc' is never read.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libsmartcols/src/table_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 2942053..4df587e 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -739,7 +739,7 @@ int scols_print_table(struct libscols_table *tb)
 		return -ENOMEM;
 
 	if (!(scols_table_is_raw(tb) || scols_table_is_export(tb)))
-		rc = recount_widths(tb, buf);
+		recount_widths(tb, buf);
 
 	if (scols_table_is_tree(tb))
 		rc = print_tree(tb, buf);
-- 
1.9.2

