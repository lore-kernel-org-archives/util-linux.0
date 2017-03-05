Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33854 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdCEUwo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:44 -0500
Received: by mail-wr0-f196.google.com with SMTP id u48so19504442wrc.1
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/13] blkid: add curly braces to do-while statement
Date: Sun,  5 Mar 2017 20:52:24 +0000
Message-Id: <20170305205232.24030-6-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some say people read do-while statements are easily as while statements and
get wrong impression.  This happens because do-whiles are not common.
Adding braces should make it easier to read the code.

Reference: http://www.spinics.net/lists/linux-kernel-janitors/msg02018.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 9278553c7..7bbb54dfd 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -139,9 +139,9 @@ static int pretty_print_word(const char *str, int max_len,
 		len = 0;
 	} else if (len > max_len)
 		ret = len - max_len;
-	do
+	do {
 		fputc(' ', stdout);
-	while (len++ < max_len);
+	} while (len++ < max_len);
 	return ret;
 }
 
-- 
2.12.0

