Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63004 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3KJSZK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:10 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so2165181wgh.29
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/13] cal: determine how many header lines are needed at initialization
Date: Sun, 10 Nov 2013 18:23:37 +0000
Message-Id: <1384107820-498-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 53 ++++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 185b7a9..0a6cd8d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -247,16 +247,16 @@ struct cal_control {
 	size_t week_width;		/* 7 * day_width + possible week num */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
-			yflag:1;	/* print whole year */
+			yflag:1,	/* print whole year */
+			header_hint:1;	/* does month name + year need two lines to fit */
 };
 
 /* function prototypes */
 static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
-static int do_monthly(int day, int month, long year, struct fmt_st *out, int header_hint,
+static int do_monthly(int day, int month, long year, struct fmt_st *out,
 		      const struct cal_control *ctl);
 static void monthly(const struct cal_control *ctl);
-static int two_header_lines(int month, long year, const struct cal_control *ctl);
 static void monthly3(const struct cal_control *ctl);
 static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int row,
 			    const struct cal_control *ctl);
@@ -510,6 +510,10 @@ static void headers_init(struct cal_control *ctl)
 {
 	size_t i, wd;
 	char *cur_dh = day_headings;
+	char tmp[FMT_ST_CHARS];
+	size_t year_len;
+
+	year_len = snprintf(tmp, sizeof(tmp), "%ld", ctl->req.year);
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		size_t space_left;
@@ -525,12 +529,16 @@ static void headers_init(struct cal_control *ctl)
 				     space_left, ctl->day_width - 1);
 	}
 
-	for (i = 0; i < MONTHS_IN_YEAR; i++)
+	for (i = 0; i < MONTHS_IN_YEAR; i++) {
 		ctl->full_month[i] = nl_langinfo(MON_1 + i);
+		/* The +1 after year_len is space in between month and year. */
+		if (ctl->week_width < strlen(ctl->full_month[i]) + year_len + 1)
+			ctl->header_hint = 1;
+	}
 }
 
 static int do_monthly(int day, int month, long year, struct fmt_st *out,
-		      int header_hint, const struct cal_control *ctl)
+		      const struct cal_control *ctl)
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
@@ -538,9 +546,7 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 
 	day_array(day, month, year, days, ctl);
 
-	if (header_hint < 0)
-		header_hint = two_header_lines(month, year, ctl);
-	if (header_hint) {
+	if (ctl->header_hint) {
 		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
 		pos++;
@@ -596,30 +602,18 @@ static void monthly(const struct cal_control *ctl)
 	int i, rows;
 	struct fmt_st out;
 
-	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, -1, ctl);
+	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, ctl);
 	for (i = 0; i < rows; i++) {
 		my_putstring(out.s[i]);
 		my_putstring("\n");
 	}
 }
 
-static int two_header_lines(int month, long year, const struct cal_control *ctl)
-{
-	char lineout[FMT_ST_CHARS];
-	size_t len;
-	snprintf(lineout, sizeof(lineout), "%ld", year);
-	len = strlen(lineout);
-	len += strlen(ctl->full_month[month - 1]) + 1;
-	if (ctl->week_width - 1 < len)
-		return 1;
-	return 0;
-}
-
 static void monthly3(const struct cal_control *ctl)
 {
 	char lineout[FMT_ST_CHARS];
 	int i;
-	int rows, two_lines;
+	int rows;
 	struct fmt_st out_prev;
 	struct fmt_st out_curm;
 	struct fmt_st out_next;
@@ -643,23 +637,20 @@ static void monthly3(const struct cal_control *ctl)
 		next_month = ctl->req.month + 1;
 		next_year  = ctl->req.year;
 	}
-	two_lines = two_header_lines(prev_month, prev_year, ctl);
-	two_lines += two_header_lines(ctl->req.month, ctl->req.year, ctl);
-	two_lines += two_header_lines(next_month, next_year, ctl);
-	if (0 < two_lines)
+	if (ctl->header_hint)
 		rows = FMT_ST_LINES;
 	else
 		rows = FMT_ST_LINES - 1;
-	do_monthly(ctl->req.day, prev_month, prev_year, &out_prev, two_lines, ctl);
-	do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out_curm, two_lines, ctl);
-	do_monthly(ctl->req.day, next_month, next_year, &out_next, two_lines, ctl);
+	do_monthly(ctl->req.day, prev_month, prev_year, &out_prev, ctl);
+	do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out_curm, ctl);
+	do_monthly(ctl->req.day, next_month, next_year, &out_next, ctl);
 
-	for (i = 0; i < (two_lines ? 3 : 2); i++) {
+	for (i = 0; i < (ctl->header_hint ? 3 : 2); i++) {
 		snprintf(lineout, sizeof(lineout),
 			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
 		my_putstring(lineout);
 	}
-	for (i = two_lines ? 3 : 2; i < rows; i++) {
+	for (i = ctl->header_hint ? 3 : 2; i < rows; i++) {
 		int w1, w2, w3;
 		w1 = w2 = w3 = ctl->week_width;
 
-- 
1.8.4.2

