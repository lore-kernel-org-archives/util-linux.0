Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f169.google.com ([209.85.128.169]:59901 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3D1UUL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 16:20:11 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so1175172veb.28
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 13:20:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130428172840.GE1925@rampage>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
	<1367169067-23705-3-git-send-email-kerolasa@iki.fi>
	<20130428172840.GE1925@rampage>
Date: Sun, 28 Apr 2013 21:20:10 +0100
Message-ID: <CAG27Bk3Ycy3AvLmOJbSfC4r=d5q_vw9--qv6=Zq2Cbqj5cW5bg@mail.gmail.com>
Subject: Re: [PATCH 02/11] cal: convert function like definitions to functions
From: Sami Kerola <kerolasa@iki.fi>
To: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28 April 2013 18:28, Dave Reisner <d@falconindy.com> wrote:
> I agree with the change, but the new functions (all functions here,
> really) should be marked as static.

Thank you for review Dave.

Good point, new version of that patch is below and pushed to my git. I
will shortly submit a change which makes all functions static, and
should be applied on top of the earlier patches.


>From 68f869cc0d258cfe978368fcc084d46901b8ed3d Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 27 Apr 2013 22:51:35 +0100
Subject: [PATCH 02/12] cal: convert function like definitions to functions
Organization: Lastminute.com

Reviewed-by: Dave Reisner <dreisner@archlinux.org>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 13830de..0c8cffc 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -209,23 +209,6 @@ char j_day_headings[J_WEEK_LEN*6+1];
 /* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
 const char *full_month[12];

-/* leap year -- account for gregorian reformation in 1752 */
-#define leap_year(yr) \
- ((yr) <= 1752 ? !((yr) % 4) : \
- (!((yr) % 4) && ((yr) % 100)) || !((yr) % 400))
-
-/* number of centuries since 1700, not inclusive */
-#define centuries_since_1700(yr) \
- ((yr) > 1700 ? (yr) / 100 - 17 : 0)
-
-/* number of centuries since 1700 whose modulo of 400 is 0 */
-#define quad_centuries_since_1700(yr) \
- ((yr) > 1600 ? ((yr) - 1600) / 400 : 0)
-
-/* number of leap years between year 1 and this year, not inclusive */
-#define leap_years_since_year_1(yr) \
- ((yr) / 4 - centuries_since_1700(yr) + quad_centuries_since_1700(yr))
-
 /* 0 => sunday, 1 => monday */
 int weekstart=0;
 int julian;
@@ -239,6 +222,9 @@ struct fmt_st
   char s[FMT_ST_LINES][FMT_ST_CHARS];
 };

+int leap_year(int year);
+int centuries_since_1700(int year, int centuries);
+int leap_years_since_year_1(int year);
 char * ascii_day(char *, int);
 int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 void center(const char *, size_t, int);
@@ -413,6 +399,31 @@ main(int argc, char **argv) {
  return EXIT_SUCCESS;
 }

+/* leap year -- account for gregorian reformation in 1752 */
+static int leap_year(int year)
+{
+ if (year <= 1752)
+ return !(year % 4);
+ else
+ return !(year % 4 && (year % 100 || year % 400));
+}
+
+/* number of centuries since 1700 */
+static int centuries_since_1700(int year, int n)
+{
+ if (year < 1700)
+ return 0;
+ else
+ return ((year / (100 * n)) - (17 / n));
+}
+
+/* number of leap years between year 1 and this year, not inclusive */
+static int leap_years_since_year_1(int year)
+{
+ return (year / 4 - centuries_since_1700(year, 1) +
+ centuries_since_1700(year, 4));
+}
+
 void headers_init(void)
 {
  int i, wd;
--
1.8.2.2


--
   Sami Kerola
   http://www.iki.fi/kerolasa/
