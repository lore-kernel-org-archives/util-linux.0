Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdHANSP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 09:18:15 -0400
Subject: [PATCH 5/8] hwclock: correlate hclocktime instead of set_time.
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2cf04064-2963-1c14-d2ed-7804b31c590c@gmx.com>
Date: Tue, 1 Aug 2017 09:18:01 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Correlate hclocktime with set_time instead of the other way around,
because set_time is used for timestamps in the adjtime file so it needs
to be unadulterated.

Also create var startup_hclocktime for correlated time.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e172fb1..df6b59e 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1029,9 +1029,14 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	bool hclock_valid = FALSE;
 	/*
 	 * Tick synchronized time read from the Hardware Clock and
-	 * then drift correct for all operations except --show.
+	 * then drift corrected for all operations except --show.
 	 */
-	struct timeval hclocktime = { 0, 0 };
+	struct timeval hclocktime = { 0 };
+	/*
+	 * hclocktime correlated to startup_time. That is, what drift
+	 * corrected Hardware Clock time would have been at start up.
+	 */
+	struct timeval startup_hclocktime = { 0 };
 	/* Total Hardware Clock drift correction needed. */
 	struct timeval tdrift;
 
@@ -1096,18 +1101,17 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 				     hclocktime.tv_sec, &tdrift);
 		if (!ctl->show)
 			hclocktime = time_inc(tdrift, hclocktime.tv_sec);
+
+		startup_hclocktime =
+		 time_inc(hclocktime, time_diff(startup_time, read_time));
 	}
 	if (ctl->show || ctl->get) {
-		display_time(hclock_valid,
-			     time_inc(hclocktime, -time_diff
-				      (read_time, startup_time)));
+		display_time(hclock_valid, startup_hclocktime);
 	} else if (ctl->set) {
 		set_hardware_clock_exact(ctl, set_time, startup_time);
 		if (!ctl->noadjfile)
-			adjust_drift_factor(ctl, adjtime,
-					    time_inc(t2tv(set_time), time_diff
-						     (read_time, startup_time)),
-					    hclock_valid, hclocktime);
+			adjust_drift_factor(ctl, adjtime, t2tv(set_time),
+					    hclock_valid, startup_hclocktime);
 	} else if (ctl->adjust) {
 		if (tdrift.tv_sec > 0 || tdrift.tv_sec < -1)
 			do_adjustment(ctl, adjtime, hclock_valid,
