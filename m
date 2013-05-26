Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:52338 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3EZJOX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 05:14:23 -0400
Received: by mail-we0-f175.google.com with SMTP id p60so3702296wes.20
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 02:14:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] cal: remove arbitrary limit of maxium year being 9999
Date: Sun, 26 May 2013 10:14:08 +0100
Message-Id: <1369559650-12341-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The change limits year to be unsigned long. In case a year + month name
exceed a column width two lines are used for them.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 122 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 41 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 9575db4..84fa4d2 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -177,7 +177,6 @@ enum {
 #define	SPACE			-1		/* used in day array */
 
 #define SMALLEST_YEAR		1
-#define GREATEST_YEAR		9999
 
 #define	DAY_LEN			3		/* 3 spaces per day */
 #define	WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
@@ -191,7 +190,7 @@ enum {
 
 #define TODAY_FLAG		0x400		/* flag day for highlighting */
 
-#define FMT_ST_LINES 8
+#define FMT_ST_LINES 9
 #define FMT_ST_CHARS 300	/* 90 suffices in most locales */
 struct fmt_st
 {
@@ -233,17 +232,18 @@ int weekstart = SUNDAY;
 int julian;
 
 /* function prototypes */
-static int leap_year(int year);
+static int leap_year(unsigned long year);
 static char * ascii_day(char *, int);
 static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 static void center(const char *, size_t, int);
-static void day_array(int, int, int, int *);
+static void day_array(int, int, unsigned long, int *);
 static int day_in_week(int, int, int);
-static int day_in_year(int, int, int);
-static void yearly(int, int, int);
-static void do_monthly(int, int, int, struct fmt_st*);
-static void monthly(int, int, int);
-static void monthly3(int, int, int);
+static int day_in_year(int, int, unsigned long);
+static void yearly(int, unsigned long, int);
+static int do_monthly(int, int, unsigned long, struct fmt_st*, int);
+static void monthly(int, int, unsigned long);
+static int two_header_lines(int month, unsigned long year);
+static void monthly3(int, int, unsigned long);
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
 static void headers_init(int);
 
@@ -251,7 +251,8 @@ int
 main(int argc, char **argv) {
 	struct tm *local_time;
 	time_t now;
-	int ch, day = 0, month = 0, year = 0, yflag = 0;
+	int ch, day = 0, month = 0, yflag = 0;
+	unsigned long year;
 	int num_months = NUM_MONTHS;
 	int colormode = UL_COLORMODE_AUTO;
 
@@ -379,15 +380,15 @@ main(int argc, char **argv) {
 			errx(EXIT_FAILURE, _("illegal month value: use 1-12"));
 		/* FALLTHROUGH */
 	case 1:
-		year = strtos32_or_err(*argv++, _("illegal year value: use 1-9999"));
-		if (year < SMALLEST_YEAR || GREATEST_YEAR < year)
-			errx(EXIT_FAILURE, _("illegal year value: use 1-9999"));
+		year = strtoul_or_err(*argv++, _("illegal year value: use positive integer"));
+		if (year < SMALLEST_YEAR)
+			errx(EXIT_FAILURE, _("illegal year value: use positive integer"));
 		if (day) {
 			int dm = days_in_month[leap_year(year)][month];
 			if (day > dm)
 				errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), dm);
 			day = day_in_year(day, month, year);
-		} else if ((local_time->tm_year + 1900) == year) {
+		} else if ((unsigned long) (local_time->tm_year + 1900) == year) {
 			day = local_time->tm_yday + 1;
 		}
 		if (!month)
@@ -417,7 +418,7 @@ main(int argc, char **argv) {
 }
 
 /* leap year -- account for gregorian reformation in 1752 */
-static int leap_year(int year)
+static int leap_year(unsigned long year)
 {
 	if (year <= REFORMATION_YEAR)
 		return !(year % 4);
@@ -449,11 +450,13 @@ static void headers_init(int julian)
 		full_month[i] = nl_langinfo(MON_1 + i);
 }
 
-static void
-do_monthly(int day, int month, int year, struct fmt_st *out) {
+static int
+do_monthly(int day, int month, unsigned long year, struct fmt_st *out, int header_hint) {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
-	int width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
+	size_t width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
+	size_t len;
+	int pos = 0;
 
 	day_array(day, month, year, days);
 
@@ -463,11 +466,23 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 	 * Basque the translation should be: "%2$dko %1$s", and
 	 * the Vietnamese should be "%s na(m %d", etc.
 	 */
-	snprintf(lineout, sizeof(lineout), _("%s %d"),
+	if (header_hint < 0)
+		header_hint = two_header_lines(month, year);
+	if (header_hint) {
+		snprintf(lineout, sizeof(lineout), _("%s"), full_month[month - 1]);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		pos++;
+		snprintf(lineout, sizeof(lineout), _("%lu"), year);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		pos++;
+	} else {
+		snprintf(lineout, sizeof(lineout), _("%s %lu"),
 			full_month[month - 1], year);
-	center_str(lineout, out->s[0], ARRAY_SIZE(out->s[0]), width);
+		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
+		pos++;
+	}
 
-	snprintf(out->s[1], FMT_ST_CHARS, "%s", day_headings);
+	snprintf(out->s[pos++], FMT_ST_CHARS, "%s", day_headings);
 	for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 		int has_hl = 0;
 		for (col = 0, p = lineout; col < DAYS_IN_WEEK; col++) {
@@ -477,35 +492,54 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 			p = ascii_day(p, xd);
 		}
 		*p = '\0';
-		snprintf(out->s[row+2], FMT_ST_CHARS, "%s", lineout);
+		snprintf(out->s[row+pos], FMT_ST_CHARS, "%s", lineout);
 		if (has_hl)
-			Hrow = out->s[row+2];
+			Hrow = out->s[row+pos];
 	}
+	pos += row;
+	return pos;
 }
 
 static void
-monthly(int day, int month, int year) {
-	int i;
+monthly(int day, int month, unsigned long year) {
+	int i, rows;
 	struct fmt_st out;
 
-	do_monthly(day, month, year, &out);
-	for (i = 0; i < FMT_ST_LINES; i++) {
+	rows = do_monthly(day, month, year, &out, -1);
+	for (i = 0; i < rows; i++) {
 		my_putstring(out.s[i]);
 		my_putstring("\n");
 	}
 }
 
+static int
+two_header_lines(int month, unsigned long year)
+{
+	char lineout[FMT_ST_CHARS];
+	size_t width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
+	size_t len;
+	snprintf(lineout, sizeof(lineout), "%lu", year);
+	len = strlen(lineout);
+	len += strlen(full_month[month - 1]) + 1;
+	if (width < len)
+		return 1;
+	return 0;
+}
+
 static void
-monthly3(int day, int month, int year) {
+monthly3(int day, int month, unsigned long year) {
 	char lineout[FMT_ST_CHARS];
 	int i;
-	int width;
+	int width, rows, r, two_lines;
 	struct fmt_st out_prev;
 	struct fmt_st out_curm;
 	struct fmt_st out_next;
-	int prev_month, prev_year;
-	int next_month, next_year;
+	int prev_month, next_month;
+	unsigned long prev_year, next_year;
 
+	memset(&out_prev, 0, sizeof(struct fmt_st));
+	memset(&out_curm, 0, sizeof(struct fmt_st));
+	memset(&out_next, 0, sizeof(struct fmt_st));
 	if (month == 1) {
 		prev_month = MONTHS_IN_YEAR;
 		prev_year  = year - 1;
@@ -520,18 +554,24 @@ monthly3(int day, int month, int year) {
 		next_month = month + 1;
 		next_year  = year;
 	}
-
-	do_monthly(day, prev_month, prev_year, &out_prev);
-	do_monthly(day, month,      year,      &out_curm);
-	do_monthly(day, next_month, next_year, &out_next);
+	two_lines = two_header_lines(prev_month, prev_year);
+	two_lines += two_header_lines(month, year);
+	two_lines += two_header_lines(next_month, next_year);
+	if (0 < two_lines)
+		rows = FMT_ST_LINES;
+	else
+		rows = FMT_ST_LINES - 1;
+	do_monthly(day, prev_month, prev_year, &out_prev, two_lines);
+	do_monthly(day, month,      year,      &out_curm, two_lines);
+	do_monthly(day, next_month, next_year, &out_next, two_lines);
 
 	width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < (two_lines ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
 			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
 		my_putstring(lineout);
 	}
-	for (i = 2; i < FMT_ST_LINES; i++) {
+	for (i = two_lines ? 3 : 2; i < rows; i++) {
 		int w1, w2, w3;
 		w1 = w2 = w3 = width;
 
@@ -551,7 +591,7 @@ monthly3(int day, int month, int year) {
 }
 
 static void
-yearly(int day, int year, int julian) {
+yearly(int day, unsigned long year, int julian) {
 	int col, *dp, i, month, row, which_cal;
 	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
@@ -566,7 +606,7 @@ yearly(int day, int year, int julian) {
 		sep_len = HEAD_SEP;
 		week_len = WEEK_LEN;
 	}
-	snprintf(lineout, sizeof(lineout), "%d", year);
+	snprintf(lineout, sizeof(lineout), "%lu", year);
 	/* 2013-04-28: The -1 near sep_len makes year header to be
 	 * aligned exactly how it has been aligned for long time, but it
 	 * is unexplainable.  */
@@ -615,7 +655,7 @@ yearly(int day, int year, int julian) {
  *	builds that array for any month from Jan. 1 through Dec. 9999.
  */
 static void
-day_array(int day, int month, int year, int *days) {
+day_array(int day, int month, unsigned long year, int *days) {
 	int julday, daynum, dw, dm;
 	int *sep1752;
 
@@ -646,7 +686,7 @@ day_array(int day, int month, int year, int *days) {
  *	return the 1 based day number within the year
  */
 static int
-day_in_year(int day, int month, int year) {
+day_in_year(int day, int month, unsigned long year) {
 	int i, leap;
 
 	leap = leap_year(year);
-- 
1.8.2.3

