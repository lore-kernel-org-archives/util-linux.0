Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:36050 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab3J0UnG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:43:06 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so5880784wes.3
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:43:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/10] cal: determine how many header lines are needed at initialization
Date: Sun, 27 Oct 2013 20:42:34 +0000
Message-Id: <1382906556-16442-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 53 ++++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index b12a959..07c613a 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -251,16 +251,16 @@ struct cal_control {
 	int wflag;			/* uses WEEK_NUM_ enum */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
-			yflag:1;	/* print whole year */
+			yflag:1,	/* print whole year */
+			header_hint:1;	/* does month name + year execeed cal_width.wk */
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
 static char *append_wnum(char *p, int *dp, int month, long year, int cal, int row,
 			 const struct cal_control *ctl);
@@ -514,6 +514,10 @@ static void headers_init(struct cal_control *ctl)
 {
 	size_t i, wd;
 	char *cur_dh = day_headings;
+	char tmp[FMT_ST_CHARS];
+	size_t year_len;
+
+	year_len = snprintf(tmp, sizeof(tmp), "%ld", ctl->req.year);
 
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		size_t space_left;
@@ -529,12 +533,16 @@ static void headers_init(struct cal_control *ctl)
 				     space_left, ctl->width.dy - 1);
 	}
 
-	for (i = 0; i < MONTHS_IN_YEAR; i++)
+	for (i = 0; i < MONTHS_IN_YEAR; i++) {
 		ctl->full_month[i] = nl_langinfo(MON_1 + i);
+		/* The +1 after year_len is space in between month and year. */
+		if (ctl->width.wk < strlen(ctl->full_month[i]) + year_len + 1)
+			ctl->header_hint = 1;
+	}
 }
 
 static int do_monthly(int day, int month, long year, struct fmt_st *out,
-		      int header_hint, const struct cal_control *ctl)
+		      const struct cal_control *ctl)
 {
 	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
@@ -542,9 +550,7 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 
 	day_array(day, month, year, days, ctl);
 
-	if (header_hint < 0)
-		header_hint = two_header_lines(month, year, ctl);
-	if (header_hint) {
+	if (ctl->header_hint) {
 		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->width.wk - 1);
 		pos++;
@@ -600,30 +606,18 @@ static void monthly(const struct cal_control *ctl)
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
-	if (ctl->width.wk - 1 < len)
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
@@ -647,23 +641,20 @@ static void monthly3(const struct cal_control *ctl)
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
 		w1 = w2 = w3 = ctl->width.wk;
 
-- 
1.8.4.1

