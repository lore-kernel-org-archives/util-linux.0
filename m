Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34005 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbcIDKPl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 4 Sep 2016 06:15:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so8943417wmv.1
        for <util-linux@vger.kernel.org>; Sun, 04 Sep 2016 03:15:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] lib/strutils: make left and right trims more robust
Date: Sun,  4 Sep 2016 11:15:34 +0100
Message-Id: <20160904101534.17460-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Do not follow null pointer, and stop going any further when
ltrim_whitespace() is at the end of a string.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/strutils.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 52c28b7..51d9c9f 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -178,8 +178,11 @@ static inline const char *skip_blank(const char *p)
  */
 static inline size_t rtrim_whitespace(unsigned char *str)
 {
-	size_t i = strlen((char *) str);
+	size_t i;
 
+	if (!str)
+		return 0;
+	i = strlen((char *) str);
 	while (i) {
 		i--;
 		if (!isspace(str[i])) {
@@ -200,7 +203,9 @@ static inline size_t ltrim_whitespace(unsigned char *str)
 	size_t len;
 	unsigned char *p;
 
-	for (p = str; p && isspace(*p); p++);
+	if (!str)
+		return 0;
+	for (p = str; *p && isspace(*p); p++);
 
 	len = strlen((char *) p);
 
-- 
2.9.3

