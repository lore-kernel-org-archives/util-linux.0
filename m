Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/8] hwclock: move systz above init clocks read
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5eb1bcb1-c50f-f952-c0a0-a2a3027a0172@gmx.com>
Date: Tue, 1 Aug 2017 09:11:31 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The systz option is all about speed, so move it to the
top and simplify the init clocks read test.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index c74e0e2..cec712d 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1046,8 +1046,11 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		adjtime->dirty = TRUE;
 	}
 
+	if (ctl->systz)
+		return set_system_clock_timezone(ctl);
+
 	if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
-	    || (!ctl->noadjfile && !ctl->systz && !ctl->predict)) {
+	    || (!ctl->noadjfile && !ctl->predict)) {
 		/* data from HW-clock are required */
 		rc = synchronize_to_clock_tick(ctl);
 
@@ -1123,8 +1126,6 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 					    hclock_valid, hclocktime);
 	} else if (ctl->hctosys) {
 		return set_system_clock(ctl, hclock_valid, hclocktime);
-	} else if (ctl->systz) {
-		return set_system_clock_timezone(ctl);
 	} else if (ctl->predict) {
 		hclocktime = time_inc(hclocktime, (double)
 				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));
