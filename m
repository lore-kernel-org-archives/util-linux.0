Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37365 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbbH0NVk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2015 09:21:40 -0400
Received: by widdq5 with SMTP id dq5so45038239wid.0
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2015 06:21:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] cal: replace magic constants with symbolical values
Date: Thu, 27 Aug 2015 14:21:28 +0100
Message-Id: <1440681689-2708-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
References: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it easier to know what the values in guestion represent.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 73 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 98ce431..dd26532 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -171,15 +171,27 @@ enum {
 	NONEDAY
 };
 
-#define	FIRST_WEEKDAY		SATURDAY	/* Jan 1st, 1 was a Saturday */
+enum {
+	JANUARY = 1,
+	FEBRUARY,
+	MARCH,
+	APRIL,
+	MAY,
+	JUNE,
+	JULY,
+	AUGUST,
+	SEPTEMBER,
+	OCTOBER,
+	NOVEMBER,
+	DECEMBER
+};
+
 #define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
-#define REFORMATION_MONTH	9		/* September */
-#define	FIRST_MISSING_DAY	639799		/* 3 Sep 1752 */
+#define REFORMATION_MONTH	SEPTEMBER
 #define	NUMBER_MISSING_DAYS	11		/* 11 day correction */
 #define YDAY_AFTER_MISSING	258             /* 14th in Sep 1752 */
 
-#define DAYS_IN_YEAR		365		/* the common case, leap years are calculated */
-#define MONTHS_IN_YEAR		12
+#define MONTHS_IN_YEAR		DECEMBER
 #define DAYS_IN_MONTH		31
 #define	MAXDAYS			42		/* slots in a month array */
 #define	SPACE			-1		/* used in day array */
@@ -188,12 +200,9 @@ enum {
 
 #define	DAY_LEN			3		/* 3 spaces per day */
 #define	WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
-#define	HEAD_SEP		2
 #define MONTHS_IN_YEAR_ROW	3		/* month columns in year view */
 #define WNUM_LEN                3
 
-#define TODAY_FLAG		0x400		/* flag day for highlighting */
-
 #define FMT_ST_CHARS 300	/* 90 suffices in most locales */
 
 static const int days_in_month[2][13] = {
@@ -473,15 +482,15 @@ int main(int argc, char **argv)
 			errx(EXIT_FAILURE, _("illegal week value: year %d "
 					     "doesn't have week %d"),
 					ctl.req.year, ctl.req.week);
-		while (m <= 12 && yday > days_in_month[leap][m])
+		while (m <= DECEMBER && yday > days_in_month[leap][m])
 			yday -= days_in_month[leap][m++];
-		if (m > 12) {
+		if (m > DECEMBER) {
 			/* In some years (e.g. 2010 in ISO mode) it's possible
 			 * to have a remnant of week 53 starting the year yet
 			 * the year in question ends during 52, in this case
 			 * we're assuming that early remnant is being referred
 			 * to if 53 is given as argument. */
-			if (ctl.req.week != week_number(31, 12, ctl.req.year - 1, &ctl))
+			if (ctl.req.week != week_number(31, DECEMBER, ctl.req.year - 1, &ctl))
 				errx(EXIT_FAILURE,
 					_("illegal week value: year %d "
 					  "doesn't have week %d"),
@@ -589,7 +598,7 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 			continue;
 		}
 		if (j < month_days) {
-			if (month->year == 1752 && month->month == 9 && (j == 3 || j == 247))
+			if (month->year == REFORMATION_YEAR && month->month == REFORMATION_MONTH && (j == 3 || j == 247))
 				j += NUMBER_MISSING_DAYS;
 			month->days[i] = j;
 			j++;
@@ -817,21 +826,21 @@ static int day_in_week(int day, int month, int32_t year)
 		FRIDAY, MONDAY, SUNDAY, WEDNESDAY, FRIDAY, MONDAY,
 		WEDNESDAY, SATURDAY, TUESDAY, THURSDAY, SUNDAY, TUESDAY
 	};
-	if (year != 1753)
-		year -= month < 3;
+	if (year != REFORMATION_YEAR + 1)
+		year -= month < MARCH;
 	else
-		year -= (month < 3) + 14;
+		year -= (month < MARCH) + 14;
 	if (REFORMATION_YEAR < year
-	    || (year == REFORMATION_YEAR && 9 < month)
-	    || (year == REFORMATION_YEAR && month == 9 && 13 < day)) {
+	    || (year == REFORMATION_YEAR && REFORMATION_MONTH < month)
+	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && 13 < day)) {
 		int64_t long_year = year;
 		return (long_year + (year / 4) - (year / 100) + (year / 400) + reform[month - 1] +
-			day) % 7;
+			day) % DAYS_IN_WEEK;
 	}
 	if (year < REFORMATION_YEAR
-	    || (year == REFORMATION_YEAR && month < 9)
-	    || (year == REFORMATION_YEAR && month == 9 && day < 3))
-		return (year + year / 4 + old[month - 1] + day) % 7;
+	    || (year == REFORMATION_YEAR && month < REFORMATION_MONTH)
+	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && day < 3))
+		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
 	return NONEDAY;
 }
 
@@ -845,7 +854,7 @@ static int day_in_week(int day, int month, int32_t year)
 static int week_number(int day, int month, int32_t year, const struct cal_control *ctl)
 {
 	int fday = 0, yday;
-	const int wday = day_in_week(1, 1, year);
+	const int wday = day_in_week(1, JANUARY, year);
 
 	if (ctl->weektype & WEEK_NUM_ISO)
 		fday = wday + (wday >= FRIDAY ? -2 : 5);
@@ -858,8 +867,8 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	/* For julian dates the month can be set to 1, the global julian
 	 * variable cannot be relied upon here, because we may recurse
 	 * internally for 31.12. which would not work. */
-	if (day > 31)
-		month = 1;
+	if (day > DAYS_IN_MONTH)
+		month = JANUARY;
 
 	yday = day_in_year(day,month,year);
 	if (year == REFORMATION_YEAR) {
@@ -868,8 +877,8 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	}
 
 	/* Last year is last year */
-	if (yday + fday < 7)
-		return week_number(31, 12, year - 1, ctl);
+	if (yday + fday < DAYS_IN_WEEK)
+		return week_number(31, DECEMBER, year - 1, ctl);
 
 	/* Or it could be part of the next year.  The reformation year had less
 	 * days than 365 making this check invalid, but reformation year ended
@@ -877,11 +886,11 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	if (ctl->weektype == WEEK_NUM_ISO && yday >= 363
 	    && day_in_week(day, month, year) >= MONDAY
 	    && day_in_week(day, month, year) <= WEDNESDAY
-	    && day_in_week(31, 12, year) >= MONDAY
-	    && day_in_week(31, 12, year) <= WEDNESDAY)
-		return week_number(1, 1, year + 1, ctl);
+	    && day_in_week(31, DECEMBER, year) >= MONDAY
+	    && day_in_week(31, DECEMBER, year) <= WEDNESDAY)
+		return week_number(1, JANUARY, year + 1, ctl);
 
-	return (yday + fday) / 7;
+	return (yday + fday) / DAYS_IN_WEEK;
 }
 
 /*
@@ -895,8 +904,8 @@ static int week_to_day(const struct cal_control *ctl)
 {
 	int yday, wday;
 
-	wday = day_in_week(1, 1, ctl->req.year);
-	yday = ctl->req.week * 7 - wday;
+	wday = day_in_week(1, JANUARY, ctl->req.year);
+	yday = ctl->req.week * DAYS_IN_WEEK - wday;
 
 	if (ctl->weektype & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
-- 
2.5.0

