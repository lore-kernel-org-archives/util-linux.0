Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54070 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeAVMDc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 07:03:32 -0500
Subject: [PATCH 2/2] cal: fix first week calculation
To: Karel Zak <kzak@redhat.com>
References: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9013746a-ea76-e710-7795-114c3543683e@gmx.com>
Date: Mon, 22 Jan 2018 07:03:27 -0500
MIME-Version: 1.0
In-Reply-To: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Commit efafeaf set 1 Jan as week 1, but the change
was missed in week_to_day() and in the man page.

Before
cal --week=40 --iso 1752
      October 1752
   Su Mo Tu We Th Fr Sa
41  1  2  3  4  5  6  7
42  8  9 10 11 12 13 14
43 15 16 17 18 19 20 21
44 22 23 24 25 26 27 28
45 29 30 31

Patched
cal --week=40 --iso 1752
     September 1752
   Su Mo Tu We Th Fr Sa
36                 1  2
37  3  4  5  6  7  8  9
38 10 11 12 13 14 15 16
39 17 18 19 20 21 22 23
40 24 25 26 27 28 29 30

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 12 ++++++------
 misc-utils/cal.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index f99c6b495..60eaa5c3b 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -195,13 +195,13 @@ highlighted if the calendar is displayed on a terminal.  If no parameters are
 specified, the current month's calendar is displayed.
 .SH NOTES
 A year starts on January 1.  The first day of the week is determined by the
-locale.
+locale or the
+.BR \-\-sunday \ and \ \-\-monday \ options.
 .PP
-The week numbering depends on the choice of the first day of the week.  If Sunday
-(the default) is used for the first day of the week, then the customary North
-American numbering will be used, i.e. the first Sunday of the year starts the
-first week.  If Monday is selected, then the ISO-8601 standard week numbering
-is used, where the first Thursday of the year is in week number 1.
+The week numbering depends on the choice of the first day of the week.  If it
+is Sunday then the customary North American numbering is used, where 1 January
+is in week number 1.  If it is Monday then the ISO 8601 standard week numbering
+is used, where the first Thursday is in week number 1.
 .SH COLORS
 Implicit coloring can be disabled as follows:
 .RS
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 1b03857f6..5a6364a27 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -1003,7 +1003,7 @@ static int week_to_day(const struct cal_control *ctl)
 	if (ctl->weektype & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
 	else
-		yday -= (wday == SUNDAY ? 6 : -1);	/* WEEK_NUM_US */
+		yday -= 6;	/* WEEK_NUM_US */
 	if (yday <= 0)
 		return 1;
 
