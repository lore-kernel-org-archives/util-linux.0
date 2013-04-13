Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37367 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab3DMT4J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:09 -0400
Received: by mail-wi0-f172.google.com with SMTP id hr17so508304wib.5
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 22/33] wdctl: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:50 +0100
Message-Id: <1365882901-11429-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/wdctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 24ec770..af9a393 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -330,7 +330,8 @@ static int set_watchdog(struct wdinfo *wd, int timeout)
 		warn(_("cannot set timeout for %s"), wd->device);
 	}
 
-	close(fd);
+	if (close_fd(fd))
+		warn(_("write failed"));
 	sigprocmask(SIG_SETMASK, &oldsigs, NULL);
 	printf("Set timeout to %d seconds\n", timeout);
 
@@ -393,7 +394,8 @@ static int read_watchdog(struct wdinfo *wd)
 		 * the machine might end up rebooting. */
 	}
 
-	close(fd);
+	if (close_fd(fd))
+		warn(_("write failed"));
 	sigprocmask(SIG_SETMASK, &oldsigs, NULL);
 
 	return 0;
-- 
1.8.2.1

