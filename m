Return-Path: elseifthen@gmx.com
Subject: [v3 PATCH 03/11] cal: update man page and usage()
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <895ad7ca-3dd3-c3ac-0c10-bc58aed74d7a@gmx.com>
Date: Tue, 2 Jan 2018 09:56:20 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 134 ++++++++++++++++++++++++++++++++++++-------------------
 misc-utils/cal.c |   6 +--
 2 files changed, 91 insertions(+), 49 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index d35b356d2..7e917886c 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -34,7 +34,7 @@
 .\"
 .\"     @(#)cal.1	8.1 (Berkeley) 6/6/93
 .\"
-.TH CAL 1 "June 2015" "util-linux" "User Commands"
+.TH CAL 1 "December 2017" "util-linux" "User Commands"
 .SH NAME
 cal \- display a calendar
 .SH SYNOPSIS
@@ -44,19 +44,40 @@ cal \- display a calendar
 .br
 .B cal
 [options]
-.RI <timestamp|monthname>
+.RI [ timestamp | month_name ]
 .SH DESCRIPTION
-.B cal
-displays a simple calendar.  If no arguments are specified, the current
-month is displayed.
-.sp
-The \fImonth\fR may be specified as a number (1-12), as a month name or as an
-abbreviated month name according to the current locales.
-.sp
 Since v2.32 the default calendar system has changed to proleptic Gregorian;
 this makes it consistent with ISO 8601, date(1), and most other conventions.
 The old default output is still available by using the
 .BR \-\-1752-reform\  option.
+.sp
+If no arguments are specified, a calendar for the current month is displayed.
+.sp
+The \fImonth\fR may be specified as a number (1-12), as a month name or as an
+abbreviated month name according to the current locale.
+.RI The \ year " must be greater than 0."
+.sp
+Timestamps are ISO like, and must be quoted.  For example: \%"2012-09-22\ 16:34:22"
+.RB See \ PARAMETERS \ below.
+.sp
+Two different calendar systems are used, Gregorian and Julian.  These are
+nearly identical systems with Gregorian making a small adjustment to the
+frequency of leap years; this facilitates improved synchronization with solar
+events like the equinoxes.  The Gregorian calendar reform was introduced in
+1582, but its adoption continued up to 1923.
+.sp
+.RB The\  \-\-1752-reform
+option uses the Gregorian calendar reform date of 3 Sept 1752.  From that date
+forward the Gregorian calendar is displayed; previous dates use the Julian
+calendar system.  11 days were removed at the time of adoption to bring the
+calendar in sync with solar events.  So Sept 1752 has a mix of Julian and
+Gregorian dates by which the 2nd is followed by the 14th (the 3rd through 13th
+are absent).
+.sp
+The default calendar system is proleptic Gregorian;  this means that dates
+previous to any calendar reform use extrapolated Gregorian dates instead of
+Julian calendar dates.
+
 .SH OPTIONS
 .TP
 \fB\-1\fR, \fB\-\-one\fR
@@ -74,7 +95,7 @@ This means that dates previous to 3 Sept 1752 will be Julian calendar dates.
 Display \fInumber\fR of months, starting from the month containing the date.
 .TP
 \fB\-S, \fB\-\-span\fR
-Display months spanning the date.
+Span the date when displaying multiple months.
 .TP
 \fB\-s\fR, \fB\-\-sunday\fR
 Display Sunday as the first day of the week.
@@ -83,7 +104,15 @@ Display Sunday as the first day of the week.
 Display Monday as the first day of the week.
 .TP
 \fB\-j\fR, \fB\-\-julian\fR
-Display Julian dates (days one-based, numbered from January 1).
+Use day-of-year numbering for all calendar types.  These are also called ordinal
+days.  Ordinal days range from 1 to 366.  This option does not switch from the
+Gregorian to the Julian calendar system, that is controlled by the Gregorian
+epoch option
+.BR \%\-\-1752-reform .
+Sometimes Gregorian calendars using ordinal dates are referred to as Julian
+calendars.  This can be confusing because there are many date related
+conventions that use Julian in their name: (ordinal) julian date, julian
+(calendar) date, (astronomical) julian date, (modified) julian date, and more.
 .TP
 \fB\-y\fR, \fB\-\-year\fR
 Display a calendar for the whole year.
@@ -92,13 +121,23 @@ Display a calendar for the whole year.
 Display a calendar for the next twelve months.
 .TP
 \fB\-w\fR, \fB\-\-week\fR[=\fInumber\fR]
-Display week numbers in the calendar (US or ISO-8601).
+Display the week number in the left most column of each month.
+If the
+.I number
+argument and only a year parameter are given, then the month containing that
+week will be displayed and its number highlighted.  Otherwise, the week number
+will be highlighted only if its month is displayed.  For example, if the
+.B \-\-year
+option is used.
+.RB See\  \-\-color.
 .TP
 \fB\-\-color\fR[=\fIwhen\fR]
-Colorize the output.  The optional argument \fIwhen\fP
-can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
-see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section.
+Control day/week highlighting.  The optional argument \fIwhen\fP can be
+\fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is
+omitted, it defaults to \fBauto\fR.  Auto means it is on if the output is to a
+terminal, otherwise it is off.   Colors could be disabled; the current built-in
+default is shown in the \fB\-\-help\fR output for this option.  See
+\fBCOLORS\fR below.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
@@ -108,43 +147,51 @@ Display help text and exit.
 .SH PARAMETERS
 .TP
 \fBSingle digits-only parameter (e.g. 'cal 2020')\fR
-Specifies the \fIyear\fR to be displayed; note the year must be fully specified:
+Specifies the year to be displayed and must be greater than 0.  The year must
+be fully specified:
 .B "cal 89"
 will not display a calendar for 1989.
 .TP
 \fBSingle string parameter (e.g. 'cal tomorrow' or 'cal August')\fR
-Specifies \fItimestamp\fR or a \fImonth name\fR (or abbreviated name) according to the current
-locales.
+Can be a timestamp, relative time, month name, or abbreviated month name
+according to the current locale.  String parameters need to be in quotes if
+they contain any spaces.
+.sp
+Timestamps are ISO like, and must be quoted.  For example: \%"2012-09-22\ 16:34:22"
 .sp
-The special placeholders are accepted when parsing timestamp, "now" may be used
-to refer to the current time, "today", "yesterday", "tomorrow" refer to of the
-current day, the day before or the next day, respectively.
+Relative date specifications are also accepted, in this case "+" is evaluated
+to the current time plus the specified time span.  Correspondingly, a time span
+that is prefixed with "-" is evaluated to the current time minus the specified
+time span; it must be preceded by "--" to indicate the end of options, for
+example "-- -2days".  Alternately it may be suffixed with a space and the word
+"ago" (for example "1 week ago").
 .sp
-The relative date specifications are also accepted, in this case "+" is
-evaluated to the current time plus the specified time span. Correspondingly, a
-time span that is prefixed with "-" is evaluated to the current time minus the
-specified time span, for example '+2days'. Instead of prefixing the time span
-with "+" or "-", it may also be suffixed with a space and the word "left" or
-"ago" (for example '1 week ago').
+These special placeholders are accepted: "now", "today", "yesterday", and
+"tomorrow" refer to the current time, current day, the day before, or the next
+day respectively.
 .TP
 \fBTwo parameters (e.g. 'cal 11 2020')\fR
-Denote the \fImonth\fR (1 - 12) and \fIyear\fR.
+Denote the month (1 - 12) and year.
 .TP
 \fBThree parameters (e.g. 'cal 25 11 2020')\fR
-Denote the \fIday\fR (1-31), \fImonth and \fIyear\fR, and the day will be
-highlighted if the calendar is displayed on a terminal.  If no parameters are
-specified, the current month's calendar is displayed.
+Denote the day (1-31), month and year, and the day will be
+highlighted.
+.RB See\  \-\-color.
+.TP
+If no parameters are specified, the current month's calendar is displayed.
 .SH NOTES
 A year starts on January 1.  The first day of the week is determined by the
-locale.
+locale or the
+.BR \-\-sunday \ and \ \-\-monday \ options.
 .PP
-The week numbering depends on the choice of the first day of the week.  If Sunday
-(the default) is used for the first day of the week, then the customary North
-American numbering will be used, i.e. the first Sunday of the year starts the
-first week.  If Monday is selected, then the ISO-8601 standard week numbering
+The week numbering depends on the choice of the first day of the week.  If it
+is Sunday
+(the default) then the customary North
+American numbering is used, where the first Sunday of the year starts the
+first week.  If it is Monday then the ISO 8601 standard week numbering
 is used, where the first Thursday of the year is in week number 1.
 .SH COLORS
-Implicit coloring can be disabled as follows:
+Implicit coloring (highlighting) can be disabled as follows:
 .RS
 
 .br
@@ -158,14 +205,9 @@ for more details about colorization configuration.
 .SH BUGS
 .PP
 .RB The\  \-\-1752-reform
-option uses the 3rd of September 1752 as the date of the Gregorian calendar
-reformation -- that is when it happened in Great Britain and its colonies
-(including what is now the USA).  Starting at that date, eleven days were eliminated
-by this reform, so the calendar for that month is rather unusual.
-The actual historical dates at which the calendar reform happened in all the
-different countries (locales), including its introduction by Pope Gregory XIII
-in October 1582, are ignored. The Gregorian calendar is a refinement to the
-Julian calendar improving its synchronization with solar cycles.
+option uses 3 Sept 1752 as the date of the Gregorian calendar reform -- that is
+when it happened in Britain.  The historical reform  dates for the other locales,
+including its introduction in October 1582, are ignored.
 .PP
 Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
 or the lunisolar Hindu, are not supported.
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index cf05ecda3..df0568c56 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -1024,7 +1024,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [[[day] month] year]\n"), program_invocation_short_name);
-	fprintf(out, _(" %s [options] <timestamp|monthname>\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] [timestamp|month_name]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Display a calendar, or some part of it.\n"), out);
@@ -1037,12 +1037,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -S, --span            span the date when displaying multiple months\n"), out);
 	fputs(_(" -s, --sunday          Sunday as first day of week\n"), out);
 	fputs(_(" -m, --monday          Monday as first day of week\n"), out);
-	fputs(_(" -j, --julian          output Julian dates\n"), out);
+	fputs(_(" -j, --julian          use day-of-year for all calendar types\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
 	fputs(_("     --1752-reform     use Chesterfield's Act format\n"), out);
-	fputs(_("     --color[=<when>]  colorize messages (auto, always or never)\n"), out);
+	fputs(_("     --color[=<when>]  date highlighting (auto, always or never)\n"), out);
 	fprintf(out,
 	        "                         %s\n", USAGE_COLORS_DEFAULT);
 
