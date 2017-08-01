Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbdHANNx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 09:13:53 -0400
Subject: [PATCH 2/8] hwclock: move rtc permissions test
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c2bfd6c4-8499-f90f-5824-d3e96628d3f2@gmx.com>
Date: Tue, 1 Aug 2017 09:13:39 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Move the rtc permissions test below the systz call and
simplify it's 'if' test.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index cec712d..ad9c502 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1037,9 +1037,6 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	/* local return code */
 	int rc = 0;
 
-	if (!ctl->systz && !ctl->predict && ur->get_permissions())
-		return EX_NOPERM;
-
 	if ((ctl->set || ctl->systohc || ctl->adjust) &&
 	    (adjtime->local_utc == UTC) != ctl->universal) {
 		adjtime->local_utc = ctl->universal ? UTC : LOCAL;
@@ -1049,6 +1046,9 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	if (ctl->systz)
 		return set_system_clock_timezone(ctl);
 
+	if (!ctl->predict && ur->get_permissions())
+		return EX_NOPERM;
+
 	if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
 	    || (!ctl->noadjfile && !ctl->predict)) {
 		/* data from HW-clock are required */
