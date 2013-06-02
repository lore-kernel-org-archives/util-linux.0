Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55797 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab3FBRwQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:16 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so2515274wgh.3
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/19] rev: reduce stream checking when closing read-only file descriptor
Date: Sun,  2 Jun 2013 18:51:18 +0100
Message-Id: <1370195485-27907-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/rev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index 1665772..1c44036 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -161,14 +161,11 @@ int main(int argc, char *argv[])
 			if (!feof(fp))
 				putwchar('\n');
 		}
-
-		fflush(fp);
 		if (ferror(fp)) {
 			warn("%s", filename);
 			rval = EXIT_FAILURE;
 		}
-		if (fclose(fp))
-			rval = EXIT_FAILURE;
+		fclose(fp);
 	} while(*argv);
 
 	free(buf);
-- 
1.8.3

