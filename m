Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:36072 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760667Ab3EBSwK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:10 -0400
Received: by mail-we0-f170.google.com with SMTP id z53so757757wey.29
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/16] cal: de-duplicate julian specific functions
Date: Thu,  2 May 2013 19:51:32 +0100
Message-Id: <1367520701-14962-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The cost is a little bit more complex functions, while the benefit is
couple data flows fewer to mind about.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 119 +++++++++++++++++++++----------------------------------
 1 file changed, 45 insertions(+), 74 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 03f6265..665dbcd 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -181,10 +181,12 @@ enum {
 #define	DAY_LEN			3		/* 3 spaces per day */
 #define	WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
 #define	HEAD_SEP		2
+#define MONTH_COLS		3		/* month columns in year view */
 
 #define	J_DAY_LEN		4		/* 4 spaces per day */
 #define	J_WEEK_LEN		(DAYS_IN_WEEK * J_DAY_LEN)
 #define	J_HEAD_SEP		2
+#define J_MONTH_COLS		2
 
 #define TODAY_FLAG		0x400		/* flag day for highlighting */
 
@@ -221,9 +223,7 @@ static int days_in_month[2][13] = {
 
 
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
-char day_headings[WEEK_LEN*6+1];
-/* weekstart = 1  =>   " M Tu  W Th  F  S  S " */
-char j_day_headings[J_WEEK_LEN*6+1];
+char day_headings[J_WEEK_LEN * 6 + 1];
 /* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
 const char *full_month[MONTHS_IN_YEAR];
 
@@ -241,14 +241,13 @@ void center(const char *, size_t, int);
 void day_array(int, int, int, int *);
 int day_in_week(int, int, int);
 int day_in_year(int, int, int);
-void yearly(int, int);
-void j_yearly(int, int);
+void yearly(int, int, int);
 void do_monthly(int, int, int, struct fmt_st*);
 void monthly(int, int, int);
 void monthly3(int, int, int);
 void trim_trailing_spaces(char *);
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
-void headers_init(void);
+void headers_init(int);
 
 int
 main(int argc, char **argv) {
@@ -390,15 +389,13 @@ main(int argc, char **argv) {
 	default:
 		usage(stderr);
 	}
-	headers_init();
+	headers_init(julian);
 
 	if (!isatty(STDOUT_FILENO))
 		day = 0; /* don't highlight */
 
-	if (yflag && julian)
-		j_yearly(day, year);
-	else if (yflag)
-		yearly(day, year);
+	if (yflag)
+		yearly(day, year, julian);
 	else if (num_months == 1)
 		monthly(day, month, year);
 	else if (num_months == 3)
@@ -432,10 +429,10 @@ static int leap_years_since_year_1(int year)
 		centuries_since_1700(year, 4));
 }
 
-void headers_init(void)
+void headers_init(int julian)
 {
-	int i, wd;
-	char *cur_dh = day_headings, *cur_j_dh = j_day_headings;
+	int i, wd, spaces = julian ? J_DAY_LEN - 1 : DAY_LEN - 1;
+	char *cur_dh = day_headings;
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		ssize_t space_left;
@@ -445,21 +442,11 @@ void headers_init(void)
 			strcat(cur_dh++, " ");
 		space_left =
 		    sizeof(day_headings) - (cur_dh - day_headings);
-		if (space_left <= 2)
+		if (space_left <= spaces)
 			break;
 		cur_dh +=
 		    center_str(nl_langinfo(ABDAY_1 + wd), cur_dh,
-			       space_left, 2);
-
-		if (i)
-			strcat(cur_j_dh++, " ");
-		space_left =
-		    sizeof(j_day_headings) - (cur_j_dh - j_day_headings);
-		if (space_left <= 3)
-			break;
-		cur_j_dh +=
-		    center_str(nl_langinfo(ABDAY_1 + wd), cur_j_dh,
-			       space_left, 3);
+			       space_left, spaces);
 	}
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
@@ -484,8 +471,7 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 			full_month[month - 1], year);
 	center_str(lineout, out->s[0], ARRAY_SIZE(out->s[0]), width);
 
-	snprintf(out->s[1], FMT_ST_CHARS, "%s",
-		julian ? j_day_headings : day_headings);
+	snprintf(out->s[1], FMT_ST_CHARS, "%s", day_headings);
 	for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 		int has_hl = 0;
 		for (col = 0, p = lineout; col < DAYS_IN_WEEK; col++) {
@@ -570,64 +556,49 @@ monthly3(int day, int month, int year) {
 }
 
 void
-j_yearly(int day, int year) {
-	int col, *dp, i, month, row, which_cal;
-	int days[MONTHS_IN_YEAR][MAXDAYS];
-	char *p, lineout[80];
-
-	snprintf(lineout, sizeof(lineout), "%d", year);
-	center(lineout, J_WEEK_LEN*2 + J_HEAD_SEP - 1, 0);
-	my_putstring("\n\n");
-
-	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(day, i + 1, year, days[i]);
-	for (month = 0; month < MONTHS_IN_YEAR; month += 2) {
-		center(full_month[month], J_WEEK_LEN-1, J_HEAD_SEP+1);
-		center(full_month[month + 1], J_WEEK_LEN-1, 0);
-		snprintf(lineout, sizeof(lineout),
-			    "\n%s%*s %s\n", j_day_headings, J_HEAD_SEP, "",
-			    j_day_headings);
-		my_putstring(lineout);
-		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
-			p = lineout;
-			for (which_cal = 0; which_cal < 2; which_cal++) {
-				dp = &days[month + which_cal][row * DAYS_IN_WEEK];
-				for (col = 0; col < DAYS_IN_WEEK; col++)
-					p = ascii_day(p, *dp++);
-				p += sprintf(p, "  ");
-			}
-			*p = '\0';
-			trim_trailing_spaces(lineout);
-			my_putstring(lineout);
-			my_putstring("\n");
-		}
-	}
-	my_putstring("\n");
-}
-
-void
-yearly(int day, int year) {
+yearly(int day, int year, int julian) {
 	int col, *dp, i, month, row, which_cal;
+	int maxrow, sep_len, week_len;
 	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p, lineout[100];
 
+	if (julian) {
+		maxrow = J_MONTH_COLS;
+		sep_len = J_HEAD_SEP;
+		week_len = J_WEEK_LEN;
+	} else {
+		maxrow = MONTH_COLS;
+		sep_len = HEAD_SEP;
+		week_len = WEEK_LEN;
+	}
 	snprintf(lineout, sizeof(lineout), "%d", year);
-	center(lineout, WEEK_LEN*3 + HEAD_SEP*2 - 1, 0);
+	/* 2013-04-28: The -1 near sep_len makes year header to be
+	 * aligned exactly how it has been aligned for long time, but it
+	 * is unexplainable.  */
+	center(lineout, (week_len + sep_len) * maxrow - sep_len - 1, 0);
 	my_putstring("\n\n");
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i]);
-	for (month = 0; month < MONTHS_IN_YEAR; month += 3) {
-		center(full_month[month], WEEK_LEN-1, HEAD_SEP+1);
-		center(full_month[month + 1], WEEK_LEN-1, HEAD_SEP+1);
-		center(full_month[month + 2], WEEK_LEN-1, 0);
-		snprintf(lineout, sizeof(lineout),
-			"\n%s%*s %s%*s %s\n", day_headings, HEAD_SEP,
-			"", day_headings, HEAD_SEP, "", day_headings);
+	for (month = 0; month < MONTHS_IN_YEAR; month += maxrow) {
+		center(full_month[month], week_len - 1, sep_len + 1);
+		if (julian) {
+			center(full_month[month + 1], week_len - 1, 0);
+		} else {
+			center(full_month[month + 1], week_len - 1, sep_len + 1);
+			center(full_month[month + 2], week_len - 1, 0);
+		}
+		if (julian)
+			snprintf(lineout, sizeof(lineout),
+				 "\n%s%*s %s\n", day_headings, sep_len, "", day_headings);
+		else
+			snprintf(lineout, sizeof(lineout),
+				 "\n%s%*s %s%*s %s\n", day_headings, sep_len,
+				 "", day_headings, sep_len, "", day_headings);
 		my_putstring(lineout);
 		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 			p = lineout;
-			for (which_cal = 0; which_cal < 3; which_cal++) {
+			for (which_cal = 0; which_cal < maxrow; which_cal++) {
 				dp = &days[month + which_cal][row * DAYS_IN_WEEK];
 				for (col = 0; col < DAYS_IN_WEEK; col++)
 					p = ascii_day(p, *dp++);
-- 
1.8.2.2

