Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:44981 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbaIGMnP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:15 -0400
Received: by mail-we0-f182.google.com with SMTP id w62so13831310wes.27
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/17] include: simplify fputc_careful() in carefulputc.h
Date: Sun,  7 Sep 2014 13:42:50 +0100
Message-Id: <1410093785-17537-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

New version of comparisions does the same thing as the old without being
quite as difficult to understand.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/carefulputc.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index f29dc69..c116d0a 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -10,26 +10,22 @@
 #include <string.h>
 #include <ctype.h>
 
-#define iso8859x_iscntrl(c) \
-	(((c) & 0x7f) < 0x20 || (c) == 0x7f)
-
-static inline int fputc_careful(int c, FILE *fp, const char fail) {
+static inline int fputc_careful(int c, FILE *fp, const char fail)
+{
 	int ret;
 
-	if (c == '\007' || c == '\t' || c == '\r' || c == '\n' ||
-	    (!iso8859x_iscntrl(c) && (isprint(c) || isspace(c))))
+	if (isprint(c) || c == '\a' || c == '\t' || c == '\r' || c == '\n')
 		ret = putc(c, fp);
-	else if ((c & 0x80) || !isprint(c^0x40))
-		ret = fprintf(fp, "\\%3o", (unsigned char) c);
+	else if (!isascii(c))
+		ret = fprintf(fp, "\\%3o", (unsigned char)c);
 	else {
 		ret = putc(fail, fp);
 		if (ret != EOF)
-			ret = putc(c^0x40, fp);
+			ret = putc(c ^ 0x40, fp);
 	}
 	return (ret < 0) ? EOF : 0;
 }
 
-
 static inline void fputs_quoted(const char *data, FILE *out)
 {
 	const char *p;
-- 
2.1.0

