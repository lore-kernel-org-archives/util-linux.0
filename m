Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34524 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcEIV1l (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so22482502wmn.1
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/12] write: remove pointless fileno(3) calls
Date: Mon,  9 May 2016 22:27:19 +0100
Message-Id: <1462829248-6935-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index e8532f6..4c6a25f 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -312,12 +312,12 @@ int main(int argc, char **argv)
 		}
 
 	/* check that sender has write enabled */
-	if (isatty(fileno(stdin)))
-		myttyfd = fileno(stdin);
-	else if (isatty(fileno(stdout)))
-		myttyfd = fileno(stdout);
-	else if (isatty(fileno(stderr)))
-		myttyfd = fileno(stderr);
+	if (isatty(STDIN_FILENO))
+		myttyfd = STDIN_FILENO;
+	else if (isatty(STDOUT_FILENO))
+		myttyfd = STDOUT_FILENO;
+	else if (isatty(STDERR_FILENO))
+		myttyfd = STDERR_FILENO;
 	else
 		myttyfd = -1;
 
-- 
2.8.2

