Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55085 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaGPUzS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jul 2014 16:55:18 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so6926004wiv.1
        for <util-linux@vger.kernel.org>; Wed, 16 Jul 2014 13:55:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] lib/colors: remove memory leak
Date: Wed, 16 Jul 2014 21:54:56 +0100
Message-Id: <1405544098-1740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/colors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/colors.c b/lib/colors.c
index cb342a0..8de1d2f 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -425,9 +425,9 @@ static int colors_add_scheme(struct ul_color_ctl *cc,
 		return -EINVAL;
 
 	rc = cn_sequence(seq0, &seq);
+	free(seq0);
 	if (rc)
 		return rc;
-	free(seq0);
 
 	/* convert logical name (e.g. "red") to real ESC code */
 	if (isalpha(*seq)) {
-- 
2.0.1

