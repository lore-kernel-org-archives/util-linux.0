Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48819 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab3KJSZF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:05 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so3771423wgh.25
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/13] cal: make user request to be part of read-only control struct
Date: Sun, 10 Nov 2013 18:23:35 +0000
Message-Id: <1384107820-498-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 138 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 65 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index bc53d4f..185b7a9 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -230,15 +230,22 @@ enum {
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
 static char day_headings[(WEEK_LEN + 1) * 6 + 1];
 
+struct cal_request {
+	int day;
+	int month;
+	long year;
+	int week;
+};
+
 struct cal_control {
 	const char *full_month[MONTHS_IN_YEAR];	/* month names */
 	int colormode;			/* day and week number highlight */
 	int num_months;			/* number of months horizontally in print out */
 	int weekstart;			/* day the week starts, often Sun or Mon */
 	int weektype;			/* WEEK_TYPE_{NONE,ISO,US} */
-	int weeknum;			/* requested --week=<number> */
 	size_t day_width;		/* day width in characters in printout */
 	size_t week_width;		/* 7 * day_width + possible week num */
+	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
 			yflag:1;	/* print whole year */
 };
@@ -248,17 +255,17 @@ static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
 static int do_monthly(int day, int month, long year, struct fmt_st *out, int header_hint,
 		      const struct cal_control *ctl);
-static void monthly(int day, int month, long year, const struct cal_control *ctl);
+static void monthly(const struct cal_control *ctl);
 static int two_header_lines(int month, long year, const struct cal_control *ctl);
-static void monthly3(int day, int month, long year, const struct cal_control *ctl);
+static void monthly3(const struct cal_control *ctl);
 static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int row,
 			    const struct cal_control *ctl);
-static void yearly(int day, long year, const struct cal_control *ctl);
+static void yearly(const struct cal_control *ctl);
 static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl);
 static int day_in_year(int day, int month, long year);
 static int day_in_week(int day, int month, long year);
 static int week_number(int day, int month, long year, const struct cal_control *ctl);
-static int week_to_day(long year, const struct cal_control *ctl);
+static int week_to_day(const struct cal_control *ctl);
 static char *ascii_day(char *p, int day, const struct cal_control *ctl);
 static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
@@ -269,14 +276,15 @@ int main(int argc, char **argv)
 {
 	struct tm *local_time;
 	time_t now;
-	int ch, day = 0, month = 0;
-	long year;
+	int ch;
 	static struct cal_control ctl = {
 		.weekstart = SUNDAY,
 		.num_months = NUM_MONTHS,
 		.colormode = UL_COLORMODE_AUTO,
 		.weektype = WEEK_NUM_DISABLED,
-		.day_width = DAY_LEN
+		.day_width = DAY_LEN,
+		.req.day = 0,
+		.req.month = 0
 	};
 
 	enum {
@@ -372,9 +380,9 @@ int main(int argc, char **argv)
 			break;
 		case 'w':
 			if (optarg) {
-				ctl.weeknum = strtos32_or_err(optarg,
+				ctl.req.week = strtos32_or_err(optarg,
 						_("invalid week argument"));
-				if (ctl.weeknum < 1 || 53 < ctl.weeknum)
+				if (ctl.req.week < 1 || 53 < ctl.req.week)
 					errx(EXIT_FAILURE,_("illegal week value: use 1-53"));
 			}
 			ctl.weektype = WEEK_NUM_US;	/* default per weekstart */
@@ -397,7 +405,7 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	if (ctl.weektype) {
-		ctl.weektype = ctl.weeknum & WEEK_NUM_MASK;
+		ctl.weektype = ctl.req.week & WEEK_NUM_MASK;
 		ctl.weektype |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
 		ctl.week_width = (ctl.day_width * DAYS_IN_WEEK) + WNUM_LEN;
 	} else
@@ -408,70 +416,70 @@ int main(int argc, char **argv)
 
 	switch(argc) {
 	case 3:
-		day = strtos32_or_err(*argv++, _("illegal day value"));
-		if (day < 1 || DAYS_IN_MONTH < day)
+		ctl.req.day = strtos32_or_err(*argv++, _("illegal day value"));
+		if (ctl.req.day < 1 || DAYS_IN_MONTH < ctl.req.day)
 			errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), DAYS_IN_MONTH);
 		/* FALLTHROUGH */
 	case 2:
-		month = strtos32_or_err(*argv++, _("illegal month value: use 1-12"));
-		if (month < 1 || MONTHS_IN_YEAR < month)
+		ctl.req.month = strtos32_or_err(*argv++, _("illegal month value: use 1-12"));
+		if (ctl.req.month < 1 || MONTHS_IN_YEAR < ctl.req.month)
 			errx(EXIT_FAILURE, _("illegal month value: use 1-12"));
 		/* FALLTHROUGH */
 	case 1:
-		year = strtol_or_err(*argv++, _("illegal year value"));
-		if (year < SMALLEST_YEAR)
+		ctl.req.year = strtol_or_err(*argv++, _("illegal year value"));
+		if (ctl.req.year < SMALLEST_YEAR)
 			errx(EXIT_FAILURE, _("illegal year value: use positive integer"));
-		if (day) {
-			int dm = days_in_month[leap_year(year)][month];
-			if (day > dm)
+		if (ctl.req.day) {
+			int dm = days_in_month[leap_year(ctl.req.year)][ctl.req.month];
+			if (ctl.req.day > dm)
 				errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), dm);
-			day = day_in_year(day, month, year);
-		} else if ((long) (local_time->tm_year + 1900) == year) {
-			day = local_time->tm_yday + 1;
+			ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);
+		} else if ((long) (local_time->tm_year + 1900) == ctl.req.year) {
+			ctl.req.day = local_time->tm_yday + 1;
 		}
-		if (!month && !ctl.weeknum)
+		if (!ctl.req.month && !ctl.req.week)
 			ctl.yflag = 1;
 		break;
 	case 0:
-		day = local_time->tm_yday + 1;
-		year = local_time->tm_year + 1900;
-		month = local_time->tm_mon + 1;
+		ctl.req.day = local_time->tm_yday + 1;
+		ctl.req.year = local_time->tm_year + 1900;
+		ctl.req.month = local_time->tm_mon + 1;
 		break;
 	default:
 		usage(stderr);
 	}
 
-	if (0 < ctl.weeknum) {
-		int yday = week_to_day(year, &ctl);
-		int leap = leap_year(year);
+	if (0 < ctl.req.week) {
+		int yday = week_to_day(&ctl);
+		int leap = leap_year(ctl.req.year);
+		int m = 1;
 
 		if (yday < 1)
 			errx(EXIT_FAILURE, _("illegal week value: year %ld "
 					     "doesn't have week %d"),
-					year, ctl.weeknum);
-		month = 1;
-		while (month <= 12 && yday > days_in_month[leap][month])
-			yday -= days_in_month[leap][month++];
-		if (month > 12) {
+					ctl.req.year, ctl.req.week);
+		while (m <= 12 && yday > days_in_month[leap][m])
+			yday -= days_in_month[leap][m++];
+		if (m > 12) {
 			/* In some years (e.g. 2010 in ISO mode) it's possible
 			 * to have a remnant of week 53 starting the year yet
 			 * the year in question ends during 52, in this case
 			 * we're assuming that early remnant is being referred
 			 * to if 53 is given as argument. */
-			if (ctl.weeknum == week_number(31, 12, year - 1, &ctl))
-				month = 1;
-			else
+			if (ctl.req.week != week_number(31, 12, ctl.req.year - 1, &ctl))
 				errx(EXIT_FAILURE,
 					_("illegal week value: year %ld "
 					  "doesn't have week %d"),
-					year, ctl.weeknum);
+					ctl.req.year, ctl.req.week);
 		}
+		if (!ctl.req.month)
+			ctl.req.month = 12 < m ? 1 : m;
 	}
 
 	headers_init(&ctl);
 
 	if (!colors_init(ctl.colormode)) {
-		day = 0;
+		ctl.req.day = 0;
 		ctl.weektype &= ~WEEK_NUM_MASK;
 	}
 
@@ -480,11 +488,11 @@ int main(int argc, char **argv)
 			ctl.num_months = MONTH_COLS - 1;
 		else
 			ctl.num_months = MONTH_COLS;
-		yearly(day, year, &ctl);
+		yearly(&ctl);
 	} else if (ctl.num_months == 1)
-		monthly(day, month, year, &ctl);
+		monthly(&ctl);
 	else if (ctl.num_months == 3)
-		monthly3(day, month, year, &ctl);
+		monthly3(&ctl);
 
 	return EXIT_SUCCESS;
 }
@@ -583,12 +591,12 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 	return pos;
 }
 
-static void monthly(int day, int month, long year, const struct cal_control *ctl)
+static void monthly(const struct cal_control *ctl)
 {
 	int i, rows;
 	struct fmt_st out;
 
-	rows = do_monthly(day, month, year, &out, -1, ctl);
+	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, -1, ctl);
 	for (i = 0; i < rows; i++) {
 		my_putstring(out.s[i]);
 		my_putstring("\n");
@@ -607,7 +615,7 @@ static int two_header_lines(int month, long year, const struct cal_control *ctl)
 	return 0;
 }
 
-static void monthly3(int day, int month, long year, const struct cal_control *ctl)
+static void monthly3(const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
@@ -621,30 +629,30 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 	memset(&out_prev, 0, sizeof(struct fmt_st));
 	memset(&out_curm, 0, sizeof(struct fmt_st));
 	memset(&out_next, 0, sizeof(struct fmt_st));
-	if (month == 1) {
+	if (ctl->req.month == 1) {
 		prev_month = MONTHS_IN_YEAR;
-		prev_year  = year - 1;
+		prev_year  = ctl->req.year - 1;
 	} else {
-		prev_month = month - 1;
-		prev_year  = year;
+		prev_month = ctl->req.month - 1;
+		prev_year  = ctl->req.year;
 	}
-	if (month == MONTHS_IN_YEAR) {
+	if (ctl->req.month == MONTHS_IN_YEAR) {
 		next_month = 1;
-		next_year  = year + 1;
+		next_year  = ctl->req.year + 1;
 	} else {
-		next_month = month + 1;
-		next_year  = year;
+		next_month = ctl->req.month + 1;
+		next_year  = ctl->req.year;
 	}
 	two_lines = two_header_lines(prev_month, prev_year, ctl);
-	two_lines += two_header_lines(month, year, ctl);
+	two_lines += two_header_lines(ctl->req.month, ctl->req.year, ctl);
 	two_lines += two_header_lines(next_month, next_year, ctl);
 	if (0 < two_lines)
 		rows = FMT_ST_LINES;
 	else
 		rows = FMT_ST_LINES - 1;
-	do_monthly(day, prev_month, prev_year, &out_prev, two_lines, ctl);
-	do_monthly(day, month,      year,      &out_curm, two_lines, ctl);
-	do_monthly(day, next_month, next_year, &out_next, two_lines, ctl);
+	do_monthly(ctl->req.day, prev_month, prev_year, &out_prev, two_lines, ctl);
+	do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out_curm, two_lines, ctl);
+	do_monthly(ctl->req.day, next_month, next_year, &out_next, two_lines, ctl);
 
 	for (i = 0; i < (two_lines ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
@@ -690,7 +698,7 @@ static char *append_weeknum(char *p, int *dp,
 	return p;
 }
 
-static void yearly(int day, long year, const struct cal_control *ctl)
+static void yearly(const struct cal_control *ctl)
 {
 	int col, i, month, row, which_cal;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
@@ -701,7 +709,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 		      weeknumlen + sizeof(day_headings) + 2 +
 		      weeknumlen + sizeof(day_headings) + 1 ];
 
-	snprintf(lineout, sizeof(lineout), "%ld", year);
+	snprintf(lineout, sizeof(lineout), "%ld", ctl->req.year);
 
 	/* 2013-04-28: The -1 near HEAD_SEP makes year header to be aligned
 	 * exactly how it has been aligned for long time, but it is
@@ -710,7 +718,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(day, i + 1, year, days[i], ctl);
+		day_array(ctl->req.day, i + 1, ctl->req.year, days[i], ctl);
 
 	for (month = 0; month < MONTHS_IN_YEAR; month += ctl->num_months) {
 		center(ctl->full_month[month], ctl->week_width - 1, HEAD_SEP + 1);
@@ -740,7 +748,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 
 				if (ctl->weektype)
 					p = append_weeknum(p, days[month + which_cal],
-							month, year, which_cal,
+							month, ctl->req.year, which_cal,
 							row, ctl);
 
 				for (col = 0; col < DAYS_IN_WEEK; col++)
@@ -894,12 +902,12 @@ static int week_number(int day, int month, long year, const struct cal_control *
  *      for ISO-8601 modes. For North American numbering this
  *      always returns a Sunday.
  */
-static int week_to_day(long year, const struct cal_control *ctl)
+static int week_to_day(const struct cal_control *ctl)
 {
 	int yday, wday;
 
-	wday = day_in_week(1, 1, year);
-	yday = ctl->weeknum * 7 - wday;
+	wday = day_in_week(1, 1, ctl->req.year);
+	yday = ctl->req.week * 7 - wday;
 
 	if (ctl->weektype & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
-- 
1.8.4.2

