Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48100 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaEEStb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 May 2014 14:49:31 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3D7DEAAF1
	for <util-linux@vger.kernel.org>; Mon,  5 May 2014 18:49:30 +0000 (UTC)
Message-ID: <1399315769.11780.39.camel@oct.suse.cz>
Subject: [PATCH 1/2] hwclock: Prevent excessive drift values
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Mon, 05 May 2014 20:49:29 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Failure of CMOS battery can cause writing of excessive drift
values (up to many years per day).

This causes excessive hwclock adjustment next time, which may lead
to overflow in calculate_adjustment() (and hang before 4a44a54b).

Prevent this situation, check drift for limits and reset drift to zero
instead.

Steps to reproduce:

mv /etc/adjtime /etc/adjtime.backup

rm /etc/adjtime
hwclock --set --date 2001-01-01\ 01:00:00

changing of /etc/adjtime.
mv /etc/adjtime /etc/adjtime.saved
hwclock --set --date 2001-01-02\ 01:00:01
mv /etc/adjtime.saved /etc/adjtime

echo "======= The /etc/adjtime has a \"correct\" look:"
cat /etc/adjtime

hwclock --debug --systohc --utc
echo "======= The /etc/adjtime now has deeply failed drift value:"
cat /etc/adjtime

mv /etc/adjtime /etc/adjtime.saved
hwclock --set --date 2015-01-01\ 01:00:00
mv /etc/adjtime.saved /etc/adjtime

hwclock --debug --adjust
echo "======= And the last /etc/adjtime:"
cat /etc/adjtime

mv /etc/adjtime.backup /etc/adjtime
hwclock --systohc --utc

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/hwclock.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 395b5c3..5e786a8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -91,6 +91,11 @@ struct clock_ops *ur;
 
 #define FLOOR(arg) ((arg >= 0 ? (int) arg : ((int) arg) - 1));
 
+/* Maximal clock adjustment in seconds per day.
+   (adjtime() glibc call has 2145 seconds limit on i386, so it is good enough for us as well,
+   43219 is a maximal safe value preventing exact_adjustment overflow.) */
+#define MAX_DRIFT 2145.0
+
 const char *adj_file_name = NULL;
 
 struct adjtime {
@@ -1008,6 +1013,7 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 		double adj_days, cal_days;
 		double exp_drift, unc_drift;
 		double factor_adjust;
+		double drift_factor;
 
 		/* Adjusted time units per hardware time unit */
 		atime_per_htime = 1.0 + adjtime_p->drift_factor / sec_per_day;
@@ -1033,16 +1039,28 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 		/* Amount to add to previous drift factor */
 		factor_adjust = unc_drift / cal_days;
 
-		if (debug)
-			printf(_("Clock drifted %.1f seconds in the past "
-				 "%d seconds in spite of a drift factor of "
-				 "%f seconds/day.\n"
-				 "Adjusting drift factor by %f seconds/day\n"),
-			       unc_drift,
-			       (int)(nowtime - adjtime_p->last_calib_time),
-			       adjtime_p->drift_factor, factor_adjust);
-
-		adjtime_p->drift_factor += factor_adjust;
+		/* New drift factor */
+		drift_factor = adjtime_p->drift_factor + factor_adjust;
+
+		if (abs(drift_factor) > MAX_DRIFT) {
+			if (debug)
+				printf(_("Clock drift factor was calculated as "
+					 "%f seconds/day.\n"
+					 "It is far too much. Resetting to zero.\n"),
+				       drift_factor);
+			drift_factor = 0;
+		} else {
+			if (debug)
+				printf(_("Clock drifted %.1f seconds in the past "
+					 "%d seconds in spite of a drift factor of "
+					 "%f seconds/day.\n"
+					 "Adjusting drift factor by %f seconds/day\n"),
+				       unc_drift,
+				       (int)(nowtime - adjtime_p->last_calib_time),
+				       adjtime_p->drift_factor, factor_adjust);
+		}
+
+		adjtime_p->drift_factor = drift_factor;
 	}
 	adjtime_p->last_calib_time = nowtime;
 
-- 
1.8.4.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

