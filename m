Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:53255 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVOmg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:36 -0500
Received: by mail-wg0-f48.google.com with SMTP id l18so21212392wgh.7
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/13] rtcwake: fix preprocessor redefinition
Date: Sun, 22 Feb 2015 14:42:13 +0000
Message-Id: <1424616139-638-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The RTC_AF is expected to be part of linux/rtc.h file.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 4aa4fd3..c3e0eb6 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -43,10 +43,9 @@
 #include "closestream.h"
 #include "timeutils.h"
 
-/* constants from legacy PC/AT hardware */
-#define	RTC_PF	0x40
-#define	RTC_AF	0x20
-#define	RTC_UF	0x10
+#ifndef RTC_AF
+# define	RTC_AF	0x20	/* Alarm interrupt */
+#endif
 
 #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
 #define SYS_POWER_STATE_PATH	"/sys/power/state"
-- 
2.3.0

