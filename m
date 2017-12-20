Return-Path: elseifthen@gmx.com
Subject: [PATCH] cal: add --iso and --1782-reform format options
To: Karel Zak <kzak@redhat.com>
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9f5b10fe-1286-3aa7-a170-7a30b9e577a3@gmx.com>
Date: Tue, 19 Dec 2017 21:32:49 -0500
MIME-Version: 1.0
In-Reply-To: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 20 +++++++++++++++-----
 misc-utils/cal.c | 39 +++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index f1084edba..4ef86913f 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -55,12 +55,20 @@ abbreviated month name according to the current locales.
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
+Display calendars based upon the Chesterfield's Act format (default).
+.RB See \ BUGS \ below.
+.TP
+.B \-\-iso
+Display calendars based upon the ISO 8601 proleptic Gregorian format.
+This means that dates previous to calendar reform use extrapolated Gregorian
+dates instead of Julian dates.
+.TP
 \fB\-n , \-\-months\fR \fInumber\fR
 Display \fInumber\fR of months, starting from the month containing the date.
 .TP
@@ -148,14 +156,16 @@ See
 for more details about colorization configuration.
 .SH BUGS
 .PP
-The
+The default
 .B cal
-program uses the 3rd of September 1752 as the date of the Gregorian calendar
+format uses the 3rd of September 1752 as the date of the Gregorian calendar
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
index 39f2bdcba..df1286170 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -160,7 +160,10 @@ enum {
 	DECEMBER
 };
 
-#define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
+/* Dec 19 2017 - After an appropriate mourning period change 1752 to -1 making
+ * the default output format the proleptic Gregorian calendar
+ */
+int reformation_year = 1752;
 #define REFORMATION_MONTH	SEPTEMBER
 #define	NUMBER_MISSING_DAYS	11		/* 11 day correction */
 #define YDAY_AFTER_MISSING	258             /* 14th in Sep 1752 */
@@ -265,7 +268,9 @@ int main(int argc, char **argv)
 	};
 
 	enum {
-		OPT_COLOR = CHAR_MAX + 1
+		OPT_COLOR = CHAR_MAX + 1,
+		OPT_ISO,
+		OPT_1752_REFORM
 	};
 
 	static const struct option longopts[] = {
@@ -279,6 +284,8 @@ int main(int argc, char **argv)
 		{"year", no_argument, NULL, 'y'},
 		{"week", optional_argument, NULL, 'w'},
 		{"color", optional_argument, NULL, OPT_COLOR},
+		{"iso", no_argument, NULL, OPT_ISO},
+		{"1752-reform", no_argument, NULL, OPT_1752_REFORM},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -390,6 +397,12 @@ int main(int argc, char **argv)
 				ctl.colormode = colormode_or_err(optarg,
 						_("unsupported color mode"));
 			break;
+		case OPT_1752_REFORM:
+			reformation_year = 1782;
+			break;
+		case OPT_ISO:
+			reformation_year = -1;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -534,7 +547,7 @@ int main(int argc, char **argv)
 /* leap year -- account for gregorian reformation in 1752 */
 static int leap_year(int32_t year)
 {
-	if (year <= REFORMATION_YEAR)
+	if (year <= reformation_year)
 		return !(year % 4);
 	else
 		return ( !(year % 4) && (year % 100) ) || !(year % 400);
@@ -644,7 +657,7 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 			continue;
 		}
 		if (j < month_days) {
-			if (month->year == REFORMATION_YEAR && month->month == REFORMATION_MONTH && (j == 3 || j == 247))
+			if (month->year == reformation_year && month->month == REFORMATION_MONTH && (j == 3 || j == 247))
 				j += NUMBER_MISSING_DAYS;
 			month->days[i] = j;
 			j++;
@@ -886,20 +899,20 @@ static int day_in_week(int day, int month, int32_t year)
 	static const int reform[] = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };
 	static const int old[]    = { 5, 1, 0, 3, 5, 1, 3, 6, 2, 4, 0, 2 };
 
-	if (year != REFORMATION_YEAR + 1)
+	if (year != reformation_year + 1)
 		year -= month < MARCH;
 	else
 		year -= (month < MARCH) + 14;
-	if (REFORMATION_YEAR < year
-	    || (year == REFORMATION_YEAR && REFORMATION_MONTH < month)
-	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && 13 < day)) {
+	if (reformation_year < year
+	    || (year == reformation_year && REFORMATION_MONTH < month)
+	    || (year == reformation_year && month == REFORMATION_MONTH && 13 < day)) {
 		int64_t long_year = year;
 		return (long_year + (year / 4) - (year / 100) + (year / 400) + reform[month - 1] +
 			day) % DAYS_IN_WEEK;
 	}
-	if (year < REFORMATION_YEAR
-	    || (year == REFORMATION_YEAR && month < REFORMATION_MONTH)
-	    || (year == REFORMATION_YEAR && month == REFORMATION_MONTH && day < 3))
+	if (year < reformation_year
+	    || (year == reformation_year && month < REFORMATION_MONTH)
+	    || (year == reformation_year && month == REFORMATION_MONTH && day < 3))
 		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
 	return NONEDAY;
 }
@@ -931,7 +944,7 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 		month = JANUARY;
 
 	yday = day_in_year(day,month,year);
-	if (year == REFORMATION_YEAR && yday >= YDAY_AFTER_MISSING)
+	if (year == reformation_year && yday >= YDAY_AFTER_MISSING)
 		fday -= NUMBER_MISSING_DAYS;
 
 	/* Last year is last year */
@@ -1022,6 +1035,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
+	fputs(_("     --1752-reform     use Chesterfield's Act format\n"), out);
+	fputs(_("     --iso             use ISO 8601 proleptic Gregorian format\n"), out);
 	fputs(_("     --color[=<when>]  colorize messages (auto, always or never)\n"), out);
 	fprintf(out,
 	        "                         %s\n", USAGE_COLORS_DEFAULT);
