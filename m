Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:58212 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab3KJSZU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:20 -0500
Received: by mail-wi0-f170.google.com with SMTP id m19so1537039wiv.1
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:19 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/13] cal: use month contents structure for --year printing
Date: Sun, 10 Nov 2013 18:23:40 +0000
Message-Id: <1384107820-498-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 229 +++++++++++--------------------------------------------
 1 file changed, 45 insertions(+), 184 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index a3c5c40..87e947a 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -244,6 +244,7 @@ struct cal_control {
 	int weektype;			/* WEEK_TYPE_{NONE,ISO,US} */
 	size_t day_width;		/* day width in characters in printout */
 	size_t week_width;		/* 7 * day_width + possible week num */
+	int gutter_width;		/* spaces in between horizontal month outputs */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
 			yflag:1,	/* print whole year */
@@ -267,16 +268,11 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
 static void monthly3(const struct cal_control *ctl);
-static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int row,
-			    const struct cal_control *ctl);
 static void yearly(const struct cal_control *ctl);
-static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl);
 static int day_in_year(int day, int month, long year);
 static int day_in_week(int day, int month, long year);
 static int week_number(int day, int month, long year, const struct cal_control *ctl);
 static int week_to_day(const struct cal_control *ctl);
-static char *ascii_day(char *p, int day, const struct cal_control *ctl);
-static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
 static void center(const char *str, size_t len, int separate);
 static void __attribute__((__noreturn__)) usage(FILE *out);
@@ -292,6 +288,7 @@ int main(int argc, char **argv)
 		.colormode = UL_COLORMODE_AUTO,
 		.weektype = WEEK_NUM_DISABLED,
 		.day_width = DAY_LEN,
+		.gutter_width = 2,
 		.req.day = 0,
 		.req.month = 0
 	};
@@ -446,8 +443,10 @@ int main(int argc, char **argv)
 		} else if ((long) (local_time->tm_year + 1900) == ctl.req.year) {
 			ctl.req.day = local_time->tm_yday + 1;
 		}
-		if (!ctl.req.month && !ctl.req.week)
+		if (!ctl.req.month && !ctl.req.week) {
+			ctl.req.month = local_time->tm_mon + 1;
 			ctl.yflag = 1;
+		}
 		break;
 	case 0:
 		ctl.req.day = local_time->tm_yday + 1;
@@ -497,6 +496,7 @@ int main(int argc, char **argv)
 			ctl.num_months = MONTH_COLS - 1;
 		else
 			ctl.num_months = MONTH_COLS;
+		ctl.gutter_width = 3;
 		yearly(&ctl);
 	} else if (ctl.num_months == 1)
 		monthly(&ctl);
@@ -620,20 +620,22 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 	char out[FMT_ST_CHARS];
 	struct cal_month *i;
 
-	if (ctl->header_hint) {
+	if (ctl->header_hint || ctl->yflag) {
 		for (i = month; i; i = i->next) {
 			sprintf(out, _("%s"), ctl->full_month[i->month - 1]);
-			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
-		fputs("\n", stdout);
-		for (i = month; i; i = i->next) {
-			sprintf(out, _("%ld"), i->year);
-			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+		if (!ctl->yflag) {
+			fputs("\n", stdout);
+			for (i = month; i; i = i->next) {
+				sprintf(out, _("%ld"), i->year);
+				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
+			}
 		}
 	} else {
 		for (i = month; i; i = i->next) {
 			sprintf(out, _("%s %ld"), ctl->full_month[i->month - 1], i->year);
-			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	}
 	puts("");
@@ -646,7 +648,7 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 		} else
 			fputs(day_headings, stdout);
 		if (i->next != NULL)
-			fputs("  ", stdout);
+			printf("%*s", ctl->gutter_width, "");
 	}
 	puts("");
 }
@@ -701,10 +703,10 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 					skip++;
 			}
 			if (i->next != NULL)
-				fputs("  ", stdout);
+				printf("%*s", ctl->gutter_width, "");
 		}
 		if (i == NULL)
-			fputs(" \n", stdout);
+			printf("%*s\n", ctl->gutter_width - (ctl->yflag ? 0 : 1), "");
 	}
 }
 
@@ -747,124 +749,39 @@ static void monthly3(const struct cal_control *ctl)
 	cal_output_months(&m1, ctl);
 }
 
-static char *append_weeknum(char *p, int *dp,
-			 int month, long year, int cal,
-			 int row, const struct cal_control *ctl)
-{
-	int col;
-
-	for (col = 0; col < DAYS_IN_WEEK; col++) {
-		int xd = dp[row * DAYS_IN_WEEK + col];
-
-		if (xd != SPACE) {
-			int weeknum = week_number(xd & ~TODAY_FLAG,
-					       month + cal + 1, year, ctl);
-			p = ascii_weeknum(p, weeknum, ctl);
-			break;
-		} else if (col+1 == DAYS_IN_WEEK)
-			p += sprintf(p,"   ");
-	}
-	return p;
-}
-
 static void yearly(const struct cal_control *ctl)
 {
-	int col, i, month, row, which_cal;
-	int days[MONTHS_IN_YEAR][MAXDAYS];
-	char *p;
-	/* three weeks + separators + \0 */
-	int weeknumlen = (ctl->weektype ? WNUM_LEN : 0);
-	char lineout[ weeknumlen + sizeof(day_headings) + 2 +
-		      weeknumlen + sizeof(day_headings) + 2 +
-		      weeknumlen + sizeof(day_headings) + 1 ];
-
-	snprintf(lineout, sizeof(lineout), "%ld", ctl->req.year);
-
-	/* 2013-04-28: The -1 near HEAD_SEP makes year header to be aligned
-	 * exactly how it has been aligned for long time, but it is
-	 * unexplainable.  */
-	center(lineout, (ctl->week_width + HEAD_SEP) * ctl->num_months - HEAD_SEP - 1, 0);
-	my_putstring("\n\n");
-
-	for (i = 0; i < MONTHS_IN_YEAR; i++)
-		day_array(ctl->req.day, i + 1, ctl->req.year, days[i], ctl);
-
-	for (month = 0; month < MONTHS_IN_YEAR; month += ctl->num_months) {
-		center(ctl->full_month[month], ctl->week_width - 1, HEAD_SEP + 1);
-		if (ctl->julian) {
-			center(ctl->full_month[month + 1], ctl->week_width - 1, 0);
-		} else {
-			center(ctl->full_month[month + 1], ctl->week_width - 1, HEAD_SEP + 1);
-			center(ctl->full_month[month + 2], ctl->week_width - 1, 0);
-		}
-		if (ctl->julian)
-			snprintf(lineout, sizeof(lineout),
-				 "\n%*s%s%*s %*s%s\n",
-				 weeknumlen,"", day_headings, HEAD_SEP, "",
-				 weeknumlen,"", day_headings);
-		else
-			snprintf(lineout, sizeof(lineout),
-				 "\n%*s%s%*s %*s%s%*s %*s%s\n",
-				 weeknumlen,"", day_headings, HEAD_SEP, "",
-				 weeknumlen,"", day_headings, HEAD_SEP, "",
-				 weeknumlen,"", day_headings);
+	struct cal_month m1, m2, m3, *i;
+	int month;
+	char out[FMT_ST_CHARS];
+	int year_width = 0;
 
-		my_putstring(lineout);
-		for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
-			p = lineout;
-			for (which_cal = 0; which_cal < ctl->num_months; which_cal++) {
-				int *dp = &days[month + which_cal][row * DAYS_IN_WEEK];
-
-				if (ctl->weektype)
-					p = append_weeknum(p, days[month + which_cal],
-							month, ctl->req.year, which_cal,
-							row, ctl);
-
-				for (col = 0; col < DAYS_IN_WEEK; col++)
-					p = ascii_day(p, *dp++, ctl);
-				p += sprintf(p, "  ");
-			}
-			*p = '\0';
-			my_putstring(lineout);
-			my_putstring("\n");
-		}
+	m1.next = &m2;
+	if (ctl->julian)
+		m2.next = NULL;
+	else {
+		m2.next = &m3;
+		m3.next = NULL;
 	}
-	my_putstring("\n");
-}
 
-/*
- * day_array --
- *	Fill in an array of 42 integers with a calendar.  Assume for a moment
- *	that you took the (maximum) 6 rows in a calendar and stretched them
- *	out end to end.  You would have 42 numbers or spaces.  This routine
- *	builds that array for any month from Jan. 1 through Dec. 9999.
- */
-static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl)
-{
-	int julday, daynum, dw, dm;
-	const int *sep1752;
-
-	memcpy(days, empty, MAXDAYS * sizeof(int));
-	if (year == REFORMATION_YEAR && month == REFORMATION_MONTH) {
-		sep1752 = ctl->julian ? j_sep1752 : d_sep1752;
-		memcpy(days, sep1752 + ctl->weekstart,
-		       ((MAXDAYS / 2) - ctl->weekstart) * sizeof(int));
-		for (dm = 0; dm < MAXDAYS / 2; dm++)
-			if (j_sep1752[dm] == day)
-				days[dm] |= TODAY_FLAG;
-		return;
-	}
-	dm = days_in_month[leap_year(year)][month];
-	dw = (day_in_week(1, month, year) - ctl->weekstart + DAYS_IN_WEEK) % DAYS_IN_WEEK;
-	julday = day_in_year(1, month, year);
-	daynum = ctl->julian ? julday : 1;
-
-	while (dm--) {
-		days[dw] = daynum++;
-		if (julday++ == day)
-			days[dw] |= TODAY_FLAG;
-		dw++;
+	/* year header */
+	for (i = &m1; i; i = i->next)
+		year_width += ctl->week_width + 1;
+	if (ctl->julian)
+		year_width--;
+	sprintf(out, "%ld", ctl->req.year);
+	center(out, year_width, 0);
+	fputs("\n\n", stdout);
+
+	for (month = 1; month < MONTHS_IN_YEAR; month += ctl->julian ? 2 : 3) {
+		set_consecutive_months(&m1, month, ctl->req.year);
+		for (i = &m1; i; i = i->next)
+			cal_fill_month(i, ctl);
+		cal_output_header(&m1, ctl);
+		cal_output_months(&m1, ctl);
 	}
+	/* Is empty line at the end year output really needed? */
+	puts("");
 }
 
 /*
@@ -988,62 +905,6 @@ static int week_to_day(const struct cal_control *ctl)
 	return yday;
 }
 
-static char *ascii_day(char *p, int day, const struct cal_control *ctl)
-{
-	int display, val;
-	int highlight = 0;
-	static char *aday[] = {
-		"",
-		" 1", " 2", " 3", " 4", " 5", " 6", " 7",
-		" 8", " 9", "10", "11", "12", "13", "14",
-		"15", "16", "17", "18", "19", "20", "21",
-		"22", "23", "24", "25", "26", "27", "28",
-		"29", "30", "31",
-	};
-
-	if (day == SPACE) {
-		memset(p, ' ', ctl->day_width);
-		return p + ctl->day_width;
-	}
-	if (day & TODAY_FLAG) {
-		day &= ~TODAY_FLAG;
-		p += sprintf(p, "%s", Senter);
-		highlight = 1;
-	}
-	if (ctl->julian) {
-		if ((val = day / 100)) {
-			day %= 100;
-			*p++ = val + '0';
-			display = 1;
-		} else {
-			*p++ = ' ';
-			display = 0;
-		}
-		val = day / 10;
-		if (val || display)
-			*p++ = val + '0';
-		else
-			*p++ = ' ';
-		*p++ = day % 10 + '0';
-	} else {
-		*p++ = aday[day][0];
-		*p++ = aday[day][1];
-	}
-	if (highlight)
-		p += sprintf(p, "%s", Sexit);
-	*p++ = ' ';
-	return p;
-}
-
-static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl)
-{
-	if ((ctl->weektype & WEEK_NUM_MASK) == weeknum)
-		p += sprintf(p, "%s%2d%s ", Senter, weeknum, Sexit);
-	else
-		p += sprintf(p, "%2d ", weeknum);
-	return p;
-}
-
 /*
  * Center string, handling multibyte characters appropriately.
  * In addition if the string is too large for the width it's truncated.
-- 
1.8.4.2

