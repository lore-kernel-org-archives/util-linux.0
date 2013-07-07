Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f52.google.com ([74.125.83.52]:53243 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:03 -0400
Received: by mail-ee0-f52.google.com with SMTP id c50so2402824eek.39
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 22/34] rev: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:37 +0100
Message-Id: <1373226889-3451-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index 13249de..0764466 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -121,7 +121,6 @@ int main(int argc, char *argv[])
 			usage(stderr);
 		}
 
-	argc -= optind;
 	argv += optind;
 
 	buf = xmalloc(bufsiz * sizeof(wchar_t));
@@ -173,3 +172,4 @@ int main(int argc, char *argv[])
 	return rval;
 }
 
+ 
-- 
1.8.3.2

