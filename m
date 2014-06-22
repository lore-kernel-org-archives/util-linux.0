Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:46528 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbaFVMY0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 08:24:26 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id DFE20C190
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 14:23:53 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: peppe <g1pi@libero.it>, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] hwclock: sometimes one day lasts 23 hours.
Date: Sun, 22 Jun 2014 14:23:25 +0200
Message-Id: <1403439805-11760-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: peppe <g1pi@libero.it>

If less than 23 hours have passed since the last calibration, hwclock
says "Not adjusting drift factor because it has been less than a day since
the last calibration.", but in fact compares to 23 hours, not 24.

This was originally reported at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=689534

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0abf01f..bdac003 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -989,7 +989,7 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 				 "calibration time is zero,\n"
 				 "so history is bad and calibration startover "
 				 "is necessary.\n"));
-	} else if ((hclocktime - adjtime_p->last_calib_time) < 23 * 60 * 60) {
+	} else if ((hclocktime - adjtime_p->last_calib_time) < 24 * 60 * 60) {
 		if (debug)
 			printf(_("Not adjusting drift factor because it has "
 				 "been less than a day since the last "
-- 
2.0.0

