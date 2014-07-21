Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:42522 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751483AbaGUCU5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Jul 2014 22:20:57 -0400
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix typeo in wipefs
Date: Sun, 20 Jul 2014 22:19:33 -0400
Message-Id: <1405909173-21826-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The message said "ioclt" instead of "ioctl".

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 misc-utils/wipefs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 2c1ea59..ad7caa5 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -358,7 +358,7 @@ static void rereadpt(int fd, const char *devname)
 
 	errno = 0;
 	ioctl(fd, BLKRRPART);
-	printf(_("%s: calling ioclt to re-read partition table: %m\n"), devname);
+	printf(_("%s: calling ioctl to re-read partition table: %m\n"), devname);
 #endif
 }
 
-- 
1.9.1

