Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f53.google.com ([74.125.83.53]:47586 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3H0SGm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:42 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so2421705eek.26
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/17] last: fix typo
Date: Tue, 27 Aug 2013 19:06:05 +0100
Message-Id: <1377626779-26030-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 8d944a8..3367038 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -433,7 +433,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
-	fprintf(out, USAGE_MAN_TAIL("last(1))"));
+	fprintf(out, USAGE_MAN_TAIL("last(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.8.4

