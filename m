Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab2JNUVa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:30 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680285wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/19] hwclock: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:21:01 +0100
Message-Id: <1350246070-10544-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock-kd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock-kd.c b/sys-utils/hwclock-kd.c
index bfe50dc..c000024 100644
--- a/sys-utils/hwclock-kd.c
+++ b/sys-utils/hwclock-kd.c
@@ -12,7 +12,6 @@
 # include <unistd.h>
 
 # include "nls.h"
-# include "usleep.h"
 
 /* Get defines for KDGHWCLK and KDSHWCLK (m68k) */
 # include <linux/kd.h>
@@ -68,7 +67,10 @@ static int synchronize_to_clock_tick_kd(void)
 		 *  A2000 RTCs and simply hangs after some time. Inserting a
 		 *  sleep helps."
 		 */
-		usleep(1);
+		struct timespec waittime;
+		waittime.tv_sec = 0;
+		waittime.tv_nsec = 1000;
+		nanosleep(&waittime, NULL);
 
 		if (ioctl(con_fd, KDGHWCLK, &nowtime) == -1) {
 			warn(_("KDGHWCLK ioctl to read time failed in loop"));
-- 
1.7.12.2

