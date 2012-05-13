Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:45009 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab2EMTOw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 May 2012 15:14:52 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mangle: check for end of string on every iteration
Date: Sun, 13 May 2012 15:14:49 -0400
Message-Id: <1336936489-8203-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Checking for the null byte at the end of the string only conditionally
leads to segfaults, evidenced by mount helpers crashing on writes to
/run/mount/utab. Simply check for the null on each iteration, and append
a null byte to the mangled string before breaking.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 lib/mangle.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/mangle.c b/lib/mangle.c
index e1b4814..656918c 100644
--- a/lib/mangle.c
+++ b/lib/mangle.c
@@ -31,16 +31,17 @@ char *mangle(const char *s)
 	if (!sp)
 		return NULL;
 	while(1) {
+		if (!*s) {
+			*sp = '\0';
+			break;
+		}
 		if (is_unwanted_char(*s)) {
 			*sp++ = '\\';
 			*sp++ = '0' + ((*s & 0300) >> 6);
 			*sp++ = '0' + ((*s & 070) >> 3);
 			*sp++ = '0' + (*s & 07);
-		} else {
+		} else
 			*sp++ = *s;
-			if (!*s)
-				break;
-		}
 		s++;
 	}
 	return ss;
-- 
1.7.10.2

