Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdFOXlu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:41:50 -0400
Subject: [PATCH 03/10] parse-date: use intmax_t where appropriate
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0edfd460-fd6c-9216-a612-07c13924ef3c@gmx.com>
Date: Thu, 15 Jun 2017 19:41:34 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 97f4db9..2d1c728 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -133,7 +133,7 @@ static unsigned char to_uchar (char ch) { return ch; }
  */
 typedef struct {
 	int negative;
-	long int value;
+	intmax_t value;
 	size_t digits;
 } textint;
 
@@ -151,11 +151,11 @@ enum { BILLION = 1000000000, LOG10_BILLION = 9 };
 
 /* Relative year, month, day, hour, minutes, seconds, and nanoseconds. */
 typedef struct {
-	long int year;
-	long int month;
-	long int day;
-	long int hour;
-	long int minutes;
+	intmax_t year;
+	intmax_t month;
+	intmax_t day;
+	intmax_t hour;
+	intmax_t minutes;
 	time_t seconds;
 	long int ns;
 } relative_time;
@@ -172,7 +172,7 @@ typedef struct {
 	const char *input;
 
 	/* N, if this is the Nth Tuesday. */
-	long int day_ordinal;
+	intmax_t day_ordinal;
 
 	/* Day of week; Sunday is 0. */
 	int day_number;
@@ -188,10 +188,10 @@ typedef struct {
 
 	/* Gregorian year, month, day, hour, minutes, seconds, and ns. */
 	textint year;
-	long int month;
-	long int day;
-	long int hour;
-	long int minutes;
+	intmax_t month;
+	intmax_t day;
+	intmax_t hour;
+	intmax_t minutes;
 	struct timespec seconds; /* includes nanoseconds */
 
 	/* Relative year, month, day, hour, minutes, seconds, and ns. */
@@ -218,7 +218,7 @@ typedef struct {
 union YYSTYPE;
 static int yylex (union YYSTYPE *, parser_control *);
 static int yyerror (parser_control const *, char const *);
-static long int time_zone_hhmm (parser_control *, textint, long int);
+static long int time_zone_hhmm (parser_control *, textint, intmax_t);
 
 /**
  * Extract into *PC any date and time info from a string of digits
@@ -271,7 +271,7 @@ static void apply_relative_time(parser_control *pc, relative_time rel,
 
 /* Set PC-> hour, minutes, seconds and nanoseconds members from arguments. */
 static void
-set_hhmmss(parser_control *pc, long int hour, long int minutes,
+set_hhmmss(parser_control *pc, intmax_t hour, intmax_t minutes,
 	   time_t sec, long int nsec)
 {
 	pc->hour = hour;
@@ -294,7 +294,7 @@ set_hhmmss(parser_control *pc, long int hour, long int minutes,
 %expect 31
 
 %union {
-	long int intval;
+	intmax_t intval;
 	textint textintval;
 	struct timespec timespec;
 	relative_time rel;
@@ -870,9 +870,9 @@ static table const military_table[] = {
  * minutes specified.
  */
 
-static long int time_zone_hhmm(parser_control *pc, textint s, long int mm)
+static long int time_zone_hhmm(parser_control *pc, textint s, intmax_t mm)
 {
-	long int n_minutes;
+	intmax_t n_minutes;
 
 	/**
 	 * If the length of S is 1 or 2 and no minutes are specified,
@@ -897,7 +897,7 @@ static long int time_zone_hhmm(parser_control *pc, textint s, long int mm)
 	return n_minutes;
 }
 
-static int to_hour(long int hours, int meridian)
+static int to_hour(intmax_t hours, int meridian)
 {
 	switch (meridian) {
 	default: /* Pacify GCC. */
@@ -912,7 +912,7 @@ static int to_hour(long int hours, int meridian)
 
 static long int to_year(textint textyear)
 {
-	long int year = textyear.value;
+	intmax_t year = textyear.value;
 
 	if (year < 0)
 		year = -year;
@@ -1265,7 +1265,7 @@ int parse_date(struct timespec *result, char const *p,
 		   struct timespec const *now)
 {
 	time_t Start;
-	long int Start_ns;
+	intmax_t Start_ns;
 	struct tm const *tmp;
 	struct tm tm;
 	struct tm tm0;
@@ -1501,12 +1501,12 @@ int parse_date(struct timespec *result, char const *p,
 				 * TZ="XXX1:00" and try mktime again.
 				 */
 
-				long int time_zone = pc.time_zone;
+				intmax_t time_zone = pc.time_zone;
 
-				long int abs_time_zone = time_zone < 0
+				intmax_t abs_time_zone = time_zone < 0
 					 ? - time_zone : time_zone;
 
-				long int abs_time_zone_hour
+				intmax_t abs_time_zone_hour
 					 = abs_time_zone / 60;
 
 				int abs_time_zone_min = abs_time_zone % 60;
@@ -1572,7 +1572,7 @@ int parse_date(struct timespec *result, char const *p,
 		 * so this block must follow others that clobber Start.
 		 */
 		if (pc.zones_seen) {
-			long int delta = pc.time_zone * 60;
+			intmax_t delta = pc.time_zone * 60;
 			time_t t1;
 #ifdef HAVE_TM_GMTOFF
 			delta -= tm.tm_gmtoff;
@@ -1600,16 +1600,16 @@ int parse_date(struct timespec *result, char const *p,
 		 * zone indicator must be applied before relative times, and if
 		 * mktime is applied again the time zone will be lost.
 		 */
-		long int sum_ns = pc.seconds.tv_nsec + pc.rel.ns;
-		long int normalized_ns = (sum_ns % BILLION + BILLION) % BILLION;
+		intmax_t sum_ns = pc.seconds.tv_nsec + pc.rel.ns;
+		intmax_t normalized_ns = (sum_ns % BILLION + BILLION) % BILLION;
 		time_t t0 = Start;
-		long int d1 = 60 * 60 * pc.rel.hour;
+		intmax_t d1 = 60 * 60 * pc.rel.hour;
 		time_t t1 = t0 + d1;
-		long int d2 = 60 * pc.rel.minutes;
+		intmax_t d2 = 60 * pc.rel.minutes;
 		time_t t2 = t1 + d2;
 		time_t d3 = pc.rel.seconds;
 		time_t t3 = t2 + d3;
-		long int d4 = (sum_ns - normalized_ns) / BILLION;
+		intmax_t d4 = (sum_ns - normalized_ns) / BILLION;
 		time_t t4 = t3 + d4;
 		time_t t5 = t4;
 
