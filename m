Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:37270 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaAOUQa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Jan 2014 15:16:30 -0500
Received: by mail-we0-f174.google.com with SMTP id x55so2256758wes.5
        for <util-linux@vger.kernel.org>; Wed, 15 Jan 2014 12:16:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] cal: limit year to 32 bit value
Date: Wed, 15 Jan 2014 20:15:51 +0000
Message-Id: <1389816953-11531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is done to keep things simple, when considering tests, for both 64
and 32 bit architectures.  Setting the upper limit of a year value to to
2^31-1 (2147483646) should be enough for anyone.

Reported-by: Mike Frysinger <vapier@gentoo.org>
Reference: http://www.spinics.net/lists/util-linux-ng/msg08662.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 87e947a..0f40111 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -232,7 +232,7 @@ static char day_headings[(WEEK_LEN + 1) * 6 + 1];
 struct cal_request {
 	int day;
 	int month;
-	long year;
+	int32_t year;
 	int week;
 };
 
@@ -255,23 +255,23 @@ struct cal_month {
 	int days[MAXDAYS];		/* the day numbers, or SPACE */
 	int weeks[MAXDAYS / DAYS_IN_WEEK];
 	int month;
-	long year;
+	int32_t year;
 	struct cal_month *next;
 };
 
 /* function prototypes */
-static int leap_year(long year);
+static int leap_year(int32_t year);
 static void headers_init(struct cal_control *ctl);
-static void set_consecutive_months(struct cal_month *month, int m, long y);
+static void set_consecutive_months(struct cal_month *month, int m, int32_t y);
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_header(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
 static void monthly3(const struct cal_control *ctl);
 static void yearly(const struct cal_control *ctl);
-static int day_in_year(int day, int month, long year);
-static int day_in_week(int day, int month, long year);
-static int week_number(int day, int month, long year, const struct cal_control *ctl);
+static int day_in_year(int day, int month, int32_t year);
+static int day_in_week(int day, int month, int32_t year);
+static int week_number(int day, int month, int32_t year, const struct cal_control *ctl);
 static int week_to_day(const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
 static void center(const char *str, size_t len, int separate);
@@ -432,15 +432,17 @@ int main(int argc, char **argv)
 			errx(EXIT_FAILURE, _("illegal month value: use 1-12"));
 		/* FALLTHROUGH */
 	case 1:
-		ctl.req.year = strtol_or_err(*argv++, _("illegal year value"));
+		ctl.req.year = strtos32_or_err(*argv++, _("illegal year value"));
 		if (ctl.req.year < SMALLEST_YEAR)
 			errx(EXIT_FAILURE, _("illegal year value: use positive integer"));
+		if (ctl.req.year == INT32_MAX)
+			errx(EXIT_FAILURE, _("illegal year value"));
 		if (ctl.req.day) {
 			int dm = days_in_month[leap_year(ctl.req.year)][ctl.req.month];
 			if (ctl.req.day > dm)
 				errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), dm);
 			ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);
-		} else if ((long) (local_time->tm_year + 1900) == ctl.req.year) {
+		} else if ((int32_t) (local_time->tm_year + 1900) == ctl.req.year) {
 			ctl.req.day = local_time->tm_yday + 1;
 		}
 		if (!ctl.req.month && !ctl.req.week) {
@@ -463,7 +465,7 @@ int main(int argc, char **argv)
 		int m = 1;
 
 		if (yday < 1)
-			errx(EXIT_FAILURE, _("illegal week value: year %ld "
+			errx(EXIT_FAILURE, _("illegal week value: year %d "
 					     "doesn't have week %d"),
 					ctl.req.year, ctl.req.week);
 		while (m <= 12 && yday > days_in_month[leap][m])
@@ -476,7 +478,7 @@ int main(int argc, char **argv)
 			 * to if 53 is given as argument. */
 			if (ctl.req.week != week_number(31, 12, ctl.req.year - 1, &ctl))
 				errx(EXIT_FAILURE,
-					_("illegal week value: year %ld "
+					_("illegal week value: year %d "
 					  "doesn't have week %d"),
 					ctl.req.year, ctl.req.week);
 		}
@@ -507,7 +509,7 @@ int main(int argc, char **argv)
 }
 
 /* leap year -- account for gregorian reformation in 1752 */
-static int leap_year(long year)
+static int leap_year(int32_t year)
 {
 	if (year <= REFORMATION_YEAR)
 		return !(year % 4);
@@ -522,7 +524,7 @@ static void headers_init(struct cal_control *ctl)
 	char tmp[FMT_ST_CHARS];
 	size_t year_len;
 
-	year_len = snprintf(tmp, sizeof(tmp), "%ld", ctl->req.year);
+	year_len = snprintf(tmp, sizeof(tmp), "%d", ctl->req.year);
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		size_t space_left;
@@ -546,7 +548,7 @@ static void headers_init(struct cal_control *ctl)
 	}
 }
 
-static void set_consecutive_months(struct cal_month *month, int m, long y)
+static void set_consecutive_months(struct cal_month *month, int m, int32_t y)
 {
 	struct cal_month *i;
 	for (i = month; i; i = i->next) {
@@ -628,13 +630,13 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 		if (!ctl->yflag) {
 			fputs("\n", stdout);
 			for (i = month; i; i = i->next) {
-				sprintf(out, _("%ld"), i->year);
+				sprintf(out, _("%d"), i->year);
 				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 			}
 		}
 	} else {
 		for (i = month; i; i = i->next) {
-			sprintf(out, _("%s %ld"), ctl->full_month[i->month - 1], i->year);
+			sprintf(out, _("%s %d"), ctl->full_month[i->month - 1], i->year);
 			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	}
@@ -728,7 +730,7 @@ static void monthly3(const struct cal_control *ctl)
 {
 	struct cal_month m1, m2, m3, *i;
 	int first_month;
-	long first_year;
+	int32_t first_year;
 
 	m1.next = &m2;
 	m2.next = &m3;
@@ -769,7 +771,7 @@ static void yearly(const struct cal_control *ctl)
 		year_width += ctl->week_width + 1;
 	if (ctl->julian)
 		year_width--;
-	sprintf(out, "%ld", ctl->req.year);
+	sprintf(out, "%d", ctl->req.year);
 	center(out, year_width, 0);
 	fputs("\n\n", stdout);
 
@@ -788,7 +790,7 @@ static void yearly(const struct cal_control *ctl)
  * day_in_year --
  *	return the 1 based day number within the year
  */
-static int day_in_year(int day, int month, long year)
+static int day_in_year(int day, int month, int32_t year)
 {
 	int i, leap;
 
@@ -805,7 +807,7 @@ static int day_in_year(int day, int month, long year)
  *	3 Sep. 1752 through 13 Sep. 1752, and returns invalid weekday
  *	during the period of 11 days.
  */
-static int day_in_week(int day, int month, long year)
+static int day_in_week(int day, int month, int32_t year)
 {
 	static const int reform[] = {
 		SUNDAY, WEDNESDAY, TUESDAY, FRIDAY, SUNDAY, WEDNESDAY,
@@ -838,7 +840,7 @@ static int day_in_week(int day, int month, long year)
  *      Day may be given as Julian day of the year mode, in which
  *      case the month is disregarded entirely.
  */
-static int week_number(int day, int month, long year, const struct cal_control *ctl)
+static int week_number(int day, int month, int32_t year, const struct cal_control *ctl)
 {
 	int fday = 0, yday;
 	int wday = day_in_week(1, 1, year);
-- 
1.8.5.3

