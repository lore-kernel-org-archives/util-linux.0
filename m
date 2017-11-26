Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43584 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdKZRr6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Nov 2017 12:47:58 -0500
Received: by mail-wm0-f66.google.com with SMTP id x63so29992315wmf.2
        for <util-linux@vger.kernel.org>; Sun, 26 Nov 2017 09:47:58 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] eject: remove list_speeds() #ifdef CDROM_SELECT_SPEED protection
Date: Sun, 26 Nov 2017 17:47:51 +0000
Message-Id: <20171126174751.10500-3-kerolasa@iki.fi>
In-Reply-To: <20171126174751.10500-1-kerolasa@iki.fi>
References: <20171126174751.10500-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The CDROM_SELECT_SPEED should be available practically everywhere.  Where
the define is missing an error message about path /proc/sys/dev/cdrom/info
cannot be opened is better error than a warnx() about kernel support.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index aa90ff72f..a38c5c38c 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -548,7 +548,6 @@ static int read_speed(const char *devname)
  */
 static void list_speeds(struct eject_control *ctl)
 {
-#ifdef CDROM_SELECT_SPEED
 	int max_speed, curr_speed = 0;
 
 	select_speed(ctl);
@@ -565,9 +564,6 @@ static void list_speeds(struct eject_control *ctl)
 	}
 
 	printf("\n");
-#else
-	warnx(_("CD-ROM select speed command not supported by this kernel"));
-#endif
 }
 
 /*
-- 
2.15.0

