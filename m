Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:41463 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3D1RL1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:27 -0400
Received: by mail-we0-f169.google.com with SMTP id p43so5053445wea.28
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/11] cal: simplify calendar reformat calculations
Date: Sun, 28 Apr 2013 18:11:01 +0100
Message-Id: <1367169067-23705-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The only September 1752 offset calculation that is necessary is whether
Sun or Mon is the first day of the week.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index f0d97af..8afa322 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -201,27 +201,16 @@ static int days_in_month[2][13] = {
 	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
 };
 
-#define SEP1752_OFS		4		/* sep1752[4] is a Sunday */
-
-/* 1 Sep 1752 is represented by sep1752[6] and j_sep1752[6] */
-int sep1752[MAXDAYS+6] = {
-				SPACE,	SPACE,	SPACE,	SPACE,
+/* September 1752 is special, and has static assignments for both date
+ * and Julian representations.  */
+ int d_sep1752[MAXDAYS / 2] = {
 	SPACE,	SPACE,	1,	2,	14,	15,	16,
 	17,	18,	19,	20,	21,	22,	23,
-	24,	25,	26,	27,	28,	29,	30,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE
-}, j_sep1752[MAXDAYS+6] = {
-				SPACE,	SPACE,	SPACE,	SPACE,
+	24,	25,	26,	27,	28,	29,	30
+}, j_sep1752[MAXDAYS / 2] = {
 	SPACE,	SPACE,	245,	246,	258,	259,	260,
 	261,	262,	263,	264,	265,	266,	267,
-	268,	269,	270,	271,	272,	273,	274,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
-	SPACE,	SPACE
+	268,	269,	270,	271,	272,	273,	274
 }, empty[MAXDAYS] = {
 	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
 	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,	SPACE,
@@ -671,18 +660,18 @@ yearly(int day, int year) {
 void
 day_array(int day, int month, int year, int *days) {
 	int julday, daynum, dw, dm;
-	int *d_sep1752;
-
-	if (month == REFORMATION_MONTH && year == REFORMATION_YEAR) {
-		int sep1752_ofs = (weekstart + SEP1752_OFS) % 7;
-		d_sep1752 = julian ? j_sep1752 : sep1752;
-		memcpy(days, d_sep1752 + sep1752_ofs, MAXDAYS * sizeof(int));
-		for (dm=0; dm<MAXDAYS; dm++)
-			if (j_sep1752[dm + sep1752_ofs] == day)
+	int *sep1752;
+
+	memcpy(days, empty, MAXDAYS * sizeof(int));
+	if (year == REFORMATION_YEAR && month == REFORMATION_MONTH) {
+		sep1752 = julian ? j_sep1752 : d_sep1752;
+		memcpy(days, sep1752 + weekstart,
+		       ((MAXDAYS / 2) - weekstart) * sizeof(int));
+		for (dm = 0; dm < MAXDAYS / 2; dm++)
+			if (j_sep1752[dm] == day)
 				days[dm] |= TODAY_FLAG;
 		return;
 	}
-	memcpy(days, empty, MAXDAYS * sizeof(int));
 	dm = days_in_month[leap_year(year)][month];
 	dw = (day_in_week(1, month, year) - weekstart + DAYS_IN_WEEK) % DAYS_IN_WEEK;
 	julday = day_in_year(1, month, year);
-- 
1.8.2.2

