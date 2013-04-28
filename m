Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:56352 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab3D1UUj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 16:20:39 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so3253982wgh.24
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 13:20:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/12] cal: mark all functions static
Date: Sun, 28 Apr 2013 21:20:29 +0100
Message-Id: <1367180429-26340-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Proposed-by: Dave Reisner <dreisner@archlinux.org>
Reference: http://marc.info/?l=util-linux-ng&m=136717012419551&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 71 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 663f928..c5f14cb 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -229,22 +229,22 @@ static int days_in_month[2][13] = {
 
 
 /* function prototypes */
-int leap_year(int year);
-int centuries_since_1700(int year, int centuries);
-int leap_years_since_year_1(int year);
-char * ascii_day(const int, char *, int);
-int center_str(const char* src, char* dest, size_t dest_size, size_t width);
-void center(const char *, size_t, int);
-void day_array(const int, const int, int, int, int, int *);
-int day_in_week(int, int, int);
-int day_in_year(int, int, int);
-void yearly(int, int, const int, const int, const char *, const char **);
-void do_monthly(const int, const int, const char *, const char **, int, int, int, struct fmt_st*);
-void monthly(const int, const int, const char *, const char **, int, int, int);
-void monthly3(const int, const int, const char *, const char **, int, int, int);
-void trim_trailing_spaces(char *);
+static int leap_year(int year);
+static int centuries_since_1700(int year, int centuries);
+static int leap_years_since_year_1(int year);
+static char * ascii_day(const int, char *, int);
+static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
+static void center(const char *, size_t, int);
+static void day_array(const int, const int, int, int, int, int *);
+static int day_in_week(int, int, int);
+static int day_in_year(int, int, int);
+static void yearly(int, int, const int, const int, const char *, const char **);
+static void do_monthly(const int, const int, const char *, const char **, int, int, int, struct fmt_st*);
+static void monthly(const int, const int, const char *, const char **, int, int, int);
+static void monthly3(const int, const int, const char *, const char **, int, int, int);
+static void trim_trailing_spaces(char *);
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
-void headers_init(const int, const int, char *, const char **);
+static void headers_init(const int, const int, char *, const char **);
 
 int main(int argc, char **argv)
 {
@@ -434,8 +434,8 @@ static int leap_years_since_year_1(int year)
 		centuries_since_1700(year, 4));
 }
 
-void headers_init(const int julian, const int weekstart, char *day_headings,
-		  const char **full_month)
+static void headers_init(const int julian, const int weekstart,
+			 char *day_headings, const char **full_month)
 {
 	int i, wd, spaces = julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
 	char *cur_dh = day_headings;
@@ -458,9 +458,9 @@ void headers_init(const int julian, const int weekstart, char *day_headings,
 		full_month[i] = nl_langinfo(MON_1 + i);
 }
 
-void do_monthly(const int julian, const int weekstart, const char *day_headings,
-		const char **full_month, int day, int month, int year,
-		struct fmt_st *out)
+static void do_monthly(const int julian, const int weekstart,
+		       const char *day_headings, const char **full_month,
+		       int day, int month, int year, struct fmt_st *out)
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
@@ -495,8 +495,9 @@ void do_monthly(const int julian, const int weekstart, const char *day_headings,
 	}
 }
 
-void monthly(const int julian, const int weekstart, const char *day_headings,
-	     const char **full_month, int day, int month, int year)
+static void monthly(const int julian, const int weekstart,
+		    const char *day_headings, const char **full_month, int day,
+		    int month, int year)
 {
 	int i;
 	struct fmt_st out;
@@ -508,8 +509,9 @@ void monthly(const int julian, const int weekstart, const char *day_headings,
 	}
 }
 
-void monthly3(const int julian, const int weekstart, const char *day_headings,
-	      const char **full_month, int day, int month, int year)
+static void monthly3(const int julian, const int weekstart,
+		     const char *day_headings, const char **full_month, int day,
+		     int month, int year)
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
@@ -567,8 +569,8 @@ void monthly3(const int julian, const int weekstart, const char *day_headings,
 	}
 }
 
-void yearly(int day, int year, const int julian, const int weekstart,
-	    const char *day_headings, const char **full_month)
+static void yearly(int day, int year, const int julian, const int weekstart,
+		   const char *day_headings, const char **full_month)
 {
 	int col, *dp, i, month, row, which_cal;
 	int maxrow, sep_len, week_len;
@@ -633,8 +635,8 @@ void yearly(int day, int year, const int julian, const int weekstart,
  *	out end to end.  You would have 42 numbers or spaces.  This routine
  *	builds that array for any month from Jan. 1 through Dec. 9999.
  */
-void day_array(const int julian, const int weekstart, int day, int month,
-	       int year, int *days)
+static void day_array(const int julian, const int weekstart, int day, int month,
+		      int year, int *days)
 {
 	int julday, daynum, dw, dm;
 	int *sep1752;
@@ -665,7 +667,7 @@ void day_array(const int julian, const int weekstart, int day, int month,
  * day_in_year --
  *	return the 1 based day number within the year
  */
-int day_in_year(int day, int month, int year)
+static int day_in_year(int day, int month, int year)
 {
 	int i, leap;
 
@@ -682,7 +684,7 @@ int day_in_year(int day, int month, int year)
  *	3 Sep. 1752 through 13 Sep. 1752.  Returns Thursday for all
  *	missing days.
  */
-int day_in_week(int day, int month, int year)
+static int day_in_week(int day, int month, int year)
 {
 	long temp;
 
@@ -697,7 +699,7 @@ int day_in_week(int day, int month, int year)
 	return (REFORMATION_WEEKDAY);
 }
 
-char *ascii_day(const int julian, char *p, int day)
+static char *ascii_day(const int julian, char *p, int day)
 {
 	int display, val;
 	int highlight = 0;
@@ -745,7 +747,7 @@ char *ascii_day(const int julian, char *p, int day)
 	return p;
 }
 
-void trim_trailing_spaces(char *s)
+static void trim_trailing_spaces(char *s)
 {
 	char *p;
 
@@ -763,13 +765,14 @@ void trim_trailing_spaces(char *s)
  * In addition if the string is too large for the width it's truncated.
  * The number of trailing spaces may be 1 less than the number of leading spaces.
  */
-int center_str(const char *src, char *dest, size_t dest_size, size_t width)
+static int center_str(const char *src, char *dest, size_t dest_size,
+		      size_t width)
 {
 	return mbsalign(src, dest, dest_size, &width,
 			MBS_ALIGN_CENTER, MBA_UNIBYTE_FALLBACK);
 }
 
-void center(const char *str, size_t len, int separate)
+static void center(const char *str, size_t len, int separate)
 {
 	char lineout[FMT_ST_CHARS];
 
-- 
1.8.2.2

