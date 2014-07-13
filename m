Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64189 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:31 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so2531100wgh.8
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/14] dmesg: avoid unnecessary variable assignment
Date: Sun, 13 Jul 2014 21:24:48 +0100
Message-Id: <1405283093-28182-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 147a3ff..f95609f 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -612,7 +612,7 @@ static void safe_fwrite(const char *buf, size_t size, FILE *out)
 	for (i = 0; i < size; i++) {
 		const char *p = buf + i;
 		int rc, hex = 0;
-	        size_t len = 1;
+		size_t len;
 
 #ifdef HAVE_WIDECHAR
 		wchar_t wc;
@@ -629,6 +629,7 @@ static void safe_fwrite(const char *buf, size_t size, FILE *out)
 		}
 		i += len - 1;
 #else
+		len = 1;
 		if (!isprint((unsigned int) *p) &&
 			!isspace((unsigned int) *p))        /* non-printable */
 			hex = 1;
-- 
2.0.1

