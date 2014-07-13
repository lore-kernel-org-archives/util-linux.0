Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36695 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbaGMUZL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:11 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so3237006wgg.4
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/14] setterm: remove unnecessary variable
Date: Sun, 13 Jul 2014 21:24:42 +0100
Message-Id: <1405283093-28182-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index afbd274..f21466e 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -770,12 +770,11 @@ static void screendump(struct setterm_control *ctl)
 	size_t i, j;
 	ssize_t rc;
 	char *inbuf, *outbuf, *p, *q;
-	char dump_default[] = "screen.dump";
 
 	/* open source and destination files */
 	fd = open_snapshot_device(ctl);
 	if (!ctl->opt_sn_name)
-		ctl->opt_sn_name = dump_default;
+		ctl->opt_sn_name = "screen.dump";
 	out = fopen(ctl->opt_sn_name, ctl->opt_snap ? "w" : "a");
 	if (!out)
 		err(EXIT_DUMPFILE, _("can not open dump file %s for output"), ctl->opt_sn_name);
-- 
2.0.1

