Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdGBTwD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Jul 2017 15:52:03 -0400
Subject: [PATCH 2/5] hwclock: usage() use program_invocation_short_name
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d0d5b0b9-184d-7733-3116-406c9033d927@gmx.com>
Date: Sun, 2 Jul 2017 15:51:46 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 8b1e2f3..eeb68e7 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1203,7 +1203,7 @@ static void __attribute__((__noreturn__))
 usage(const struct hwclock_control *ctl)
 {
 	fputs(USAGE_HEADER, stdout);
-	puts(_(" hwclock [function] [option...]"));
+	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
 	puts(_("Query or set the RTC (Real Time Clock / Hardware Clock)"));
@@ -1222,8 +1222,10 @@ usage(const struct hwclock_control *ctl)
 #endif
 	puts(_("     --predict        predict the drifted RTC time according to --date"));
 	fputs(USAGE_OPTIONS, stdout);
-	puts(_(" -u, --utc            inform hwclock the RTC timescale is UTC"));
-	puts(_(" -l, --localtime      inform hwclock the RTC timescale is Local"));
+	printf(_(
+	       " -u, --utc            inform %s the RTC timescale is UTC\n"), program_invocation_short_name);
+	printf(_(
+	       " -l, --localtime      inform %s the RTC timescale is Local\n"), program_invocation_short_name);
 #ifdef __linux__
 	printf(_(
 	       " -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);
