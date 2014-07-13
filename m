Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:60024 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:44 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so3306318wes.18
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/14] lscpu: avoid double free
Date: Sun, 13 Jul 2014 21:24:53 +0100
Message-Id: <1405283093-28182-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The double free was possible for architectures other than x86_64 or i386.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu-dmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 251d4ac..6c870a1 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -258,7 +258,7 @@ int read_hypervisor_dmi(void)
 	if (rc)
 		goto done;
 	free(buf);
-
+	buf = NULL;
 memory_scan:
 #if defined(__x86_64__) || defined(__i386__)
 	/* Fallback to memory scan (x86, x86_64) */
-- 
2.0.1

