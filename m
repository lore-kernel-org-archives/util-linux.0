Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:44840 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761543Ab3EBSwe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:34 -0400
Received: by mail-we0-f174.google.com with SMTP id z2so733991wey.33
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/16] cal: move global variables to local scope
Date: Thu,  2 May 2013 19:51:39 +0100
Message-Id: <1367520701-14962-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also include small change to function parameter coding style.  The braces
are from function line to new line, and return value is in same line with
the function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 103 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index f4fb898..127a855 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -223,31 +223,22 @@ static int days_in_month[2][13] = {
 };
 
 
-/* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
-char day_headings[J_WEEK_LEN * 6 + 1];
-/* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
-const char *full_month[MONTHS_IN_YEAR];
-
-/* 0 => sunday, 1 => monday */
-int weekstart = SUNDAY;
-int julian;
-
 /* function prototypes */
 static int leap_year(int year);
 static int centuries_since_1700(int year, int centuries);
 static int leap_years_since_year_1(int year);
-char * ascii_day(char *, int);
+char * ascii_day(const int, char *, int);
 int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 void center(const char *, size_t, int);
-void day_array(int, int, int, int *);
+void day_array(const int, const int, int, int, int, int *);
 int day_in_week(int, int, int);
 int day_in_year(int, int, int);
-void yearly(int, int, int);
-void do_monthly(int, int, int, struct fmt_st*);
-void monthly(int, int, int);
-void monthly3(int, int, int);
+void yearly(int, int, const int, const int, const char *, const char **);
+void do_monthly(const int, const int, const char *, const char **, int, int, int, struct fmt_st*);
+void monthly(const int, const int, const char *, const char **, int, int, int);
+void monthly3(const int, const int, const char *, const char **, int, int, int);
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
-void headers_init(int);
+void headers_init(const int, const int, char *, const char **);
 
 int
 main(int argc, char **argv) {
@@ -255,6 +246,12 @@ main(int argc, char **argv) {
 	time_t now;
 	int ch, day = 0, month = 0, year = 0, yflag = 0;
 	int num_months = NUM_MONTHS;
+	/* UTF-8 can have up to 6 bytes per char; and an extra byte for
+	 * ending \0 */
+	char day_headings[J_WEEK_LEN * 6 + 1];
+	const char *full_month[MONTHS_IN_YEAR];
+	int julian = 0;
+	int weekstart = SUNDAY;
 
 	enum Highlight_type {
 		HIGHLIGHT_UNUSED,
@@ -411,7 +408,7 @@ main(int argc, char **argv) {
 	default:
 		usage(stderr);
 	}
-	headers_init(julian);
+	headers_init(julian, weekstart, day_headings, full_month);
 
 	switch (highlight) {
 	case HIGHLIGHT_NEVER:
@@ -430,11 +427,11 @@ main(int argc, char **argv) {
 	}
 
 	if (yflag)
-		yearly(day, year, julian);
+		yearly(day, year, julian, weekstart, day_headings, full_month);
 	else if (num_months == 1)
-		monthly(day, month, year);
+		monthly(julian, weekstart, day_headings, full_month, day, month, year);
 	else if (num_months == 3)
-		monthly3(day, month, year);
+		monthly3(julian, weekstart, day_headings, full_month, day, month, year);
 
 	return EXIT_SUCCESS;
 }
@@ -464,7 +461,8 @@ static int leap_years_since_year_1(int year)
 		centuries_since_1700(year, 4));
 }
 
-void headers_init(int julian)
+void headers_init(const int julian, const int weekstart, char *day_headings,
+		  const char **full_month)
 {
 	int i, wd, spaces = julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
 	char *cur_dh = day_headings;
@@ -475,8 +473,7 @@ void headers_init(int julian)
 
 		if (i)
 			strcat(cur_dh++, " ");
-		space_left =
-		    sizeof(day_headings) - (cur_dh - day_headings);
+		space_left = (J_WEEK_LEN * 6 + 1) - (cur_dh - day_headings);
 		if (space_left <= spaces)
 			break;
 		cur_dh +=
@@ -488,13 +485,15 @@ void headers_init(int julian)
 		full_month[i] = nl_langinfo(MON_1 + i);
 }
 
-void
-do_monthly(int day, int month, int year, struct fmt_st *out) {
+void do_monthly(const int julian, const int weekstart, const char *day_headings,
+		const char **full_month, int day, int month, int year,
+		struct fmt_st *out)
+{
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
 	int width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
 
-	day_array(day, month, year, days);
+	day_array(julian, weekstart, day, month, year, days);
 
 	/*
 	 * %s is the month name, %d the year number.
@@ -513,7 +512,7 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 			int xd = days[row * DAYS_IN_WEEK + col];
 			if (xd != SPACE && (xd & TODAY_FLAG))
 				has_hl = 1;
-			p = ascii_day(p, xd);
+			p = ascii_day(julian, p, xd);
 		}
 		*p = '\0';
 		snprintf(out->s[row+2], FMT_ST_CHARS, "%s", lineout);
@@ -522,20 +521,22 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 	}
 }
 
-void
-monthly(int day, int month, int year) {
+void monthly(const int julian, const int weekstart, const char *day_headings,
+	     const char **full_month, int day, int month, int year)
+{
 	int i;
 	struct fmt_st out;
 
-	do_monthly(day, month, year, &out);
+	do_monthly(julian, weekstart, day_headings, full_month, day, month, year, &out);
 	for (i = 0; i < FMT_ST_LINES; i++) {
 		my_putstring(out.s[i]);
 		my_putstring("\n");
 	}
 }
 
-void
-monthly3(int day, int month, int year) {
+void monthly3(const int julian, const int weekstart, const char *day_headings,
+	      const char **full_month, int day, int month, int year)
+{
 	char lineout[FMT_ST_CHARS];
 	int i;
 	int width;
@@ -560,9 +561,9 @@ monthly3(int day, int month, int year) {
 		next_year  = year;
 	}
 
-	do_monthly(day, prev_month, prev_year, &out_prev);
-	do_monthly(day, month,      year,      &out_curm);
-	do_monthly(day, next_month, next_year, &out_next);
+	do_monthly(julian, weekstart, day_headings, full_month, day, prev_month, prev_year, &out_prev);
+	do_monthly(julian, weekstart, day_headings, full_month, day, month,      year,      &out_curm);
+	do_monthly(julian, weekstart, day_headings, full_month, day, next_month, next_year, &out_next);
 
 	width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
 	for (i = 0; i < 2; i++) {
@@ -589,8 +590,9 @@ monthly3(int day, int month, int year) {
 	}
 }
 
-void
-yearly(int day, int year, int julian) {
+void yearly(int day, int year, const int julian, const int weekstart,
+	    const char *day_headings, const char **full_month)
+{
 	int col, *dp, i, month, row, which_cal;
 	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
@@ -613,7 +615,7 @@ yearly(int day, int year, int julian) {
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(day, i + 1, year, days[i]);
+		day_array(julian, weekstart,  day, i + 1, year, days[i]);
 	for (month = 0; month < MONTHS_IN_YEAR; month += maxrow) {
 		center(full_month[month], week_len - 1, sep_len + 1);
 		if (julian) {
@@ -635,7 +637,7 @@ yearly(int day, int year, int julian) {
 			for (which_cal = 0; which_cal < maxrow; which_cal++) {
 				dp = &days[month + which_cal][row * DAYS_IN_WEEK];
 				for (col = 0; col < DAYS_IN_WEEK; col++)
-					p = ascii_day(p, *dp++);
+					p = ascii_day(julian, p, *dp++);
 				p += sprintf(p, "  ");
 			}
 			*p = '\0';
@@ -653,8 +655,9 @@ yearly(int day, int year, int julian) {
  *	out end to end.  You would have 42 numbers or spaces.  This routine
  *	builds that array for any month from Jan. 1 through Dec. 9999.
  */
-void
-day_array(int day, int month, int year, int *days) {
+void day_array(const int julian, const int weekstart, int day, int month,
+	       int year, int *days)
+{
 	int julday, daynum, dw, dm;
 	int *sep1752;
 
@@ -684,8 +687,8 @@ day_array(int day, int month, int year, int *days) {
  * day_in_year --
  *	return the 1 based day number within the year
  */
-int
-day_in_year(int day, int month, int year) {
+int day_in_year(int day, int month, int year)
+{
 	int i, leap;
 
 	leap = leap_year(year);
@@ -701,8 +704,8 @@ day_in_year(int day, int month, int year) {
  *	3 Sep. 1752 through 13 Sep. 1752.  Returns Thursday for all
  *	missing days.
  */
-int
-day_in_week(int day, int month, int year) {
+int day_in_week(int day, int month, int year)
+{
 	long temp;
 
 	temp =
@@ -716,8 +719,8 @@ day_in_week(int day, int month, int year) {
 	return(REFORMATION_WEEKDAY);
 }
 
-char *
-ascii_day(char *p, int day) {
+char *ascii_day(const int julian, char *p, int day)
+{
 	int display, val;
 	int highlight = 0;
 	static char *aday[] = {
@@ -769,15 +772,13 @@ ascii_day(char *p, int day) {
  * In addition if the string is too large for the width it's truncated.
  * The number of trailing spaces may be 1 less than the number of leading spaces.
  */
-int
-center_str(const char* src, char* dest, size_t dest_size, size_t width)
+int center_str(const char *src, char *dest, size_t dest_size, size_t width)
 {
 	return mbsalign(src, dest, dest_size, &width,
 			MBS_ALIGN_CENTER, MBA_UNIBYTE_FALLBACK);
 }
 
-void
-center(const char *str, size_t len, int separate)
+void center(const char *str, size_t len, int separate)
 {
 	char lineout[FMT_ST_CHARS];
 
-- 
1.8.2.2

