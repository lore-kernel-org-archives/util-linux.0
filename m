Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f179.google.com ([209.85.215.179]:49471 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:10 -0400
Received: by mail-ea0-f179.google.com with SMTP id b15so2466639eae.38
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 24/34] hwclock: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:39 +0100
Message-Id: <1373226889-3451-25-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5dd7919..b6ceb4d 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1729,7 +1729,6 @@ int main(int argc, char **argv)
 	}
 
 	argc -= optind;
-	argv += optind;
 
 #ifdef HAVE_LIBAUDIT
 	if (testing != TRUE) {
-- 
1.8.3.2

