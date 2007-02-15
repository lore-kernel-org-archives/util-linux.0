Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803AbXBOOSn (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 09:18:43 -0500
Date: Thu, 15 Feb 2007 15:18:35 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: Christian Schlotter <schlotter@users.sourceforge.net>,
        util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
Message-ID: <20070215141835.GH3925@petra.dvoda.cz>
References: <45868535.5030402@users.sourceforge.net> <20070215130303.GG3925@petra.dvoda.cz> <45D460A8.7080409@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <45D460A8.7080409@draigBrady.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 15, 2007 at 01:31:20PM +0000, Pádraig Brady wrote:
 
> Sorry I missed the original mail/patch.
> Can you send again?

There is a small display error when using cal from util-linux-2.13-pre7
with the command line "cal -3m".  On Sep 27th 2006 it produced the
following output (Sep 27th is highlighted):

    August 2006          September 2006         October 2006
Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
    1  2  3  4  5  6               1  2  3                     1
 7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8
14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15
21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22
28 29 30 31           25 26 27 28 29 30  23 24 25 26 27 28 29
                                            30 31

As one can see, the second but last row of October is misaligned because
the characters used for highlighting are not taken into account when
aligning the last line of September.

This patch fixes the erroneous display by adopting the style of the
yearly(...) function.  The patch also removes one unused variable "len"
and unifies the amount of whitespace used for separating two month
displays.

Signed-off-by: Christian Schlotter <schlotter@users.sourceforge.net>
---
 misc-utils/cal.c |  124
+++++++++++++++++++++++++-----------------------------
 1 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 339a610..9719c12 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -232,7 +232,7 @@ void yearly(int, int);
 void j_yearly(int, int);
 void do_monthly(int, int, int, struct fmt_st*);
 void monthly(int, int, int);
-void monthly3(int, int, int);
+void monthly3(int, int, int, const int);
 void trim_trailing_spaces(char *);
 void usage(void);
 void headers_init(void);
@@ -245,6 +245,7 @@ main(int argc, char **argv) {
 	int ch, day, month, year, yflag;
 	char *progname, *p;
 	int num_months = NUM_MONTHS;
+	const int show_year = 1;

 	progname = argv[0];
 	if ((p = strrchr(progname, '/')) != NULL)
@@ -347,7 +348,7 @@ main(int argc, char **argv) {
 	if (month && num_months == 1)
 		monthly(day, month, year);
 	else if (month && num_months == 3)
-		monthly3(day, month, year);
+		monthly3(day, month, year, show_year);
 	else if (julian)
 		j_yearly(day, year);
 	else
@@ -424,7 +425,7 @@ void headers_init(void)

 void
 do_monthly(int day, int month, int year, struct fmt_st *out) {
-	int col, row, len, days[MAXDAYS];
+	int col, row, days[MAXDAYS];
 	char *p, lineout[FMT_ST_CHARS];
 	int width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;

@@ -436,7 +437,7 @@ do_monthly(int day, int month, int year, struct
fmt_st *out) {
 	 * Basque the translation should be: "%2$dko %1$s", and
 	 * the Vietnamese should be "%s na(m %d", etc.
 	 */
-	len = sprintf(lineout, _("%s %d"), full_month[month - 1], year);
+	sprintf(lineout, _("%s %d"), full_month[month - 1], year);
 	center_str(lineout, out->s[0], SIZE(out->s[0]), width);

 	sprintf(out->s[1],"%s",
@@ -466,46 +467,62 @@ monthly(int day, int month, int year) {
 }

 void
-monthly3(int day, int month, int year) {
-	char lineout[FMT_ST_CHARS];
-	int i;
-	int width;
-	struct fmt_st out_prev;
-	struct fmt_st out_curm;
-	struct fmt_st out_next;
-	int prev_month, prev_year;
-	int next_month, next_year;
-
+monthly3(int day, int month, int year, const int show_year) {
+	char *p, lineout[FMT_ST_CHARS], head[FMT_ST_CHARS / 3];
+	int *dp, days[3][MAXDAYS], months[3], years[3], row, col, i;
+	const int week_len = (julian) ? J_WEEK_LEN : WEEK_LEN;
+	const int head_sep = (julian) ? J_HEAD_SEP : HEAD_SEP;
+	const char * const headings = (julian) ? j_day_headings : day_headings;
+
+	/* previous, current and next month/year */
 	if (month == 1) {
-		prev_month = 12;
-		prev_year  = year - 1;
+		months[0] = 12;
+		years[0] = year - 1;
 	} else {
-		prev_month = month - 1;
-		prev_year  = year;
+		months[0] = month - 1;
+		years[0] = year;
 	}
+	months[1] = month;
+	years[1] = year;
 	if (month == 12) {
-		next_month = 1;
-		next_year  = year + 1;
+		months[2] = 1;
+		years[2] = year + 1;
 	} else {
-		next_month = month + 1;
-		next_year  = year;
+		months[2] = month + 1;
+		years[2] = year;
 	}

-	do_monthly(day, prev_month, prev_year, &out_prev);
-	do_monthly(day, month,      year,      &out_curm);
-	do_monthly(day, next_month, next_year, &out_next);
-        width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
-	for (i = 0; i < 2; i++)
-		printf("%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
-	for (i = 2; i < FMT_ST_LINES; i++) {
-		snprintf(lineout, SIZE(lineout), "%-*s  %-*s  %-*s\n",
-		       width, out_prev.s[i],
-		       width, out_curm.s[i],
-		       width, out_next.s[i]);
+    memset(lineout, ' ', sizeof(lineout) - 1);
+    lineout[sizeof(lineout) - 1] = '\0';
+
+    for (i = 0; i < 3; i++) {
+	    day_array(day, months[i], years[i], days[i]);
+	    if (show_year) {
+		    snprintf(head, sizeof(head), _("%s %d"),
+			     full_month[months[i] - 1], years[i]);
+	    } else {
+		    snprintf(head, sizeof(head), _("%s"),
+			     full_month[months[i] - 1]);
+	    }
+	    center(head, week_len, (i == 2) ? 0 : head_sep);
+    }
+    printf("\n%s%*s %s%*s %s\n", headings, head_sep, "", headings,
+	   head_sep, "", headings);
+    for (row = 0; row < 6; row++) {
+	    p = lineout;
+	    for (i = 0; i < 3; i++) {
+		    dp = &days[i][row * 7];
+		    for (col = 0; col < 7; col++) {
+			    p = ascii_day(p, *dp++);
+		    }
+		    p += sprintf(p, "  ");
+	    }
+	    *p = '\0';
+	    trim_trailing_spaces(lineout);
 #if defined(HAVE_NCURSES) || defined(HAVE_LIBTERMCAP)
-		my_putstring(lineout);
+		my_putstring(lineout);putchar('\n');
 #else
-		fputs(lineout,stdout);
+		puts(lineout);
 #endif
 	}
 }
@@ -546,47 +563,20 @@ j_yearly(int day, int year) {
 #endif
 		}
 	}
-	printf("\n");
 }

 void
 yearly(int day, int year) {
-	int col, *dp, i, month, row, which_cal;
-	int days[12][MAXDAYS];
-	char *p, lineout[100];
+	int month;
+	char lineout[100];
+	const int show_year = 0;

 	sprintf(lineout, "%d", year);
 	center(lineout, WEEK_LEN * 3 + HEAD_SEP * 2, 0);
 	printf("\n\n");

-	for (i = 0; i < 12; i++)
-		day_array(day, i + 1, year, days[i]);
-	memset(lineout, ' ', sizeof(lineout) - 1);
-	lineout[sizeof(lineout) - 1] = '\0';
-	for (month = 0; month < 12; month += 3) {
-		center(full_month[month], WEEK_LEN, HEAD_SEP);
-		center(full_month[month + 1], WEEK_LEN, HEAD_SEP);
-		center(full_month[month + 2], WEEK_LEN, 0);
-		printf("\n%s%*s %s%*s %s\n", day_headings, HEAD_SEP,
-		    "", day_headings, HEAD_SEP, "", day_headings);
-		for (row = 0; row < 6; row++) {
-			p = lineout;
-			for (which_cal = 0; which_cal < 3; which_cal++) {
-				dp = &days[month + which_cal][row * 7];
-				for (col = 0; col < 7; col++)
-					p = ascii_day(p, *dp++);
-				p += sprintf(p, "  ");
-			}
-			*p = '\0';
-			trim_trailing_spaces(lineout);
-#if defined(HAVE_NCURSES) || defined(HAVE_LIBTERMCAP)
-                        my_putstring(lineout);putchar('\n');
-#else
-                        puts(lineout);
-#endif
-		}
-	}
-	printf("\n");
+	for (month = 0; month < 12; month += 3)
+		monthly3(day, month + 2, year, show_year);
 }

 /*
-- 
1.4.4.2


-- 
 Karel Zak  <kzak@redhat.com>
