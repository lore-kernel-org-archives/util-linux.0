Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58896 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbdFOXnG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:43:06 -0400
Subject: [PATCH 04/10] parse-date: use int where appropriate
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a49a2968-dcb5-d7fe-6840-1515ebff5cca@gmx.com>
Date: Thu, 15 Jun 2017 19:42:46 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 2d1c728..b79b333 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -157,7 +157,7 @@ typedef struct {
 	intmax_t hour;
 	intmax_t minutes;
 	time_t seconds;
-	long int ns;
+	int ns;
 } relative_time;
 
 #if HAVE_COMPOUND_LITERALS
@@ -181,7 +181,7 @@ typedef struct {
 	int local_isdst;
 
 	/* Time zone, in minutes east of UTC. */
-	long int time_zone;
+	int time_zone;
 
 	/* Style used for time. */
 	int meridian;
@@ -272,7 +272,7 @@ static void apply_relative_time(parser_control *pc, relative_time rel,
 /* Set PC-> hour, minutes, seconds and nanoseconds members from arguments. */
 static void
 set_hhmmss(parser_control *pc, intmax_t hour, intmax_t minutes,
-	   time_t sec, long int nsec)
+	   time_t sec, int nsec)
 {
 	pc->hour = hour;
 	pc->minutes = minutes;
@@ -970,9 +970,9 @@ static long int tm_diff(struct tm const *a, struct tm const *b)
 	int a400 = SHR (a100, 2);
 	int b400 = SHR (b100, 2);
 	int intervening_leap_days = (a4 - b4) - (a100 - b100) + (a400 - b400);
-	long int ayear = a->tm_year;
-	long int years = ayear - b->tm_year;
-	long int days = (365 * years + intervening_leap_days
+	int ayear = a->tm_year;
+	int years = ayear - b->tm_year;
+	int days = (365 * years + intervening_leap_days
 			 + (a->tm_yday - b->tm_yday));
 	return (60 * (60 * (24 * days + (a->tm_hour - b->tm_hour))
 		+ (a->tm_min - b->tm_min))
