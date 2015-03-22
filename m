Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33455 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbCVXFf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Mar 2015 19:05:35 -0400
Received: by wgbcc7 with SMTP id cc7so132501590wgb.0
        for <util-linux@vger.kernel.org>; Sun, 22 Mar 2015 16:05:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/5] dmesg: fix shadow declaration
Date: Sun, 22 Mar 2015 23:05:26 +0000
Message-Id: <1427065530-10695-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
References: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/dmesg.c:650:9: warning: declaration of 's' shadows a previous local [-Wshadow]
sys-utils/dmesg.c:619:12: warning: shadowed declaration is here [-Wshadow]

And since the code had to be touched deprecate loop printing one character
at a time, in favour of printf and instruction to repeat spaces the number
required.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 5a6ee41..b56199f 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -614,7 +614,6 @@ static int fwrite_hex(const char *buf, size_t size, FILE *out)
 static void safe_fwrite(const char *buf, size_t size, int indent, FILE *out)
 {
 	size_t i;
-	int in;
 #ifdef HAVE_WIDECHAR
 	mbstate_t s;
 	memset(&s, 0, sizeof (s));
@@ -647,13 +646,9 @@ static void safe_fwrite(const char *buf, size_t size, int indent, FILE *out)
 		if (hex)
 			rc = fwrite_hex(p, len, out);
 		else if (*p == '\n' && *(p + 1) && indent) {
-			char s = ' ';
-			rc = fwrite(p, 1, len, out) != len;
-			in = indent;
-			do {
-				if (!rc) rc = fwrite(&s, 1, 1, out) != 1;
-				in--;
-			} while (in && !rc);
+		        rc = fwrite(p, 1, len, out) != len;
+			if (fprintf(out, "%*s", indent, "") != indent)
+				rc |= 1;
 		}
 		else
 			rc = fwrite(p, 1, len, out) != len;
-- 
2.3.3

