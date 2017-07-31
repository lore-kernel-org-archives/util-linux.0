Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37899 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdGaTz2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id g32so15163253wrd.5
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 9/9] agetty: fix invalid usage crash
Date: Mon, 31 Jul 2017 20:55:08 +0100
Message-Id: <20170731195508.11661-10-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ agetty
agetty: not enough arguments: Success
Segmentation fault (core dumped)

Reference: 9325dbfd2018b2a3b510617f4aa13777fbbe23c3
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index f06b9fc6e..d9e9548fa 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -803,7 +803,8 @@ static void parse_args(int argc, char **argv, struct options *op)
 
 	if (argc < optind + 1) {
 		log_warn(_("not enough arguments"));
-		warn(_("not enough arguments"));
+		warnx(_("not enough arguments"));
+		errtryhelp(EXIT_FAILURE);
 	}
 
 	/* Accept "tty", "baudrate tty", and "tty baudrate". */
@@ -812,7 +813,8 @@ static void parse_args(int argc, char **argv, struct options *op)
 		parse_speeds(op, argv[optind++]);
 		if (argc < optind + 1) {
 			log_warn(_("not enough arguments"));
-			warn(_("not enough arguments"));
+			warnx(_("not enough arguments"));
+			exit(EXIT_FAILURE);
 		}
 		op->tty = argv[optind++];
 	} else {
-- 
2.13.3

