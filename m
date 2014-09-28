Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:41517 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaI1TxF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:05 -0400
Received: by mail-we0-f174.google.com with SMTP id w62so11476882wes.19
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/23] hwclock: use fabs() instead abs() when argument is double
Date: Sun, 28 Sep 2014 20:51:51 +0100
Message-Id: <1411933916-30576-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/hwclock.c:1219:13: warning: using integer absolute value function
      'abs' when argument is of floating point type [-Wabsolute-value]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 493ee88..e780158 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -60,6 +60,7 @@
 #include <errno.h>
 #include <getopt.h>
 #include <limits.h>
+#include <math.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -1042,7 +1043,7 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 		/* New drift factor */
 		drift_factor = adjtime_p->drift_factor + factor_adjust;
 
-		if (abs(drift_factor) > MAX_DRIFT) {
+		if (fabs(drift_factor) > MAX_DRIFT) {
 			if (debug)
 				printf(_("Clock drift factor was calculated as "
 					 "%f seconds/day.\n"
@@ -1215,7 +1216,7 @@ do_adjustment(struct adjtime *adjtime_p,
 		if (debug)
 			printf(_("Not setting clock because last adjustment time is zero, "
 				 "so history is bad.\n"));
-	} else if (abs(adjtime_p->drift_factor) > MAX_DRIFT) {
+	} else if (fabs(adjtime_p->drift_factor) > MAX_DRIFT) {
 		if (debug)
 			printf(_("Not setting clock because drift factor %f is far too high.\n"),
 				adjtime_p->drift_factor);
-- 
2.1.1

