Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34501 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdBYRnE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Feb 2017 12:43:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id 89so5739527wrr.1
        for <util-linux@vger.kernel.org>; Sat, 25 Feb 2017 09:43:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] setterm: fix bitfield warning [smatch]
Date: Sat, 25 Feb 2017 17:35:17 +0000
Message-Id: <20170225173517.16922-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

term-utils/setterm.c:179:27: warning: dubious bitfield without explicit
`signed' or `unsigned'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 1cf59957b..8e969c2b3 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -176,7 +176,7 @@ struct setterm_control {
 	int opt_rt_len;		/* regular tab length */
 	int opt_tb_array[TABS_MAX + 1];	/* array for tab list */
 	/* colors */
-	int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;
+	unsigned int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;
 	/* boolean options */
 	unsigned int opt_cu_on:1, opt_li_on:1, opt_bo_on:1, opt_hb_on:1,
 	    opt_bl_on:1, opt_re_on:1, opt_un_on:1, opt_rep_on:1,
-- 
2.12.0

