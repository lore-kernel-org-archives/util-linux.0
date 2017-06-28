Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57408 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdF1QlH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:07 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: J William Piggott <elseifthen@gmx.com>
Subject: [PATCH 8/8] hwclock: don't ifdef printf arguments
Date: Wed, 28 Jun 2017 18:40:57 +0200
Message-Id: <1498668057-8256-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This may fails if printf() is macro, introduced in cc7cb070.

clang compiler warnings:

    CC       sys-utils/hwclock.o
  ../sys-utils/hwclock.c:1228:2: warning: embedding a directive within macro arguments has undefined behavior [-Wembedded-directive]
  #ifdef __linux__
   ^
  ../sys-utils/hwclock.c:1230:2: warning: embedding a directive within macro arguments has undefined behavior [-Wembedded-directive]
  #endif
   ^
  2 warnings generated.

CC: J William Piggott <elseifthen@gmx.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/hwclock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2f2c03a..a0a48dd 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1225,10 +1225,11 @@ usage(const struct hwclock_control *ctl)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -u, --utc            inform hwclock the RTC timescale is UTC\n"), out);
 	fputs(_(" -l, --localtime      inform hwclock the RTC timescale is Local\n"), out);
-	fprintf(out, _(
 #ifdef __linux__
-		" -f, --rtc <file>     use an alternate file to %1$s\n"
+	printf(_(
+		" -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);
 #endif
+	printf(_(
 		"     --directisa      use the ISA bus instead of %1$s access\n"), _PATH_RTC_DEV);
 	fputs(_("     --date <time>    date/time input for --set and --predict\n"), out);
 #if defined(__linux__) && defined(__alpha__)
-- 
1.8.5.6

