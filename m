Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36434 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbDPP0h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 16 Apr 2015 11:26:37 -0400
Received: by wgsk9 with SMTP id k9so84646593wgs.3
        for <util-linux@vger.kernel.org>; Thu, 16 Apr 2015 08:26:35 -0700 (PDT)
From: Alexey Galakhov <agalakhov@gmail.com>
To: util-linux@vger.kernel.org
Cc: Alexey Galakhov <agalakhov@gmail.com>
Subject: [PATCH] hwclock: flush stdout in hwclock -c
Date: Thu, 16 Apr 2015 17:26:27 +0200
Message-Id: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows using hwclock -c in automated test scripts that parse
its output line-by-line. The standard output is flushed before
each 10 second delay.

Signed-off-by: Alexey Galakhov <agalakhov@gmail.com>
---
 sys-utils/hwclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e1e5816..4cdb2ea 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1532,6 +1532,7 @@ static int compare_clock (const bool utc, const bool local_opt)
 			printf("hw-time      system-time         freq-offset-ppm   tick\n");
 			printf("%10.0f   %10.6f\n", (double) time1_hw, time1_sys);
 		}
+		fflush(stdout);
 		sleep(10);
 	}
 
-- 
2.3.5

