Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38743 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab3AZPtN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jan 2013 10:49:13 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so368794wib.4
        for <util-linux@vger.kernel.org>; Sat, 26 Jan 2013 07:49:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] dmesg: fix typo
Date: Sat, 26 Jan 2013 15:42:26 +0000
Message-Id: <1359214946-13515-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

My mistake in commit fbbc4c88d5273c46db065594493261eb9bb1a2c4.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index a307d84..48c121f 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -236,7 +236,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		fprintf(stderr, " %7s - %s\n",
 			level_names[i].name,
 			_(level_names[i].help));
-	fputc(USAGE_SEPARATOR, out);
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_MAN_TAIL("dmesg(q)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.8.1.1

