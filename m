Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62865 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805Ab3EBSzK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:55:10 -0400
Received: by mail-wi0-f174.google.com with SMTP id m6so924915wiv.13
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:55:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] dmesg: fix usage() typo
Date: Thu,  2 May 2013 19:55:03 +0100
Message-Id: <1367520903-15133-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index a89fb6c..6910fc7 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -264,7 +264,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 			level_names[i].name,
 			_(level_names[i].help));
 	fputs(USAGE_SEPARATOR, out);
-	fprintf(out, USAGE_MAN_TAIL("dmesg(q)"));
+	fprintf(out, USAGE_MAN_TAIL("dmesg(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.8.2.2

