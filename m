Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751426AbeABPBY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 10:01:24 -0500
Subject: [v3 PATCH 09/11] cal: remove the non-functional options
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <51f9ef72-3a18-c3ab-889b-22cdf5e141c3@gmx.com>
Date: Tue, 2 Jan 2018 10:01:23 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--one and --sunday are the default behavior making
the options no-op.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 24 +++++++++---------------
 misc-utils/cal.c | 19 ++++---------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 718a38c98..23e21c3a5 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -80,9 +80,6 @@ Julian calendar dates.
 
 .SH OPTIONS
 .TP
-\fB\-1\fR, \fB\-\-one\fR
-Display single month output (default).
-.TP
 \fB\-3\fR, \fB\-\-three\fR
 Display three months spanning the date.
 .TP
@@ -108,11 +105,8 @@ Display \fInumber\fR of months, starting from the month containing the date.
 \fB\-S, \fB\-\-span\fR
 Span the date when displaying multiple months.
 .TP
-\fB\-s\fR, \fB\-\-sunday\fR
-Display Sunday as the first day of the week.
-.TP
 \fB\-m\fR, \fB\-\-monday\fR
-Display Monday as the first day of the week.
+Display Monday as the first day of the week (Sunday is default).
 .TP
 \fB\-j\fR, \fB\-\-julian\fR
 .RB Use\  \-\-ordinal .
@@ -189,16 +183,16 @@ highlighted.
 .TP
 If no parameters are specified, the current month's calendar is displayed.
 .SH NOTES
-A year starts on January 1.  The first day of the week is determined by the
-locale or the
-.BR \-\-sunday \ and \ \-\-monday \ options.
+A year starts on January 1.  The first day of the week is determined either by
+the locale, the
+.BR \-\-monday \ option,
+or defaults to Sunday.
 .PP
 The week numbering depends on the choice of the first day of the week.  If it
-is Sunday
-(the default) then the customary North
-American numbering is used, where the first Sunday of the year starts the
-first week.  If it is Monday then the ISO 8601 standard week numbering
-is used, where the first Thursday of the year is in week number 1.
+is Sunday (the default) then the customary North American numbering is used,
+where the first Sunday of the year starts the first week.  If it is Monday then
+the ISO 8601 standard week numbering is used, where the first Thursday of the
+year is in week number 1.
 .SH COLORS
 Implicit coloring (highlighting) can be disabled as follows:
 .RS
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 6f7dadfac..0756f922f 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -257,8 +257,8 @@ int main(int argc, char **argv)
 
 	static struct cal_control ctl = {
 		.reform_year = -1,		/* def. proleptic Gregorian */
-		.weekstart = SUNDAY,
-		.num_months = 1,		/* default is "cal -1" */
+		.weekstart = SUNDAY,		/* default */
+		.num_months = 1,		/* default */
 		.span_months = 0,
 		.colormode = UL_COLORMODE_UNDEF,
 		.weektype = WEEK_NUM_DISABLED,
@@ -277,9 +277,7 @@ int main(int argc, char **argv)
 	};
 
 	static const struct option longopts[] = {
-		{"one", no_argument, NULL, '1'},
 		{"three", no_argument, NULL, '3'},
-		{"sunday", no_argument, NULL, 's'},
 		{"monday", no_argument, NULL, 'm'},
 		{"julian", no_argument, NULL, 'j'},
 		{"months", required_argument, NULL, 'n'},
@@ -297,8 +295,7 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
-		{ '1', '3', 'Y', 'n', 'y' },
-		{ 'm', 's' },
+		{ '3', 'Y', 'n', 'y' },
 		{ 'r', OPT_CAESAR },
 		{ 0 }
 	};
@@ -353,23 +350,17 @@ int main(int argc, char **argv)
 		ctl.weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
-	while ((ch = getopt_long(argc, argv, "13jL::mn:orsSyw::YVh",
+	while ((ch = getopt_long(argc, argv, "3jL::mn:orSyw::YVh",
 				 longopts, NULL)) != -1) {
 
 		err_exclusive_options(ch, longopts, excl, excl_st);
 
 		switch(ch) {
-		case '1':
-			/* default */
-			break;
 		case '3':
 			ctl.num_months = 3;
 			ctl.span_months = 1;
 			ctl.months_in_row = 3;
 			break;
-		case 's':
-			ctl.weekstart = SUNDAY;		/* default */
-			break;
 		case 'm':
 			ctl.weekstart = MONDAY;
 			break;
@@ -1047,11 +1038,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Without any arguments, display the current month.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -1, --one             show only a single month (default)\n"), out);
 	fputs(_(" -3, --three           show three months spanning the date\n"), out);
 	fputs(_(" -n, --months <num>    show num months starting with date's month\n"), out);
 	fputs(_(" -S, --span            span the date when displaying multiple months\n"), out);
-	fputs(_(" -s, --sunday          Sunday as first day of week\n"), out);
 	fputs(_(" -m, --monday          Monday as first day of week\n"), out);
 	fputs(_(" -o  --ordinal         use day-of-year for all calendar types\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
