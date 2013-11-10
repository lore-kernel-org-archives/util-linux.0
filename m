Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:40131 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3KJSZN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:13 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so234909wgg.33
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/13] cal: add month contents structure
Date: Sun, 10 Nov 2013 18:23:38 +0000
Message-Id: <1384107820-498-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This changes determination of calendar month content completely, as well
as outputing.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 169 insertions(+), 7 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 0a6cd8d..a3eff48 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -251,11 +251,22 @@ struct cal_control {
 			header_hint:1;	/* does month name + year need two lines to fit */
 };
 
+struct cal_month {
+	int days[MAXDAYS];		/* the day numbers, or SPACE */
+	int weeks[MAXDAYS / DAYS_IN_WEEK];
+	int month;
+	long year;
+	struct cal_month *next;
+};
+
 /* function prototypes */
 static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
 static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		      const struct cal_control *ctl);
+static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl);
+static void cal_output_header(struct cal_month *month, const struct cal_control *ctl);
+static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
 static void monthly3(const struct cal_control *ctl);
 static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int row,
@@ -597,18 +608,169 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 	return pos;
 }
 
-static void monthly(const struct cal_control *ctl)
+static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl)
 {
-	int i, rows;
-	struct fmt_st out;
+	int first_week_day = day_in_week(1, month->month, month->year);
+	int month_days;
+	int i, j, weeklines = 0;
+
+	if (ctl->julian)
+		j = day_in_year(1, month->month, month->year);
+	else
+		j = 1;
+	month_days = j + days_in_month[leap_year(month->year)][month->month];
+
+	/* True when Sunday is not first day in the output week. */
+	if (ctl->weekstart) {
+		first_week_day -= ctl->weekstart;
+		if (first_week_day < 0)
+			first_week_day = DAYS_IN_WEEK - ctl->weekstart;
+		month_days += ctl->weekstart - 1;
+	}
+
+	/* Fill day array. */
+	for (i = 0; i < MAXDAYS; i++) {
+		if (0 < first_week_day) {
+			month->days[i] = SPACE;
+			first_week_day--;
+			continue;
+		}
+		if (j < month_days) {
+			if (month->year == 1752 && month->month == 9 && (j == 3 || j == 247))
+				j += NUMBER_MISSING_DAYS;
+			month->days[i] = j;
+			j++;
+			continue;
+		}
+		month->days[i] = SPACE;
+		weeklines++;
+	}
 
-	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, ctl);
-	for (i = 0; i < rows; i++) {
-		my_putstring(out.s[i]);
-		my_putstring("\n");
+	/* Add week numbers */
+	if (ctl->weektype) {
+		int weeknum = week_number(1, month->month, month->year, ctl);
+		weeklines = MAXDAYS / DAYS_IN_WEEK - weeklines / DAYS_IN_WEEK;
+		for (i = 0; i < MAXDAYS / DAYS_IN_WEEK; i++) {
+			if (0 < weeklines)
+				month->weeks[i] = weeknum++;
+			else
+				month->weeks[i] = SPACE;
+			weeklines--;
+			if (52 < weeknum && i == 0)
+				weeknum = week_number(month->days[DAYS_IN_WEEK * (i + 1)], 1, month->year, ctl);
+			else if (52 < weeknum)
+				weeknum = week_number(31, 12, month->year, ctl);
+		}
 	}
 }
 
+static void cal_output_header(struct cal_month *month, const struct cal_control *ctl)
+{
+	char out[FMT_ST_CHARS];
+	struct cal_month *i;
+
+	if (ctl->header_hint) {
+		for (i = month; i; i = i->next) {
+			sprintf(out, _("%s"), ctl->full_month[i->month - 1]);
+			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+		}
+		fputs("\n", stdout);
+		for (i = month; i; i = i->next) {
+			sprintf(out, _("%ld"), i->year);
+			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+		}
+	} else {
+		for (i = month; i; i = i->next) {
+			sprintf(out, _("%s %ld"), ctl->full_month[i->month - 1], i->year);
+			center(out, ctl->week_width - 1, i->next == NULL ? 0 : 2);
+		}
+	}
+	puts("");
+	for (i = month; i; i = i->next) {
+		if (ctl->weektype) {
+			if (ctl->julian)
+				printf("%*s%s", (int)ctl->day_width - 1, "", day_headings);
+			else
+				printf("%*s%s", (int)ctl->day_width, "", day_headings);
+		} else
+			fputs(day_headings, stdout);
+		if (i->next != NULL)
+			fputs("  ", stdout);
+	}
+	puts("");
+}
+
+static void cal_output_months(struct cal_month *month, const struct cal_control *ctl)
+{
+	int reqday, week_line, d;
+	int skip;
+	struct cal_month *i;
+
+	for (week_line = 0; week_line < MAXDAYS / DAYS_IN_WEEK; week_line++) {
+		for (i = month; i; i = i->next) {
+			/* Determine the day that should be highlighted. */
+			reqday = 0;
+			if (i->month == ctl->req.month && i->year == ctl->req.year) {
+				if (ctl->julian)
+					reqday = ctl->req.day;
+				else
+					reqday =
+					    ctl->req.day + 1 - day_in_year(1, i->month,
+									   i->year);
+			}
+
+			if (ctl->weektype) {
+				if (0 < i->weeks[week_line]) {
+					if ((ctl->weektype & WEEK_NUM_MASK) ==
+					    i->weeks[week_line])
+						printf("%s%2d%s", Senter, i->weeks[week_line],
+						       Sexit);
+					else
+						printf("%2d", i->weeks[week_line]);
+				} else
+					printf("%2s", "");
+				skip = ctl->day_width;
+			} else
+				/* First day of the week is one char narrower than the other days,
+				 * unless week number is printed.  */
+				skip = ctl->day_width - 1;
+
+			for (d = DAYS_IN_WEEK * week_line;
+			     d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
+				if (0 < i->days[d]) {
+					if (reqday == i->days[d])
+						printf("%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
+						       "", Senter, (ctl->julian ? 3 : 2),
+						       i->days[d], Sexit);
+					else
+						printf("%*d", skip, i->days[d]);
+				} else
+					printf("%*s", skip, "");
+				if (skip < (int)ctl->day_width)
+					skip++;
+			}
+			if (i->next != NULL)
+				fputs("  ", stdout);
+		}
+		if (i == NULL)
+			fputs(" \n", stdout);
+	}
+}
+
+static void monthly(const struct cal_control *ctl)
+{
+	struct cal_month month;
+
+	month.month = ctl->req.month;
+	month.year = ctl->req.year;
+	month.next = NULL;
+
+	cal_fill_month(&month, ctl);
+
+	cal_output_header(&month, ctl);
+	cal_output_months(&month, ctl);
+}
+
 static void monthly3(const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
-- 
1.8.4.2

