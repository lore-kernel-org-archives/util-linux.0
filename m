Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:49593 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbaBUKRS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Feb 2014 05:17:18 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so2402721wes.9
        for <util-linux@vger.kernel.org>; Fri, 21 Feb 2014 02:17:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] more: fix double free crash
Date: Fri, 21 Feb 2014 10:17:11 +0000
Message-Id: <1392977831-3789-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit b9579f1f44b46c9f12f1e01b01c02d82ae1cf728 moved fclose() to
checkf(), but missed removing file closure in magic().  Ironically the
cause of regression is in previous commit message.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 4c39887..8fe4142 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -640,7 +640,6 @@ static int magic(FILE *f, char *fs)
 		case 0x457f:	/* simple ELF detection */
 			printf(_("\n******** %s: Not a text file ********\n\n"),
 			       fs);
-			fclose(f);
 			return 1;
 		}
 	}
-- 
1.9.0

