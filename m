Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/4] cal: new top header to display the calendar system
To: Karel Zak <kzak@redhat.com>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6022019c-48a2-770c-c025-683025067976@gmx.com>
Date: Wed, 24 Jan 2018 20:02:10 -0500
MIME-Version: 1.0
In-Reply-To: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Output a top header showing what calendar system is being
displayed: Julian, Gregorian, or Mixed.

Add months_in_row handling for 2 month columns; this enables
proper centering of the header in that case.

Also set the default gutter_width with to 3; using multiple
values complicates alignment of the top header; changing it to
3 makes cal's output consistent.

cal 8 1752
        Julian

     August 1752
Su Mo Tu We Th Fr Sa
                   1
 2  3  4  5  6  7  8
 9 10 11 12 13 14 15
16 17 18 19 20 21 22
23 24 25 26 27 28 29
30 31

cal 9 1752
         Mixed

   September 1752
Su Mo Tu We Th Fr Sa
       1  2 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30

cal 10 1752
       Gregorian

    October 1752
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31

cal -3 9 1752
                              Mixed

     August 1752          September 1752          October 1752
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
                   1          1  2 14 15 16    1  2  3  4  5  6  7
 2  3  4  5  6  7  8   17 18 19 20 21 22 23    8  9 10 11 12 13 14
 9 10 11 12 13 14 15   24 25 26 27 28 29 30   15 16 17 18 19 20 21
16 17 18 19 20 21 22                          22 23 24 25 26 27 28
23 24 25 26 27 28 29                          29 30 31
30 31

cal --iso 9 1752
       Gregorian

   September 1752
Su Mo Tu We Th Fr Sa
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30

cal --reform julian 1 2018
        Julian

    January 2018
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 |  3 ++
 misc-utils/cal.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 60eaa5c3b..95d1a255b 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -67,6 +67,9 @@ is followed by the 14th (the 3rd through the 13th are absent).
 .sp
 Optionally, either the proleptic Gregorian calendar or the Julian calendar may
 be used exclusively.
+.sp
+The calendar system being output is displayed at the top.  The values can be:
+Gregorian, Julian, or Mixed.
 .RB See\  \-\-reform\  below.
 .SH OPTIONS
 .TP
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index d59afc03d..2551cd20d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -244,6 +244,8 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 static void cal_output_header(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
 static void months(const struct cal_control *ctl);
+static int is_mixed_output(const struct cal_control *ctl);
+static void top_header(const struct cal_control *ctl);
 static int day_in_year(const struct cal_control *ctl, int day,
 		       int month, int32_t year);
 static int day_in_week(const struct cal_control *ctl, int day,
@@ -269,7 +271,7 @@ int main(int argc, char **argv)
 		.colormode = UL_COLORMODE_UNDEF,
 		.weektype = WEEK_NUM_DISABLED,
 		.day_width = DAY_LEN,
-		.gutter_width = 2,
+		.gutter_width = 3,
 		.req.day = 0,
 		.req.month = 0
 	};
@@ -531,7 +533,6 @@ int main(int argc, char **argv)
 	}
 
 	if (yflag || Yflag) {
-		ctl.gutter_width = 3;
 		if (!ctl.num_months)
 			ctl.num_months = MONTHS_IN_YEAR;
 		if (yflag) {
@@ -539,7 +540,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (ctl.num_months > 1 && ctl.months_in_row == 0)
+	if (ctl.num_months == 2)
+		ctl.months_in_row = 2;
+	else if (ctl.num_months > 2 && !ctl.months_in_row)
 		ctl.months_in_row = ctl.julian ? MONTHS_IN_YEAR_ROW - 1 :
 						 MONTHS_IN_YEAR_ROW;
 	else if (!ctl.months_in_row)
@@ -548,6 +551,7 @@ int main(int argc, char **argv)
 	if (!ctl.num_months)
 		ctl.num_months = 1;		/* display at least one month */
 
+	top_header(&ctl);
 	months(&ctl);
 
 	return EXIT_SUCCESS;
@@ -846,6 +850,82 @@ static void months(const struct cal_control *ctl)
 	}
 }
 
+/*
+ * Use the requested date, number of months to display, and the span option to
+ * determin whether the Gregorian reform month will be displayed; meaning mixed
+ * calendar systems will be used in the output.
+ */
+static int is_mixed_output(const struct cal_control *ctl)
+{
+	if (ctl->req.year > ctl->reform_year) {
+		if (ctl->span_months && ctl->num_months / 2
+		    > ((ctl->req.year - ctl->reform_year) * MONTHS_IN_YEAR)
+		    - ((REFORMATION_MONTH + 1) - ctl->req.month))
+			return 1;
+	} else if (ctl->req.year < ctl->reform_year) {
+		if (ctl->span_months) {
+			if (ctl->num_months / 2 + ctl->num_months % 2
+			    > ((ctl->reform_year - ctl->req.year)
+			       * MONTHS_IN_YEAR)
+			    + (REFORMATION_MONTH - ctl->req.month))
+				return 1;
+		} else {
+			if (ctl->num_months
+			    > ((ctl->reform_year - ctl->req.year)
+			       * MONTHS_IN_YEAR)
+			    + (REFORMATION_MONTH - ctl->req.month))
+				return 1;
+		}
+	} else {			/* req.year is reform year */
+		if (ctl->req.month > REFORMATION_MONTH) {
+			if (ctl->span_months && ctl->num_months / 2
+			    > (ctl->req.month - (REFORMATION_MONTH + 1)))
+				return 1;
+		} else {
+			if (ctl->span_months) {
+				if (ctl->num_months / 2 + ctl->num_months % 2
+				    > (REFORMATION_MONTH - ctl->req.month))
+					return 1;
+			} else {
+				if (ctl->num_months
+				    > (REFORMATION_MONTH - ctl->req.month))
+					return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+/* Print first line - shows the calendar system being displayed */
+static void top_header(const struct cal_control *ctl)
+{
+	char out[FMT_ST_CHARS];
+	int cols = 0;
+
+	if (ctl->reform_year == GREGORIAN) {
+		sprintf(out, "%s", _("Gregorian"));
+	} else if (ctl->reform_year == JULIAN) {
+		sprintf(out, "%s", _("Julian"));
+	} else {			/* we have a reform year */
+		if (is_mixed_output(ctl))
+			sprintf(out, "%s", _("Mixed"));
+		else if (ctl->req.year > ctl->reform_year)
+			sprintf(out, "%s", _("Gregorian"));
+		else if (ctl->req.year < ctl->reform_year)
+			sprintf(out, "%s", _("Julian"));
+		else {			/* req.year is reform year */
+			if (ctl->req.month > REFORMATION_MONTH)
+				sprintf(out, "%s", _("Gregorian"));
+			else
+				sprintf(out, "%s", _("Julian"));
+		}
+	}
+
+	cols += (ctl->week_width * ctl->months_in_row) + 1;
+	center(out, cols, 0);
+	my_putstring("\n\n");
+}
+
 /*
  * day_in_year --
  *	return the 1 based day number within the year
