Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:64471 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbaK3N6L (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:11 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so14905050wiv.14
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:10 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/10] strutils: fix unsigned integer overflows [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:38 +0000
Message-Id: <1417355862-16935-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

include/strutils.h:174:10: runtime error: unsigned integer overflow: 0 -
1 cannot be represented in type 'size_t' (aka 'unsigned long')

include/strutils.h:178:6: runtime error: unsigned integer overflow:
18446744073709551615 + 1 cannot be represented in type 'size_t' (aka
'unsigned long')

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/strutils.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index cfe8a95..4d8463a 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -171,11 +171,14 @@ static inline size_t rtrim_whitespace(unsigned char *str)
 {
 	size_t i = strlen((char *) str);
 
-	while (i--) {
-		if (!isspace(str[i]))
+	while (i) {
+		i--;
+		if (!isspace(str[i])) {
+			i++;
 			break;
+		}
 	}
-	str[++i] = '\0';
+	str[i] = '\0';
 	return i;
 }
 
-- 
2.1.3

