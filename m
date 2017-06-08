Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35244 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdFHTwa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so8876251wmc.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/11] uuidgen: slice up the usage text
Date: Thu,  8 Jun 2017 20:52:08 +0100
Message-Id: <20170608195215.1702-5-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidgen.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 911fead72..4c1d47d5e 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -28,11 +28,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("Create a new UUID value.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -r, --random     generate random-based uuid\n"
-		" -t, --time       generate time-based uuid\n"
-		" -V, --version    output version information and exit\n"
-		" -h, --help       display this help and exit\n\n"), out);
-
+	fputs(_(" -r, --random     generate random-based uuid\n"), out);
+	fputs(_(" -t, --time       generate time-based uuid\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("uuidgen(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
2.13.1

