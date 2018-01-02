Return-Path: elseifthen@gmx.com
Subject: [v3 PATCH 08/11] cal: add short versions of new options
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8e1ef094-5a6f-c4bb-5b72-dcad72c0bcbb@gmx.com>
Date: Tue, 2 Jan 2018 10:00:41 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Also, the project uses 'L' for --color so that
was added.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 |  6 +++---
 misc-utils/cal.c | 28 +++++++++++++---------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 17439d2f9..718a38c98 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -86,7 +86,7 @@ Display single month output (default).
 \fB\-3\fR, \fB\-\-three\fR
 Display three months spanning the date.
 .TP
-.B \-\-1752-reform
+.BR \-r ,\  \-\-1752-reform
 Display calendars based upon the Chesterfield's Act.
 This means that dates previous to 3 Sept 1752 will be Julian calendar dates.
 .RB See \ BUGS \ below.
@@ -119,7 +119,7 @@ Display Monday as the first day of the week.
 .RB The\  \%\-\-julian\  option
 has been deprecated and may be repurposed or removed in a future release.
 .TP
-.B \-\-ordinal
+.BR \-o ,\  \-\-ordinal
 Display day-of-year numbering for all calendar types.  Ordinal days range from
 1 to 366.
 .TP
@@ -140,7 +140,7 @@ will be highlighted only if its month is displayed.  For example, if the
 option is used.
 .RB See\  \-\-color.
 .TP
-\fB\-\-color\fR[=\fIwhen\fR]
+\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]
 Control day/week highlighting.  The optional argument \fIwhen\fP can be
 \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is
 omitted, it defaults to \fBauto\fR.  Auto means it is on if the output is to a
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 00c00ebc0..6f7dadfac 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -273,10 +273,7 @@ int main(int argc, char **argv)
 	 * will be renamed -j, --julian and made public.
 	 */
 	enum {
-		OPT_1752_REFORM = CHAR_MAX + 1,
-		OPT_CAESAR,
-		OPT_COLOR,
-		OPT_ORDINAL
+		OPT_CAESAR = CHAR_MAX + 1
 	};
 
 	static const struct option longopts[] = {
@@ -289,10 +286,10 @@ int main(int argc, char **argv)
 		{"span", no_argument, NULL, 'S'},
 		{"year", no_argument, NULL, 'y'},
 		{"week", optional_argument, NULL, 'w'},
-		{"color", optional_argument, NULL, OPT_COLOR},
-		{"ordinal", no_argument, NULL, OPT_ORDINAL},
+		{"color", optional_argument, NULL, 'L'},
+		{"ordinal", no_argument, NULL, 'o'},
 		{"caesar", no_argument, NULL, OPT_CAESAR},
-		{"1752-reform", no_argument, NULL, OPT_1752_REFORM},
+		{"1752-reform", no_argument, NULL, 'r'},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -302,7 +299,7 @@ int main(int argc, char **argv)
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ '1', '3', 'Y', 'n', 'y' },
 		{ 'm', 's' },
-		{ OPT_1752_REFORM, OPT_CAESAR },
+		{ 'r', OPT_CAESAR },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -356,7 +353,8 @@ int main(int argc, char **argv)
 		ctl.weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
-	while ((ch = getopt_long(argc, argv, "13mjn:sSyw::YVh", longopts, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "13jL::mn:orsSyw::YVh",
+				 longopts, NULL)) != -1) {
 
 		err_exclusive_options(ch, longopts, excl, excl_st);
 
@@ -379,7 +377,7 @@ int main(int argc, char **argv)
 			errx(EXIT_FAILURE,
 			    _("use --ordinal, --julian has been deprecated."));
 			break;
-		case OPT_ORDINAL:
+		case 'o':
 			ctl.ordinal = 1;
 			ctl.day_width = DAY_LEN + 1;
 			break;
@@ -405,13 +403,13 @@ int main(int argc, char **argv)
 			}
 			ctl.weektype = WEEK_NUM_US;	/* default per weekstart */
 			break;
-		case OPT_COLOR:
+		case 'L':
 			ctl.colormode = UL_COLORMODE_AUTO;
 			if (optarg)
 				ctl.colormode = colormode_or_err(optarg,
 						_("unsupported color mode"));
 			break;
-		case OPT_1752_REFORM:
+		case 'r':
 			ctl.reform_year = 1752;
 			break;
 		case OPT_CAESAR:
@@ -1055,12 +1053,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -S, --span            span the date when displaying multiple months\n"), out);
 	fputs(_(" -s, --sunday          Sunday as first day of week\n"), out);
 	fputs(_(" -m, --monday          Monday as first day of week\n"), out);
-	fputs(_("     --ordinal         use day-of-year for all calendar types\n"), out);
+	fputs(_(" -o  --ordinal         use day-of-year for all calendar types\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
-	fputs(_("     --1752-reform     use Chesterfield's Act format\n"), out);
-	fputs(_("     --color[=<when>]  date highlighting (auto, always or never)\n"), out);
+	fputs(_(" -r  --1752-reform     use Chesterfield's Act format\n"), out);
+	fputs(_(" -L  --color[=<when>]  date highlighting (auto, always or never)\n"), out);
 	fprintf(out,
 	        "                         %s\n", USAGE_COLORS_DEFAULT);
 
