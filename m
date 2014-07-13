Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:64519 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:14 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so3283333wgh.9
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/14] lscpu: avoid use of bzero() in favor of memset()
Date: Sun, 13 Jul 2014 21:24:43 +0100
Message-Id: <1405283093-28182-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The bzero() is marked as LEGACY in POSIX.1-2001.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b64c1f9..062dff5 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -690,7 +690,7 @@ is_vmware_platform(void)
 	if (sigsetjmp(segv_handler_env, 1))
 		return 0;
 
-	bzero(&act, sizeof(act));
+	memset(&act, 0, sizeof(act));
 	act.sa_sigaction = segv_handler;
 	act.sa_flags = SA_SIGINFO;
 
-- 
2.0.1

