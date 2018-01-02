Return-Path: elseifthen@gmx.com
Subject: [v3 PATCH 04/11] cal: rename --julian to --ordinal
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0a376a82-325a-b095-8702-d563b7012c7d@gmx.com>
Date: Tue, 2 Jan 2018 09:57:20 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Using --julian for ordinal output was confusing.
Also --julian is to be repurposed for Julian Calendar output.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/deprecated.txt |  6 ++++++
 misc-utils/cal.1             | 16 +++++++---------
 misc-utils/cal.c             | 41 ++++++++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 34ea698da..d79fd2c80 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -2,6 +2,12 @@ The following is a list of commands or features that are deprecated.  All
 deprecated utils are in maintenance mode and we keep them in source tree for
 backward compatibility only.
 
+what:  cal --julian
+why:   renamed to --ordinal
+since: v2.32
+
+--------------------------
+
 what:  column --columns
 why:   renamed to --output-width
 since: v2.30
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 7e917886c..afd3bdc5f 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -104,15 +104,13 @@ Display Sunday as the first day of the week.
 Display Monday as the first day of the week.
 .TP
 \fB\-j\fR, \fB\-\-julian\fR
-Use day-of-year numbering for all calendar types.  These are also called ordinal
-days.  Ordinal days range from 1 to 366.  This option does not switch from the
-Gregorian to the Julian calendar system, that is controlled by the Gregorian
-epoch option
-.BR \%\-\-1752-reform .
-Sometimes Gregorian calendars using ordinal dates are referred to as Julian
-calendars.  This can be confusing because there are many date related
-conventions that use Julian in their name: (ordinal) julian date, julian
-(calendar) date, (astronomical) julian date, (modified) julian date, and more.
+.RB Use\  \-\-ordinal .
+.RB The\  \%\-\-julian\  option
+has been deprecated and may be repurposed or removed in a future release.
+.TP
+.B \-\-ordinal
+Display day-of-year numbering for all calendar types.  Ordinal days range from
+1 to 366.
 .TP
 \fB\-y\fR, \fB\-\-year\fR
 Display a calendar for the whole year.
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index df0568c56..0990f5199 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -216,7 +216,7 @@ struct cal_control {
 	size_t week_width;		/* 7 * day_width + possible week num */
 	int gutter_width;		/* spaces in between horizontal month outputs */
 	struct cal_request req;		/* the times user is interested */
-	unsigned int	julian:1,	/* julian output */
+	unsigned int	ordinal:1,	/* ordinal output */
 			header_year:1,	/* print year number */
 			header_hint:1;	/* does month name + year need two lines to fit */
 };
@@ -270,7 +270,8 @@ int main(int argc, char **argv)
 
 	enum {
 		OPT_1752_REFORM = CHAR_MAX + 1,
-		OPT_COLOR
+		OPT_COLOR,
+		OPT_ORDINAL
 	};
 
 	static const struct option longopts[] = {
@@ -284,6 +285,7 @@ int main(int argc, char **argv)
 		{"year", no_argument, NULL, 'y'},
 		{"week", optional_argument, NULL, 'w'},
 		{"color", optional_argument, NULL, OPT_COLOR},
+		{"ordinal", no_argument, NULL, OPT_ORDINAL},
 		{"1752-reform", no_argument, NULL, OPT_1752_REFORM},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
@@ -366,7 +368,11 @@ int main(int argc, char **argv)
 			ctl.weekstart = MONDAY;
 			break;
 		case 'j':
-			ctl.julian = 1;
+			errx(EXIT_FAILURE,
+			    _("use --ordinal, --julian has been deprecated."));
+			break;
+		case OPT_ORDINAL:
+			ctl.ordinal = 1;
 			ctl.day_width = DAY_LEN + 1;
 			break;
 		case 'y':
@@ -530,7 +536,7 @@ int main(int argc, char **argv)
 	}
 
 	if (ctl.num_months > 1 && ctl.months_in_row == 0)
-		ctl.months_in_row = ctl.julian ? MONTHS_IN_YEAR_ROW - 1 :
+		ctl.months_in_row = ctl.ordinal ? MONTHS_IN_YEAR_ROW - 1 :
 						 MONTHS_IN_YEAR_ROW;
 	else if (!ctl.months_in_row)
 		ctl.months_in_row = 1;
@@ -634,7 +640,7 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 	int month_days;
 	int i, j, weeklines = 0;
 
-	if (ctl->julian)
+	if (ctl->ordinal)
 		j = day_in_year(ctl, 1, month->month, month->year);
 	else
 		j = 1;
@@ -710,7 +716,7 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 	my_putstring("\n");
 	for (i = month; i; i = i->next) {
 		if (ctl->weektype) {
-			if (ctl->julian)
+			if (ctl->ordinal)
 				sprintf(out, "%*s%s", (int)ctl->day_width - 1, "", day_headings);
 			else
 				sprintf(out, "%*s%s", (int)ctl->day_width, "", day_headings);
@@ -737,7 +743,7 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 			/* Determine the day that should be highlighted. */
 			reqday = 0;
 			if (i->month == ctl->req.month && i->year == ctl->req.year) {
-				if (ctl->julian)
+				if (ctl->ordinal)
 					reqday = ctl->req.day;
 				else
 					reqday = ctl->req.day + 1 -
@@ -766,9 +772,12 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 			     d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
 				if (0 < i->days[d]) {
 					if (reqday == i->days[d])
-						sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
-						       "", Senter, (ctl->julian ? 3 : 2),
-						       i->days[d], Sexit);
+						sprintf(out, "%*s%s%*d%s", skip
+							- (ctl->ordinal
+							   ? 3 : 2),
+							"", Senter,
+							(ctl->ordinal ? 3 : 2),
+							i->days[d], Sexit);
 					else
 						sprintf(out, "%*d", skip, i->days[d]);
 				} else
@@ -842,8 +851,8 @@ static void yearly(const struct cal_control *ctl)
 	char out[FMT_ST_CHARS];
 	int year_width = 0;
 
-	year_width += (ctl->week_width + 1) * (ctl->julian ? 2 : 3);
-	if (ctl->julian)
+	year_width += (ctl->week_width + 1) * (ctl->ordinal ? 2 : 3);
+	if (ctl->ordinal)
 		year_width--;
 
 	if (ctl->header_year) {
@@ -927,7 +936,7 @@ static int day_in_week(const struct cal_control *ctl, int day,
  * week_number
  *      return the week number of a given date, 1..54.
  *      Supports ISO-8601 and North American modes.
- *      Day may be given as Julian day of the year mode, in which
+ *      Day may be given as ordinal day, in which
  *      case the month is disregarded entirely.
  */
 static int week_number(int day, int month, int32_t year, const struct cal_control *ctl)
@@ -943,9 +952,7 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 		 * more than 52 weeks, */
 		fday = wday + 6;
 	}
-	/* For julian dates the month can be set to 1, the global julian
-	 * variable cannot be relied upon here, because we may recurse
-	 * internally for 31.12. which would not work. */
+	/* For ordinal dates the month can be set to 1 */
 	if (day > DAYS_IN_MONTH)
 		month = JANUARY;
 
@@ -1037,7 +1044,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -S, --span            span the date when displaying multiple months\n"), out);
 	fputs(_(" -s, --sunday          Sunday as first day of week\n"), out);
 	fputs(_(" -m, --monday          Monday as first day of week\n"), out);
-	fputs(_(" -j, --julian          use day-of-year for all calendar types\n"), out);
+	fputs(_("     --ordinal         use day-of-year for all calendar types\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
