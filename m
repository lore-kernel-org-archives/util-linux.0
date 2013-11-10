Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:45000 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3KJSZQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:16 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so3760220wes.37
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/13] cal: use month contents structure for --three printing
Date: Sun, 10 Nov 2013 18:23:39 +0000
Message-Id: <1384107820-498-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 136 +++++++++++--------------------------------------------
 1 file changed, 26 insertions(+), 110 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index a3eff48..a3c5c40 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -141,7 +141,6 @@ static int		Slen;		/* strlen of Senter+Sexit */
 #endif
 
 static const char	*Senter="", *Sexit="";/* enter and exit standout mode */
-static char		*Hrow;		/* pointer to highlighted row in month */
 
 #include "widechar.h"
 
@@ -262,8 +261,7 @@ struct cal_month {
 /* function prototypes */
 static int leap_year(long year);
 static void headers_init(struct cal_control *ctl);
-static int do_monthly(int day, int month, long year, struct fmt_st *out,
-		      const struct cal_control *ctl);
+static void set_consecutive_months(struct cal_month *month, int m, long y);
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_header(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
@@ -548,64 +546,17 @@ static void headers_init(struct cal_control *ctl)
 	}
 }
 
-static int do_monthly(int day, int month, long year, struct fmt_st *out,
-		      const struct cal_control *ctl)
+static void set_consecutive_months(struct cal_month *month, int m, long y)
 {
-	int col, row, days[MAXDAYS];
-	char *p, lineout[FMT_ST_CHARS];
-	int pos = 0;
-
-	day_array(day, month, year, days, ctl);
-
-	if (ctl->header_hint) {
-		snprintf(lineout, sizeof(lineout), _("%s"), ctl->full_month[month - 1]);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
-		pos++;
-		snprintf(lineout, sizeof(lineout), _("%ld"), year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
-		pos++;
-	} else {
-		/* TRANSLATORS: %s is the month name, %ld the year number.
-		 * You can change the order and/or add something here;
-		 * e.g. for Basque the translation should be "%2$ldko %1$s".
-		 */
-		snprintf(lineout, sizeof(lineout), _("%s %ld"),
-			ctl->full_month[month - 1], year);
-		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), ctl->week_width - 1);
-		pos++;
-	}
-
-	snprintf(out->s[pos++], FMT_ST_CHARS, "%s%s",
-				(ctl->weektype ? "   " : ""),
-				day_headings);
-
-	for (row = 0; row < DAYS_IN_WEEK - 1; row++) {
-		int has_hl = 0;
-		p = lineout;
-		if (ctl->weektype)
-			for (col = 0; col < DAYS_IN_WEEK; col++) {
-				int xd = days[row * DAYS_IN_WEEK + col];
-				if (xd != SPACE) {
-					int wn = week_number(xd & ~TODAY_FLAG,
-							month, year, ctl);
-					p = ascii_weeknum(p, wn, ctl);
-					break;
-				} else if (col+1 == DAYS_IN_WEEK)
-					p += sprintf(p,"   ");
-			}
-		for (col = 0; col < DAYS_IN_WEEK; col++) {
-			int xd = days[row * DAYS_IN_WEEK + col];
-			if (xd != SPACE && (xd & TODAY_FLAG))
-				has_hl = 1;
-			p = ascii_day(p, xd, ctl);
+	struct cal_month *i;
+	for (i = month; i; i = i->next) {
+		i->month = m++;
+		i->year = y;
+		if (MONTHS_IN_YEAR < m) {
+			m = 1;
+			y++;
 		}
-		*p = '\0';
-		snprintf(out->s[row+pos], FMT_ST_CHARS, "%s", lineout);
-		if (has_hl)
-			Hrow = out->s[row+pos];
 	}
-	pos += row;
-	return pos;
 }
 
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl)
@@ -773,62 +724,27 @@ static void monthly(const struct cal_control *ctl)
 
 static void monthly3(const struct cal_control *ctl)
 {
-	char lineout[FMT_ST_CHARS];
-	int i;
-	int rows;
-	struct fmt_st out_prev;
-	struct fmt_st out_curm;
-	struct fmt_st out_next;
-	int prev_month, next_month;
-	long prev_year, next_year;
-
-	memset(&out_prev, 0, sizeof(struct fmt_st));
-	memset(&out_curm, 0, sizeof(struct fmt_st));
-	memset(&out_next, 0, sizeof(struct fmt_st));
+	struct cal_month m1, m2, m3, *i;
+	int first_month;
+	long first_year;
+
+	m1.next = &m2;
+	m2.next = &m3;
+	m3.next = NULL;
+
 	if (ctl->req.month == 1) {
-		prev_month = MONTHS_IN_YEAR;
-		prev_year  = ctl->req.year - 1;
-	} else {
-		prev_month = ctl->req.month - 1;
-		prev_year  = ctl->req.year;
-	}
-	if (ctl->req.month == MONTHS_IN_YEAR) {
-		next_month = 1;
-		next_year  = ctl->req.year + 1;
+		first_month = MONTHS_IN_YEAR;
+		first_year = ctl->req.year - 1;
 	} else {
-		next_month = ctl->req.month + 1;
-		next_year  = ctl->req.year;
-	}
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
+		first_month = ctl->req.month - 1;
+		first_year = ctl->req.year;
 	}
-	for (i = ctl->header_hint ? 3 : 2; i < rows; i++) {
-		int w1, w2, w3;
-		w1 = w2 = w3 = ctl->week_width;
 
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
-
-		my_putstring(lineout);
-	}
+	set_consecutive_months(&m1, first_month, first_year);
+	for (i = &m1; i; i = i->next)
+		cal_fill_month(i, ctl);
+	cal_output_header(&m1, ctl);
+	cal_output_months(&m1, ctl);
 }
 
 static char *append_weeknum(char *p, int *dp,
-- 
1.8.4.2

