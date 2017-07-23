Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38610 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdGWVUl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Jul 2017 17:20:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id r123so1126561wmb.5
        for <util-linux@vger.kernel.org>; Sun, 23 Jul 2017 14:20:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] wdctl: do not call fsync(2) when closing watchdog device
Date: Sun, 23 Jul 2017 22:20:37 +0100
Message-Id: <20170723212037.923-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This removes bogus write failed warning.

$ wdctl
wdctl: write failed: Invalid argument
Device:        /dev/watchdog
[...]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/wdctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 33012dca3..642db85d2 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -343,7 +343,7 @@ static int set_watchdog(struct wdinfo *wd, int timeout)
 		warn(_("cannot set timeout for %s"), wd->device);
 	}
 
-	if (close_fd(fd))
+	if (close(fd))
 		warn(_("write failed"));
 	sigprocmask(SIG_SETMASK, &oldsigs, NULL);
 	printf(P_("Timeout has been set to %d second.\n",
@@ -408,7 +408,7 @@ static int read_watchdog(struct wdinfo *wd)
 		 * the machine might end up rebooting. */
 	}
 
-	if (close_fd(fd))
+	if (close(fd))
 		warn(_("write failed"));
 	sigprocmask(SIG_SETMASK, &oldsigs, NULL);
 
-- 
2.13.3

