Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38952 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3KJSX4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:23:56 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm11so1284832wib.2
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:23:55 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/13] cal: rename ascii_wnum() to ascii_weeknum()
Date: Sun, 10 Nov 2013 18:23:29 +0000
Message-Id: <1384107820-498-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Week is not long word, so it does not need to be enshorted and made more
difficult to understand.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index f82d02e..bcc1580 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -249,7 +249,7 @@ struct cal_control {
 /* function prototypes */
 static int leap_year(long year);
 static char *ascii_day(char *, int, const struct cal_control *ctl);
-static char *ascii_wnum(char *p, int wn, const struct cal_control *ctl);
+static char *ascii_weeknum(char *p, int wn, const struct cal_control *ctl);
 static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 static void center(const char *, size_t, int);
 static void day_array(int, int, long, int *, const struct cal_control *ctl);
@@ -558,7 +558,7 @@ static int do_monthly(int day, int month, long year, struct fmt_st *out,
 				if (xd != SPACE) {
 					int wn = week_number(xd & ~TODAY_FLAG,
 							month, year, ctl);
-					p = ascii_wnum(p, wn, ctl);
+					p = ascii_weeknum(p, wn, ctl);
 					break;
 				} else if (col+1 == DAYS_IN_WEEK)
 					p += sprintf(p,"   ");
@@ -679,7 +679,7 @@ static char *append_weeknum(char *p, int *dp,
 		if (xd != SPACE) {
 			int weeknum = week_number(xd & ~TODAY_FLAG,
 					       month + cal + 1, year, ctl);
-			p = ascii_wnum(p, weeknum, ctl);
+			p = ascii_weeknum(p, weeknum, ctl);
 			break;
 		} else if (col+1 == DAYS_IN_WEEK)
 			p += sprintf(p,"   ");
@@ -965,7 +965,7 @@ static char *ascii_day(char *p, int day, const struct cal_control *ctl)
 	return p;
 }
 
-static char *ascii_wnum(char *p, int weeknum, const struct cal_control *ctl)
+static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl)
 {
 	if ((ctl->weektype & WEEK_NUM_MASK) == weeknum)
 		p += sprintf(p,"%s",Senter);
-- 
1.8.4.2

