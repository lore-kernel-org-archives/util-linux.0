Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64014 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3J0Um5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:42:57 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so3030999wid.5
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:42:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/10] cal: determine output width at beginning of run and reuse result
Date: Sun, 27 Oct 2013 20:42:31 +0000
Message-Id: <1382906556-16442-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 90 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 44c1af1..df92cdd 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -187,11 +187,6 @@ enum {
 #define MONTH_COLS		3		/* month columns in year view */
 #define WNUM_LEN                3
 
-#define	J_DAY_LEN		4		/* 4 spaces per day */
-#define	J_WEEK_LEN		(DAYS_IN_WEEK * J_DAY_LEN)
-#define	J_HEAD_SEP		2
-#define J_MONTH_COLS		2
-
 #define TODAY_FLAG		0x400		/* flag day for highlighting */
 
 #define FMT_ST_LINES 9
@@ -233,12 +228,18 @@ enum {
 };
 
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
-static char day_headings[J_WEEK_LEN * 6 + 1];
+static char day_headings[(WEEK_LEN + 1) * 6 + 1];
+
+struct cal_width {
+	size_t dy;			/* day width in characters in printout */
+	size_t wk;			/* week width == (7 * dlen + possible week num) */
+};
 
 struct cal_control {
 	const char *full_month[MONTHS_IN_YEAR];	/* month names */
 	int colormode;			/* day and week number highlight */
 	int num_months;			/* number of months horizontally in print out */
+	struct cal_width width;		/* width of output */
 	int weekstart;			/* day the week starts, often Sun or Mon */
 	int wflag;			/* uses WEEK_NUM_ enum */
 	int wnum;			/* requested --week=number */
@@ -278,7 +279,8 @@ int main(int argc, char **argv)
 		.weekstart = SUNDAY,
 		.num_months = NUM_MONTHS,
 		.colormode = UL_COLORMODE_AUTO,
-		.wflag = WEEK_NUM_DISABLED
+		.wflag = WEEK_NUM_DISABLED,
+		.width.dy = DAY_LEN
 	};
 
 	enum {
@@ -367,6 +369,7 @@ int main(int argc, char **argv)
 			break;
 		case 'j':
 			ctl.julian = 1;
+			ctl.width.dy = DAY_LEN + 1;
 			break;
 		case 'y':
 			ctl.yflag = 1;
@@ -400,7 +403,9 @@ int main(int argc, char **argv)
 	if (ctl.wflag) {
 		ctl.wflag = ctl.wnum & WEEK_NUM_MASK;
 		ctl.wflag |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
-	}
+		ctl.width.wk = (ctl.width.dy * DAYS_IN_WEEK) + WNUM_LEN;
+	} else
+		ctl.width.wk = (ctl.width.dy * DAYS_IN_WEEK);
 
 	time(&now);
 	local_time = localtime(&now);
@@ -474,9 +479,13 @@ int main(int argc, char **argv)
 		ctl.wflag &= ~WEEK_NUM_MASK;
 	}
 
-	if (ctl.yflag)
+	if (ctl.yflag) {
+		if (ctl.julian)
+			ctl.num_months = MONTH_COLS - 1;
+		else
+			ctl.num_months = MONTH_COLS;
 		yearly(day, year, &ctl);
-	else if (ctl.num_months == 1)
+	} else if (ctl.num_months == 1)
 		monthly(day, month, year, &ctl);
 	else if (ctl.num_months == 3)
 		monthly3(day, month, year, &ctl);
@@ -495,7 +504,7 @@ static int leap_year(long year)
 
 static void headers_init(struct cal_control *ctl)
 {
-	size_t i, wd, spaces = ctl->julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
+	size_t i, wd;
 	char *cur_dh = day_headings;
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
@@ -506,10 +515,10 @@ static void headers_init(struct cal_control *ctl)
 			strcat(cur_dh++, " ");
 		space_left = sizeof(day_headings) - (cur_dh - day_headings);
 
-		if (space_left <= spaces)
+		if (space_left <= (ctl->width.dy - 1))
 			break;
 		cur_dh += center_str(nl_langinfo(ABDAY_1 + wd), cur_dh,
-				     space_left, spaces);
+				     space_left, ctl->width.dy - 1);
 	}
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
@@ -521,8 +530,6 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
-	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1
-		       + (ctl->wflag ? WNUM_LEN : 0);
 	int pos = 0;
 
 	day_array(day, month, year, days, ctl);
@@ -531,10 +538,10 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		header_hint = two_header_lines(month, year, ctl);
 	if (header_hint) {
 		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->width.wk - 1);
 		pos++;
 		snprintf(lineout, sizeof(lineout), _("%ld"), year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->width.wk - 1);
 		pos++;
 	} else {
 		/* TRANSLATORS: %s is the month name, %ld the year number.
@@ -543,7 +550,7 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		 */
 		snprintf(lineout, sizeof(lineout), _("%s %ld"),
 			ctl->full_month[month - 1], year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->width.wk - 1);
 		pos++;
 	}
 
@@ -595,12 +602,11 @@ static void monthly(int day, int month, long year, const struct cal_control *ctl
 static int two_header_lines(int month, long year, const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
-	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1;
 	size_t len;
 	snprintf(lineout, sizeof(lineout), "%ld", year);
 	len = strlen(lineout);
 	len += strlen(ctl->full_month[month - 1]) + 1;
-	if (width < len)
+	if (ctl->width.wk - 1 < len)
 		return 1;
 	return 0;
 }
@@ -609,7 +615,7 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
-	int width, rows, two_lines;
+	int rows, two_lines;
 	struct fmt_st out_prev;
 	struct fmt_st out_curm;
 	struct fmt_st out_next;
@@ -644,7 +650,6 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 	do_monthly(day, month,      year,      &out_curm, two_lines, ctl);
 	do_monthly(day, next_month, next_year, &out_next, two_lines, ctl);
 
-	width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) -1;
 	for (i = 0; i < (two_lines ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
 			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
@@ -652,7 +657,7 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 	}
 	for (i = two_lines ? 3 : 2; i < rows; i++) {
 		int w1, w2, w3;
-		w1 = w2 = w3 = width;
+		w1 = w2 = w3 = ctl->width.wk;
 
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
 		/* adjust width to allow for non printable characters */
@@ -692,7 +697,6 @@ static char *append_wnum(char *p, int *dp,
 static void yearly(int day, long year, const struct cal_control *ctl)
 {
 	int col, i, month, row, which_cal;
-	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p;
 	/* three weeks + separators + \0 */
@@ -700,50 +704,42 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 	char lineout[ wnumlen + sizeof(day_headings) + 2 +
 		      wnumlen + sizeof(day_headings) + 2 +
 		      wnumlen + sizeof(day_headings) + 1 ];
-	if (ctl->julian) {
-		maxrow = J_MONTH_COLS;
-		sep_len = J_HEAD_SEP;
-		week_len = J_WEEK_LEN + wnumlen;
-	} else {
-		maxrow = MONTH_COLS;
-		sep_len = HEAD_SEP;
-		week_len = WEEK_LEN + wnumlen;
-	}
+
 	snprintf(lineout, sizeof(lineout), "%ld", year);
 
-	/* 2013-04-28: The -1 near sep_len makes year header to be aligned
+	/* 2013-04-28: The -1 near HEAD_SEP makes year header to be aligned
 	 * exactly how it has been aligned for long time, but it is
 	 * unexplainable.  */
-	center(lineout, (week_len + sep_len) * maxrow - sep_len - 1, 0);
+	center(lineout, (ctl->width.wk + HEAD_SEP) * ctl->num_months - HEAD_SEP - 1, 0);
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i], ctl);
 
-	for (month = 0; month < MONTHS_IN_YEAR; month += maxrow) {
-		center(ctl->full_month[month], week_len - 1, sep_len + 1);
+	for (month = 0; month < MONTHS_IN_YEAR; month += ctl->num_months) {
+		center(ctl->full_month[month], ctl->width.wk - 1, HEAD_SEP + 1);
 		if (ctl->julian) {
-			center(ctl->full_month[month + 1], week_len - 1, 0);
+			center(ctl->full_month[month + 1], ctl->width.wk - 1, 0);
 		} else {
-			center(ctl->full_month[month + 1], week_len - 1, sep_len + 1);
-			center(ctl->full_month[month + 2], week_len - 1, 0);
+			center(ctl->full_month[month + 1], ctl->width.wk - 1, HEAD_SEP + 1);
+			center(ctl->full_month[month + 2], ctl->width.wk - 1, 0);
 		}
 		if (ctl->julian)
 			snprintf(lineout, sizeof(lineout),
 				 "\n%*s%s%*s %*s%s\n",
-				 wnumlen,"", day_headings, sep_len, "",
+				 wnumlen,"", day_headings, HEAD_SEP, "",
 				 wnumlen,"", day_headings);
 		else
 			snprintf(lineout, sizeof(lineout),
 				 "\n%*s%s%*s %*s%s%*s %*s%s\n",
-				 wnumlen,"", day_headings, sep_len, "",
-				 wnumlen,"", day_headings, sep_len, "",
+				 wnumlen,"", day_headings, HEAD_SEP, "",
+				 wnumlen,"", day_headings, HEAD_SEP, "",
 				 wnumlen,"", day_headings);
 
 		my_putstring(lineout);
 		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 			p = lineout;
-			for (which_cal = 0; which_cal < maxrow; which_cal++) {
+			for (which_cal = 0; which_cal < ctl->num_months; which_cal++) {
 				int *dp = &days[month + which_cal][row * DAYS_IN_WEEK];
 
 				if (ctl->wflag)
@@ -919,6 +915,7 @@ static int week_to_day(long year, const struct cal_control *ctl)
 	return yday;
 }
 
+
 static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 {
 	int display, val;
@@ -933,9 +930,8 @@ static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 	};
 
 	if (day == SPACE) {
-		int len = ctl->julian ? J_DAY_LEN : DAY_LEN;
-		memset(p, ' ', len);
-		return p+len;
+		memset(p, ' ', ctl->width.dy);
+		return p + ctl->width.dy;
 	}
 	if (day & TODAY_FLAG) {
 		day &= ~TODAY_FLAG;
-- 
1.8.4.1

