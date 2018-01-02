Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752871AbeABOyY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 09:54:24 -0500
Subject: [v3 PATCH 01/11] cal: change default output format
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f709fb7c-b68a-ba0c-d515-2bec538bdef0@gmx.com>
Date: Tue, 2 Jan 2018 09:54:22 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Change the default calendar system to proleptic Gregorian;
this makes it consistent with ISO 8601, date(1), and  most
other conventions.

Also add the --1752-reform option to keep the old default
output available.

The current POSIX description for cal(1) could be interpreted as saying that a
1752 reform is the default format. The history of the description seems to
indicate otherwise. Issue 2 introduced cal(1) and required the Gregorian
format:

http://pubs.opengroup.org/onlinepubs/007908799/xcu/cal.html
 > DESCRIPTION
 >
 >    The cal utility writes a Gregorian calendar to standard output.

The reason for the change in Issue 6 was to *allow* Julian output:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
 > The DESCRIPTION is updated to allow for traditional behavior for years
 > before the adoption of the Gregorian calendar.

So it seems the intent was to allow old implementations, not to define a
default calendar system to use.

Having the default calendar system comply with ISO 8601 makes cal(1) more
compatible with the rest of the system.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 22 +++++++++----
 misc-utils/cal.c | 94 +++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index f1084edba..2499483b6 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -52,15 +52,24 @@ month is displayed.
 .sp
 The \fImonth\fR may be specified as a number (1-12), as a month name or as an
 abbreviated month name according to the current locales.
+.sp
+Since v2.32 the default calendar system has changed to proleptic Gregorian;
+this makes it consistent with ISO 8601, date(1), and most other conventions.
+The old default output is still available by using the
+.BR \-\-1752-reform\  option.
 .SH OPTIONS
 .TP
 \fB\-1\fR, \fB\-\-one\fR
-Display single month output.
-(This is the default.)
+Display single month output (default).
 .TP
 \fB\-3\fR, \fB\-\-three\fR
 Display three months spanning the date.
 .TP
+.B \-\-1752-reform
+Display calendars based upon the Chesterfield's Act.
+This means that dates previous to 3 Sept 1752 will be Julian calendar dates.
+.RB See \ BUGS \ below.
+.TP
 \fB\-n , \-\-months\fR \fInumber\fR
 Display \fInumber\fR of months, starting from the month containing the date.
 .TP
@@ -148,14 +157,15 @@ See
 for more details about colorization configuration.
 .SH BUGS
 .PP
-The
-.B cal
-program uses the 3rd of September 1752 as the date of the Gregorian calendar
+.RB The\  \-\-1752-reform
+option uses the 3rd of September 1752 as the date of the Gregorian calendar
 reformation -- that is when it happened in Great Britain and its colonies
 (including what is now the USA).  Starting at that date, eleven days were eliminated
 by this reformation, so the calendar for that month is rather unusual.
 The actual historical dates at which the calendar reform happened in all the
-different countries (locales) are ignored.
+different countries (locales), including its introduction by Pope Gregory XIII
+in October 1582, are ignored. The Gregorian calendar is a refinement to the
+Julian calendar improving its synchronization with solar cycles.
 .PP
 Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
 or the lunisolar Hindu, are not supported.
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 39f2bdcba..2dfdaa25b 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -160,7 +160,6 @@ enum {
 	DECEMBER
 };
 
-#define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
 #define REFORMATION_MONTH	SEPTEMBER
 #define	NUMBER_MISSING_DAYS	11		/* 11 day correction */
 #define YDAY_AFTER_MISSING	258             /* 14th in Sep 1752 */
@@ -206,6 +205,7 @@ struct cal_control {
 	const char *full_month[MONTHS_IN_YEAR];	/* month names */
 	const char *abbr_month[MONTHS_IN_YEAR];	/* abbreviated month names */
 
+	int reform_year;		/* Gregorian reform year */
 	int colormode;			/* day and week number highlight */
 	int num_months;			/* number of requested months */
 	int span_months;		/* span the date */
@@ -230,7 +230,7 @@ struct cal_month {
 };
 
 /* function prototypes */
-static int leap_year(int32_t year);
+static int leap_year(const struct cal_control *ctl, int32_t year);
 static int monthname_to_number(struct cal_control *ctl, const char *name);
 static void headers_init(struct cal_control *ctl);
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl);
@@ -238,8 +238,10 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
 static void yearly(const struct cal_control *ctl);
-static int day_in_year(int day, int month, int32_t year);
-static int day_in_week(int day, int month, int32_t year);
+static int day_in_year(const struct cal_control *ctl, int day,
+		       int month, int32_t year);
+static int day_in_week(const struct cal_control *ctl, int day,
+		       int month, int32_t year);
 static int week_number(int day, int month, int32_t year, const struct cal_control *ctl);
 static int week_to_day(const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
@@ -252,7 +254,9 @@ int main(int argc, char **argv)
 	char *term;
 	time_t now;
 	int ch = 0, yflag = 0, Yflag = 0;
+
 	static struct cal_control ctl = {
+		.reform_year = -1,		/* def. proleptic Gregorian */
 		.weekstart = SUNDAY,
 		.num_months = 1,		/* default is "cal -1" */
 		.span_months = 0,
@@ -265,7 +269,8 @@ int main(int argc, char **argv)
 	};
 
 	enum {
-		OPT_COLOR = CHAR_MAX + 1
+		OPT_1752_REFORM = CHAR_MAX + 1,
+		OPT_COLOR
 	};
 
 	static const struct option longopts[] = {
@@ -279,6 +284,7 @@ int main(int argc, char **argv)
 		{"year", no_argument, NULL, 'y'},
 		{"week", optional_argument, NULL, 'w'},
 		{"color", optional_argument, NULL, OPT_COLOR},
+		{"1752-reform", no_argument, NULL, OPT_1752_REFORM},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -335,7 +341,8 @@ int main(int argc, char **argv)
 		val.string = nl_langinfo(_NL_TIME_WEEK_1STDAY);
 
 		wfd = val.word;
-		wfd = day_in_week(wfd % 100, (wfd / 100) % 100, wfd / (100 * 100));
+		wfd = day_in_week(&ctl, wfd % 100, (wfd / 100) % 100,
+				  wfd / (100 * 100));
 		ctl.weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
@@ -390,6 +397,9 @@ int main(int argc, char **argv)
 				ctl.colormode = colormode_or_err(optarg,
 						_("unsupported color mode"));
 			break;
+		case OPT_1752_REFORM:
+			ctl.reform_year = 1752;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -451,10 +461,12 @@ int main(int argc, char **argv)
 		if (ctl.req.year == INT32_MAX)
 			errx(EXIT_FAILURE, _("illegal year value"));
 		if (ctl.req.day) {
-			int dm = days_in_month[leap_year(ctl.req.year)][ctl.req.month];
+			int dm = days_in_month[leap_year(&ctl, ctl.req.year)]
+					      [ctl.req.month];
 			if (ctl.req.day > dm)
 				errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), dm);
-			ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);
+			ctl.req.day = day_in_year(&ctl, ctl.req.day,
+						  ctl.req.month, ctl.req.year);
 		} else if ((int32_t) (local_time->tm_year + 1900) == ctl.req.year) {
 			ctl.req.day = local_time->tm_yday + 1;
 		}
@@ -476,7 +488,7 @@ int main(int argc, char **argv)
 
 	if (0 < ctl.req.week) {
 		int yday = week_to_day(&ctl);
-		int leap = leap_year(ctl.req.year);
+		int leap = leap_year(&ctl, ctl.req.year);
 		int m = 1;
 
 		if (yday < 1)
@@ -532,9 +544,9 @@ int main(int argc, char **argv)
 }
 
 /* leap year -- account for gregorian reformation in 1752 */
-static int leap_year(int32_t year)
+static int leap_year(const struct cal_control *ctl, int32_t year)
 {
-	if (year <= REFORMATION_YEAR)
+	if (year <= ctl->reform_year)
 		return !(year % 4);
 	else
 		return ( !(year % 4) && (year % 100) ) || !(year % 400);
@@ -618,15 +630,15 @@ static void headers_init(struct cal_control *ctl)
 
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl)
 {
-	int first_week_day = day_in_week(1, month->month, month->year);
+	int first_week_day = day_in_week(ctl, 1, month->month, month->year);
 	int month_days;
 	int i, j, weeklines = 0;
 
 	if (ctl->julian)
-		j = day_in_year(1, month->month, month->year);
+		j = day_in_year(ctl, 1, month->month, month->year);
 	else
 		j = 1;
-	month_days = j + days_in_month[leap_year(month->year)][month->month];
+	month_days = j + days_in_month[leap_year(ctl, month->year)][month->month];
 
 	/* True when Sunday is not first day in the output week. */
 	if (ctl->weekstart) {
@@ -644,7 +656,9 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 			continue;
 		}
 		if (j < month_days) {
-			if (month->year == REFORMATION_YEAR && month->month == REFORMATION_MONTH && (j == 3 || j == 247))
+			if (month->year == ctl->reform_year &&
+			    month->month == REFORMATION_MONTH &&
+			    (j == 3 || j == 247))
 				j += NUMBER_MISSING_DAYS;
 			month->days[i] = j;
 			j++;
@@ -726,9 +740,9 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 				if (ctl->julian)
 					reqday = ctl->req.day;
 				else
-					reqday =
-					    ctl->req.day + 1 - day_in_year(1, i->month,
-									   i->year);
+					reqday = ctl->req.day + 1 -
+						 day_in_year(ctl, 1, i->month,
+							     i->year);
 			}
 
 			if (ctl->weektype) {
@@ -847,11 +861,12 @@ static void yearly(const struct cal_control *ctl)
  * day_in_year --
  *	return the 1 based day number within the year
  */
-static int day_in_year(int day, int month, int32_t year)
+static int day_in_year(const struct cal_control *ctl,
+		       int day, int month, int32_t year)
 {
 	int i, leap;
 
-	leap = leap_year(year);
+	leap = leap_year(ctl, year);
 	for (i = 1; i < month; i++)
 		day += days_in_month[leap][i];
 	return day;
@@ -864,7 +879,8 @@ static int day_in_year(int day, int month, int32_t year)
  *	3 Sep. 1752 through 13 Sep. 1752, and returns invalid weekday
  *	during the period of 11 days.
  */
-static int day_in_week(int day, int month, int32_t year)
+static int day_in_week(const struct cal_control *ctl, int day,
+		       int month, int32_t year)
 {
 	/*
 	* The magic constants in the reform[] array are, in a simplified
@@ -886,20 +902,21 @@ static int day_in_week(int day, int month, int32_t year)
 	static const int reform[] = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };
 	static const int old[]    = { 5, 1, 0, 3, 5, 1, 3, 6, 2, 4, 0, 2 };
 
-	if (year != REFORMATION_YEAR + 1)
+	if (year != ctl->reform_year + 1)
 		year -= month < MARCH;
 	else
 		year -= (month < MARCH) + 14;
-	if (REFORMATION_YEAR < year
-	    || (year == REFORMATION_YEAR && REFORMATION_MONTH < month)
-	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && 13 < day)) {
+	if (ctl->reform_year < year
+	    || (year == ctl->reform_year && REFORMATION_MONTH < month)
+	    || (year == ctl->reform_year
+	    && month == REFORMATION_MONTH && 13 < day)) {
 		int64_t long_year = year;
-		return (long_year + (year / 4) - (year / 100) + (year / 400) + reform[month - 1] +
-			day) % DAYS_IN_WEEK;
+		return (long_year + (year / 4) - (year / 100) + (year / 400) +
+			reform[month - 1] + day) % DAYS_IN_WEEK;
 	}
-	if (year < REFORMATION_YEAR
-	    || (year == REFORMATION_YEAR && month < REFORMATION_MONTH)
-	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && day < 3))
+	if (year < ctl->reform_year
+	    || (year == ctl->reform_year && month < REFORMATION_MONTH)
+	    || (year == ctl->reform_year && month == REFORMATION_MONTH && day < 3))
 		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
 	return NONEDAY;
 }
@@ -914,7 +931,7 @@ static int day_in_week(int day, int month, int32_t year)
 static int week_number(int day, int month, int32_t year, const struct cal_control *ctl)
 {
 	int fday = 0, yday;
-	const int wday = day_in_week(1, JANUARY, year);
+	const int wday = day_in_week(ctl, 1, JANUARY, year);
 
 	if (ctl->weektype & WEEK_NUM_ISO)
 		fday = wday + (wday >= FRIDAY ? -2 : 5);
@@ -930,8 +947,8 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	if (day > DAYS_IN_MONTH)
 		month = JANUARY;
 
-	yday = day_in_year(day,month,year);
-	if (year == REFORMATION_YEAR && yday >= YDAY_AFTER_MISSING)
+	yday = day_in_year(ctl, day, month, year);
+	if (year == ctl->reform_year && yday >= YDAY_AFTER_MISSING)
 		fday -= NUMBER_MISSING_DAYS;
 
 	/* Last year is last year */
@@ -942,10 +959,10 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	 * days than 365 making this check invalid, but reformation year ended
 	 * on Sunday and in week 51, so it's ok here. */
 	if (ctl->weektype == WEEK_NUM_ISO && yday >= 363
-	    && day_in_week(day, month, year) >= MONDAY
-	    && day_in_week(day, month, year) <= WEDNESDAY
-	    && day_in_week(31, DECEMBER, year) >= MONDAY
-	    && day_in_week(31, DECEMBER, year) <= WEDNESDAY)
+	    && day_in_week(ctl, day, month, year) >= MONDAY
+	    && day_in_week(ctl, day, month, year) <= WEDNESDAY
+	    && day_in_week(ctl, 31, DECEMBER, year) >= MONDAY
+	    && day_in_week(ctl, 31, DECEMBER, year) <= WEDNESDAY)
 		return week_number(1, JANUARY, year + 1, ctl);
 
 	return (yday + fday) / DAYS_IN_WEEK;
@@ -962,7 +979,7 @@ static int week_to_day(const struct cal_control *ctl)
 {
 	int yday, wday;
 
-	wday = day_in_week(1, JANUARY, ctl->req.year);
+	wday = day_in_week(ctl, 1, JANUARY, ctl->req.year);
 	yday = ctl->req.week * DAYS_IN_WEEK - wday;
 
 	if (ctl->weektype & WEEK_NUM_ISO)
@@ -1022,6 +1039,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
+	fputs(_("     --1752-reform     use Chesterfield's Act format\n"), out);
 	fputs(_("     --color[=<when>]  colorize messages (auto, always or never)\n"), out);
 	fprintf(out,
 	        "                         %s\n", USAGE_COLORS_DEFAULT);
