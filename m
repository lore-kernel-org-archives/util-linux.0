Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34637 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3J0UnM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:43:12 -0400
Received: by mail-wg0-f45.google.com with SMTP id z12so5811278wgg.0
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:43:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/10] cal: make cal --three to use content structures
Date: Sun, 27 Oct 2013 20:42:36 +0000
Message-Id: <1382906556-16442-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 64 ++++++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 1e1721e..5d0a5f5 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -716,7 +716,7 @@ static void cal_output_week(int week, struct cal_month *month, const struct cal_
 	}
 
 	/* Determine the day that should be highlighted. */
-	if ((month->month + 1) == ctl->req.month && month->year == ctl->req.year) {
+	if (((month->month + 1) == ctl->req.month || ctl->req.week) && month->year == ctl->req.year) {
 		if (ctl->julian)
 			reqday = ctl->req.day;
 		else
@@ -759,18 +759,11 @@ static void monthly(const struct cal_control *ctl)
 
 static void monthly3(const struct cal_control *ctl)
 {
-	char lineout[FMT_ST_CHARS];
-	int i;
-	int rows;
-	struct fmt_st out_prev;
-	struct fmt_st out_curm;
-	struct fmt_st out_next;
+	struct cal_month month[3];
+	int i, m;
 	int prev_month, next_month;
 	long prev_year, next_year;
 
-	memset(&out_prev, 0, sizeof(struct fmt_st));
-	memset(&out_curm, 0, sizeof(struct fmt_st));
-	memset(&out_next, 0, sizeof(struct fmt_st));
 	if (ctl->req.month == 1) {
 		prev_month = MONTHS_IN_YEAR;
 		prev_year  = ctl->req.year - 1;
@@ -785,35 +778,32 @@ static void monthly3(const struct cal_control *ctl)
 		next_month = ctl->req.month + 1;
 		next_year  = ctl->req.year;
 	}
-	if (ctl->header_hint)
-		rows = FMT_ST_LINES;
-	else
-		rows = FMT_ST_LINES - 1;
-	do_monthly(ctl->req.day, prev_month, prev_year, &out_prev, ctl);
-	do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out_curm, ctl);
-	do_monthly(ctl->req.day, next_month, next_year, &out_next, ctl);
-
-	for (i = 0; i < (ctl->header_hint ? 3 : 2); i++) {
-		snprintf(lineout, sizeof(lineout),
-			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
-		my_putstring(lineout);
-	}
-	for (i = ctl->header_hint ? 3 : 2; i < rows; i++) {
-		int w1, w2, w3;
-		w1 = w2 = w3 = ctl->width.wk;
 
-#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
-		/* adjust width to allow for non printable characters */
-		w1 += (out_prev.s[i] == Hrow ? Slen : 0);
-		w2 += (out_curm.s[i] == Hrow ? Slen : 0);
-		w3 += (out_next.s[i] == Hrow ? Slen : 0);
-#endif
-		snprintf(lineout, sizeof(lineout), "%-*s %-*s %-*s\n",
-		       w1, out_prev.s[i],
-		       w2, out_curm.s[i],
-		       w3, out_next.s[i]);
+	cal_fill_month(&(month[0]), prev_month, prev_year, ctl);
+	cal_fill_month(&(month[1]), ctl->req.month, ctl->req.year, ctl);
+	cal_fill_month(&(month[2]), next_month, next_year, ctl);
 
-		my_putstring(lineout);
+	for (i = 0; i <= ctl->header_hint; i++) {
+		for (m = 0; m < 3; m++) {
+			cal_output_month_headers(i, &month[m], ctl);
+			if (m < 2)
+				fputs("  ", stdout);
+		}
+		fputs("\n", stdout);
+	}
+	for (m = 0; m < 3; m++) {
+		cal_output_day_header(ctl);
+		if (m < 2)
+			fputs("  ", stdout);
+	}
+	fputs("\n", stdout);
+	for (i = 0; i < MAXDAYS / DAYS_IN_WEEK; i++) {
+		for (m = 0; m < 3; m++) {
+			cal_output_week(i, &month[m], ctl);
+			if (m < 2)
+				fputs("  ", stdout);
+		}
+		fputs(" \n", stdout);
 	}
 }
 
-- 
1.8.4.1

