Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:52630 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3KJSZA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:00 -0500
Received: by mail-wi0-f179.google.com with SMTP id fb10so1285939wid.0
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:24:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/13] cal: determine output width at beginning of run and reuse result
Date: Sun, 10 Nov 2013 18:23:33 +0000
Message-Id: <1384107820-498-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 85 +++++++++++++++++++++++++-------------------------------
 1 file changed, 38 insertions(+), 47 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c1bbdce..bc53d4f 100644
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
@@ -233,7 +228,7 @@ enum {
 };
 
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
-static char day_headings[J_WEEK_LEN * 6 + 1];
+static char day_headings[(WEEK_LEN + 1) * 6 + 1];
 
 struct cal_control {
 	const char *full_month[MONTHS_IN_YEAR];	/* month names */
@@ -242,6 +237,8 @@ struct cal_control {
 	int weekstart;			/* day the week starts, often Sun or Mon */
 	int weektype;			/* WEEK_TYPE_{NONE,ISO,US} */
 	int weeknum;			/* requested --week=<number> */
+	size_t day_width;		/* day width in characters in printout */
+	size_t week_width;		/* 7 * day_width + possible week num */
 	unsigned int	julian:1,	/* julian output */
 			yflag:1;	/* print whole year */
 };
@@ -278,7 +275,8 @@ int main(int argc, char **argv)
 		.weekstart = SUNDAY,
 		.num_months = NUM_MONTHS,
 		.colormode = UL_COLORMODE_AUTO,
-		.weektype = WEEK_NUM_DISABLED
+		.weektype = WEEK_NUM_DISABLED,
+		.day_width = DAY_LEN
 	};
 
 	enum {
@@ -367,6 +365,7 @@ int main(int argc, char **argv)
 			break;
 		case 'j':
 			ctl.julian = 1;
+			ctl.day_width = DAY_LEN + 1;
 			break;
 		case 'y':
 			ctl.yflag = 1;
@@ -400,7 +399,9 @@ int main(int argc, char **argv)
 	if (ctl.weektype) {
 		ctl.weektype = ctl.weeknum & WEEK_NUM_MASK;
 		ctl.weektype |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
-	}
+		ctl.week_width = (ctl.day_width * DAYS_IN_WEEK) + WNUM_LEN;
+	} else
+		ctl.week_width = ctl.day_width * DAYS_IN_WEEK;
 
 	time(&now);
 	local_time = localtime(&now);
@@ -474,9 +475,13 @@ int main(int argc, char **argv)
 		ctl.weektype &= ~WEEK_NUM_MASK;
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
@@ -495,7 +500,7 @@ static int leap_year(long year)
 
 static void headers_init(struct cal_control *ctl)
 {
-	size_t i, wd, spaces = ctl->julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
+	size_t i, wd;
 	char *cur_dh = day_headings;
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
@@ -506,10 +511,10 @@ static void headers_init(struct cal_control *ctl)
 			strcat(cur_dh++, " ");
 		space_left = sizeof(day_headings) - (cur_dh - day_headings);
 
-		if (space_left <= spaces)
+		if (space_left <= (ctl->day_width - 1))
 			break;
 		cur_dh += center_str(nl_langinfo(ABDAY_1 + wd), cur_dh,
-				     space_left, spaces);
+				     space_left, ctl->day_width - 1);
 	}
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
@@ -521,8 +526,6 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
-	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1
-		       + (ctl->weektype ? WNUM_LEN : 0);
 	int pos = 0;
 
 	day_array(day, month, year, days, ctl);
@@ -531,10 +534,10 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		header_hint = two_header_lines(month, year, ctl);
 	if (header_hint) {
 		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
 		pos++;
 		snprintf(lineout, sizeof(lineout), _("%ld"), year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
 		pos++;
 	} else {
 		/* TRANSLATORS: %s is the month name, %ld the year number.
@@ -543,7 +546,7 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		 */
 		snprintf(lineout, sizeof(lineout), _("%s %ld"),
 			ctl->full_month[month - 1], year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
 		pos++;
 	}
 
@@ -595,12 +598,11 @@ static void monthly(int day, int month, long year, const struct cal_control *ctl
 static int two_header_lines(int month, long year, const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
-	size_t width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) - 1;
 	size_t len;
 	snprintf(lineout, sizeof(lineout), "%ld", year);
 	len = strlen(lineout);
 	len += strlen(ctl->full_month[month - 1]) + 1;
-	if (width < len)
+	if (ctl->week_width - 1 < len)
 		return 1;
 	return 0;
 }
@@ -609,7 +611,7 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
-	int width, rows, two_lines;
+	int rows, two_lines;
 	struct fmt_st out_prev;
 	struct fmt_st out_curm;
 	struct fmt_st out_next;
@@ -644,7 +646,6 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 	do_monthly(day, month,      year,      &out_curm, two_lines, ctl);
 	do_monthly(day, next_month, next_year, &out_next, two_lines, ctl);
 
-	width = (ctl->julian ? J_WEEK_LEN : WEEK_LEN) -1;
 	for (i = 0; i < (two_lines ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
 			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
@@ -652,7 +653,7 @@ static void monthly3(int day, int month, long year, const struct cal_control *ct
 	}
 	for (i = two_lines ? 3 : 2; i < rows; i++) {
 		int w1, w2, w3;
-		w1 = w2 = w3 = width;
+		w1 = w2 = w3 = ctl->week_width;
 
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
 		/* adjust width to allow for non printable characters */
@@ -692,7 +693,6 @@ static char *append_weeknum(char *p, int *dp,
 static void yearly(int day, long year, const struct cal_control *ctl)
 {
 	int col, i, month, row, which_cal;
-	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p;
 	/* three weeks + separators + \0 */
@@ -700,50 +700,42 @@ static void yearly(int day, long year, const struct cal_control *ctl)
 	char lineout[ weeknumlen + sizeof(day_headings) + 2 +
 		      weeknumlen + sizeof(day_headings) + 2 +
 		      weeknumlen + sizeof(day_headings) + 1 ];
-	if (ctl->julian) {
-		maxrow = J_MONTH_COLS;
-		sep_len = J_HEAD_SEP;
-		week_len = J_WEEK_LEN + weeknumlen;
-	} else {
-		maxrow = MONTH_COLS;
-		sep_len = HEAD_SEP;
-		week_len = WEEK_LEN + weeknumlen;
-	}
+
 	snprintf(lineout, sizeof(lineout), "%ld", year);
 
-	/* 2013-04-28: The -1 near sep_len makes year header to be aligned
+	/* 2013-04-28: The -1 near HEAD_SEP makes year header to be aligned
 	 * exactly how it has been aligned for long time, but it is
 	 * unexplainable.  */
-	center(lineout, (week_len + sep_len) * maxrow - sep_len - 1, 0);
+	center(lineout, (ctl->week_width + HEAD_SEP) * ctl->num_months - HEAD_SEP - 1, 0);
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i], ctl);
 
-	for (month = 0; month < MONTHS_IN_YEAR; month += maxrow) {
-		center(ctl->full_month[month], week_len - 1, sep_len + 1);
+	for (month = 0; month < MONTHS_IN_YEAR; month += ctl->num_months) {
+		center(ctl->full_month[month], ctl->week_width - 1, HEAD_SEP + 1);
 		if (ctl->julian) {
-			center(ctl->full_month[month + 1], week_len - 1, 0);
+			center(ctl->full_month[month + 1], ctl->week_width - 1, 0);
 		} else {
-			center(ctl->full_month[month + 1], week_len - 1, sep_len + 1);
-			center(ctl->full_month[month + 2], week_len - 1, 0);
+			center(ctl->full_month[month + 1], ctl->week_width - 1, HEAD_SEP + 1);
+			center(ctl->full_month[month + 2], ctl->week_width - 1, 0);
 		}
 		if (ctl->julian)
 			snprintf(lineout, sizeof(lineout),
 				 "\n%*s%s%*s %*s%s\n",
-				 weeknumlen,"", day_headings, sep_len, "",
+				 weeknumlen,"", day_headings, HEAD_SEP, "",
 				 weeknumlen,"", day_headings);
 		else
 			snprintf(lineout, sizeof(lineout),
 				 "\n%*s%s%*s %*s%s%*s %*s%s\n",
-				 weeknumlen,"", day_headings, sep_len, "",
-				 weeknumlen,"", day_headings, sep_len, "",
+				 weeknumlen,"", day_headings, HEAD_SEP, "",
+				 weeknumlen,"", day_headings, HEAD_SEP, "",
 				 weeknumlen,"", day_headings);
 
 		my_putstring(lineout);
 		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 			p = lineout;
-			for (which_cal = 0; which_cal < maxrow; which_cal++) {
+			for (which_cal = 0; which_cal < ctl->num_months; which_cal++) {
 				int *dp = &days[month + which_cal][row * DAYS_IN_WEEK];
 
 				if (ctl->weektype)
@@ -933,9 +925,8 @@ static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 	};
 
 	if (day == SPACE) {
-		int len = ctl->julian ? J_DAY_LEN : DAY_LEN;
-		memset(p, ' ', len);
-		return p+len;
+		memset(p, ' ', ctl->day_width);
+		return p + ctl->day_width;
 	}
 	if (day & TODAY_FLAG) {
 		day &= ~TODAY_FLAG;
-- 
1.8.4.2

