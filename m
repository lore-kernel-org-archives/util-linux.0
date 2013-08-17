Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:33207 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:21 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so2561875wes.24
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/16] include: carefulput: print determined char when unprintable char is found
Date: Sat, 17 Aug 2013 19:15:11 +0100
Message-Id: <1376763321-22782-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is done to allow reuse of the functin in last(1).

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/carefulputc.h | 4 ++--
 term-utils/wall.c     | 2 +-
 term-utils/write.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/carefulputc.h b/include/carefulputc.h
index 2d857eb..d4d0ee4 100644
--- a/include/carefulputc.h
+++ b/include/carefulputc.h
@@ -10,7 +10,7 @@
 #define iso8859x_iscntrl(c) \
 	(((c) & 0x7f) < 0x20 || (c) == 0x7f)
 
-static inline int carefulputc(int c, FILE *fp) {
+static inline int carefulputc(int c, FILE *fp, const char fail) {
 	int ret;
 
 	if (c == '\007' || c == '\t' || c == '\r' || c == '\n' ||
@@ -19,7 +19,7 @@ static inline int carefulputc(int c, FILE *fp) {
 	else if ((c & 0x80) || !isprint(c^0x40))
 		ret = fprintf(fp, "\\%3o", (unsigned char) c);
 	else {
-		ret = putc('^', fp);
+		ret = putc(fail, fp);
 		if (ret != EOF)
 			ret = putc(c^0x40, fp);
 	}
diff --git a/term-utils/wall.c b/term-utils/wall.c
index f094073..2d87e47 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -286,7 +286,7 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 					cnt = 0;
 				}
 				if (ch != '\n')
-					carefulputc(ch, fp);
+					carefulputc(ch, fp, '^');
 			}
 		}
 	}
diff --git a/term-utils/write.c b/term-utils/write.c
index 83937d3..cb3b044 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -372,7 +372,7 @@ void wr_fputs(char *s)
 {
 	char c;
 
-#define	PUTC(c)	if (carefulputc(c, stdout) == EOF) \
+#define	PUTC(c)	if (carefulputc(c, stdout, '^') == EOF) \
     err(EXIT_FAILURE, _("carefulputc failed"));
 	while (*s) {
 		c = *s++;
-- 
1.8.3.4

