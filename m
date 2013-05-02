Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:48899 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354Ab3EBSvx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:51:53 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so932062wgg.20
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:51:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/16] cal: convert function like definitions to functions
Date: Thu,  2 May 2013 19:51:27 +0100
Message-Id: <1367520701-14962-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reviewed-by: Thomas Bächler <thomas@archlinux.org>
Reviewed-by: Dave Reisner <dreisner@archlinux.org>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 13830de..e6dd92f 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -209,23 +209,6 @@ char j_day_headings[J_WEEK_LEN*6+1];
 /* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
 const char *full_month[12];
 
-/* leap year -- account for gregorian reformation in 1752 */
-#define	leap_year(yr) \
-	((yr) <= 1752 ? !((yr) % 4) : \
-	(!((yr) % 4) && ((yr) % 100)) || !((yr) % 400))
-
-/* number of centuries since 1700, not inclusive */
-#define	centuries_since_1700(yr) \
-	((yr) > 1700 ? (yr) / 100 - 17 : 0)
-
-/* number of centuries since 1700 whose modulo of 400 is 0 */
-#define	quad_centuries_since_1700(yr) \
-	((yr) > 1600 ? ((yr) - 1600) / 400 : 0)
-
-/* number of leap years between year 1 and this year, not inclusive */
-#define	leap_years_since_year_1(yr) \
-	((yr) / 4 - centuries_since_1700(yr) + quad_centuries_since_1700(yr))
-
 /* 0 => sunday, 1 => monday */
 int weekstart=0;
 int julian;
@@ -239,6 +222,9 @@ struct fmt_st
   char s[FMT_ST_LINES][FMT_ST_CHARS];
 };
 
+static int leap_year(int year);
+static int centuries_since_1700(int year, int centuries);
+static int leap_years_since_year_1(int year);
 char * ascii_day(char *, int);
 int center_str(const char* src, char* dest, size_t dest_size, size_t width);
 void center(const char *, size_t, int);
@@ -413,6 +399,31 @@ main(int argc, char **argv) {
 	return EXIT_SUCCESS;
 }
 
+/* leap year -- account for gregorian reformation in 1752 */
+static int leap_year(int year)
+{
+	if (year <= 1752)
+		return !(year % 4);
+	else
+		return ( !(year % 4) && (year % 100) ) || !(year % 400);
+}
+
+/* number of centuries since 1700 */
+static int centuries_since_1700(int year, int n)
+{
+	if (year < 1700)
+		return 0;
+	else
+		return ((year / (100 * n)) - (17 / n));
+}
+
+/* number of leap years between year 1 and this year, not inclusive */
+static int leap_years_since_year_1(int year)
+{
+	return (year / 4 - centuries_since_1700(year, 1) +
+		centuries_since_1700(year, 4));
+}
+
 void headers_init(void)
 {
 	int i, wd;
-- 
1.8.2.2

