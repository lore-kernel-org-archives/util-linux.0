Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f181.google.com ([209.85.215.181]:41471 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:41 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so2524173eae.40
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/34] lscpu: fix memory leak [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:30 +0100
Message-Id: <1373226889-3451-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu-dmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 21e024b..8f02779 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -130,8 +130,10 @@ static int hypervisor_from_dmi_table(uint32_t base, uint16_t len,
 		 * is invalid, but we cannot reliably locate the next entry.
 		 * Better stop at this point.
 		 */
-		if (h.length < 4)
+		if (h.length < 4) {
+			free(data);
 			return HYPER_NONE;
+		}
 
 		/* look for the next handle */
 		next = data + h.length;
-- 
1.8.3.2

