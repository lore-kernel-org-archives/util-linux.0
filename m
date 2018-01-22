Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/2] cal: honor num_months when only a year argument
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
Date: Mon, 22 Jan 2018 15:05:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


I don't know if this was an oversight or an overzealous
interpretation of POSIX. Just in case, I'll address the
POSIX possibility. POSIX description for cal(1) says:

  If only the year operand is given, cal shall produce a
  calendar for all twelve months in the given calendar year.

It also says that cal(1) has no options, so in that context
if an option is given then it should be expected to override
POSIX behavior.

Before patched all of these command displayed a full year:
cal -1 2020
cal -3 2020
cal -n6 2020

Patched the number of months options are honored.

This patch also fixes the -1 option which was a no-op.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 5a6364a27..8a715d94c 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -267,7 +267,6 @@ int main(int argc, char **argv)
 	static struct cal_control ctl = {
 		.reform_year = DEFAULT_REFORM_YEAR,
 		.weekstart = SUNDAY,
-		.num_months = 1,		/* default is "cal -1" */
 		.span_months = 0,
 		.colormode = UL_COLORMODE_UNDEF,
 		.weektype = WEEK_NUM_DISABLED,
@@ -363,7 +362,7 @@ int main(int argc, char **argv)
 
 		switch(ch) {
 		case '1':
-			/* default */
+			ctl.num_months = 1;
 			break;
 		case '3':
 			ctl.num_months = 3;
@@ -536,7 +535,8 @@ int main(int argc, char **argv)
 
 	if (yflag || Yflag) {
 		ctl.gutter_width = 3;
-		ctl.num_months = MONTHS_IN_YEAR;
+		if (!ctl.num_months)
+			ctl.num_months = MONTHS_IN_YEAR;
 		if (yflag) {
 			ctl.req.start_month = 1;	/* start from Jan */
 			ctl.header_year = 1;		/* print year number */
@@ -549,6 +549,9 @@ int main(int argc, char **argv)
 	else if (!ctl.months_in_row)
 		ctl.months_in_row = 1;
 
+	if (!ctl.num_months)
+		ctl.num_months = 1;		/* display at least one month */
+
 	if (yflag || Yflag)
 		yearly(&ctl);
 	else
