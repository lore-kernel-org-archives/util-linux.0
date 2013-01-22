Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:50559 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:42 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so191110wib.0
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/14] hwclock: make usage() change translator friendly
Date: Tue, 22 Jan 2013 23:27:08 +0000
Message-Id: <1358897233-6676-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --compare option from 83765871ef0d6c554c46027577648b77c7351a78 is
made to be separate fputs() line.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 04aa650..c7c14df 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1443,8 +1443,8 @@ static void usage(const char *fmt, ...)
 		" -w, --systohc        set the hardware clock from the current system time\n"
 		"     --systz          set the system time based on the current timezone\n"
 		"     --adjust         adjust the RTC to account for systematic drift since\n"
-		"                        the clock was last set or adjusted\n"
-		" -c, --compare        periodically compare the system clock with the CMOS clock\n"), usageto);
+		"                        the clock was last set or adjusted\n"), usageto);
+	fputs(_(" -c, --compare        periodically compare the system clock with the CMOS clock\n"), usageto);
 #ifdef __linux__
 	fputs(_("     --getepoch       print out the kernel's hardware clock epoch value\n"
 		"     --setepoch       set the kernel's hardware clock epoch value to the \n"
-- 
1.8.1.1

