Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:45093 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3D1RLU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:20 -0400
Received: by mail-wg0-f54.google.com with SMTP id y10so3021479wgg.33
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/11] cal: clean up use of constants
Date: Sun, 28 Apr 2013 18:10:59 +0100
Message-Id: <1367169067-23705-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit also adds few new symbolic names, such as DAYS_IN_WEEK.  While
these definitions may look a little too trivial to have I am sure they
ease understanding what is going on in code where they are used.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 142 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 60 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index eacf3dd..f0d97af 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -151,15 +151,51 @@ char		*Hrow;		/* pointer to highlighted row in month */
 #error NUM_MONTHS must be 1 or 3
 #endif
 
-#define	THURSDAY		4		/* for reformation */
-#define	SATURDAY		6		/* 1 Jan 1 was a Saturday */
+enum {
+	SUNDAY = 0,
+	MONDAY,
+	TUESDAY,
+	WEDNESDAY,
+	THURSDAY,
+	FRIDAY,
+	SATURDAY,
+	DAYS_IN_WEEK
+};
+
+#define	FIRST_WEEKDAY		SATURDAY	/* Jan 1st, 1 was a Saturday */
+#define	REFORMATION_WEEKDAY	TUESDAY		/* after reformation it was Thursday */
 
+#define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
+#define REFORMATION_MONTH	9		/* September */
 #define	FIRST_MISSING_DAY	639799		/* 3 Sep 1752 */
 #define	NUMBER_MISSING_DAYS	11		/* 11 day correction */
 
+#define DAYS_IN_YEAR		365		/* the common case, leap years are calculated */
+#define MONTHS_IN_YEAR		12
+#define DAYS_IN_MONTH		31
 #define	MAXDAYS			42		/* slots in a month array */
 #define	SPACE			-1		/* used in day array */
 
+#define SMALLEST_YEAR		1
+#define GREATEST_YEAR		9999
+
+#define	DAY_LEN			3		/* 3 spaces per day */
+#define	WEEK_LEN		(DAYS_IN_WEEK * DAY_LEN)
+#define	HEAD_SEP		2
+
+#define	J_DAY_LEN		4		/* 4 spaces per day */
+#define	J_WEEK_LEN		(DAYS_IN_WEEK * J_DAY_LEN)
+#define	J_HEAD_SEP		2
+
+#define TODAY_FLAG		0x400		/* flag day for highlighting */
+
+#define FMT_ST_LINES 8
+#define FMT_ST_CHARS 300	/* 90 suffices in most locales */
+struct fmt_st
+{
+  char s[FMT_ST_LINES][FMT_ST_CHARS];
+};
+
 static int days_in_month[2][13] = {
 	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
 	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
@@ -195,33 +231,19 @@ int sep1752[MAXDAYS+6] = {
 	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE
 };
 
-#define	DAY_LEN		3		/* 3 spaces per day */
-#define	J_DAY_LEN	4		/* 4 spaces per day */
-#define	WEEK_LEN	21		/* 7 days * 3 characters */
-#define	J_WEEK_LEN	28		/* 7 days * 4 characters */
-#define	HEAD_SEP	2		/* spaces between day headings */
-#define	J_HEAD_SEP	2
 
 /* utf-8 can have up to 6 bytes per char; and an extra byte for ending \0 */
 char day_headings[WEEK_LEN*6+1];
 /* weekstart = 1  =>   " M Tu  W Th  F  S  S " */
 char j_day_headings[J_WEEK_LEN*6+1];
 /* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
-const char *full_month[12];
+const char *full_month[MONTHS_IN_YEAR];
 
 /* 0 => sunday, 1 => monday */
-int weekstart=0;
+int weekstart = SUNDAY;
 int julian;
 
-#define TODAY_FLAG		0x400		/* flag day for highlighting */
-
-#define FMT_ST_LINES 8
-#define FMT_ST_CHARS 300	/* 90 suffices in most locales */
-struct fmt_st
-{
-  char s[FMT_ST_LINES][FMT_ST_CHARS];
-};
-
+/* function prototypes */
 int leap_year(int year);
 int centuries_since_1700(int year, int centuries);
 int leap_years_since_year_1(int year);
@@ -244,7 +266,7 @@ int
 main(int argc, char **argv) {
 	struct tm *local_time;
 	time_t now;
-	int ch, day, month, year, yflag;
+	int ch, day = 0, month = 0, year = 0, yflag = 0;
 	int num_months = NUM_MONTHS;
 
 	static const struct option longopts[] = {
@@ -267,7 +289,7 @@ main(int argc, char **argv) {
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
 	if ((term = getenv("TERM"))) {
 		int ret;
-		my_setupterm(term, 1, &ret);
+		my_setupterm(term, STDOUT_FILENO, &ret);
 		if (ret > 0) {
 			Senter = my_tgetstr("so","smso");
 			Sexit = my_tgetstr("se","rmso");
@@ -307,11 +329,10 @@ main(int argc, char **argv) {
 
 		wfd = val.word;
 		wfd = day_in_week(wfd % 100, (wfd / 100) % 100, wfd / (100 * 100));
-		weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % 7;
+		weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
 
-	yflag = 0;
 	while ((ch = getopt_long(argc, argv, "13mjsyVh", longopts, NULL)) != -1)
 		switch(ch) {
 		case '1':
@@ -321,10 +342,10 @@ main(int argc, char **argv) {
 			num_months = 3;
 			break;
 		case 's':
-			weekstart = 0;		/* default */
+			weekstart = SUNDAY;	/* default */
 			break;
 		case 'm':
-			weekstart = 1;
+			weekstart = MONDAY;
 			break;
 		case 'j':
 			julian = 1;
@@ -347,21 +368,20 @@ main(int argc, char **argv) {
 	time(&now);
 	local_time = localtime(&now);
 
-	day = month = year = 0;
 	switch(argc) {
 	case 3:
 		day = strtos32_or_err(*argv++, _("illegal day value"));
-                if (day < 1 || 31 < day)
-			errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), 31);
+		if (day < 1 || DAYS_IN_MONTH < day)
+			errx(EXIT_FAILURE, _("illegal day value: use 1-%d"), DAYS_IN_MONTH);
 		/* FALLTHROUGH */
 	case 2:
 		month = strtos32_or_err(*argv++, _("illegal month value: use 1-12"));
-		if (month < 1 || 12 < month)
+		if (month < 1 || MONTHS_IN_YEAR < month)
 			errx(EXIT_FAILURE, _("illegal month value: use 1-12"));
 		/* FALLTHROUGH */
 	case 1:
 		year = strtos32_or_err(*argv++, _("illegal year value: use 1-9999"));
-		if (year < 1 || 9999 < year)
+		if (year < SMALLEST_YEAR || GREATEST_YEAR < year)
 			errx(EXIT_FAILURE, _("illegal year value: use 1-9999"));
 		if (day) {
 			int dm = days_in_month[leap_year(year)][month];
@@ -384,7 +404,7 @@ main(int argc, char **argv) {
 	}
 	headers_init();
 
-	if (!isatty(1))
+	if (!isatty(STDOUT_FILENO))
 		day = 0; /* don't highlight */
 
 	if (yflag && julian)
@@ -402,7 +422,7 @@ main(int argc, char **argv) {
 /* leap year -- account for gregorian reformation in 1752 */
 int leap_year(int year)
 {
-	if (year <= 1752)
+	if (year <= REFORMATION_YEAR)
 		return !(year % 4);
 	else
 		return !(year % 4 && (year % 100 || year % 400));
@@ -411,10 +431,10 @@ int leap_year(int year)
 /* number of centuries since 1700 */
 int centuries_since_1700(int year, int n)
 {
-	if (year < 1700)
+	if (year < REFORMATION_YEAR)
 		return 0;
 	else
-		return ((year / (100 * n)) - (17 / n));
+		return ((year / (100 * n)) - ((REFORMATION_YEAR / 100) / n));
 }
 
 /* number of leap years between year 1 and this year, not inclusive */
@@ -432,9 +452,9 @@ void headers_init(void)
 	strcpy(day_headings, "");
 	strcpy(j_day_headings, "");
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		ssize_t space_left;
-		wd = (i + weekstart) % 7;
+		wd = (i + weekstart) % DAYS_IN_WEEK;
 
 		if (i)
 			strcat(cur_dh++, " ");
@@ -457,7 +477,7 @@ void headers_init(void)
 			       space_left, 3);
 	}
 
-	for (i = 0; i < 12; i++)
+	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		full_month[i] = nl_langinfo(MON_1 + i);
 }
 
@@ -481,10 +501,10 @@ do_monthly(int day, int month, int year, struct fmt_st *out) {
 
 	snprintf(out->s[1], FMT_ST_CHARS, "%s",
 		julian ? j_day_headings : day_headings);
-	for (row = 0; row < 6; row++) {
+	for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 		int has_hl = 0;
-		for (col = 0, p = lineout; col < 7; col++) {
-			int xd = days[row * 7 + col];
+		for (col = 0, p = lineout; col < DAYS_IN_WEEK; col++) {
+			int xd = days[row * DAYS_IN_WEEK + col];
 			if (xd != SPACE && (xd & TODAY_FLAG))
 				has_hl = 1;
 			p = ascii_day(p, xd);
@@ -521,13 +541,13 @@ monthly3(int day, int month, int year) {
 	int next_month, next_year;
 
 	if (month == 1) {
-		prev_month = 12;
+		prev_month = MONTHS_IN_YEAR;
 		prev_year  = year - 1;
 	} else {
 		prev_month = month - 1;
 		prev_year  = year;
 	}
-	if (month == 12) {
+	if (month == MONTHS_IN_YEAR) {
 		next_month = 1;
 		next_year  = year + 1;
 	} else {
@@ -567,29 +587,29 @@ monthly3(int day, int month, int year) {
 void
 j_yearly(int day, int year) {
 	int col, *dp, i, month, row, which_cal;
-	int days[12][MAXDAYS];
+	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p, lineout[80];
 
 	snprintf(lineout, sizeof(lineout), "%d", year);
 	center(lineout, J_WEEK_LEN*2 + J_HEAD_SEP - 1, 0);
 	my_putstring("\n\n");
 
-	for (i = 0; i < 12; i++)
+	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i]);
 	memset(lineout, ' ', sizeof(lineout) - 1);
 	lineout[sizeof(lineout) - 1] = '\0';
-	for (month = 0; month < 12; month += 2) {
+	for (month = 0; month < MONTHS_IN_YEAR; month += 2) {
 		center(full_month[month], J_WEEK_LEN-1, J_HEAD_SEP+1);
 		center(full_month[month + 1], J_WEEK_LEN-1, 0);
 		snprintf(lineout, sizeof(lineout),
 			    "\n%s%*s %s\n", j_day_headings, J_HEAD_SEP, "",
 			    j_day_headings);
 		my_putstring(lineout);
-		for (row = 0; row < 6; row++) {
+		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 			p = lineout;
 			for (which_cal = 0; which_cal < 2; which_cal++) {
-				dp = &days[month + which_cal][row * 7];
-				for (col = 0; col < 7; col++)
+				dp = &days[month + which_cal][row * DAYS_IN_WEEK];
+				for (col = 0; col < DAYS_IN_WEEK; col++)
 					p = ascii_day(p, *dp++);
 				p += sprintf(p, "  ");
 			}
@@ -605,18 +625,18 @@ j_yearly(int day, int year) {
 void
 yearly(int day, int year) {
 	int col, *dp, i, month, row, which_cal;
-	int days[12][MAXDAYS];
+	int days[MONTHS_IN_YEAR][MAXDAYS];
 	char *p, lineout[100];
 
 	snprintf(lineout, sizeof(lineout), "%d", year);
 	center(lineout, WEEK_LEN*3 + HEAD_SEP*2 - 1, 0);
 	my_putstring("\n\n");
 
-	for (i = 0; i < 12; i++)
+	for (i = 0; i < MONTHS_IN_YEAR; i++)
 		day_array(day, i + 1, year, days[i]);
 	memset(lineout, ' ', sizeof(lineout) - 1);
 	lineout[sizeof(lineout) - 1] = '\0';
-	for (month = 0; month < 12; month += 3) {
+	for (month = 0; month < MONTHS_IN_YEAR; month += 3) {
 		center(full_month[month], WEEK_LEN-1, HEAD_SEP+1);
 		center(full_month[month + 1], WEEK_LEN-1, HEAD_SEP+1);
 		center(full_month[month + 2], WEEK_LEN-1, 0);
@@ -624,11 +644,11 @@ yearly(int day, int year) {
 			"\n%s%*s %s%*s %s\n", day_headings, HEAD_SEP,
 			"", day_headings, HEAD_SEP, "", day_headings);
 		my_putstring(lineout);
-		for (row = 0; row < 6; row++) {
+		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
 			p = lineout;
 			for (which_cal = 0; which_cal < 3; which_cal++) {
-				dp = &days[month + which_cal][row * 7];
-				for (col = 0; col < 7; col++)
+				dp = &days[month + which_cal][row * DAYS_IN_WEEK];
+				for (col = 0; col < DAYS_IN_WEEK; col++)
 					p = ascii_day(p, *dp++);
 				p += sprintf(p, "  ");
 			}
@@ -653,7 +673,7 @@ day_array(int day, int month, int year, int *days) {
 	int julday, daynum, dw, dm;
 	int *d_sep1752;
 
-	if (month == 9 && year == 1752) {
+	if (month == REFORMATION_MONTH && year == REFORMATION_YEAR) {
 		int sep1752_ofs = (weekstart + SEP1752_OFS) % 7;
 		d_sep1752 = julian ? j_sep1752 : sep1752;
 		memcpy(days, d_sep1752 + sep1752_ofs, MAXDAYS * sizeof(int));
@@ -664,7 +684,7 @@ day_array(int day, int month, int year, int *days) {
 	}
 	memcpy(days, empty, MAXDAYS * sizeof(int));
 	dm = days_in_month[leap_year(year)][month];
-	dw = (day_in_week(1, month, year) - weekstart + 7) % 7;
+	dw = (day_in_week(1, month, year) - weekstart + DAYS_IN_WEEK) % DAYS_IN_WEEK;
 	julday = day_in_year(1, month, year);
 	daynum = julian ? julday : 1;
 	while (dm--) {
@@ -700,13 +720,15 @@ int
 day_in_week(int day, int month, int year) {
 	long temp;
 
-	temp = (long)(year - 1) * 365 + leap_years_since_year_1(year - 1)
+	temp =
+	    (long)(year - SMALLEST_YEAR) * DAYS_IN_YEAR +
+	    leap_years_since_year_1(year - SMALLEST_YEAR)
 	    + day_in_year(day, month, year);
 	if (temp < FIRST_MISSING_DAY)
-		return ((temp - 1 + SATURDAY) % 7);
+		return ((temp - 1 + FIRST_WEEKDAY) % DAYS_IN_WEEK);
 	if (temp >= (FIRST_MISSING_DAY + NUMBER_MISSING_DAYS))
-		return (((temp - 1 + SATURDAY) - NUMBER_MISSING_DAYS) % 7);
-	return (THURSDAY);
+		return (((temp - 1 + FIRST_WEEKDAY) - NUMBER_MISSING_DAYS) % DAYS_IN_WEEK);
+	return (REFORMATION_WEEKDAY);
 }
 
 char *
-- 
1.8.2.2

