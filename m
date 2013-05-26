Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:43584 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3EZJOT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 05:14:19 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so3544712wes.26
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 02:14:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] =?UTF-8?q?cal:=20use=20Claus=20T=C3=B8ndering's=20day?= =?UTF-8?q?=20of=20the=20week=20algorithm?=
Date: Sun, 26 May 2013 10:14:07 +0100
Message-Id: <1369559650-12341-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week#T.C3.B8ndering.27s_algorithm
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 4d45145..9575db4 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -234,8 +234,6 @@ int julian;
 
 /* function prototypes */
 static int leap_year(int year);
-static int centuries_since_1700(int year, int centuries);
-static int leap_years_since_year_1(int year);
 static char * ascii_day(char *, int);
 static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 static void center(const char *, size_t, int);
@@ -427,22 +425,6 @@ static int leap_year(int year)
 		return ( !(year % 4) && (year % 100) ) || !(year % 400);
 }
 
-/* number of centuries since 1700 */
-static int centuries_since_1700(int year, int n)
-{
-	if (year < REFORMATION_YEAR)
-		return 0;
-	else
-		return ((year / (100 * n)) - ((REFORMATION_YEAR / 100) / n));
-}
-
-/* number of leap years between year 1 and this year, not inclusive */
-static int leap_years_since_year_1(int year)
-{
-	return (year / 4 - centuries_since_1700(year, 1) +
-		centuries_since_1700(year, 4));
-}
-
 static void headers_init(int julian)
 {
 	int i, wd, spaces = julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
@@ -681,18 +663,26 @@ day_in_year(int day, int month, int year) {
  *	during the period of 11 days.
  */
 static int
-day_in_week(int day, int month, int year) {
-	long temp;
-
-	temp =
-	    (long)(year - SMALLEST_YEAR) * DAYS_IN_YEAR +
-	    leap_years_since_year_1(year - SMALLEST_YEAR)
-	    + day_in_year(day, month, year);
-	if (temp < FIRST_MISSING_DAY)
-		return ((temp + (FIRST_WEEKDAY - 1)) % DAYS_IN_WEEK);
-	if (temp >= (FIRST_MISSING_DAY + NUMBER_MISSING_DAYS))
-		return ((temp + (FIRST_WEEKDAY - 1 - NUMBER_MISSING_DAYS)) % DAYS_IN_WEEK);
-	return (NONEDAY);
+day_in_week(int d, int m, int y)
+{
+	static const int reform[] = {
+		SUNDAY, WEDNESDAY, TUESDAY, FRIDAY, SUNDAY, WEDNESDAY,
+		FRIDAY, MONDAY, THURSDAY, SATURDAY, TUESDAY, THURSDAY
+	};
+	static const int old[] = {
+		FRIDAY, MONDAY, SUNDAY, WEDNESDAY, FRIDAY, MONDAY,
+		WEDNESDAY, SATURDAY, TUESDAY, THURSDAY, SUNDAY, TUESDAY
+	};
+	if (y != 1753)
+		y -= m < 3;
+	else
+		y -= (m < 3) + 14;
+	if (1752 < y || (y == 1752 && 9 < m) || (y == 1752 && m == 9 && 13 < d))
+		return (y + (y / 4) - (y / 100) + (y / 400) + reform[m - 1] +
+			d) % 7;
+	if (y < 1752 || (y == 1752 && m < 9) || (y == 1752 && m == 9 && d < 3))
+		return (y + y / 4 + old[m - 1] + d) % 7;
+	return NONEDAY;
 }
 
 static char *
-- 
1.8.2.3

