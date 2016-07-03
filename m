Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35858 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbcGCVYH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so17534810wme.3
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/15] write: remove pointless fileno(3) calls
Date: Sun,  3 Jul 2016 22:23:46 +0100
Message-Id: <20160703212358.1218-4-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index b8bd08e..03af660 100644
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
2.9.0

