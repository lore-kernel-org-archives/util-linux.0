Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 4/4] cal: new option toggles the calendar system header
To: Karel Zak <kzak@redhat.com>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
 <875bde54-8488-1a3d-5edc-f64f553ce228@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a846dfd3-950c-1616-7cdf-03395aef5c0d@gmx.com>
Date: Fri, 26 Jan 2018 19:26:40 -0500
MIME-Version: 1.0
In-Reply-To: <875bde54-8488-1a3d-5edc-f64f553ce228@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Add an option that toggles displaying of the new calendar
system header.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

v2 changelog
 Changed the new option to a boolean. This allows overriding
 an alias configuration and makes it easy for Karel to choose
 what the default should be.

 misc-utils/cal.1 |  5 +++++
 misc-utils/cal.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 95d1a255b..8e6c5e7e3 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -147,6 +147,11 @@ calendar output uses the Julian calendar system.
 .RB See\  \%DESCRIPTION\  above.
 .RE
 .TP
+.BR \-\-top-header\ on | off
+Toggle displaying of the calendar system header (default on).
+.br
+.RB See\  DESCRIPTION\  above.
+.TP
 \fB\-y\fR, \fB\-\-year\fR
 Display a calendar for the whole year.
 .TP
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2551cd20d..acca40b0d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -223,6 +223,7 @@ struct cal_control {
 	size_t day_width;		/* day width in characters in printout */
 	size_t week_width;		/* 7 * day_width + possible week num */
 	int gutter_width;		/* spaces in between horizontal month outputs */
+	int top_header;			/* display the calendar system header */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
 			header_hint:1;	/* does month name + year need two lines to fit */
@@ -265,6 +266,7 @@ int main(int argc, char **argv)
 	int ch = 0, yflag = 0, Yflag = 0;
 
 	static struct cal_control ctl = {
+		.top_header = 1,
 		.reform_year = DEFAULT_REFORM_YEAR,
 		.weekstart = SUNDAY,
 		.span_months = 0,
@@ -279,7 +281,8 @@ int main(int argc, char **argv)
 	enum {
 		OPT_COLOR = CHAR_MAX + 1,
 		OPT_ISO,
-		OPT_REFORM
+		OPT_REFORM,
+		OPT_TOP_HEADER
 	};
 
 	static const struct option longopts[] = {
@@ -295,6 +298,7 @@ int main(int argc, char **argv)
 		{"color", optional_argument, NULL, OPT_COLOR},
 		{"reform", required_argument, NULL, OPT_REFORM},
 		{"iso", no_argument, NULL, OPT_ISO},
+		{"top-header", required_argument, NULL, OPT_TOP_HEADER},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -412,6 +416,12 @@ int main(int argc, char **argv)
 		case OPT_ISO:
 			ctl.reform_year = ISO;
 			break;
+		case OPT_TOP_HEADER:
+			ctl.top_header =
+				parse_switch(optarg,
+					    _("invalid --top-header argument"),
+					     "on", "off",  "1", "0", NULL);
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -551,7 +561,8 @@ int main(int argc, char **argv)
 	if (!ctl.num_months)
 		ctl.num_months = 1;		/* display at least one month */
 
-	top_header(&ctl);
+	if (ctl.top_header)
+		top_header(&ctl);
 	months(&ctl);
 
 	return EXIT_SUCCESS;
@@ -1135,6 +1146,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -j, --julian          use day-of-year for all calendars\n"), out);
 	fputs(_("     --reform <val>    Gregorian reform date (1752|gregorian|iso|julian)\n"), out);
 	fputs(_("     --iso             alias for --reform=iso\n"), out);
+	fputs(_("     --top-header <on|off>\n"
+		"                       toggle the calendar system header\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
