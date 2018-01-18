Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52384 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbeARCVI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 21:21:08 -0500
Subject: [PATCH] cal: fix julian calendars for large years
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <189c9e72-ed8e-2970-12d1-7a268d980eb7@gmx.com>
Date: Wed, 17 Jan 2018 21:21:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Before:
cal --r julian 31 12 2147483646
 December 2147483646
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31

Patched:
cal --r julian 31 12 2147483646
 December 2147483646
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
 9 10 11 12 13 14 15
16 17 18 19 20 21 22
23 24 25 26 27 28 29
30 31

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 543fbc6e1..a854eaf9d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -924,14 +924,15 @@ static int day_in_week(const struct cal_control *ctl, int day,
 	    || (year == ctl->reform_year && REFORMATION_MONTH < month)
 	    || (year == ctl->reform_year
 		&& month == REFORMATION_MONTH && 13 < day)) {
-		int64_t long_year = year;
-		return (long_year + (year / 4) - (year / 100) + (year / 400) +
-			reform[month - 1] + day) % DAYS_IN_WEEK;
+		return ((int64_t) year + (year / 4)
+			- (year / 100) + (year / 400)
+			+ reform[month - 1] + day) % DAYS_IN_WEEK;
 	}
 	if (year < ctl->reform_year
 	    || (year == ctl->reform_year && month < REFORMATION_MONTH)
 	    || (year == ctl->reform_year && month == REFORMATION_MONTH && day < 3))
-		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
+		return ((int64_t) year + year / 4 + old[month - 1] + day)
+			% DAYS_IN_WEEK;
 	return NONEDAY;
 }
 
