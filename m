Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44241 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761988Ab3EBSwk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:40 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so10795wgg.4
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/16] cal: simplify day_in_week()
Date: Thu,  2 May 2013 19:51:41 +0100
Message-Id: <1367520701-14962-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The day_in_week() does not need to perform fullfledged September 1752
calculations, that month is dealt as static assignment.

Reported-by: Thomas Bächler <thomas@archlinux.org>
References: http://www.spinics.net/lists/util-linux-ng/msg07910.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 78f092d..d9b07bf 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -164,7 +164,6 @@ enum {
 };
 
 #define	FIRST_WEEKDAY		SATURDAY	/* Jan 1st, 1 was a Saturday */
-#define	REFORMATION_WEEKDAY	THURSDAY	/* after reformation it was Thursday */
 #define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
 #define REFORMATION_MONTH	9		/* September */
 #define	FIRST_MISSING_DAY	639799		/* 3 Sep 1752 */
@@ -702,9 +701,9 @@ static int day_in_year(int day, int month, int year)
 /*
  * day_in_week
  *	return the 0 based day number for any date from 1 Jan. 1 to
- *	31 Dec. 9999.  Assumes the Gregorian reformation eliminates
- *	3 Sep. 1752 through 13 Sep. 1752.  Returns Thursday for all
- *	missing days.
+ *	31 Dec. 9999.  Assumes the Gregorian reformation dates
+ *	3 Sep. 1752 through 13 Sep. 1752 are handled as statically
+ *	assigned array, see day_array().
  */
 static int day_in_week(int day, int month, int year)
 {
@@ -715,10 +714,10 @@ static int day_in_week(int day, int month, int year)
 	    leap_years_since_year_1(year - SMALLEST_YEAR)
 	    + day_in_year(day, month, year);
 	if (temp < FIRST_MISSING_DAY)
-		return ((temp - 1 + FIRST_WEEKDAY) % DAYS_IN_WEEK);
-	if (temp >= (FIRST_MISSING_DAY + NUMBER_MISSING_DAYS))
-		return (((temp - 1 + FIRST_WEEKDAY) - NUMBER_MISSING_DAYS) % DAYS_IN_WEEK);
-	return(REFORMATION_WEEKDAY);
+		return ((temp + (FIRST_WEEKDAY - 1)) % DAYS_IN_WEEK);
+	if (temp > FIRST_MISSING_DAY)
+		return ((temp + (FIRST_WEEKDAY - 1 - NUMBER_MISSING_DAYS)) % DAYS_IN_WEEK);
+	abort();
 }
 
 static char *ascii_day(const int julian, char *p, int day)
-- 
1.8.2.2

