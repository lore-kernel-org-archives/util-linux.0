Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:55870 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbaE0NHI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 09:07:08 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>
Subject: [PATCH] cal: all output must use my_putstring
Date: Tue, 27 May 2014 15:07:05 +0200
Message-Id: <1401196025-7090-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201405271250.41256.sweet_f_a@gmx.de>
References: <201405271250.41256.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Replace all puts, fputs and printf calls by my_putstring() because
we don't want to mix different output channels (buffers).

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/cal.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 81375fe..e763fe1 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -609,7 +609,7 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 		if (!ctl->yflag) {
-			fputs("\n", stdout);
+			my_putstring("\n");
 			for (i = month; i; i = i->next) {
 				sprintf(out, _("%d"), i->year);
 				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
@@ -621,23 +621,27 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	}
-	puts("");
+	my_putstring("\n");
 	for (i = month; i; i = i->next) {
 		if (ctl->weektype) {
 			if (ctl->julian)
-				printf("%*s%s", (int)ctl->day_width - 1, "", day_headings);
+				sprintf(out, "%*s%s", (int)ctl->day_width - 1, "", day_headings);
 			else
-				printf("%*s%s", (int)ctl->day_width, "", day_headings);
+				sprintf(out, "%*s%s", (int)ctl->day_width, "", day_headings);
+			my_putstring(out);
 		} else
-			fputs(day_headings, stdout);
-		if (i->next != NULL)
-			printf("%*s", ctl->gutter_width, "");
+			my_putstring(day_headings);
+		if (i->next != NULL) {
+			sprintf(out, "%*s", ctl->gutter_width, "");
+			my_putstring(out);
+		}
 	}
-	puts("");
+	my_putstring("\n");
 }
 
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl)
 {
+	char out[FMT_ST_CHARS];
 	int reqday, week_line, d;
 	int skip;
 	struct cal_month *i;
@@ -659,12 +663,13 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 				if (0 < i->weeks[week_line]) {
 					if ((ctl->weektype & WEEK_NUM_MASK) ==
 					    i->weeks[week_line])
-						printf("%s%2d%s", Senter, i->weeks[week_line],
+						sprintf(out, "%s%2d%s", Senter, i->weeks[week_line],
 						       Sexit);
 					else
-						printf("%2d", i->weeks[week_line]);
+						sprintf(out, "%2d", i->weeks[week_line]);
 				} else
-					printf("%2s", "");
+					sprintf(out, "%2s", "");
+				my_putstring(out);
 				skip = ctl->day_width;
 			} else
 				/* First day of the week is one char narrower than the other days,
@@ -675,21 +680,26 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 			     d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
 				if (0 < i->days[d]) {
 					if (reqday == i->days[d])
-						printf("%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
+						sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
 						       "", Senter, (ctl->julian ? 3 : 2),
 						       i->days[d], Sexit);
 					else
-						printf("%*d", skip, i->days[d]);
+						sprintf(out, "%*d", skip, i->days[d]);
 				} else
-					printf("%*s", skip, "");
+					sprintf(out, "%*s", skip, "");
+				my_putstring(out);
 				if (skip < (int)ctl->day_width)
 					skip++;
 			}
-			if (i->next != NULL)
-				printf("%*s", ctl->gutter_width, "");
+			if (i->next != NULL) {
+				sprintf(out, "%*s", ctl->gutter_width, "");
+				my_putstring(out);
+			}
+		}
+		if (i == NULL) {
+			sprintf(out, "%*s\n", ctl->gutter_width - (ctl->yflag ? 0 : 1), "");
+			my_putstring(out);
 		}
-		if (i == NULL)
-			printf("%*s\n", ctl->gutter_width - (ctl->yflag ? 0 : 1), "");
 	}
 }
 
@@ -754,7 +764,7 @@ static void yearly(const struct cal_control *ctl)
 		year_width--;
 	sprintf(out, "%d", ctl->req.year);
 	center(out, year_width, 0);
-	fputs("\n\n", stdout);
+	my_putstring("\n\n");
 
 	for (month = 1; month < MONTHS_IN_YEAR; month += ctl->julian ? 2 : 3) {
 		set_consecutive_months(&m1, month, ctl->req.year);
@@ -764,7 +774,7 @@ static void yearly(const struct cal_control *ctl)
 		cal_output_months(&m1, ctl);
 	}
 	/* Is empty line at the end year output really needed? */
-	puts("");
+	my_putstring("\n");
 }
 
 /*
-- 
1.8.4.5

