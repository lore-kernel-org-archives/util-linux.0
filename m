Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55479 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab3J0UnE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:43:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id hm4so3039071wib.8
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:43:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/10] cal: make user request to be part of read-only control struct
Date: Sun, 27 Oct 2013 20:42:33 +0000
Message-Id: <1382906556-16442-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 136 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index df92cdd..b12a959 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -235,6 +235,13 @@ struct cal_width {
 	size_t wk;			/* week width == (7 * dlen + possible week num) */
 };
 
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
@@ -242,7 +249,7 @@ struct cal_control {
 	struct cal_width width;		/* width of output */
 	int weekstart;			/* day the week starts, often Sun or Mon */
 	int wflag;			/* uses WEEK_NUM_ enum */
-	int wnum;			/* requested --week=number */
+	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
 			yflag:1;	/* print whole year */
 };
@@ -252,17 +259,17 @@ static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
 static int do_monthly(int day, int month, long year, struct fmt_st *out, int header_hint,
 		      const struct cal_control *ctl);
-static void monthly(int day, int month, long year, const struct cal_control *ctl);
+static void monthly(const struct cal_control *ctl);
 static int two_header_lines(int month, long year, const struct cal_control *ctl);
-static void monthly3(int day, int month, long year, const struct cal_control *ctl);
+static void monthly3(const struct cal_control *ctl);
 static char *append_wnum(char *p, int *dp, int month, long year, int cal, int row,
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
 static char *ascii_wnum(char *p, int wnum, const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
@@ -273,14 +280,15 @@ int main(int argc, char **argv)
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
 		.wflag = WEEK_NUM_DISABLED,
-		.width.dy = DAY_LEN
+		.width.dy = DAY_LEN,
+		.req.day = 0,
+		.req.month = 0
 	};
 
 	enum {
@@ -376,9 +384,9 @@ int main(int argc, char **argv)
 			break;
 		case 'w':
 			if (optarg) {
-				ctl.wnum = strtos32_or_err(optarg,
+				ctl.req.week = strtos32_or_err(optarg,
 						_("invalid week argument"));
-				if (ctl.wnum < 1 || 53 < ctl.wnum)
+				if (ctl.req.week < 1 || 53 < ctl.req.week)
 					errx(EXIT_FAILURE,_("illegal week value: use 1-53"));
 			}
 			ctl.wflag = WEEK_NUM_US;	/* default per weekstart */
@@ -401,7 +409,7 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	if (ctl.wflag) {
-		ctl.wflag = ctl.wnum & WEEK_NUM_MASK;
+		ctl.wflag = ctl.req.week & WEEK_NUM_MASK;
 		ctl.wflag |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
 		ctl.width.wk = (ctl.width.dy * DAYS_IN_WEEK) + WNUM_LEN;
 	} else
@@ -412,70 +420,70 @@ int main(int argc, char **argv)
 
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
+			if (dm < ctl.req.day)
 				errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), dm);
-			day = day_in_year(day, month, year);
-		} else if ((long) (local_time->tm_year + 1900) == year) {
-			day = local_time->tm_yday + 1;
+			ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);
+		} else if ((long) (local_time->tm_year + 1900) == ctl.req.year) {
+			ctl.req.day = local_time->tm_yday + 1;
 		}
-		if (!month && !ctl.wnum)
+		if (!ctl.req.month && !ctl.req.week)
 			ctl.yflag = 1;
 		break;
 	case 0:
-		day = local_time->tm_yday + 1;
-		year = local_time->tm_year + 1900;
-		month = local_time->tm_mon + 1;
+		ctl.req.day = local_time->tm_yday + 1;
+		ctl.req.month = local_time->tm_mon + 1;
+		ctl.req.year = local_time->tm_year + 1900;
 		break;
 	default:
 		usage(stderr);
 	}
 
-	if (0 < ctl.wnum) {
-		int yday = week_to_day(year, &ctl);
-		int leap = leap_year(year);
+	if (0 < ctl.req.week) {
+		int yday = week_to_day(&ctl);
+		int leap = leap_year(ctl.req.year);
 
 		if (yday < 1)
 			errx(EXIT_FAILURE, _("illegal week value: year %ld "
 					     "doesn't have week %d"),
-					year, ctl.wnum);
-		month = 1;
-		while (month <= 12 && yday > days_in_month[leap][month])
-			yday -= days_in_month[leap][month++];
-		if (month > 12) {
+					ctl.req.year, ctl.req.week);
+		ctl.req.month = 1;
+		while (ctl.req.month <= 12 && days_in_month[leap][ctl.req.month] < yday)
+			yday -= days_in_month[leap][ctl.req.month++];
+		if (12 < ctl.req.month) {
 			/* In some years (e.g. 2010 in ISO mode) it's possible
 			 * to have a remnant of week 53 starting the year yet
 			 * the year in question ends during 52, in this case
 			 * we're assuming that early remnant is being referred
 			 * to if 53 is given as argument. */
-			if (ctl.wnum == week_number(31, 12, year - 1, &ctl))
-				month = 1;
+			if (ctl.req.week == week_number(31, 12, ctl.req.year - 1, &ctl))
+				ctl.req.month = 1;
 			else
 				errx(EXIT_FAILURE,
 					_("illegal week value: year %ld "
 					  "doesn't have week %d"),
-					year, ctl.wnum);
+					ctl.req.year, ctl.req.week);
 		}
 	}
 
 	headers_init(&ctl);
 
 	if (!colors_init(ctl.colormode)) {
-		day = 0;
+		ctl.req.day = 0;
 		ctl.wflag &= ~WEEK_NUM_MASK;
 	}
 
@@ -484,11 +492,11 @@ int main(int argc, char **argv)
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
@@ -587,12 +595,12 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
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
@@ -611,7 +619,7 @@ static int two_header_lines(int month, long year, const struct cal_control *ctl)
 	return 0;
 }
 
-static void monthly3(int day, int month, long year, const struct cal_control *ctl)
+static void monthly3(const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
@@ -625,30 +633,30 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
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
@@ -694,7 +702,7 @@ static char *append_wnum(char *p, int *dp,
 	return p;
 }
 
-static void yearly(int day, long year, const struct cal_control *ctl)
+static void yearly(const struct cal_control *ctl)
 {
 	int col, i, month, row, which_cal;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
@@ -705,7 +713,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 		      wnumlen + sizeof(day_headings) + 2 +
 		      wnumlen + sizeof(day_headings) + 1 ];
 
-	snprintf(lineout, sizeof(lineout), "%ld", year);
+	snprintf(lineout, sizeof(lineout), "%ld", ctl->req.year);
 
 	/* 2013-04-28: The -1 near HEAD_SEP makes year header to be aligned
 	 * exactly how it has been aligned for long time, but it is
@@ -714,7 +722,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(day, i + 1, year, days[i], ctl);
+		day_array(ctl->req.day, i + 1, ctl->req.year, days[i], ctl);
 
 	for (month = 0; month < MONTHS_IN_YEAR; month += ctl->num_months) {
 		center(ctl->full_month[month], ctl->width.wk - 1, HEAD_SEP + 1);
@@ -744,7 +752,7 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 
 				if (ctl->wflag)
 					p = append_wnum(p, days[month + which_cal],
-							month, year, which_cal,
+							month, ctl->req.year, which_cal,
 							row, ctl);
 
 				for (col = 0; col < DAYS_IN_WEEK; col++)
@@ -898,12 +906,12 @@ static int week_number(int day, int month, long year, const struct cal_control *
  *      for ISO-8601 modes. For North American numbering this
  *      always returns a Sunday.
  */
-static int week_to_day(long year, const struct cal_control *ctl)
+static int week_to_day(const struct cal_control *ctl)
 {
 	int yday, wday;
 
-	wday = day_in_week(1, 1, year);
-	yday = ctl->wnum * 7 - wday;
+	wday = day_in_week(1, 1, ctl->req.year);
+	yday = ctl->req.week * 7 - wday;
 
 	if (ctl->wflag & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
-- 
1.8.4.1

