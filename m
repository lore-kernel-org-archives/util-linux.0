Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38348 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbbH0NVm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2015 09:21:42 -0400
Received: by wicgk12 with SMTP id gk12so9236372wic.1
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2015 06:21:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] cal: check biggest week number correctly when highlighting
Date: Thu, 27 Aug 2015 14:21:29 +0100
Message-Id: <1440681689-2708-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
References: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows Sunday based week 54 be highlighted, and deny week 54 for
Monday based weeks when year has only 52 weeks.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c           |  2 +-
 tests/expected/cal/weekarg | 20 ++++++++++++++++++++
 tests/ts/cal/weekarg       | 26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index dd26532..6faac5c 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -484,7 +484,7 @@ int main(int argc, char **argv)
 					ctl.req.year, ctl.req.week);
 		while (m <= DECEMBER && yday > days_in_month[leap][m])
 			yday -= days_in_month[leap][m++];
-		if (m > DECEMBER) {
+		if (DECEMBER < m && ctl.weektype & WEEK_NUM_ISO) {
 			/* In some years (e.g. 2010 in ISO mode) it's possible
 			 * to have a remnant of week 53 starting the year yet
 			 * the year in question ends during 52, in this case
diff --git a/tests/expected/cal/weekarg b/tests/expected/cal/weekarg
index 18e560e..37fc53c 100644
--- a/tests/expected/cal/weekarg
+++ b/tests/expected/cal/weekarg
@@ -125,3 +125,23 @@ Julian - Monday-based, week 40 with colors, 3 month
 38 259 260 261 262 263 264 265  43 294 295 296 297 298 299 300  47 322 323 324 325 326 327 328 
 39 266 267 268 269 270 271 272  44 301 302 303 304              48 329 330 331 332 333 334     
 [7m40[27m 273                                                                                         
+Gregorian - Sunday-based, week 54 with colors, 3 month 
+     November 2000            December 2000             January 2001     
+   Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa
+45           1  2  3  4  49                 1  2   1     1  2  3  4  5  6 
+46  5  6  7  8  9 10 11  50  3  4  5  6  7  8  9   2  7  8  9 10 11 12 13 
+47 12 13 14 15 16 17 18  51 10 11 12 13 14 15 16   3 14 15 16 17 18 19 20 
+48 19 20 21 22 23 24 25  52 17 18 19 20 21 22 23   4 21 22 23 24 25 26 27 
+49 26 27 28 29 30        53 24 25 26 27 28 29 30   5 28 29 30 31          
+                         [7m54[27m [7m31[27m                                            
+Gregorian - Monday-based, week 53 with colors, 3 month 
+cal: illegal week value: year 2000 doesn't have week 53
+Gregorian - Monday-based, week 52 with colors, 3 month 
+     November 2000            December 2000             January 2001     
+   Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su
+44        1  2  3  4  5  48              1  2  3   1  1  2  3  4  5  6  7 
+45  6  7  8  9 10 11 12  49  4  5  6  7  8  9 10   2  8  9 10 11 12 13 14 
+46 13 14 15 16 17 18 19  50 11 12 13 14 15 16 17   3 15 16 17 18 19 20 21 
+47 20 21 22 23 24 25 26  51 18 19 20 21 22 23 24   4 22 23 24 25 26 27 28 
+48 27 28 29 30           [7m52[27m 25 26 27 28 29 30 [7m31[27m   5 29 30 31             
+                                                                          
diff --git a/tests/ts/cal/weekarg b/tests/ts/cal/weekarg
index 55dc327..19f58c1 100755
--- a/tests/ts/cal/weekarg
+++ b/tests/ts/cal/weekarg
@@ -129,5 +129,31 @@ if [ "$USETERM" == "yes" ]; then
 fi
 $TS_CMD_CAL -3mj $WEEK $MYTIME >> $TS_OUTPUT
 
+MYTIME="31 12 2000"
+PWEEK="week 54 with colors"
+WEEK="--week=54 --color=always"
+ts_log "Gregorian - Sunday-based, $PWEEK, 3 month $x"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL --three --sunday $WEEK $MYTIME
+fi
+$TS_CMD_CAL --three --sunday $WEEK $MYTIME >> $TS_OUTPUT
+
+PWEEK="week 53 with colors"
+WEEK="--week=53 --color=always"
+ts_log "Gregorian - Monday-based, $PWEEK, 3 month $x"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL --three --monday $WEEK $MYTIME
+fi
+$TS_CMD_CAL --three --monday $WEEK $MYTIME >> $TS_OUTPUT 2>&1
+
+PWEEK="week 52 with colors"
+WEEK="--week=52 --color=always"
+ts_log "Gregorian - Monday-based, $PWEEK, 3 month $x"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL --three --monday $WEEK $MYTIME
+fi
+$TS_CMD_CAL --three --monday $WEEK $MYTIME >> $TS_OUTPUT 2>&1
+
+
 ts_finalize
 
-- 
2.5.0

