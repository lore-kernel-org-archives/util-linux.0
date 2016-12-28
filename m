Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f67.google.com ([209.85.214.67]:36617 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbcL1JlT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 28 Dec 2016 04:41:19 -0500
Received: by mail-it0-f67.google.com with SMTP id n68so35701105itn.3
        for <util-linux@vger.kernel.org>; Wed, 28 Dec 2016 01:40:37 -0800 (PST)
From: The Flying Rapist <impeccableenglish@gmail.com>
To: util-linux@vger.kernel.org
Cc: The Flying Rapist <admin@nosuck.org>
Subject: [PATCH] col: backspacing widechars
Date: Wed, 28 Dec 2016 04:36:20 -0500
Message-Id: <20161228093620.5528-1-ImpeccableEnglish@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: The Flying Rapist <admin@nosuck.org>

Until now, backspace characters have not accounted for characters of widths other than one.  This single line amends that.
---
 text-utils/col.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/col.c b/text-utils/col.c
index 9b0e23058..c63b46fee 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -248,7 +248,7 @@ int main(int argc, char **argv)
 			case BS:		/* can't go back further */
 				if (cur_col == 0)
 					continue;
-				--cur_col;
+				cur_col -= c->c_width;
 				continue;
 			case CR:
 				cur_col = 0;
-- 
2.11.0

