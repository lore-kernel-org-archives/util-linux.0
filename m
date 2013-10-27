Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:47581 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab3J0Umo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:42:44 -0400
Received: by mail-we0-f171.google.com with SMTP id t60so5733466wes.16
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:42:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/10] cal: use control structure for run time configuration
Date: Sun, 27 Oct 2013 20:42:27 +0000
Message-Id: <1382906556-16442-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Runtime configuration is set at the time of command line option parsing,
and other initialization.  Later the configuration is read-only.  This
should make code a little bit more understandable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 243 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 126 insertions(+), 117 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c9264ba..b4eb1ba 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -234,40 +234,50 @@ enum {
 
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
 static char day_headings[J_WEEK_LEN * 6 + 1];
-/* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
-static const char *full_month[MONTHS_IN_YEAR];
 
-/* 0 => sunday, 1 => monday */
-static int weekstart = SUNDAY;
-static int julian;
+struct cal_control {
+	const char *full_month[MONTHS_IN_YEAR];	/* month names */
+	int colormode;			/* day and week number highlight */
+	int num_months;			/* number of months horizontally in print out */
+	int weekstart;			/* day the week starts, often Sun or Mon */
+	int wflag;			/* uses WEEK_NUM_ enum */
+	int wnum;			/* requested --week=number */
+	unsigned int	julian:1,	/* julian output */
+			yflag:1;	/* print whole year */
+};
 
 /* function prototypes */
 static int leap_year(long year);
-static char * ascii_day(char *, int);
-static char * ascii_wnum(char *, int,int);
+static char *ascii_day(char *, int, const struct cal_control *ctl);
+static char *ascii_wnum(char *p, int wn, const struct cal_control *ctl);
 static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 static void center(const char *, size_t, int);
-static void day_array(int, int, long, int *);
+static void day_array(int, int, long, int *, const struct cal_control *ctl);
 static int day_in_week(int, int, long);
 static int day_in_year(int, int, long);
-static int week_number(int, int, long, int);
-static int week_to_day(int, long, int);
-static void yearly(int, long, int, int);
-static int do_monthly(int, int, long, int, struct fmt_st*, int);
-static void monthly(int, int, long, int);
-static int two_header_lines(int month, long year);
-static void monthly3(int, int, long, int);
+static int week_number(int, int, long, const struct cal_control *ctl);
+static int week_to_day(long, const struct cal_control *ctl);
+static void yearly(int, long, const struct cal_control *ctl);
+static int do_monthly(int day, int month, long year, struct fmt_st *out,
+		      int header_hint, const struct cal_control *ctl);
+static void monthly(int, int, long, const struct cal_control *ctl);
+static int two_header_lines(int month, long year, const struct cal_control *ctl);
+static void monthly3(int, int, long, const struct cal_control *ctl);
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
-static void headers_init(int);
+static void headers_init(struct cal_control *ctl);
 
 int main(int argc, char **argv)
 {
 	struct tm *local_time;
 	time_t now;
-	int ch, day = 0, month = 0, yflag = 0, wflag = WEEK_NUM_DISABLED;
+	int ch, day = 0, month = 0;
 	long year;
-	int num_months = NUM_MONTHS;
-	int colormode = UL_COLORMODE_AUTO, wnum = 0;
+	static struct cal_control ctl = {
+		.weekstart = SUNDAY,
+		.num_months = NUM_MONTHS,
+		.colormode = UL_COLORMODE_AUTO,
+		.wflag = WEEK_NUM_DISABLED
+	};
 
 	enum {
 		OPT_COLOR = CHAR_MAX + 1
@@ -335,42 +345,42 @@ int main(int argc, char **argv)
 
 		wfd = val.word;
 		wfd = day_in_week(wfd % 100, (wfd / 100) % 100, wfd / (100 * 100));
-		weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
+		ctl.weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
 
 	while ((ch = getopt_long(argc, argv, "13mjsywVh", longopts, NULL)) != -1)
 		switch(ch) {
 		case '1':
-			num_months = 1;		/* default */
+			ctl.num_months = 1;		/* default */
 			break;
 		case '3':
-			num_months = 3;
+			ctl.num_months = 3;
 			break;
 		case 's':
-			weekstart = SUNDAY;	/* default */
+			ctl.weekstart = SUNDAY;		/* default */
 			break;
 		case 'm':
-			weekstart = MONDAY;
+			ctl.weekstart = MONDAY;
 			break;
 		case 'j':
-			julian = 1;
+			ctl.julian = 1;
 			break;
 		case 'y':
-			yflag = 1;
+			ctl.yflag = 1;
 			break;
 		case 'w':
 			if (optarg) {
-				wnum = strtos32_or_err(optarg,
+				ctl.wnum = strtos32_or_err(optarg,
 						_("invalid week argument"));
-				if (wnum < 1 || wnum > 53)
+				if (ctl.wnum < 1 || 53 < ctl.wnum)
 					errx(EXIT_FAILURE,_("illegal week value: use 1-53"));
 			}
-			wflag = WEEK_NUM_US;	/* default per weekstart */
+			ctl.wflag = WEEK_NUM_US;	/* default per weekstart */
 			break;
 		case OPT_COLOR:
 			if (optarg)
-				colormode = colormode_or_err(optarg,
+				ctl.colormode = colormode_or_err(optarg,
 						_("unsupported color mode"));
 			break;
 		case 'V':
@@ -385,9 +395,9 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	if (wflag) {
-		wflag = wnum & WEEK_NUM_MASK;
-		wflag |= (weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
+	if (ctl.wflag) {
+		ctl.wflag = ctl.wnum & WEEK_NUM_MASK;
+		ctl.wflag |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
 	}
 
 	time(&now);
@@ -416,8 +426,8 @@ int main(int argc, char **argv)
 		} else if ((long) (local_time->tm_year + 1900) == year) {
 			day = local_time->tm_yday + 1;
 		}
-		if (!month && !wnum)
-			yflag=1;
+		if (!month && !ctl.wnum)
+			ctl.yflag = 1;
 		break;
 	case 0:
 		day = local_time->tm_yday + 1;
@@ -428,14 +438,14 @@ int main(int argc, char **argv)
 		usage(stderr);
 	}
 
-	if (wnum > 0) {
-		int yday = week_to_day(wnum, year, wflag);
+	if (0 < ctl.wnum) {
+		int yday = week_to_day(year, &ctl);
 		int leap = leap_year(year);
 
 		if (yday < 1)
 			errx(EXIT_FAILURE, _("illegal week value: year %ld "
 					     "doesn't have week %d"),
-					year, wnum);
+					year, ctl.wnum);
 		month = 1;
 		while (month <= 12 && yday > days_in_month[leap][month])
 			yday -= days_in_month[leap][month++];
@@ -445,29 +455,29 @@ int main(int argc, char **argv)
 			 * the year in question ends during 52, in this case
 			 * we're assuming that early remnant is being referred
 			 * to if 53 is given as argument. */
-			if (wnum == week_number(31, 12, year - 1, wflag))
+			if (ctl.wnum == week_number(31, 12, year - 1, &ctl))
 				month = 1;
 			else
 				errx(EXIT_FAILURE,
 					_("illegal week value: year %ld "
 					  "doesn't have week %d"),
-					year, wnum);
+					year, ctl.wnum);
 		}
 	}
 
-	headers_init(julian);
+	headers_init(&ctl);
 
-	if (!colors_init(colormode)) {
+	if (!colors_init(ctl.colormode)) {
 		day = 0;
-		wflag &= ~WEEK_NUM_MASK;
+		ctl.wflag &= ~WEEK_NUM_MASK;
 	}
 
-	if (yflag)
-		yearly(day, year, julian, wflag);
-	else if (num_months == 1)
-		monthly(day, month, year, wflag);
-	else if (num_months == 3)
-		monthly3(day, month, year, wflag);
+	if (ctl.yflag)
+		yearly(day, year, &ctl);
+	else if (ctl.num_months == 1)
+		monthly(day, month, year, &ctl);
+	else if (ctl.num_months == 3)
+		monthly3(day, month, year, &ctl);
 
 	return EXIT_SUCCESS;
 }
@@ -481,14 +491,14 @@ static int leap_year(long year)
 		return ( !(year % 4) && (year % 100) ) || !(year % 400);
 }
 
-static void headers_init(int julian)
+static void headers_init(struct cal_control *ctl)
 {
-	size_t i, wd, spaces = julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
+	size_t i, wd, spaces = ctl->julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
 	char *cur_dh = day_headings;
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		size_t space_left;
-		wd = (i + weekstart) % DAYS_IN_WEEK;
+		wd = (i + ctl->weekstart) % DAYS_IN_WEEK;
 
 		if (i)
 			strcat(cur_dh++, " ");
@@ -501,24 +511,24 @@ static void headers_init(int julian)
 	}
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		full_month[i] = nl_langinfo(MON_1 + i);
+		ctl->full_month[i] = nl_langinfo(MON_1 + i);
 }
 
-static int do_monthly(int day, int month, long year, int wflag,
-		      struct fmt_st *out, int header_hint)
+static int do_monthly(int day, int month, long year, struct fmt_st *out,
+		      int header_hint, const struct cal_control *ctl)
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
-	size_t width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1
-		       + (wflag ? WNUM_LEN : 0);
+	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1
+		       + (ctl->wflag ? WNUM_LEN : 0);
 	int pos = 0;
 
-	day_array(day, month, year, days);
+	day_array(day, month, year, days, ctl);
 
 	if (header_hint < 0)
-		header_hint = two_header_lines(month, year);
+		header_hint = two_header_lines(month, year, ctl);
 	if (header_hint) {
-		snprintf(lineout, sizeof(lineout), _("%s"), full_month[month - 1]);
+		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
 		pos++;
 		snprintf(lineout, sizeof(lineout), _("%ld"), year);
@@ -530,26 +540,25 @@ static int do_monthly(int day, int month, long year, int wflag,
 		 * e.g. for Basque the translation should be "%2$ldko %1$s".
 		 */
 		snprintf(lineout, sizeof(lineout), _("%s %ld"),
-			full_month[month - 1], year);
+			ctl->full_month[month - 1], year);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
 		pos++;
 	}
 
 	snprintf(out->s[pos++], FMT_ST_CHARS, "%s%s",
-				(wflag ? "   " : ""),
+				(ctl->wflag ? "   " : ""),
 				day_headings);
 
 	for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 		int has_hl = 0;
 		p = lineout;
-		if (wflag)
+		if (ctl->wflag)
 			for (col = 0; col < DAYS_IN_WEEK; col++) {
 				int xd = days[row * DAYS_IN_WEEK + col];
 				if (xd != SPACE) {
-					int wnum = week_number(xd & ~TODAY_FLAG,
-							month, year, wflag);
-					p = ascii_wnum(p, wnum,
-							(wflag & WEEK_NUM_MASK) == wnum);
+					int wn = week_number(xd & ~TODAY_FLAG,
+							month, year, ctl);
+					p = ascii_wnum(p, wn, ctl);
 					break;
 				} else if (col+1 == DAYS_IN_WEEK)
 					p += sprintf(p,"   ");
@@ -558,7 +567,7 @@ static int do_monthly(int day, int month, long year, int wflag,
 			int xd = days[row * DAYS_IN_WEEK + col];
 			if (xd != SPACE && (xd & TODAY_FLAG))
 				has_hl = 1;
-			p = ascii_day(p, xd);
+			p = ascii_day(p, xd, ctl);
 		}
 		*p = '\0';
 		snprintf(out->s[row+pos], FMT_ST_CHARS, "%s", lineout);
@@ -569,32 +578,32 @@ static int do_monthly(int day, int month, long year, int wflag,
 	return pos;
 }
 
-static void monthly(int day, int month, long year, int wflag)
+static void monthly(int day, int month, long year, const struct cal_control *ctl)
 {
 	int i, rows;
 	struct fmt_st out;
 
-	rows = do_monthly(day, month, year, wflag, &out, -1);
+	rows = do_monthly(day, month, year, &out, -1, ctl);
 	for (i = 0; i < rows; i++) {
 		my_putstring(out.s[i]);
 		my_putstring("\n");
 	}
 }
 
-static int two_header_lines(int month, long year)
+static int two_header_lines(int month, long year, const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
-	size_t width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
+	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1;
 	size_t len;
 	snprintf(lineout, sizeof(lineout), "%ld", year);
 	len = strlen(lineout);
-	len += strlen(full_month[month - 1]) + 1;
+	len += strlen(ctl->full_month[month - 1]) + 1;
 	if (width < len)
 		return 1;
 	return 0;
 }
 
-static void monthly3(int day, int month, long year, int wflag)
+static void monthly3(int day, int month, long year, const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
@@ -622,18 +631,18 @@ static void monthly3(int day, int month, long year, int wflag)
 		next_month = month + 1;
 		next_year  = year;
 	}
-	two_lines = two_header_lines(prev_month, prev_year);
-	two_lines += two_header_lines(month, year);
-	two_lines += two_header_lines(next_month, next_year);
+	two_lines = two_header_lines(prev_month, prev_year, ctl);
+	two_lines += two_header_lines(month, year, ctl);
+	two_lines += two_header_lines(next_month, next_year, ctl);
 	if (0 < two_lines)
 		rows = FMT_ST_LINES;
 	else
 		rows = FMT_ST_LINES - 1;
-	do_monthly(day, prev_month, prev_year, wflag, &out_prev, two_lines);
-	do_monthly(day, month,      year,      wflag, &out_curm, two_lines);
-	do_monthly(day, next_month, next_year, wflag, &out_next, two_lines);
+	do_monthly(day, prev_month, prev_year, &out_prev, two_lines, ctl);
+	do_monthly(day, month,      year,      &out_curm, two_lines, ctl);
+	do_monthly(day, next_month, next_year, &out_next, two_lines, ctl);
 
-	width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
+	width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) -1;
 	for (i = 0; i < (two_lines ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
 			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
@@ -660,7 +669,7 @@ static void monthly3(int day, int month, long year, int wflag)
 
 static char *append_wnum(char *p, int *dp,
 			 int month, long year, int cal,
-			 int row, int wflag)
+			 int row, const struct cal_control *ctl)
 {
 	int col;
 
@@ -669,8 +678,8 @@ static char *append_wnum(char *p, int *dp,
 
 		if (xd != SPACE) {
 			int wnum = week_number(xd & ~TODAY_FLAG,
-					       month + cal + 1, year, wflag);
-			p = ascii_wnum(p, wnum, (wflag & WEEK_NUM_MASK) == wnum);
+					       month + cal + 1, year, ctl);
+			p = ascii_wnum(p, wnum, ctl);
 			break;
 		} else if (col+1 == DAYS_IN_WEEK)
 			p += sprintf(p,"   ");
@@ -678,18 +687,18 @@ static char *append_wnum(char *p, int *dp,
 	return p;
 }
 
-static void yearly(int day, long year, int julian, int wflag)
+static void yearly(int day, long year, const struct cal_control *ctl)
 {
 	int col, i, month, row, which_cal;
 	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p;
 	/* three weeks + separators + \0 */
-	int wnumlen = (wflag ? WNUM_LEN : 0);
+	int wnumlen = (ctl->wflag ? WNUM_LEN : 0);
 	char lineout[ wnumlen + sizeof(day_headings) + 2 +
 		      wnumlen + sizeof(day_headings) + 2 +
 		      wnumlen + sizeof(day_headings) + 1 ];
-	if (julian) {
+	if (ctl->julian) {
 		maxrow = J_MONTH_COLS;
 		sep_len = J_HEAD_SEP;
 		week_len = J_WEEK_LEN + wnumlen;
@@ -707,17 +716,17 @@ static void yearly(int day, long year, int julian, int wflag)
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(day, i + 1, year, days[i]);
+		day_array(day, i + 1, year, days[i], ctl);
 
 	for (month = 0; month < MONTHS_IN_YEAR; month += maxrow) {
-		center(full_month[month], week_len - 1, sep_len + 1);
-		if (julian) {
-			center(full_month[month + 1], week_len - 1, 0);
+		center(ctl->full_month[month], week_len - 1, sep_len + 1);
+		if (ctl->julian) {
+			center(ctl->full_month[month + 1], week_len - 1, 0);
 		} else {
-			center(full_month[month + 1], week_len - 1, sep_len + 1);
-			center(full_month[month + 2], week_len - 1, 0);
+			center(ctl->full_month[month + 1], week_len - 1, sep_len + 1);
+			center(ctl->full_month[month + 2], week_len - 1, 0);
 		}
-		if (julian)
+		if (ctl->julian)
 			snprintf(lineout, sizeof(lineout),
 				 "\n%*s%s%*s %*s%s\n",
 				 wnumlen,"", day_headings, sep_len, "",
@@ -735,13 +744,13 @@ static void yearly(int day, long year, int julian, int wflag)
 			for (which_cal = 0; which_cal < maxrow; which_cal++) {
 				int *dp = &days[month + which_cal][row * DAYS_IN_WEEK];
 
-				if (wflag)
+				if (ctl->wflag)
 					p = append_wnum(p, days[month + which_cal],
 							month, year, which_cal,
-							row, wflag);
+							row, ctl);
 
 				for (col = 0; col < DAYS_IN_WEEK; col++)
-					p = ascii_day(p, *dp++);
+					p = ascii_day(p, *dp++, ctl);
 				p += sprintf(p, "  ");
 			}
 			*p = '\0';
@@ -759,25 +768,25 @@ static void yearly(int day, long year, int julian, int wflag)
  *	out end to end.  You would have 42 numbers or spaces.  This routine
  *	builds that array for any month from Jan. 1 through Dec. 9999.
  */
-static void day_array(int day, int month, long year, int *days)
+static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl)
 {
 	int julday, daynum, dw, dm;
 	const int *sep1752;
 
 	memcpy(days, empty, MAXDAYS * sizeof(int));
 	if (year == REFORMATION_YEAR && month == REFORMATION_MONTH) {
-		sep1752 = julian ? j_sep1752 : d_sep1752;
-		memcpy(days, sep1752 + weekstart,
-		       ((MAXDAYS / 2) - weekstart) * sizeof(int));
+		sep1752 = ctl->julian ? j_sep1752 : d_sep1752;
+		memcpy(days, sep1752 + ctl->weekstart,
+		       ((MAXDAYS / 2) - ctl->weekstart) * sizeof(int));
 		for (dm = 0; dm < MAXDAYS / 2; dm++)
 			if (j_sep1752[dm] == day)
 				days[dm] |= TODAY_FLAG;
 		return;
 	}
 	dm = days_in_month[leap_year(year)][month];
-	dw = (day_in_week(1, month, year) - weekstart + DAYS_IN_WEEK) % DAYS_IN_WEEK;
+	dw = (day_in_week(1, month, year) - ctl->weekstart + DAYS_IN_WEEK) % DAYS_IN_WEEK;
 	julday = day_in_year(1, month, year);
-	daynum = julian ? julday : 1;
+	daynum = ctl->julian ? julday : 1;
 
 	while (dm--) {
 		days[dw] = daynum++;
@@ -841,12 +850,12 @@ static int day_in_week(int d, int m, long y)
  *      Day may be given as Julian day of the year mode, in which
  *      case the month is disregarded entirely.
  */
-static int week_number(int day, int month, long year, int wflag)
+static int week_number(int day, int month, long year, const struct cal_control *ctl)
 {
 	int fday = 0, yday;
 	int wday = day_in_week(1, 1, year);
 
-	if (wflag & WEEK_NUM_ISO)
+	if (ctl->wflag & WEEK_NUM_ISO)
 		fday = wday + (wday >= FRIDAY ? -2 : 5);
 	else
 		/* WEEK_NUM_US
@@ -869,17 +878,17 @@ static int week_number(int day, int month, long year, int wflag)
 
 	/* Last year is last year */
 	if (yday + fday < 7)
-		return week_number(31, 12, year - 1, wflag);
+		return week_number(31, 12, year - 1, ctl);
 
 	/* Or it could be part of the next year.  The reformation year had less
 	 * days than 365 making this check invalid, but reformation year ended
 	 * on Sunday and in week 51, so it's ok here. */
-	if (wflag == WEEK_NUM_ISO && yday >= 363
+	if (ctl->wflag == WEEK_NUM_ISO && yday >= 363
 	    && day_in_week(day, month, year) >= MONDAY
 	    && day_in_week(day, month, year) <= WEDNESDAY
 	    && day_in_week(31, 12, year) >= MONDAY
 	    && day_in_week(31, 12, year) <= WEDNESDAY)
-		return  week_number(1, 1, year + 1, wflag);
+		return  week_number(1, 1, year + 1, ctl);
 
 	return (yday + fday) / 7;
 }
@@ -891,14 +900,14 @@ static int week_number(int day, int month, long year, int wflag)
  *      for ISO-8601 modes. For North American numbering this
  *      always returns a Sunday.
  */
-static int week_to_day(int wnum, long year, int wflag)
+static int week_to_day(long year, const struct cal_control *ctl)
 {
 	int yday, wday;
 
 	wday = day_in_week(1, 1, year);
-	yday = wnum * 7 - wday;
+	yday = ctl->wnum * 7 - wday;
 
-	if (wflag & WEEK_NUM_ISO)
+	if (ctl->wflag & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
 	else
 		yday -= (wday == SUNDAY ? 6 : -1);	/* WEEK_NUM_US */
@@ -908,7 +917,7 @@ static int week_to_day(int wnum, long year, int wflag)
 	return yday;
 }
 
-static char *ascii_day(char *p, int day)
+static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 {
 	int display, val;
 	int highlight = 0;
@@ -922,7 +931,7 @@ static char *ascii_day(char *p, int day)
 	};
 
 	if (day == SPACE) {
-		int len = julian ? J_DAY_LEN : DAY_LEN;
+		int len = ctl->julian ? J_DAY_LEN : DAY_LEN;
 		memset(p, ' ', len);
 		return p+len;
 	}
@@ -931,7 +940,7 @@ static char *ascii_day(char *p, int day)
 		p += sprintf(p, "%s", Senter);
 		highlight = 1;
 	}
-	if (julian) {
+	if (ctl->julian) {
 		if ((val = day / 100)) {
 			day %= 100;
 			*p++ = val + '0';
@@ -956,12 +965,12 @@ static char *ascii_day(char *p, int day)
 	return p;
 }
 
-static char * ascii_wnum(char *p, int wnum,int highlight)
+static char *ascii_wnum(char *p, int wnum, const struct cal_control *ctl)
 {
-	if (highlight)
+	if ((ctl->wflag & WEEK_NUM_MASK) == wnum)
 		p += sprintf(p,"%s",Senter);
 	p += sprintf(p,"%2d",wnum);
-	if (highlight)
+	if ((ctl->wflag & WEEK_NUM_MASK) == wnum)
 		p += sprintf(p,"%s ",Sexit);
 	else
 		p += sprintf(p," ");
-- 
1.8.4.1

