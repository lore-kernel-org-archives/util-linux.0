Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38333 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab3J0UnJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:43:09 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so3129773wib.5
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:43:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/10] cal: add month contents structure
Date: Sun, 27 Oct 2013 20:42:35 +0000
Message-Id: <1382906556-16442-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit changes determination of calendar month content completely,
as well as outputing.  The output is done week by week, which will allow
laying out months horizontally more understandable way.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 6 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 07c613a..1e1721e 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -255,11 +255,21 @@ struct cal_control {
 			header_hint:1;	/* does month name + year execeed cal_width.wk */
 };
 
+struct cal_month {
+	int days[MAXDAYS];		/* internally day numbers are julian or SPACE */
+	int dsny;			/* days since new year */
+	int weeks[MAXDAYS / DAYS_IN_WEEK];
+	int month;
+	long year;
+};
+
 /* function prototypes */
 static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
 static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		      const struct cal_control *ctl);
+static void cal_fill_month(struct cal_month *month, int mt, long yr,
+			   const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
 static void monthly3(const struct cal_control *ctl);
 static char *append_wnum(char *p, int *dp, int month, long year, int cal, int row,
@@ -601,15 +611,149 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 	return pos;
 }
 
+static void cal_fill_month(struct cal_month *month, int mt, long yr, const struct cal_control *ctl)
+{
+	int first_week_day = day_in_week(1, mt, yr);
+	int month_days;
+	int i, j, weeklines = 0;
+
+	month->year = yr;
+	month->month = mt - 1;
+
+	if (ctl->julian)
+		j = day_in_year(1, mt, yr);
+	else
+		j = 1;
+	month_days = j + days_in_month[leap_year(yr)][mt];
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
+			if (yr == 1752 && mt == 9 && (j == 3 || j == 247))
+				j += NUMBER_MISSING_DAYS;
+			month->days[i] = j;
+			j++;
+			continue;
+		}
+		month->days[i] = SPACE;
+		weeklines++;
+	}
+
+	/* Add week numbers */
+	if (ctl->wflag) {
+		int weeknum = week_number(1, mt, yr, ctl);
+		weeklines = MAXDAYS / DAYS_IN_WEEK - weeklines / DAYS_IN_WEEK;
+		for (i = 0; i < MAXDAYS / DAYS_IN_WEEK; i++) {
+			if (0 < weeklines)
+				month->weeks[i] = weeknum++;
+			else
+				month->weeks[i] = SPACE;
+			weeklines--;
+			if (52 < weeknum && i == 0)
+				weeknum = week_number(month->days[DAYS_IN_WEEK * (i + 1)], 1, yr, ctl);
+			else if (52 < weeknum)
+				weeknum = week_number(31, 12, yr, ctl);
+		}
+	}
+}
+
+static void cal_output_month_headers(int line, struct cal_month *month, const struct cal_control *ctl)
+{
+	char out[FMT_ST_CHARS];
+
+	if (!ctl->header_hint) {
+		sprintf(out, _("%s %ld"), ctl->full_month[month->month], month->year);
+		center(out, ctl->width.wk - 1, 0);
+	} else {
+		if (line == 0)
+			sprintf(out, _("%s"), ctl->full_month[month->month]);
+		else
+			sprintf(out, _("%ld"), month->year);
+		center(out, ctl->width.wk - 1, 0);
+	}
+}
+
+static void cal_output_day_header(const struct cal_control *ctl)
+{
+	if (ctl->wflag) {
+		if (ctl->julian)
+			printf("%*s%s", (int)ctl->width.dy - 1, "", day_headings);
+		else
+			printf("%*s%s", (int)ctl->width.dy, "", day_headings);
+	} else
+		fputs(day_headings, stdout);
+}
+
+static void cal_output_week(int week, struct cal_month *month, const struct cal_control *ctl)
+{
+	int i, reqday = 0;
+	int j = 7 * week;
+	int skip = ctl->width.dy - 1;
+
+	if (ctl->wflag) {
+		skip--;
+		if (0 < month->weeks[week]) {
+			if ((ctl->wflag & WEEK_NUM_MASK) == month->weeks[week])
+				printf("%s%2d%s", Senter, month->weeks[week], Sexit);
+			else
+				printf("%2d", month->weeks[week]);
+		} else
+			printf("%2s", "");
+		skip = ctl->width.dy;
+	}
+
+	/* Determine the day that should be highlighted. */
+	if ((month->month + 1) == ctl->req.month && month->year == ctl->req.year) {
+		if (ctl->julian)
+			reqday = ctl->req.day;
+		else
+			reqday = ctl->req.day + 1 - day_in_year(1, month->month + 1, ctl->req.year);
+	}
+
+	for (i = 0; i < DAYS_IN_WEEK; i++) {
+		if (0 < month->days[j])
+			if (reqday == month->days[j])
+				printf("%*s%s%*d%s", skip - (ctl->julian ? 3 : 2), "", Senter, (ctl->julian ? 3 : 2), month->days[j], Sexit);
+			else
+				printf("%*d", skip, month->days[j]);
+		else {
+			printf("%*s", skip, "");
+		}
+		if (skip < (int)ctl->width.dy)
+			skip++;
+		j++;
+	}
+}
+
 static void monthly(const struct cal_control *ctl)
 {
-	int i, rows;
-	struct fmt_st out;
+	struct cal_month month;
+	int i;
+
+	cal_fill_month(&month, ctl->req.month, ctl->req.year, ctl);
 
-	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, ctl);
-	for (i = 0; i < rows; i++) {
-		my_putstring(out.s[i]);
-		my_putstring("\n");
+	for (i = 0; i <= ctl->header_hint; i++) {
+		cal_output_month_headers(i, &month, ctl);
+		fputs("\n", stdout);
+	}
+	cal_output_day_header(ctl);
+	fputs("\n", stdout);
+	for (i = 0; i < MAXDAYS / DAYS_IN_WEEK; i++) {
+		cal_output_week(i, &month, ctl);
+		fputs(" \n", stdout);
 	}
 }
 
-- 
1.8.4.1

