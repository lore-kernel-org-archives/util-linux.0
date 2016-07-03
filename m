Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33417 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id r201so17540408wme.0
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/15] write: remove PUTC macro
Date: Sun,  3 Jul 2016 22:23:54 +0100
Message-Id: <20160703212358.1218-12-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Function like macros make following the execution flow unnecessarily
difficult, and deserves to be removed.

Requested-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 696a7a7..517bd88 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -220,18 +220,15 @@ static void signal_handler(int signo)
  */
 static void write_line(char *s)
 {
-	char c;
-
-#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
-    err(EXIT_FAILURE, _("carefulputc failed"));
 	while (*s) {
-		c = *s++;
-		if (c == '\n')
-			PUTC('\r');
-		PUTC(c);
+		const int c = *s++;
+
+		if (c == '\n' && fputc_careful('\r', stdout, '^') == EOF)
+			goto fail;
+		if (fputc_careful(c, stdout, '^') == EOF)
+ fail:
+			err(EXIT_FAILURE, _("carefulputc failed"));
 	}
-	return;
-#undef PUTC
 }
 
 /*
-- 
2.9.0

