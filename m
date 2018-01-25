Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/4] cal: new option to drop the calendar system header
To: Karel Zak <kzak@redhat.com>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <875bde54-8488-1a3d-5edc-f64f553ce228@gmx.com>
Date: Wed, 24 Jan 2018 20:03:26 -0500
MIME-Version: 1.0
In-Reply-To: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Add an option to not display the new calendar system header.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 |  5 +++++
 misc-utils/cal.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 95d1a255b..d5562c691 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -80,6 +80,11 @@ Display single month output.
 \fB\-3\fR, \fB\-\-three\fR
 Display three months spanning the date.
 .TP
+.B \-\-drop-header
+Do not display the calendar system header.
+.br
+.RB See\  \%DESCRIPTION\  above.
+.TP
 \fB\-n , \-\-months\fR \fInumber\fR
 Display \fInumber\fR of months, starting from the month containing the date.
 .TP
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2551cd20d..49e2968a8 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -223,6 +223,7 @@ struct cal_control {
 	size_t day_width;		/* day width in characters in printout */
 	size_t week_width;		/* 7 * day_width + possible week num */
 	int gutter_width;		/* spaces in between horizontal month outputs */
+	int drop_header;		/* don't display calendar system header */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
 			header_hint:1;	/* does month name + year need two lines to fit */
@@ -278,6 +279,7 @@ int main(int argc, char **argv)
 
 	enum {
 		OPT_COLOR = CHAR_MAX + 1,
+		OPT_DROP_HEADER,
 		OPT_ISO,
 		OPT_REFORM
 	};
@@ -295,6 +297,7 @@ int main(int argc, char **argv)
 		{"color", optional_argument, NULL, OPT_COLOR},
 		{"reform", required_argument, NULL, OPT_REFORM},
 		{"iso", no_argument, NULL, OPT_ISO},
+		{"drop-header", no_argument, NULL, OPT_DROP_HEADER},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -412,6 +415,9 @@ int main(int argc, char **argv)
 		case OPT_ISO:
 			ctl.reform_year = ISO;
 			break;
+		case OPT_DROP_HEADER:
+			ctl.drop_header = 1;;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -551,7 +557,8 @@ int main(int argc, char **argv)
 	if (!ctl.num_months)
 		ctl.num_months = 1;		/* display at least one month */
 
-	top_header(&ctl);
+	if (!ctl.drop_header)
+		top_header(&ctl);
 	months(&ctl);
 
 	return EXIT_SUCCESS;
@@ -1135,6 +1142,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -j, --julian          use day-of-year for all calendars\n"), out);
 	fputs(_("     --reform <val>    Gregorian reform date (1752|gregorian|iso|julian)\n"), out);
 	fputs(_("     --iso             alias for --reform=iso\n"), out);
+	fputs(_("     --drop-header     do not display the calendar system header\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
