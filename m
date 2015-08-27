Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38218 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbH0NVf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2015 09:21:35 -0400
Received: by wicgk12 with SMTP id gk12so9233185wic.1
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2015 06:21:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] cal: correct gregorian week numbering
Date: Thu, 27 Aug 2015 14:21:26 +0100
Message-Id: <1440681689-2708-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
References: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Jan 1 is always First week, and year always has 53 weeks.  The week 53
may be cut short, e.g., it may and often has fewer than 7 days.  Every
year 28 year intervals US week numbering continues all the way to 54th
week, such as 1972, 2000, and 2028.

Addresses: https://bugzilla.redhat.com/show_bug.cgi?id=1249486
Reported-by: Michal Toth
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 548e567..98ce431 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -390,8 +390,8 @@ int main(int argc, char **argv)
 			if (optarg) {
 				ctl.req.week = strtos32_or_err(optarg,
 						_("invalid week argument"));
-				if (ctl.req.week < 1 || 53 < ctl.req.week)
-					errx(EXIT_FAILURE,_("illegal week value: use 1-53"));
+				if (ctl.req.week < 1 || 54 < ctl.req.week)
+					errx(EXIT_FAILURE,_("illegal week value: use 1-54"));
 			}
 			ctl.weektype = WEEK_NUM_US;	/* default per weekstart */
 			break;
@@ -604,15 +604,13 @@ static void cal_fill_month(struct cal_month *month, const struct cal_control *ct
 		int weeknum = week_number(1, month->month, month->year, ctl);
 		weeklines = MAXDAYS / DAYS_IN_WEEK - weeklines / DAYS_IN_WEEK;
 		for (i = 0; i < MAXDAYS / DAYS_IN_WEEK; i++) {
-			if (0 < weeklines)
+			if (0 < weeklines) {
+				if (52 < weeknum)
+					weeknum = week_number(month->days[i * DAYS_IN_WEEK], month->month, month->year, ctl);
 				month->weeks[i] = weeknum++;
-			else
+			} else
 				month->weeks[i] = SPACE;
 			weeklines--;
-			if (i == 0 && (52 < weeknum || (month->year == 1753 && 51 < weeknum)))
-				weeknum = week_number(month->days[DAYS_IN_WEEK * (i + 1)], 1, month->year, ctl);
-			else if (52 < weeknum)
-				weeknum = week_number(31, 12, month->year, ctl);
 		}
 	}
 }
@@ -839,7 +837,7 @@ static int day_in_week(int day, int month, int32_t year)
 
 /*
  * week_number
- *      return the week number of a given date, 1..53.
+ *      return the week number of a given date, 1..54.
  *      Supports ISO-8601 and North American modes.
  *      Day may be given as Julian day of the year mode, in which
  *      case the month is disregarded entirely.
@@ -847,17 +845,16 @@ static int day_in_week(int day, int month, int32_t year)
 static int week_number(int day, int month, int32_t year, const struct cal_control *ctl)
 {
 	int fday = 0, yday;
-	int wday = day_in_week(1, 1, year);
+	const int wday = day_in_week(1, 1, year);
 
 	if (ctl->weektype & WEEK_NUM_ISO)
 		fday = wday + (wday >= FRIDAY ? -2 : 5);
-	else
-		/* WEEK_NUM_US
-		 * - according to gcal, the first Sun is in the first week
-		 * - according to wikipedia, the first Sat is in the first week
-		 */
-		fday = wday + (wday == SUNDAY ? 6 : -1);
-
+	else {
+		/* WEEK_NUM_US: Jan 1 is always First week, that may
+		 * begin previous year.  That means there is very seldom
+		 * more than 52 weeks, */
+		fday = wday + 6;
+	}
 	/* For julian dates the month can be set to 1, the global julian
 	 * variable cannot be relied upon here, because we may recurse
 	 * internally for 31.12. which would not work. */
@@ -882,7 +879,7 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 	    && day_in_week(day, month, year) <= WEDNESDAY
 	    && day_in_week(31, 12, year) >= MONDAY
 	    && day_in_week(31, 12, year) <= WEDNESDAY)
-		return  week_number(1, 1, year + 1, ctl);
+		return week_number(1, 1, year + 1, ctl);
 
 	return (yday + fday) / 7;
 }
-- 
2.5.0

