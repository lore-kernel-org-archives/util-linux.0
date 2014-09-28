Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:52727 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaI1TwD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:03 -0400
Received: by mail-we0-f173.google.com with SMTP id p10so2448859wes.18
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/23] swapon: align available columns section in usage()
Date: Sun, 28 Sep 2014 20:51:34 +0100
Message-Id: <1411933916-30576-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 5db57cfc469b45ada0162a64d627ce25a3d2431f missed doing this change.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 976f87e..1170f9e 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -735,7 +735,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 	fputs(_("\nAvailable columns (for --show):\n"), out);
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
-		fprintf(out, " %4s  %s\n", infos[i].name, _(infos[i].help));
+		fprintf(out, " %-5s  %s\n", infos[i].name, _(infos[i].help));
 
 	fprintf(out, USAGE_MAN_TAIL("swapon(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-- 
2.1.1

