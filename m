Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57540 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeAPVlk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Jan 2018 16:41:40 -0500
Subject: [v5 PATCH 2/3] cal: add option to set Gregorian reform date
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
 <20180115133622.v4wbionunsjj7bmy@ws.net.home>
 <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <faff0cac-fb47-1926-3ef0-dba6907f47d7@gmx.com>
Date: Tue, 16 Jan 2018 16:41:10 -0500
MIME-Version: 1.0
In-Reply-To: <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Create the new option: --reform <1752|gregorian|iso|julian>

This adds the capability to display either the proleptic Gregorian or
the Julian calendar systems exclusively.

Also create the option --iso as alias of --reform=gregorian.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index ea582964c..543fbc6e1 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -133,6 +133,14 @@ static const char *my_tgetstr(char *ss
 
 #include "widechar.h"
 
+enum {
+	GREGORIAN		= INT32_MIN,
+	ISO			= INT32_MIN,
+	GB1752			= 1752,
+	DEFAULT_REFORM_YEAR	= 1752,
+	JULIAN			= INT32_MAX
+};
+
 enum {
 	SUNDAY = 0,
 	MONDAY,
@@ -246,6 +254,7 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 static int week_to_day(const struct cal_control *ctl);
 static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
 static void center(const char *str, size_t len, int separate);
+static int parse_reform_year(const char *reform_year);
 static void __attribute__((__noreturn__)) usage(void);
 
 int main(int argc, char **argv)
@@ -256,7 +265,7 @@ int main(int argc, char **argv)
 	int ch = 0, yflag = 0, Yflag = 0;
 
 	static struct cal_control ctl = {
-		.reform_year = 1752,
+		.reform_year = DEFAULT_REFORM_YEAR,
 		.weekstart = SUNDAY,
 		.num_months = 1,		/* default is "cal -1" */
 		.span_months = 0,
@@ -269,7 +278,9 @@ int main(int argc, char **argv)
 	};
 
 	enum {
-		OPT_COLOR = CHAR_MAX + 1
+		OPT_COLOR = CHAR_MAX + 1,
+		OPT_ISO,
+		OPT_REFORM
 	};
 
 	static const struct option longopts[] = {
@@ -283,6 +294,8 @@ int main(int argc, char **argv)
 		{"year", no_argument, NULL, 'y'},
 		{"week", optional_argument, NULL, 'w'},
 		{"color", optional_argument, NULL, OPT_COLOR},
+		{"reform", required_argument, NULL, OPT_REFORM},
+		{"iso", no_argument, NULL, OPT_ISO},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
 		{"help", no_argument, NULL, 'h'},
@@ -395,6 +408,12 @@ int main(int argc, char **argv)
 				ctl.colormode = colormode_or_err(optarg,
 						_("unsupported color mode"));
 			break;
+		case OPT_REFORM:
+			ctl.reform_year = parse_reform_year(optarg);
+			break;
+		case OPT_ISO:
+			ctl.reform_year = ISO;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -453,7 +472,7 @@ int main(int argc, char **argv)
 		ctl.req.year = strtos32_or_err(*argv++, _("illegal year value"));
 		if (ctl.req.year < SMALLEST_YEAR)
 			errx(EXIT_FAILURE, _("illegal year value: use positive integer"));
-		if (ctl.req.year == INT32_MAX)
+		if (ctl.req.year == JULIAN)
 			errx(EXIT_FAILURE, _("illegal year value"));
 		if (ctl.req.day) {
 			int dm = days_in_month[leap_year(&ctl, ctl.req.year)]
@@ -1012,6 +1031,30 @@ static void center(const char *str, size_t len, int separate)
 	}
 }
 
+static int parse_reform_year(const char *reform_year)
+{
+	size_t i;
+
+	struct reform {
+		char *name;
+		int val;
+	};
+
+	struct reform years[] = {
+	{"gregorian",	GREGORIAN},
+	{"iso",		ISO},
+	{"1752",	GB1752},
+	{"julian",	JULIAN},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(years); i++) {
+		if (strcasecmp(reform_year, years[i].name) == 0) {
+			return years[i].val;
+		}
+	}
+	errx(EXIT_FAILURE, "invalid --reform value: '%s'", reform_year);
+}
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
@@ -1030,7 +1073,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -S, --span            span the date when displaying multiple months\n"), out);
 	fputs(_(" -s, --sunday          Sunday as first day of week\n"), out);
 	fputs(_(" -m, --monday          Monday as first day of week\n"), out);
-	fputs(_(" -j, --julian          output Julian dates\n"), out);
+	fputs(_(" -j, --julian          use day-of-year for all calendars\n"), out);
+	fputs(_("     --reform <val>    Gregorian reform date (1752|gregorian|iso|julian)\n"), out);
+	fputs(_("     --iso             alias for --reform=iso\n"), out);
 	fputs(_(" -y, --year            show the whole year\n"), out);
 	fputs(_(" -Y, --twelve          show the next twelve months\n"), out);
 	fputs(_(" -w, --week[=<num>]    show US or ISO-8601 week numbers\n"), out);
