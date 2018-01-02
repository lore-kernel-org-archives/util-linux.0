Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeABPCH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 10:02:07 -0500
Subject: [v3 PATCH 10/11] cal: fix first week calculation
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8fdab0a8-e105-24a9-91bc-0f48e291d5bb@gmx.com>
Date: Tue, 2 Jan 2018 10:02:05 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Commit efafeaf set 1 Jan as week 1, but the change
was missed in week_to_day() and in the man page.

Before
cal --week=40 1752
      October 1752
   Su Mo Tu We Th Fr Sa
41  1  2  3  4  5  6  7
42  8  9 10 11 12 13 14
43 15 16 17 18 19 20 21
44 22 23 24 25 26 27 28
45 29 30 31

Patched
cal --week=40 1752
     September 1752
   Su Mo Tu We Th Fr Sa
36                 1  2
37  3  4  5  6  7  8  9
38 10 11 12 13 14 15 16
39 17 18 19 20 21 22 23
40 24 25 26 27 28 29 30

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 5 ++---
 misc-utils/cal.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 23e21c3a5..14125bafc 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -190,9 +190,8 @@ or defaults to Sunday.
 .PP
 The week numbering depends on the choice of the first day of the week.  If it
 is Sunday (the default) then the customary North American numbering is used,
-where the first Sunday of the year starts the first week.  If it is Monday then
-the ISO 8601 standard week numbering is used, where the first Thursday of the
-year is in week number 1.
+where 1 January is in week number 1.  If it is Monday then the ISO 8601
+standard week numbering is used, where the first Thursday is in week number 1.
 .SH COLORS
 Implicit coloring (highlighting) can be disabled as follows:
 .RS
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 0756f922f..2a24dad26 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -994,7 +994,7 @@ static int week_to_day(const struct cal_control *ctl)
 	if (ctl->weektype & WEEK_NUM_ISO)
 		yday -= (wday >= FRIDAY ? -2 : 5);
 	else
-		yday -= (wday == SUNDAY ? 6 : -1);	/* WEEK_NUM_US */
+		yday -= 6;	/* WEEK_NUM_US */
 	if (yday <= 0)
 		return 1;
 
