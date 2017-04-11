Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61036 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754088AbdDKIGK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Apr 2017 04:06:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] hwclock: fix non-linux build
Date: Tue, 11 Apr 2017 10:05:55 +0200
Message-Id: <1491897955-22436-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

There was one missing ifdef since 336f7c5f.

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/hwclock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 3875bcc..3e0d6e9 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1520,9 +1520,12 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!(ctl.show | ctl.set | ctl.systohc | ctl.hctosys |
-	     ctl.systz | ctl.adjust | ctl.getepoch | ctl.setepoch |
-	     ctl.predict | ctl.get))
+	if (!(ctl.show | ctl.set | ctl.systohc | ctl.hctosys
+	     | ctl.systz | ctl.adjust | ctl.predict | ctl.get
+#ifdef __linux__
+	     | ctl.getepoch | ctl.setepoch
+#endif
+	     ))
 		ctl.show = 1;	/* default to show */
 
 #ifdef __linux__
-- 
1.8.5.6

