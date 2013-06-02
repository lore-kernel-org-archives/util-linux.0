Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53408 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab3FBRwg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:36 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so2046900wgh.1
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/19] cal: fix few type mismatches
Date: Sun,  2 Jun 2013 18:51:25 +0100
Message-Id: <1370195485-27907-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sloppiness from commit e44fe4712140774b677de466affc31e0581ee335.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index befadbe..d6fb32c 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -237,7 +237,7 @@ static char * ascii_day(char *, int);
 static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 static void center(const char *, size_t, int);
 static void day_array(int, int, long, int *);
-static int day_in_week(int, int, int);
+static int day_in_week(int, int, long);
 static int day_in_year(int, int, long);
 static void yearly(int, long, int);
 static int do_monthly(int, int, long, struct fmt_st*, int);
@@ -469,11 +469,11 @@ static int do_monthly(int day, int month, long year,
 		snprintf(lineout, sizeof(lineout), _("%s"), full_month[month - 1]);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
 		pos++;
-		snprintf(lineout, sizeof(lineout), _("%lu"), year);
+		snprintf(lineout, sizeof(lineout), _("%ld"), year);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
 		pos++;
 	} else {
-		snprintf(lineout, sizeof(lineout), _("%s %lu"),
+		snprintf(lineout, sizeof(lineout), _("%s %ld"),
 			full_month[month - 1], year);
 		center_str(lineout, out->s[pos], ARRAY_SIZE(out->s[pos]), width);
 		pos++;
@@ -514,7 +514,7 @@ static int two_header_lines(int month, long year)
 	char lineout[FMT_ST_CHARS];
 	size_t width = (julian ? J_WEEK_LEN : WEEK_LEN) - 1;
 	size_t len;
-	snprintf(lineout, sizeof(lineout), "%lu", year);
+	snprintf(lineout, sizeof(lineout), "%ld", year);
 	len = strlen(lineout);
 	len += strlen(full_month[month - 1]) + 1;
 	if (width < len)
@@ -602,7 +602,7 @@ static void yearly(int day, long year, int julian)
 		sep_len = HEAD_SEP;
 		week_len = WEEK_LEN;
 	}
-	snprintf(lineout, sizeof(lineout), "%lu", year);
+	snprintf(lineout, sizeof(lineout), "%ld", year);
 	/* 2013-04-28: The -1 near sep_len makes year header to be
 	 * aligned exactly how it has been aligned for long time, but it
 	 * is unexplainable.  */
@@ -699,7 +699,7 @@ static int day_in_year(int day, int month, long year)
  *	3 Sep. 1752 through 13 Sep. 1752, and returns invalid weekday
  *	during the period of 11 days.
  */
-static int day_in_week(int d, int m, int y)
+static int day_in_week(int d, int m, long y)
 {
 	static const int reform[] = {
 		SUNDAY, WEDNESDAY, TUESDAY, FRIDAY, SUNDAY, WEDNESDAY,
-- 
1.8.3

