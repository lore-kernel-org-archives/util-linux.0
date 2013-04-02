Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:42982 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:11 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so614019wey.18
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/13] agetty: the command does not have -h and -V options
Date: Tue,  2 Apr 2013 20:42:47 +0100
Message-Id: <1364931777-2645-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index f745e68..311582c 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1662,9 +1662,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_("     --long-hostname        show full qualified hostname\n"), out);
 	fputs(_("     --erase-chars <string> additional backspace chars\n"), out);
 	fputs(_("     --kill-chars <string>  additional kill chars\n"), out);
-	fputs(USAGE_SEPARATOR, out);
-	fputs(USAGE_HELP, out);
-	fputs(USAGE_VERSION, out);
+	fputs(_("     --help                 display this help and exit\n"), out);
+	fputs(_("     --version              output version information and exit\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("agetty(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-- 
1.8.2

