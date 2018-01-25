Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbeAYAvz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 19:51:55 -0500
Subject: [PATCH 1/4] cal: always include the year in the month header
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Date: Wed, 24 Jan 2018 19:51:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Most of cal's output has the year in the month header. The
exception is when a full year is output, which then has a top
header containing the year.

There is a bug when using --span with --year, --Year, or with
only a year for the date parameter; then months for multiple
years are output and only one year is displayed at the top.

These are all broken:
 cal -Sy 2020
 cal -SY 2020
 cal -S 2020
 cal -3 2020 (this is broken in the current release because it
	      too sets --span, but still displays 12 months)

The top header typically scrolls off the screen for a full
year output anyway. So it is convenient to have the year
included in each month.

To fix these issues and to make cal's output consistent,
always display the year in the month header.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 562ae2afb..8dea2c459 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -705,17 +705,16 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 	char out[FMT_ST_CHARS];
 	struct cal_month *i;
 
-	if (ctl->header_hint || ctl->header_year) {
+	if (ctl->header_hint) {
 		for (i = month; i; i = i->next) {
 			sprintf(out, _("%s"), ctl->full_month[i->month - 1]);
 			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
-		if (!ctl->header_year) {
-			my_putstring("\n");
-			for (i = month; i; i = i->next) {
-				sprintf(out, _("%04d"), i->year);
-				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
-			}
+		my_putstring("\n");
+		for (i = month; i; i = i->next) {
+			sprintf(out, _("%04d"), i->year);
+			center(out, ctl->week_width - 1,
+			       i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	} else {
 		for (i = month; i; i = i->next) {
