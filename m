Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52340 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3G1VLq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:46 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so1815770wiw.1
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] rev: use string printing rather than character output
Date: Sun, 28 Jul 2013 22:11:21 +0100
Message-Id: <1375045881-11978-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fliping a string in memory, and printing it with multibyte output
function makes the command about 1/3 quicker.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/rev.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index 1c44036..85e1630 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -86,10 +86,20 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static void reverse_str(wchar_t *str, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n / 2; ++i) {
+		wchar_t tmp = str[i];
+		str[i] = str[n - 1 - i];
+		str[n - 1 - i] = tmp;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	char *filename = "stdin";
-	wchar_t *t;
 	size_t len, bufsiz = BUFSIZ;
 	FILE *fp = stdin;
 	int ch, rval = EXIT_SUCCESS;
@@ -153,13 +163,8 @@ int main(int argc, char *argv[])
 
 				len = wcslen(buf);
 			}
-
-			if (*(t = buf + len - 1) == '\n')
-				--t;
-			for ( ; buf <= t; --t)
-				putwchar(*t);
-			if (!feof(fp))
-				putwchar('\n');
+			reverse_str(buf, len - 1);
+			fputws(buf, stdout);
 		}
 		if (ferror(fp)) {
 			warn("%s", filename);
-- 
1.8.3.4

