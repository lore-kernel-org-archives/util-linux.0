Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:39996 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3KJSX7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:23:59 -0500
Received: by mail-we0-f169.google.com with SMTP id q58so3865339wes.0
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:23:58 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/13] cal: add input variable names to function prototypes
Date: Sun, 10 Nov 2013 18:23:30 +0000
Message-Id: <1384107820-498-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While prototypes such as 'function(int, int, char, int);' are legal they
do not help when trying to understand how the function is expected to be
used.  Adding variable names gives at least a hint when looking the
prototypes.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index bcc1580..abb6e0f 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -248,23 +248,25 @@ struct cal_control {
 
 /* function prototypes */
 static int leap_year(long year);
-static char *ascii_day(char *, int, const struct cal_control *ctl);
-static char *ascii_weeknum(char *p, int wn, const struct cal_control *ctl);
-static int center_str(const char* src, char* dest, size_t dest_size, size_t width);
-static void center(const char *, size_t, int);
-static void day_array(int, int, long, int *, const struct cal_control *ctl);
-static int day_in_week(int, int, long);
-static int day_in_year(int, int, long);
-static int week_number(int, int, long, const struct cal_control *ctl);
-static int week_to_day(long, const struct cal_control *ctl);
-static void yearly(int, long, const struct cal_control *ctl);
-static int do_monthly(int day, int month, long year, struct fmt_st *out,
-		      int header_hint, const struct cal_control *ctl);
-static void monthly(int, int, long, const struct cal_control *ctl);
-static int two_header_lines(int month, long year, const struct cal_control *ctl);
-static void monthly3(int, int, long, const struct cal_control *ctl);
-static void __attribute__ ((__noreturn__)) usage(FILE * out);
 static void headers_init(struct cal_control *ctl);
+static int do_monthly(int day, int month, long year, struct fmt_st *out, int header_hint,
+		      const struct cal_control *ctl);
+static void monthly(int day, int month, long year, const struct cal_control *ctl);
+static int two_header_lines(int month, long year, const struct cal_control *ctl);
+static void monthly3(int day, int month, long year, const struct cal_control *ctl);
+static char *append_weeknum(char *p, int *dp, int month, long year, int cal, int row,
+			    const struct cal_control *ctl);
+static void yearly(int day, long year, const struct cal_control *ctl);
+static void day_array(int day, int month, long year, int *days, const struct cal_control *ctl);
+static int day_in_year(int day, int month, long year);
+static int day_in_week(int d, int m, long y);
+static int week_number(int day, int month, long year, const struct cal_control *ctl);
+static int week_to_day(long year, const struct cal_control *ctl);
+static char *ascii_day(char *p, int day, const struct cal_control *ctl);
+static char *ascii_weeknum(char *p, int weeknum, const struct cal_control *ctl);
+static int center_str(const char *src, char *dest, size_t dest_size, size_t width);
+static void center(const char *str, size_t len, int separate);
+static void __attribute__((__noreturn__)) usage(FILE *out);
 
 int main(int argc, char **argv)
 {
-- 
1.8.4.2

