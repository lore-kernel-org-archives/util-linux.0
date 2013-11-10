Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:56373 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3KJSYY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:24:24 -0500
Received: by mail-we0-f169.google.com with SMTP id q58so3854612wes.28
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:24:23 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/13] cal: make day_in_week() use same variable names as other functions
Date: Sun, 10 Nov 2013 18:23:31 +0000
Message-Id: <1384107820-498-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index abb6e0f..748288d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -259,7 +259,7 @@ static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int
 static void yearly(int day, long year, const struct cal_control *ctl);
 static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl);
 static int day_in_year(int day, int month, long year);
-static int day_in_week(int d, int m, long y);
+static int day_in_week(int day, int month, long year);
 static int week_number(int day, int month, long year, const struct cal_control *ctl);
 static int week_to_day(long year, const struct cal_control *ctl);
 static char *ascii_day(char *p, int day, const struct cal_control *ctl);
@@ -819,7 +819,7 @@ static int day_in_year(int day, int month, long year)
  *	3 Sep. 1752 through 13 Sep. 1752, and returns invalid weekday
  *	during the period of 11 days.
  */
-static int day_in_week(int d, int m, long y)
+static int day_in_week(int day, int month, long year)
 {
 	static const int reform[] = {
 		SUNDAY, WEDNESDAY, TUESDAY, FRIDAY, SUNDAY, WEDNESDAY,
@@ -829,19 +829,19 @@ static int day_in_week(int d, int m, long y)
 		FRIDAY, MONDAY, SUNDAY, WEDNESDAY, FRIDAY, MONDAY,
 		WEDNESDAY, SATURDAY, TUESDAY, THURSDAY, SUNDAY, TUESDAY
 	};
-	if (y != 1753)
-		y -= m < 3;
+	if (year != 1753)
+		year -= month < 3;
 	else
-		y -= (m < 3) + 14;
-	if (REFORMATION_YEAR < y
-	    || (y == REFORMATION_YEAR && 9 < m)
-	    || (y == REFORMATION_YEAR && m == 9 && 13 < d))
-		return (y + (y / 4) - (y / 100) + (y / 400) + reform[m - 1] +
-			d) % 7;
-	if (y < REFORMATION_YEAR
-	    || (y == REFORMATION_YEAR && m < 9)
-	    || (y == REFORMATION_YEAR && m == 9 && d < 3))
-		return (y + y / 4 + old[m - 1] + d) % 7;
+		year -= (month < 3) + 14;
+	if (REFORMATION_YEAR < year
+	    || (year == REFORMATION_YEAR && 9 < month)
+	    || (year == REFORMATION_YEAR && month == 9 && 13 < day))
+		return (year + (year / 4) - (year / 100) + (year / 400) + reform[month - 1] +
+			day) % 7;
+	if (year < REFORMATION_YEAR
+	    || (year == REFORMATION_YEAR && month < 9)
+	    || (year == REFORMATION_YEAR && month == 9 && day < 3))
+		return (year + year / 4 + old[month - 1] + day) % 7;
 	return NONEDAY;
 }
 
-- 
1.8.4.2

