Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbdGBTzn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Jul 2017 15:55:43 -0400
Subject: [PATCH 5/5] hwclock: sync one-liner descriptions
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <13c53c4b-8842-71b8-5d7c-827d5d8d04bd@gmx.com>
Date: Sun, 2 Jul 2017 15:55:26 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Make whatisdb/manpage and usage() one-line descriptions match.

Also update the description; hwclock has evolved into much more
than reading and setting the Hardware Clock. It also sets the
System Clock, warps the System Clock, sets the kernel time
configurations, and more.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 4 ++--
 sys-utils/hwclock.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 72b842e..fa8a19a 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -6,7 +6,7 @@
 .\"
 .TH HWCLOCK 8 "April 2015" "util-linux" "System Administration"
 .SH NAME
-hwclock \- read or set the hardware clock (RTC)
+hwclock \- time clocks utility
 .SH SYNOPSIS
 .B hwclock
 .RI [ function ]
@@ -14,7 +14,7 @@ hwclock \- read or set the hardware clock (RTC)
 .
 .SH DESCRIPTION
 .B hwclock
-is a tool for accessing the Hardware Clock.  It can: display the
+is an administration tool for the time clocks.  It can: display the
 Hardware Clock time; set the Hardware Clock to a specified time; set the
 Hardware Clock from the System Clock; set the System Clock from the
 Hardware Clock; compensate for Hardware Clock drift; correct the System
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 19d7652..5320683 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1206,7 +1206,7 @@ usage(const struct hwclock_control *ctl)
 	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
-	puts(_("Query or set the RTC (Real Time Clock / Hardware Clock)"));
+	puts(_("Time clocks utility."));
 
 	fputs(USAGE_FUNCTIONS, stdout);
 	puts(_(" -r, --show           display the RTC time"));
