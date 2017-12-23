Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 2/2] cal: change reformation to reform
To: Karel Zak <kzak@redhat.com>
References: <e2d14b08-f310-cf33-feb4-6e07b8b0f59b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d28187e1-eb2e-bbdb-f2c3-d729356fdc7b@gmx.com>
Date: Fri, 22 Dec 2017 21:02:03 -0500
MIME-Version: 1.0
In-Reply-To: <e2d14b08-f310-cf33-feb4-6e07b8b0f59b@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The proper term is calendar reform:
https://en.wikipedia.org/wiki/Calendar_reform

The term reformation is mostly associated with religion.

Also fix the reform[] array comment
and remove some extraneous tabs/spaces.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 |  4 ++--
 misc-utils/cal.c | 42 ++++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 6706d9df2..a107f7b34 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -160,9 +160,9 @@ for more details about colorization configuration.
 The default
 .B cal
 format uses the 3rd of September 1752 as the date of the Gregorian calendar
-reformation -- that is when it happened in Great Britain and its colonies
+reform -- that is when it happened in Great Britain and its colonies
 (including what is now the USA).  Starting at that date, eleven days were eliminated
-by this reformation, so the calendar for that month is rather unusual.
+by this reform, so the calendar for that month is rather unusual.
 The actual historical dates at which the calendar reform happened in all the
 different countries (locales), including its introduction by Pope Gregory XIII
 in October 1582, are ignored. The Gregorian calendar is a refinement to the
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 140c89840..aa05e3ac1 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -160,23 +160,23 @@ enum {
 	DECEMBER
 };
 
-#define REFORMATION_MONTH	SEPTEMBER
-#define	NUMBER_MISSING_DAYS	11		/* 11 day correction */
+#define REFORM_MONTH		SEPTEMBER
+#define NUMBER_MISSING_DAYS	11		/* 11 day correction */
 #define YDAY_AFTER_MISSING	258             /* 14th in Sep 1752 */
 
 #define MONTHS_IN_YEAR		DECEMBER
 #define DAYS_IN_MONTH		31
-#define	MAXDAYS			42		/* slots in a month array */
-#define	SPACE			-1		/* used in day array */
+#define MAXDAYS			42		/* slots in a month array */
+#define SPACE			-1		/* used in day array */
 
 #define SMALLEST_YEAR		1
 
-#define	DAY_LEN			3		/* 3 spaces per day */
-#define	WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
+#define DAY_LEN			3		/* 3 spaces per day */
+#define WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
 #define MONTHS_IN_YEAR_ROW	3		/* month columns in year view */
-#define WNUM_LEN                3
+#define WNUM_LEN		3
 
-#define FMT_ST_CHARS 300	/* 90 suffices in most locales */
+#define FMT_ST_CHARS		300	/* 90 suffices in most locales */
 
 static const int days_in_month[2][13] = {
 	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
@@ -552,7 +552,7 @@ int main(int argc, char **argv)
 	return EXIT_SUCCESS;
 }
 
-/* leap year -- account for gregorian reformation in 1752 */
+/* leap year -- account for gregorian reform in 1752 */
 static int leap_year(const struct cal_control *ctl, int32_t year)
 {
 	if (year <= ctl->reform_year)
@@ -666,7 +666,7 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 		}
 		if (j < month_days) {
 			if (month->year == ctl->reform_year &&
-			    month->month == REFORMATION_MONTH &&
+			    month->month == REFORM_MONTH &&
 			    (j == 3 || j == 247))
 				j += NUMBER_MISSING_DAYS;
 			month->days[i] = j;
@@ -884,7 +884,7 @@ static int day_in_year(const struct cal_control *ctl,
 /*
  * day_in_week
  *	return the 0 based day number for any date from 1 Jan. 1 to
- *	31 Dec. 9999.  Assumes the Gregorian reformation eliminates
+ *	31 Dec. 9999.  Assumes the Gregorian reform eliminates
  *	3 Sep. 1752 through 13 Sep. 1752, and returns invalid weekday
  *	during the period of 11 days.
  */
@@ -895,8 +895,11 @@ static int day_in_week(const struct cal_control *ctl, int day,
 	* The magic constants in the reform[] array are, in a simplified
 	* sense, the remaining days after slicing into one week periods the total
 	* days from the beginning of the year to the target month. That is,
-	* weeks + reform[] days gets us to the target month. The exception is,
-	* that for the months past February 'DOY - 1' must be used.
+	* weeks + reform[] days gets us to the target month. Subtract one from
+	* the total days, before removing full weeks, to count the first day of
+	* the year. The exception is, the first two months need an extra day,
+	* because they are considered part of the previous year in the leap
+	* year handling scheme.
 	*
 	*   DoY (Day of Year): total days to the target month
 	*
@@ -916,16 +919,15 @@ static int day_in_week(const struct cal_control *ctl, int day,
 	else
 		year -= (month < MARCH) + 14;
 	if (ctl->reform_year < year
-	    || (year == ctl->reform_year && REFORMATION_MONTH < month)
-	    || (year == ctl->reform_year
-	    && month == REFORMATION_MONTH && 13 < day)) {
+	    || (year == ctl->reform_year && REFORM_MONTH < month)
+	    || (year == ctl->reform_year && month == REFORM_MONTH && 13 < day)) {
 		int64_t long_year = year;
 		return (long_year + (year / 4) - (year / 100) + (year / 400) +
 			reform[month - 1] + day) % DAYS_IN_WEEK;
 	}
 	if (year < ctl->reform_year
-	    || (year == ctl->reform_year && month < REFORMATION_MONTH)
-	    || (year == ctl->reform_year && month == REFORMATION_MONTH && day < 3))
+	    || (year == ctl->reform_year && month < REFORM_MONTH)
+	    || (year == ctl->reform_year && month == REFORM_MONTH && day < 3))
 		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
 	return NONEDAY;
 }
@@ -964,8 +966,8 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	if (yday + fday < DAYS_IN_WEEK)
 		return week_number(31, DECEMBER, year - 1, ctl);
 
-	/* Or it could be part of the next year.  The reformation year had less
-	 * days than 365 making this check invalid, but reformation year ended
+	/* Or it could be part of the next year.  The reform year had less
+	 * days than 365 making this check invalid, but reform year ended
 	 * on Sunday and in week 51, so it's ok here. */
 	if (ctl->weektype == WEEK_NUM_ISO && yday >= 363
 	    && day_in_week(ctl, day, month, year) >= MONDAY
